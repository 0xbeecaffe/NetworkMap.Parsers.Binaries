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
using PGT.ExtensionInterfaces;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Net;
using System.Text.RegularExpressions;

namespace L3Discovery.Routers.JunOS
{
	public class JuniperEX : IRouter
	{
		#region Fields
		private IScriptableSession _session;
		private string _hostName;
		private string _versionInfo;
		private string _inventory;
		private string _systemSerial;
		private string _modelNumber;
		private int _stackCount = -1;
		private string _bgpASNumber;
		private string _operationStatusLabel = "";
		private PGTDataSet.ScriptSettingRow ScriptSettings;

		/// <summary>
		/// Router ID keyed by routing protocol
		/// </summary>
		private Dictionary<RoutingProtocol, string> _routerID = new Dictionary<RoutingProtocol, string>();

		/// <summary>
		/// Used as an internal cache for interface configurations to speed up subsequent queries for the same interface config
		/// </summary>
		private Dictionary<string, RouterInterface> _interfaces = new Dictionary<string, RouterInterface>();

		/// <summary>
		/// The list of routing protocols active on this router
		/// </summary>
		private List<RoutingProtocol> _runningRoutingProtocols;
		#endregion

		#region IRouter implementation
		public RoutingProtocol[] ActiveRoutingProtocols
		{
			get
			{
				if (_runningRoutingProtocols == null)
				{
					_runningRoutingProtocols = new List<L3Discovery.RoutingProtocol>();
					string response = _session.ExecCommand("show ospf overview");
					if (!response.Contains("not running") && !response.Contains("not valid"))
					{
						_runningRoutingProtocols.Add(L3Discovery.RoutingProtocol.OSPF);
					}

					response = _session.ExecCommand("show rip neighbor");
					if (!response.Contains("not running") && !response.Contains("not valid"))
					{
						_runningRoutingProtocols.Add(L3Discovery.RoutingProtocol.RIP);
					}

					response = _session.ExecCommand("show bgp neighbor");
					if (!response.Contains("not running") && !response.Contains("not valid"))
					{
						_runningRoutingProtocols.Add(L3Discovery.RoutingProtocol.BGP);
					}

					response = _session.ExecCommand("show configuration routing-options static ");
					if (response != "")
					{
						_runningRoutingProtocols.Add(L3Discovery.RoutingProtocol.STATIC);
					}
				}
				return _runningRoutingProtocols.ToArray();
			}
		}

		public string BGPAutonomousSystem
		{
			get
			{
				if (_bgpASNumber == null) CalculateRouterIDAndASNumber();
				return _bgpASNumber;
			}
		}

		public bool GetInterfaceConfiguration(RouterInterface checkInterface)
		{
			bool result = false;
			try
			{
				if (string.IsNullOrEmpty(checkInterface?.Name)) throw new ArgumentException("Interface parameter and/or interface name must not be null");
				if (_interfaces.ContainsKey(checkInterface.Name)) checkInterface.Configuration = _interfaces[checkInterface.Name].Configuration;
				else
				{
					checkInterface.Configuration = _session.ExecCommand(string.Format("show configuration interfaces {0}", checkInterface.Name));
					string desc = Regex.Match(checkInterface.Configuration, @"(?<=description ).*", RegexOptions.Compiled)?.Value;
					checkInterface.Description = desc.TrimEnd('\r');
					var ifIP = Regex.Match(checkInterface.Configuration, @"(?<=address )[\/\d.]{0,99}", RegexOptions.Compiled);
					if (ifIP.Success)
					{
						string[] addressAndMask = ifIP.Value.Split('/');
						checkInterface.Address = addressAndMask[0];
						checkInterface.MaskLength = addressAndMask.Length >= 2 ? addressAndMask[1] : "";
					}
					_interfaces.Add(checkInterface.Name, checkInterface);
				}
				result = true;
			}
			catch (Exception Ex)
			{
				string msg = string.Format("JunOS IRouter : error requesting interface configuration for {0} : {1}", checkInterface.Name, Ex.Message);
				DebugEx.WriteLine(msg);
			}
			return result;
		}

