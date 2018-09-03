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
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Net;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading;

namespace L3Discovery.ProtocolParsers.CiscoIOS.OSPF
{
	public class Cisco_IOS_OSPFParser : IGenericProtocolParser, IOSPFProtocolParser
	{
		#region Fields
		/// <summary>
		/// The IRouter this parser is working for
		/// </summary>
		private IRouter _router;
		private string _OperationStatusLabel = "Init";
		/// <summary>
		/// Used to store LSAs. The outer key in Dictionary is the area, the inner key is the LSA Type. List values are OSPFLSA objects.
		/// </summary>
		private Dictionary<OSPFArea, Dictionary<string, List<OSPFLSA>>> _ospfAreaLSAs = new Dictionary<OSPFArea, Dictionary<string, List<OSPFLSA>>>();
		#endregion

		public bool Initilize(IRouter router, Enum protocol)
		{
			_router = router;
			if (protocol is NeighborProtocol && (NeighborProtocol)protocol == NeighborProtocol.OSPF)
			{
				return router?.Vendor == "Cisco";
			}
			else return false;
		}

		public string OperationStatusLabel => _OperationStatusLabel;

		public void Parse(INeighborRegistry registry, CancellationToken token)
		{
			if (_router?.Session == null || !_router.Session.IsConnected()) throw new ArgumentException("Unable to parse OSPF. Either thisRouter or Session parameter is invalid");
			try
			{
				_OperationStatusLabel = "Querying OSPF neighbors...";
				string TextToParse = _router.Session.ExecCommand("show ip ospf neighbor");
				_OperationStatusLabel = "Querying OSPF interfaces...";
				string ospfInterfaces = _router.Session.ExecCommand("show ip ospf interface brief");
				_OperationStatusLabel = "Processing OSPF data...";
				token.ThrowIfCancellationRequested();
				string[] ospf_lines = TextToParse.Split("\r\n".ToCharArray(), StringSplitOptions.RemoveEmptyEntries);
				string neighborRouterID = "";
				string neighborState = "";
				string remoteNeighboringIP = "";
				string description = "";

				foreach (string line in ospf_lines.Select(l => l.Trim()))
				{
					neighborRouterID = "";
					neighborState = "";
					remoteNeighboringIP = "";
					description = "";
					DebugEx.WriteLine(String.Format("CISCO_IOS_OSPF_PARSER : parsing OSPF neighbor row [ {0} ]", line), DebugLevel.Full);
					token.ThrowIfCancellationRequested();
					try
					{
						string[] words = line.SplitBySpace();
						if (words.Length < 4) continue;
						// Words should look like:
						// Neighbor ID,Pri,State,Dead Time,Address,Interface
						// 172.20.0.255,128,FULL/BDR,00:00:34,172.20.0.14,TenGigabitEthernet0/1/0 
						var MatchedIPs = Regex.Matches(line, @"\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}");
						// we expect two ip addresses in the line, first is the Neighbor router ID, second is Neighboring IP address
						if (MatchedIPs.Count == 2 && System.Net.IPAddress.TryParse(MatchedIPs[0].Value, out IPAddress nID) && System.Net.IPAddress.TryParse(MatchedIPs[1].Value, out IPAddress nIP))
						{
							// This is a new peer, initialize variables
							string ifName = words[words.Length - 1]; // last work is the interface name
							_OperationStatusLabel = string.Format("Querying router interface {0}...", ifName);
							RouterInterface ri = _router.GetInterfaceByName(ifName);
							if (ri != null)
							{
								// add OSPF Area info to RouterInterface
								if (ospfInterfaces != "")
								{
									string ospfIntfLine = ospfInterfaces.SplitByLine().FirstOrDefault(l => l.Trim().StartsWith(ri.Name));
									if (!string.IsNullOrEmpty(ospfIntfLine))
									{
										string[] w = ospfIntfLine.SplitBySpace();
										//Interface    PID   Area            IP Address/Mask    Cost  State Nbrs F/C
										//Te0/1/0      100   172.20.0.0      172.20.0.1/28      1     DR    1/1
										ri.OSPFArea = w[2];
									}
								}
								neighborRouterID = nID.ToString();
								remoteNeighboringIP = nIP.ToString();
								neighborState = words[2];
								description = "";
								_OperationStatusLabel = string.Format("Registering OSPF neighbor {0}...", neighborRouterID);
								registry.RegisterL3Neighbor(_router, NeighborProtocol.OSPF, neighborRouterID, "", description, remoteNeighboringIP, ri, neighborState);
							}
						}
					}
					catch (OperationCanceledException)
					{
						throw;
					}
					catch (Exception Ex)
					{
						string msg = String.Format("Cisco IOS OSPF Protocol Parser : Error while parsing ospf output line [{0}]. Error is : {1}", line, Ex.InnerExceptionsMessage());
						DebugEx.WriteLine(msg);
						_OperationStatusLabel = msg;
					}
				}
				_OperationStatusLabel = "Cisco IOS OSPF Protocol Parser completed.";
			}
			catch (Exception Ex)
			{
				_OperationStatusLabel = "Cisco IOS OSPF Protocol Parser failed with error : " + Ex.Message;
			}
		}

