/*
 * #########################################################################*/
/* #                                                                       #*/
/* #  This file is part of PGTNetworkMap project, which is written         #*/
/* #  as a PGT plug-in to perform Layer 3 network inventory.               #*/
/* #                                                                       #*/
/* #  You may not use this file except in compliance with the license.     #*/
/* #                                                                       #*/
/* #  Copyright Laszlo Frank (c) 2014-2018                                 #*/
/* #                                                                       #*/
/* #########################################################################*/


using PGT.Common;
using System;
using System.Diagnostics;
using System.Linq;
using System.Reflection;
using System.Text.RegularExpressions;
using System.Threading;

namespace L3Discovery.ProtocolParsers.JunOS.BGP
{
	public class Junos_BGPParser : IGenericProtocolParser, IBGPProtocolParser
	{
		/// <summary>
		/// The IRouter this parser is working for
		/// </summary>
		private IRouter _router;

		private string _OperationStatusLabel = "Init";

		private const string ParsingForVendor = "JunOS";

		public string GetOperationStatusLabel() => _OperationStatusLabel;

		public bool Initialize(IRouter router, Enum protocol)
		{
			_router = router;
			if (protocol is NeighborProtocol && (NeighborProtocol)protocol == NeighborProtocol.BGP)
			{
				return router?.GetVendor() == ParsingForVendor;
			}
			else return false;
		}