		public RouterInterface GetInterfaceByName(string InterfaceName)
		{
			RouterInterface result = null;
			if (string.IsNullOrEmpty(InterfaceName)) throw new ArgumentException("Invalid interface name");
			try
			{
				if (_interfaces.ContainsKey(InterfaceName)) result = _interfaces[InterfaceName];
				else
				{
					result = new RouterInterface() { Name = InterfaceName.Trim() };
					GetInterfaceConfiguration(result);
				}
			}
			catch (Exception Ex)
			{
				string msg = string.Format("JunOS IRouter : error requesting interface configuration for {0} : {1}", result.Name, Ex.Message);
				DebugEx.WriteLine(msg);
			}
			return result;
		}

		public string GetInterfaceNameByIPAddress(string Address)
		{
			if (string.IsNullOrEmpty(Address)) throw new ArgumentException("Invalid interface address. GetInterfaceNameByIPAddress requires a valid ip address to query.");
			string ifName = "";
			try
			{
				var foundIfName = _interfaces.Values.Where(c => c.Address == Address)?.Select(c => c.Name).FirstOrDefault();
				if (foundIfName == null)
				{
					string ifInfo = _session.ExecCommand(string.Format("show interfaces terse | match {0}", Address));
					// ifInfo should look like : "ge-0/0/9.0              up    up   inet     172.16.2.30/28  "
					string[] a = ifInfo.SplitBySpace();
					ifName = a[0];
				}
				else ifName = foundIfName;
			}
			catch (Exception Ex)
			{
				string msg = string.Format("JunOS IRouter : error finding interface name for ip address {0} : {1}", Address, Ex.Message);
				DebugEx.WriteLine(msg);
			}
			return ifName;
		}

		public string HostName
		{
			get { return _hostName; }
		}

		public bool Initialize(IScriptableSession session)
		{
			_session = session;
			ScriptSettings = SettingsManager.GetCurrentScriptSettings();
			_versionInfo = session.ExecCommand("show version");
			_hostName = session.GetHostName();
			return _versionInfo.ToLowerInvariant().Contains("junos");
		}

		public string Inventory
		{
			get
			{
				if (_inventory == null) _inventory = _session.ExecCommand("show chassis hardware");
				return _inventory;
			}
		}

		public string ManagementIP { get { return Session?.ConnectionParameters.DeviceIP; } }

		public string ModelNumber
		{
			get
			{
				if (_modelNumber == null) CalculateSystemSerial(); // this will calculate _modelNumber
				return _modelNumber;
			}
		}

		public string OperationStatusLabel
		{
			get
			{
				return this._operationStatusLabel;
			}
		}

		public string Platform { get { return "JunOS"; } }

		public void RegisterNHRP(INeighborRegistry registry)
		{
			try
			{
				string vrrpSummary = _session.ExecCommand("show vrrp summary");
				string[] vrrpSummaryLines = vrrpSummary.SplitByLine();
				// 
				// Sample input for parsing
				//
				//Interface State       Group VR state VR Mode Type   Address
				//irb.2100  up          210   master Active    lcl    10.37.24.2
				//																						 vip    10.37.24.1
				//irb.2200  up          220   master Active    lcl    10.37.26.2
				//																						 vip    10.37.26.1


				string VIPAddress = "";
				string GroupID = "";
				string PeerAddress = "";
				bool isActive = false;
				RouterInterface ri = null;
				foreach (string thisLine in vrrpSummaryLines)
				{
					if (thisLine.IndentLevel() == 0)
					{
						// interface definition is changing
						if (GroupID != "" && VIPAddress != "")
						{
							registry.RegisterNHRPPeer(this, ri, NHRPProtocol.VRRP, isActive, VIPAddress, GroupID, PeerAddress);
							VIPAddress = "";
							GroupID = "";
							PeerAddress = "";
							ri = null;
						}
						// 
						string[] words = thisLine.SplitBySpace();
						string ifName = words[0];
						isActive = thisLine.ToLowerInvariant().Contains("master");
						ri = GetInterfaceByName(ifName);
						GroupID = words[2];
						continue;
					}
					if (ri != null)
					{
						string[] words = thisLine.SplitBySpace();
						if (words.Length == 2)
						{
							switch (words[0])
							{
								case "lcl": break;
								case "mas": PeerAddress = words[1]; break;
								case "vip": VIPAddress = words[1]; break;
							}
						}
					}
				}
				// register the last one
				if (ri != null && VIPAddress != "" && GroupID != "")
				{
					registry.RegisterNHRPPeer(this, ri, NHRPProtocol.VRRP, isActive, VIPAddress, GroupID, PeerAddress);
				}
			}
			catch (Exception Ex)
			{
				string msg = string.Format("CiscoIOSRouter says : error processing NHRP interfaces : {0}", Ex.Message);
				DebugEx.WriteLine(msg);
			}
		}