		public void Reset()
		{
			_router = null;
			_OperationStatusLabel = "Init";
			_ospfAreaLSAs = new Dictionary<OSPFArea, Dictionary<string, List<OSPFLSA>>>();
		}

		public ISpecializedProtocolParser ProtocolDependentParser(Enum protocol)
		{
			if (protocol is NeighborProtocol && (NeighborProtocol)protocol == NeighborProtocol.OSPF) return this;
			else return null;
		}

		public Enum[] SupportedProtocols => new Enum[] { NeighborProtocol.OSPF };

		public string SupportTag => "Cisco, IOS OSPF Protocol Parser module v2.0";

		#region IOSPFProtocolPArser implementation

		public void ProcessOSPFDatabase()
		{
			#region Query, parse and store LSAs
			string ospfOverView = _router.Session.ExecCommand("show ip ospf");
			string ospfAreaRouters = _router.Session.ExecCommand("show ip ospf database");
			string[] lines = ospfAreaRouters.SplitByLine();
			OSPFArea currentArea = null;
			string currentLSATypeName = "";
			List<OSPFLSA> LSAs = new List<OSPFLSA>();
			Dictionary<string, List<OSPFLSA>> OSPFLSAs = new Dictionary<string, List<OSPFLSA>>();
			foreach (string line in lines.Where(l => l != "").Select(l => l.Trim()))
			{
				try
				{
					if (line.ToLowerInvariant().Contains("link states (area "))
					{
						string AreaName = Regex.Match(line, @"(?<=\().*?(?=\))")?.Value;
						string thisAreaID = Regex.Match(AreaName, @"(?<=Area )[\d.]{0,99}")?.Value;
						string thisLSATypeName = Regex.Match(line.ToLowerInvariant(), @"^.*(?=(link))")?.Value;
						// line is like : Router Link States (Area 172.20.0.0)
						if (currentArea == null)
						{
							currentArea = new OSPFArea();
							currentArea.AreaID = thisAreaID.Trim();
							currentArea.AreaType = GetAreaType(currentArea.AreaID);
						}
						else if (thisAreaID != currentArea.AreaID)
						{
							// area ID is changing
							this._ospfAreaLSAs[currentArea] = OSPFLSAs;
							OSPFLSAs = new Dictionary<string, List<OSPFLSA>>();
							currentArea = new OSPFArea();
							currentArea.AreaID = thisAreaID.Trim();
							currentArea.AreaType = GetAreaType(currentArea.AreaID);
						}
						//--
						if (currentLSATypeName == "") currentLSATypeName = thisLSATypeName.Trim();
						else if (currentLSATypeName != thisLSATypeName)
						{
							// LSA Type is changing
							OSPFLSAs.Add(currentLSATypeName, LSAs);
							LSAs = new List<OSPFLSA>();
							currentLSATypeName = thisLSATypeName.Trim();
						}
					}
					else if (line.ToLowerInvariant().Contains("link states"))
					{
						// line is like : Type-5 AS External Link States
						// area is not changing, only the LSA Type
						string thisLSATypeName = Regex.Match(line.ToLowerInvariant(), @"^.*(?=(link))")?.Value;
						if (currentLSATypeName != "" && currentLSATypeName != thisLSATypeName)
						{
							// LSA Type is changing
							OSPFLSAs.Add(currentLSATypeName, LSAs);
							currentLSATypeName = thisLSATypeName;
						}
						LSAs = new List<OSPFLSA>();
					}
					else
					{
						string[] r = line.ToLowerInvariant().SplitBySpace();
						string firstWord = r[0].Trim();
						//if first word is ip address, then this is an LSA entry
						if (IPAddress.TryParse(firstWord, out IPAddress testIP))
						{
							// header : Link ID         ADV Router      Age Seq#       Checksum Link count
							// line is like :100.65.0.46     100.65.0.46     238         0x8000EBC3 0x00D97D 1
							string LSAID = firstWord;
							// The Adv Router should be the second word in thisLine
							string AdvRouter = r[1].Trim();
							OSPFLSA thisLSA = new OSPFLSA() { LSAType = currentLSATypeName, LSAID = LSAID, AdvRouter = AdvRouter };
							LSAs.Add(thisLSA);
						}
					}
				}
				catch (Exception Ex)
				{
					DebugEx.WriteLine("Cisco IOS OSPF Protocol Parser : unable to parse OSPF database line :" + line, DebugLevel.Warning);
				}
			}
			// add the last area router ID-s
			if (currentArea != null)
			{
				this._ospfAreaLSAs[currentArea] = OSPFLSAs;
			}
			#endregion

			#region Local functions
			OSPFAreaType GetAreaType(string AreaID)
			{
				try
				{
					if (AreaID == "0.0.0.0") return OSPFAreaType.Backbone;
					bool scanningAreaBlock = false;
					List<string> areaBlok = new List<string>();
					foreach (string line in ospfOverView.SplitByLine().Select(l => l.ToLowerInvariant().Trim()))
					{
						if (line.StartsWith(string.Format("area {0}", AreaID)))
						{
							if (scanningAreaBlock) break;
							scanningAreaBlock = true;
							continue;
						}
						if (scanningAreaBlock) areaBlok.Add(line);
					}
					if (areaBlok.Any(l => l.Contains("nssa"))) return OSPFAreaType.NSSA;
					if (areaBlok.Any(l => l.Contains("stub"))) return OSPFAreaType.Stub;
					if (areaBlok.Any(l => l.Contains("totally"))) return OSPFAreaType.TotallyStub;
					return OSPFAreaType.Normal;
				}
				catch (Exception Ex)
				{
					DebugEx.WriteLine("Cisco_IOS_OSPFParser.ProcessOSPFDatabase.GetAreaType() : unexpected error : " + Ex.Message);
					return OSPFAreaType.Unknown;
				}
			}
			#endregion
		}