		public void Parse(INeighborRegistry registry, CancellationToken token, RoutingInstance instance)
		{
			var session = _router.GetSession();
			if (session == null || !session.IsConnected()) throw new ArgumentException("Unable to parse BGP. Either thisRouter or Session parameter is invalid");
			else
			{
				try
				{
					_OperationStatusLabel = "Querying bgp neighbors...";
					string instanceName = instance?.Name.ToLower() ?? "default";
					string bgpNeighbors = instanceName == "default" ? session.ExecCommand("show bgp neighbor") : session.ExecCommand(string.Format("show bgp neighbor instance {0}", instanceName));

					token.ThrowIfCancellationRequested();
					string[] bgp_lines = bgpNeighbors.Split("\r\n".ToCharArray(), StringSplitOptions.RemoveEmptyEntries);
					string peerRouterID = "";
					string localNeighboringIP = "";
					string remoteNeighboringIP = "";
					string remoteAS = "";
					string description = "";
					string neighborState = "";
					bool sessionEstablished = true;
					bool skipRestOfLines = false;
					string localInterfaceName = "";
					string calculatedLocalInterfaceName = "";
					BGPType _bgpType = BGPType.undetermined;

					string localRid = _router.RouterID(NeighborProtocol.BGP, instance);
					string defaultLocalAS = _router.BGPAutonomousSystem(instance)?.Trim() ?? "";
					string localAS = "";
					// If not null, peering uses Local-as feature and neighboring details must be registered
					BGPProtocolDetails bgpDetails = null;
					var trimmedLines = bgp_lines.Select(l => l.Trim()).ToList();
					for (int lineIndex = 0; lineIndex < trimmedLines.Count(); lineIndex++)
					{
						string line = trimmedLines[lineIndex];

						DebugEx.WriteLine(String.Format("JunOSBGPParser : parsing BGP neighbor row [ {0} ]", line), DebugLevel.Full);
						token.ThrowIfCancellationRequested();
						try
						{
							#region Get description
							if (line.StartsWith("Description:"))
							{
								string[] words = line.Split(":".ToCharArray(), StringSplitOptions.RemoveEmptyEntries);
								description = words[1];
								continue;
							}
							#endregion

							#region Check for Peer line 
							if (line.StartsWith("Peer:"))
							{
								// This is a new peer, initialize variables
								peerRouterID = "";
								localNeighboringIP = "";
								remoteNeighboringIP = "";
								description = "";
								neighborState = "";
								sessionEstablished = true;
								skipRestOfLines = false;
								localInterfaceName = "";
								calculatedLocalInterfaceName = "";
								// Get local address
								Match m = Regex.Match(line, @"(?<=Local: )[\d.]{0,99}", RegexOptions.Compiled);
								if (m.Success) localNeighboringIP = m.Value;
								// Get peer address
								m = Regex.Match(line, @"(?<=Peer: )[\d.]{0,99}", RegexOptions.Compiled);
								if (m.Success) remoteNeighboringIP = m.Value;
								// Get AS Numbers
								var ASes = Regex.Matches(line, @"(?<=AS )[\d.]{0,99}", RegexOptions.Compiled);
								if (ASes.Count != 2) throw new InvalidOperationException("Cannot parse BGP output : unable to retrieve local and remote AS numbers.");
								remoteAS = ASes[0].Value.Trim();
								localAS = ASes[1].Value.Trim();
								if (localAS != defaultLocalAS)
								{
									DebugEx.WriteLine("JunOSBGPParser : Local AS feature detected, registering BGPPerringDetails ", DebugLevel.Full);
									bgpDetails = new BGPProtocolDetails();
									bgpDetails.LocalASN = localAS;
									bgpDetails.RemoteASN = remoteAS;
								}
								else bgpDetails = null;
								_OperationStatusLabel = string.Format("Processing neighbor {0} for AS {1}...", remoteNeighboringIP, remoteAS);
								continue;
							}
							#endregion

							if (skipRestOfLines) continue;

							#region Check for state
							if (line.StartsWith("Type:") && line.Contains("State:"))
							{
								Match m = Regex.Match(line, @"(?<=State: )\w+", RegexOptions.Compiled);
								if (m.Success) neighborState = m.Value;
								sessionEstablished = neighborState.ToLowerInvariant() == "established";
								m = Regex.Match(line, @"(?<=Type: )\w+", RegexOptions.Compiled);
								if (m.Success) _bgpType = m.Value.ToLowerInvariant() == "internal" ? BGPType.iBGP : BGPType.eBGP;
							}
							#endregion

							if (sessionEstablished)
							{
								#region Parse Remote router ID
								if (line.StartsWith("Peer ID:"))
								{
									// Get remote router ID
									Match m = Regex.Match(line, @"(?<=Peer ID: )[\d.]{0,99}", RegexOptions.Compiled);
									if (!m.Success) throw new InvalidOperationException("Cannot parse BGP output : unable to retrieve peer router ID.");
									peerRouterID = m.Value;
									// Get local router ID
									m = Regex.Match(line, @"(?<=Local ID: )[\d.]{0,99}", RegexOptions.Compiled);
									if (m.Success)
									{
										if (m.Value == localRid)
										{
											DebugEx.WriteLine("JunOSBGPParser : Local ID and Local IP are equal, resolving local interface name...", DebugLevel.Full);
											calculatedLocalInterfaceName = _router.GetInterfaceNameByIPAddress(localRid, instance);
											DebugEx.WriteLine(String.Format("JunOSBGPParser :got {0} for localInterfaceName", calculatedLocalInterfaceName), DebugLevel.Full);
										}
									}
									DebugEx.WriteLine(String.Format("JunOSBGPParser : found a neighbor {0}AS{1} <-> {2}AS{3}", localRid, localAS, peerRouterID, remoteAS), DebugLevel.Full);
									continue;
								}
								#endregion

								#region Get local interface
								if (localInterfaceName == "")
								{
									switch (_bgpType)
									{
										case BGPType.eBGP:
											{
												if (line.StartsWith("Local Interface:"))
												{
													string[] words = line.Split(":".ToCharArray(), StringSplitOptions.RemoveEmptyEntries);
													localInterfaceName = words[1];
													continue;
												}
												break;
											}
										case BGPType.iBGP:
											{
												// since JunOS does not show Local Interface for iBGP, we need to query it, if we know the local ip
												if (localNeighboringIP != "") localInterfaceName = _router.GetInterfaceNameByIPAddress(localNeighboringIP, instance);
												break;
											}
									}
								}
								#endregion
							}

							if (lineIndex == trimmedLines.Count - 1 || trimmedLines[lineIndex + 1].StartsWith("Peer:"))
							{
								// we are either at the end of the output, or at the end of current peer block and localInterface is still not capture from output
								// let's use calculatedLocalInterface
								DebugEx.WriteLine("JunOSBGPParser : Local Interface was not stated, using localInterfaceName calculated from LocaLID  ", DebugLevel.Full);
								localInterfaceName = calculatedLocalInterfaceName;
							}

							if (sessionEstablished && (localInterfaceName == "" || peerRouterID == "" || remoteAS == "" || localNeighboringIP == "" || remoteNeighboringIP == ""))
							{
								DebugEx.WriteLine(String.Format("JunOSBGPParser : still missing some data to register : localInterfaceName=[{1}], peerRouterID=[{2}], remoteAS=[{3}], localNeighboringIP=[{4}], remoteNeighboringIP=[{5}]  ", line, localInterfaceName, peerRouterID, remoteAS, localNeighboringIP, remoteNeighboringIP), DebugLevel.Full);
								continue;
							}

							// when the BGP session is not established we can't know the neighbor router ID, so name it after peering ip which should be unique anyway
							// We also won't know the localInterface at this point, so we need to query it by ip address
							if (!sessionEstablished)
							{
								peerRouterID = remoteNeighboringIP;
								if (localNeighboringIP != "") localInterfaceName = _router.GetInterfaceNameByIPAddress(localNeighboringIP, instance);
							}
							// search database for peer router, select it or add new neighbor
							_OperationStatusLabel = string.Format("Querying router interface {0}...", localInterfaceName);
							RouterInterface ri = _router.GetInterfaceByName(localInterfaceName, instance);
							_OperationStatusLabel = string.Format("Registering BGP neighbor {0}...", peerRouterID);
							DebugEx.WriteLine(String.Format("JunOSBGPParser : registering neighbor {0} AS {1} <-> {2} AS {3}", localRid, localAS, peerRouterID, remoteAS), DebugLevel.Full);
							int neighborshipID = registry.RegisterNeighbor(_router, instance, NeighborProtocol.BGP, peerRouterID, remoteAS, description, remoteNeighboringIP, ri, neighborState);
							if (bgpDetails != null)
							{
								DebugEx.WriteLine("JunOSBGPParser : registering bgp protocol details", DebugLevel.Full);
								registry.RegisterNeighboringDetails(neighborshipID, bgpDetails);
							}
							// now all is done for this peer, skip lines until next peer is found
							skipRestOfLines = true;
						}
						catch (OperationCanceledException)
						{
							throw;
						}
						catch (InvalidOperationException)
						{
							throw;
						}
						catch (Exception Ex)
						{
							string msg = String.Format("JunOSBGPParser : Error while parsing bgp output line [{0}]. Error is : {1}", line, Ex.InnerExceptionsMessage());
							DebugEx.WriteLine(msg);
							_OperationStatusLabel = msg;
						}
					}

					_OperationStatusLabel = "JunOS BGP route parser completed.";
				}
				catch (Exception Ex)
				{
					_OperationStatusLabel = "JunoS BGP parser failed with error : " + Ex.Message;
				}
			}
		}

		public void Reset()
		{
			_router = null;
			_OperationStatusLabel = "Init";
		}

		public ISpecializedProtocolParser ProtocolDependentParser(Enum protocol)
		{
			if (protocol is NeighborProtocol && (NeighborProtocol)protocol == NeighborProtocol.BGP) return this;
			else return null;
		}

		public string GetSupportTag() => string.Format("Juniper, JunOS BGP Protocol Parser module v{0}", Assembly.GetAssembly(typeof(Junos_BGPParser)).GetName().Version.ToString());

		public object[] GetSupportedProtocols() => new Enum[] { NeighborProtocol.BGP };

		public string GetVendor()
		{
			return ParsingForVendor;
		}

		internal enum BGPType { eBGP, iBGP, undetermined };
	}
}