		public void Reset()
		{
			_routerID = null;
			_hostName = null;
			_versionInfo = null;
			_inventory = null;
			_systemSerial = null;
			_modelNumber = null;
			_stackCount = -1;
			_bgpASNumber = null;
			_interfaces.Clear();
			_routerID.Clear();
			_runningRoutingProtocols.Clear();
		}

		public string RouterID(RoutingProtocol protocol)
		{
			if (_routerID.Count == 0) CalculateRouterIDAndASNumber();
			return _routerID.ContainsKey(protocol) ? _routerID[protocol] : "";
		}

		public RouteTableEntry[] RoutingTable
		{
			get
			{
				List<RouteTableEntry> parsedRoutes = new List<RouteTableEntry>();
				string routes = _session.ExecCommand("show route");
				MatchCollection knownNetworks = Regex.Matches(routes, @"\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b\/\d{1,2}", RegexOptions.Compiled);
				if (knownNetworks.Count > 0)
				{
					// insert actual routes
					for (int i = 0; i < knownNetworks.Count; i++)
					{
						string thisNetwork = knownNetworks[i].Value;
						int routeBlockStart = knownNetworks[i].Index;
						int routeBlockEnd = i == knownNetworks.Count - 1 ? routes.Length : knownNetworks[i + 1].Index;
						string thisRouteBlock = routes.Substring(routeBlockStart, routeBlockEnd - routeBlockStart);
						MatchCollection protocolBlocksHeaders = Regex.Matches(thisRouteBlock, @"[*[](.*?)\]", RegexOptions.Compiled);
						for (int j = 0; j < protocolBlocksHeaders.Count; j++)
						{
							string thisProtocolBlockHeader = protocolBlocksHeaders[j].Value;
							bool isBestRoute = thisProtocolBlockHeader.IndexOf("*[") >= 0;
							int protocolBlockStart = protocolBlocksHeaders[j].Index;
							int protocolBlockEnd = j == protocolBlocksHeaders.Count - 1 ? thisRouteBlock.Length : protocolBlocksHeaders[j + 1].Index;
							string thisProtocolBlock = thisRouteBlock.Substring(protocolBlockStart, protocolBlockEnd - protocolBlockStart);
							string thisProtocolName = Regex.Match(thisProtocolBlockHeader, @"[a-zA-Z,-]+", RegexOptions.Compiled)?.Value;
							string routePreference = Regex.Match(thisProtocolBlockHeader, @"[0-9]+", RegexOptions.Compiled)?.Value;
							thisProtocolName = thisProtocolName.Replace("-", ""); // access-internal -> accessinternal
							if (!Enum.TryParse<RoutingProtocol>(thisProtocolName.ToUpperInvariant(), true, out RoutingProtocol thisRoutingProtocol))
							{
								DebugEx.WriteLine("JunOS router is unable to parse routing protocol name : " + thisProtocolName);
								continue;
							}
							string nextHopAddress = Regex.Match(thisProtocolBlock, @"(?<=to )[\d\.]{0,99}", RegexOptions.Compiled)?.Value;
							string routeTag = Regex.Match(thisProtocolBlock, @"(?<=tag )[\d\.]{0,99}", RegexOptions.Compiled)?.Value;
							string outInterface = Regex.Match(thisProtocolBlock, @"(?<=via ).*", RegexOptions.Compiled)?.Value;
							try
							{
								RouteTableEntry re = new RouteTableEntry();
								// get the router ID corresponding to protocol, or get the router ID for the most preferred routing protocol
								if (_routerID.ContainsKey(thisRoutingProtocol)) re.RouterID = _routerID[thisRoutingProtocol];
								else re.RouterID = _routerID[_routerID.Keys.OrderBy(k => (int)k).First()];
								string[] prefixAndMask = thisNetwork.Split('/');
								re.Prefix = prefixAndMask[0];
								re.MaskLength = int.Parse(prefixAndMask[1]);
								re.Protocol = thisProtocolName.ToUpperInvariant();
								re.AD = routePreference;
								re.Metric = "";
								re.NextHop = nextHopAddress;
								re.Best = isBestRoute;
								re.Tag = routeTag;
								re.OutInterface = outInterface.TrimEnd('\r');
								parsedRoutes.Add(re);
							}
							catch (Exception Ex)
							{
								string msg = string.Format("JunOS IRouter : error processing route table : {0}", Ex.Message);
								DebugEx.WriteLine(msg);
							}
						}
					}
				}
				return parsedRoutes.ToArray();
			}
		}