		public OSPFArea[] OSPFAreas
		{
			get
			{
				if (_ospfAreaLSAs.Count == 0) ProcessOSPFDatabase();
				try
				{
					return _ospfAreaLSAs.Keys.ToArray();
				}
				catch
				{
					return new OSPFArea[] { };
				}
			}
		}

		/// <summary>
		/// Must return the list of the requested LSA Types of the given OSPF area
		/// </summary>
		/// <param name="OSPFArea"></param>
		/// <returns></returns>
		public OSPFLSA[] OSPFLSAs(OSPFArea OSPFArea, string LSATypeName)
		{
			if (_ospfAreaLSAs.Count == 0) ProcessOSPFDatabase();
			try
			{
				var areaLSAs = _ospfAreaLSAs[OSPFArea];
				var requestedLSAs = areaLSAs[LSATypeName];
				return requestedLSAs.ToArray();
			}
			catch
			{
				return new OSPFLSA[] { };
			}
		}

		/// <summary>
		/// Must return all the OSPF LSA Type Names this router is holding in its database
		/// </summary>
		public string[] OSPFLSATypes(OSPFArea OSPFArea)
		{
			if (_ospfAreaLSAs.Count == 0) ProcessOSPFDatabase();
			try
			{
				return _ospfAreaLSAs[OSPFArea].Keys.ToArray();
			}
			catch
			{
				return new string[] { };
			}
		}
		#endregion
	}
}