		public RouterInterface[] RoutedInterfaces
		{
			get
			{
				List<RouterInterface> fi = new List<RouterInterface>();
				try
				{
					string inetInterfaces = _session.ExecCommand("show interfaces terse | match inet");

					foreach (string line in inetInterfaces.SplitByLine())
					{
						try
						{
							string[] words = line.SplitBySpace();
							if (words.Length >= 5)
							{
								// words should look like : xe-0/0/25.0,up,up,inet,172.20.1.18/31 
								string ifName = words[0];


								if (!ifName.StartsWith("bme"))
								{
									string[] ifIPAndMask = words[4].Split('/');
									IPAddress ipa;
									if (IPAddress.TryParse(ifIPAndMask[0], out ipa))
									{
										RouterInterface ri = new RouterInterface();
										ri.Name = ifName;
										ri.Address = ifIPAndMask[0];
										ri.MaskLength = ifIPAndMask.Length >= 2 ? ifIPAndMask[1] : "";
										ri.Status = string.Format("{0},{1}", words[1], words[2]);
										if (_interfaces.ContainsKey(ri.Name)) ri.Configuration = _interfaces[ri.Name].Configuration;
										fi.Add(ri);
									}
								}
							}
						}
						catch (Exception Ex)
						{
							string msg = string.Format("JunOS IRouter : error processing routed interfaces : {0}", Ex.Message);
							DebugEx.WriteLine(msg);
						}
					}
				}
				catch (Exception Ex)
				{
					string msg = string.Format("JunOS IRouter : error processing routed interfaces : {0}", Ex.Message);
					DebugEx.WriteLine(msg);
				}
				return fi.ToArray();
			}
		}

		public IScriptableSession Session { get { return _session; } }

		public int StackCount
		{
			get
			{
				if (_stackCount == -1)
				{
					var FPCs = Regex.Matches(Inventory, @"FPC \d.*");
					_stackCount = FPCs.Count;
				}
				return _stackCount;
			}
		}

		public string SupportTag => "Juniper, JunOS, Router Module for EX/QFX/MX/SRX v0.97";

		public string SystemSerial
		{
			get
			{
				if (_systemSerial == null) CalculateSystemSerial();
				return _systemSerial;
			}
		}

		public string Type
		{
			get
			{
				// Type can be Switch, Router or Firewall, depending on Model
				string modelLine = Version.ToLower().SplitByLine().First(l => l.StartsWith("model:"));
				if (!string.IsNullOrEmpty(modelLine))
				{
					string model = modelLine.Split(':')[1].Trim();
					if (model.StartsWith("ex")) return "Switch";
					else if (model.StartsWith("mx")) return "Router";
					else if (model.StartsWith("srx")) return "Firewall";
					else return "Unknown";
				}
				else return "Unknown";
			}
		}

		public string Vendor { get { return "JunOS"; } }

		public string Version
		{
			get
			{
				if (_versionInfo == null) _versionInfo = _session.ExecCommand("show version");
				return _versionInfo;
			}
		}

		#endregion

		#region Private members
		private void CalculateRouterIDAndASNumber()
		{
			#region get global router ID if exists
			string globalRouterID = "";
			string routingOptions = _session.ExecCommand("show configuration routing-options");
			Match m = Regex.Match(routingOptions, @"(?<=router-id )[\d.]{0,99}");
			if (m.Success) globalRouterID = m.Value;
			else globalRouterID = ManagementIP;
			#endregion

			#region  get routerID for all routing protocols this router is running
			foreach (RoutingProtocol thisPprotocol in ActiveRoutingProtocols.OrderBy(p => p))
			{
				switch (thisPprotocol)
				{
					case RoutingProtocol.BGP:
						{
							string bgpNeighbors = _session.ExecCommand("show bgp neighbor");
							m = Regex.Match(bgpNeighbors, @"(?<=Local ID: )[\d.]{0,99}");
							if (m.Success) _routerID[thisPprotocol] = m.Value;
							else _routerID[thisPprotocol] = globalRouterID; // fall back to global
																															// get also the BGP AS number
							var ASes = Regex.Matches(bgpNeighbors, @"(?<=AS )[\d.]{0,99}", RegexOptions.Compiled);
							if (ASes.Count >= 2) _bgpASNumber = ASes[1].Value;
							else
							{
								m = Regex.Match(routingOptions, @"(?<=autonomous-system )[\d.]{0,99}");
								if (m.Success) _bgpASNumber = m.Value;
							}
							break;
						}
					case RoutingProtocol.OSPF:
						{
							string ospfStatus = _session.ExecCommand("show ospf overview");
							m = Regex.Match(ospfStatus, @"(?<=Router ID: )[\d.]{0,99}");
							if (m.Success) _routerID[thisPprotocol] = m.Value;
							else _routerID[thisPprotocol] = globalRouterID; // fall back to global
							break;
						}
					case RoutingProtocol.RIP:
					case RoutingProtocol.STATIC:
						{
							_routerID[thisPprotocol] = globalRouterID; // fall back to global
							break;
						}
					default: _routerID[thisPprotocol] = globalRouterID; break;
				}
			}
			#endregion
		}

		private void CalculateSystemSerial()
		{
			// some switches does not support the "show inventory" command
			bool exec_error = Inventory.ToLowerInvariant().Contains("invalid input detected") || ScriptSettings.FailedCommandPattern.SplitBySemicolon().Any(w => Inventory.IndexOf(w) >= 0);
			if (exec_error)
			{
				DebugEx.WriteLine(String.Format("JunOS IRouter : switch does not support \"show chassis hardware\" command, parsing version information"), DebugLevel.Debug);
				// try to parse sh_version to get system serial numbers      
				try
				{
					_systemSerial = string.Join(",", _versionInfo.SplitByLine().Where(l => l.StartsWith("System serial number")).Select(l => l.Split(':')[1].Trim()));
				}
				catch (Exception Ex)
				{
					DebugEx.WriteLine(String.Format("JunOS IRouter : error searching serial number in \"sh version\" output : {0}", Ex.InnerExceptionsMessage()), DebugLevel.Debug);
				}
			}
			else
			{
				switch (Type)
				{
					case "Switch":
						{
							// Assuming an EX / QFX series switch
							var FPCs = Regex.Matches(Inventory, @"FPC \d.*");
							foreach (Match thisFPC in FPCs)
							{
								string[] fpcLineWords = thisFPC.Value.SplitBySpace();
								// words should look like:FPC,0,REV,19,650-044931,PE3716200032,EX4300-48T
								// serial number should be words[5]
								_systemSerial += (";" + fpcLineWords[5]);
								_modelNumber += (";" + fpcLineWords[6]);
							}
							_systemSerial = _systemSerial?.TrimStart(';');
							_modelNumber = _modelNumber?.TrimStart(';');
							break;
						}
					case "Firewall":
						{
							// Assuming SRX firewall
							var FPCs = Regex.Matches(Inventory, @"\bChassis.*\b");
							foreach (Match thisFPC in FPCs)
							{
								string[] chassisLineWords = thisFPC.Value.SplitBySpace();
								// expecting chassisLineWords as : Chassis,BU4913AK0887,SRX240H2
								_systemSerial += (";" + chassisLineWords[1]);
								_modelNumber += (";" + chassisLineWords[2]);
							}
							_systemSerial = _systemSerial?.TrimStart(';');
							_modelNumber = _modelNumber?.TrimStart(';');
							break;
						}
					case "Router":
						{
							// not yet implemented
							_systemSerial = "?";
							_modelNumber = "?";
							break;
						}
				}
			}
		}
		#endregion
	}
}