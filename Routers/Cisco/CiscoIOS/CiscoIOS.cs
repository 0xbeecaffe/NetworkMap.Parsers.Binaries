#define DEBUG
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

using PGT;
using PGT.Common;
using PGT.ExtensionInterfaces;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Net;
using System.Reflection;
using System.Text.RegularExpressions;

namespace L3Discovery.Routers.CiscoIOS
{
	public class CiscoIOSRouter : IRouter
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
		private const string _internalClassVersion = "v2.00";
		private PGTDataSet.ScriptSettingRow ScriptSettings;
		// There is no global router ID settings in IOS. Therefore, we will prefer BGP then OSPF RouterID, but 
		// we still need to determine a default routerID in case no dynamic routing protocol is running only STATIC.
		// To calculate this, we will use the same logic as BGP does : prefer the lowest numbered loopback interface ip address
		// then select the highest ip address from all interfaces if no loopback present.
		// if still bot found, use the current management address.

		/// <summary>
		/// The default router ID 
		/// </summary>
		private string defaultlRouterID = "";

		/// <summary>
		/// Router ID keyed by routing protocol
		/// </summary>
		private Dictionary<NeighborProtocol, string> _routerID = new Dictionary<NeighborProtocol, string>();

		/// <summary>
		/// Used as an internal cache for interface configurations to speed up subsequent queries for the same interface config
		/// </summary>
		private Dictionary<string, RouterInterface> _interfaces = new Dictionary<string, RouterInterface>();

		/// <summary>
		/// The list of routing protocols active on this router
		/// </summary>
		private List<NeighborProtocol> _runningNeighborProtocols;
		#endregion

		#region Constructors
		public CiscoIOSRouter()
		{
			if (DebugEx.DebugLevelThreshold >= DebugLevel.Full)
			{
				Assembly curAssembly = Assembly.GetAssembly(typeof(CiscoIOSRouter));
				DebugEx.WriteLine(string.Format("{0}.ctor() : class instantiated from {1}. Internal class version : {2}", this.GetType().FullName, curAssembly, _internalClassVersion), DebugLevel.Full);
			}
			else DebugEx.WriteLine(string.Format("{0}.ctor() : class instantiated", this.GetType().FullName), DebugLevel.Informational);
		}
		#endregion

		#region IRouter implementation
		/// <summary>
		/// Must return the list of static and dynamic routing protocols active on this router. 
		/// </summary>
		public Enum[] ActiveProtocols
		{
			get
			{
				if (_runningNeighborProtocols == null)
				{
					_runningNeighborProtocols = new List<L3Discovery.NeighborProtocol>();


					string response = _session.ExecCommand("show ip protocols");
					if (response != "")
					{
						var protocolLines = response.SplitByLine().Where(l => l.Trim().ToLowerInvariant().StartsWith("routing protocol is"));
						foreach (string thisprotocolLine in protocolLines)
						{
							foreach (NeighborProtocol thisProtocol in Enum.GetValues(typeof(NeighborProtocol)))
							{
								if (thisprotocolLine.Contains(thisProtocol.ToString().ToLowerInvariant()))
								{
									_runningNeighborProtocols.Add(thisProtocol);
									break;
								}
							}
						}
					}

					response = _session.ExecCommand("show ip route static");
					if (!string.IsNullOrEmpty(response)) _runningNeighborProtocols.Add(NeighborProtocol.STATIC);

					response = _session.ExecCommand("show cdp");
					if (!response.ToLowerInvariant().Contains("not enabled")) _runningNeighborProtocols.Add(NeighborProtocol.CDP);
				}
				DebugEx.WriteLine(string.Format("CiscoIOSRouter : Routing protocols active on {0} : {1}", ManagementIP, string.Join(",", _runningNeighborProtocols.Select(p => p.ToString()))), DebugLevel.Full);
				return _runningNeighborProtocols.Cast<Enum>().ToArray();
			}
		}

		/// <summary>
		/// Must return the BGP AS number the router is member of
		/// </summary>
		/// <param name="session"></param>
		/// <returns></returns>
		public string BGPAutonomousSystem
		{
			get
			{
				if (_bgpASNumber == null) CalculateRouterIDAndASNumber();
				return _bgpASNumber;
			}
		}

		/// <summary>
		/// Must return the RouterInterface for the specified interface name
		/// </summary>
		/// <param name="session"></param>
		/// <returns></returns>

		public RouterInterface GetInterfaceByName(string InterfaceName)
		{
			RouterInterface result = null;
			if (string.IsNullOrEmpty(InterfaceName)) throw new ArgumentException("Invalid interface name");
			try
			{
				result = GetRouterinterfaceFromCacheByName(InterfaceName);
				if (result == null)
				{
					result = new RouterInterface() { Name = InterfaceName.Trim() };
					GetInterfaceConfiguration(result);
				}
			}
			catch (Exception Ex)
			{
				string msg = string.Format("CiscoIOSRouter says : error requesting interface configuration for {0} : {1}", result.Name, Ex.Message);
				DebugEx.WriteLine(msg);
			}
			return result;
		}

		/// <summary>
		/// Must return the name of the interface that has the specified IPv4 address
		/// </summary>
		/// <param name="session"></param>
		/// <returns></returns>
		public string GetInterfaceNameByIPAddress(string Address)
		{
			if (string.IsNullOrEmpty(Address)) throw new ArgumentException("Invalid interface address. GetInterfaceNameByIPAddress requires a valid ip address to query.");
			string ifName = "";
			try
			{
				var foundIfName = _interfaces.Values.Where(c => c.Address == Address)?.Select(c => c.Name).FirstOrDefault();
				if (foundIfName == null)
				{
					string ifInfo = _session.ExecCommand(string.Format("show ip int brief | i {0}", Address));
					// ifInfo should look like : "Loopback0                  145.233.26.165  YES NVRAM  up                    up      "
					string[] a = ifInfo.SplitBySpace();
					ifName = a[0];
				}
				else ifName = foundIfName;
			}
			catch (Exception Ex)
			{
				string msg = string.Format("CiscoIOSRouter IRouter says : error finding interface name for ip address {0} : {1}", Address, Ex.Message);
				DebugEx.WriteLine(msg);
			}
			return ifName;
		}

		/// <summary>
		/// Must update the configuration of the requested interface 
		/// </summary>
		/// <param name="checkInterface">The interface whose configuration to return</param>
		/// <returns></returns>
		public bool GetInterfaceConfiguration(RouterInterface checkInterface)
		{
			bool result = false;
			try
			{
				if (string.IsNullOrEmpty(checkInterface?.Name)) throw new ArgumentException("Interface parameter and/or interface name must not be null");
				string shortIfName = Common.CiscoInterfaceNameToShortVersion(checkInterface.Name);
				string longIfName = Common.CiscoInterfaceNameToLongVersion(checkInterface.Name);
				checkInterface.Configuration = GetRouterinterfaceFromCacheByName(checkInterface.Name)?.Configuration;
				if (checkInterface.Configuration == null)
				{
					// was not found in cache
					checkInterface.Configuration = _session.ExecCommand(string.Format("show run interface {0}", shortIfName));
					bool authorizationFailure = checkInterface.Configuration.ToLowerInvariant().Contains("command authorization failed");
					if (authorizationFailure)
					{
						// in case of authorization failure, we can still find the interface ip
						string[] ipintbrief = _session.ExecCommand(string.Format("show ip interface brief {0}", shortIfName)).SplitByLine();
						// response should look like : GigabitEthernet0/1         10.37.0.2       YES NVRAM  up                    up
						// but Cico routers use long and short interface names in a mixed way, let's check both
						string foundline = ipintbrief.FirstOrDefault(l => l.ToLowerInvariant().StartsWith(shortIfName) || l.ToLowerInvariant().StartsWith(longIfName));
						if (foundline != null)
						{
							string[] words = foundline.SplitBySpace();
							if (words.Length > 1 && IPAddress.TryParse(words[1], out IPAddress ipa) && ipa.ToString() == words[1])
							{
								checkInterface.Address = words[1];
								checkInterface.MaskLength = "32";
							}
						}
					}
					else
					{
						bool execFailure = checkInterface.Configuration.ToLowerInvariant().Contains("invalid");
						if (execFailure) throw new InvalidOperationException(string.Format("CiscoIOSRouter.GetInterfaceConfiguration :  unable to find interface <{0}>", shortIfName));
						string desc = Regex.Match(checkInterface.Configuration, @"(?<=description ).*", RegexOptions.Compiled)?.Value;
						checkInterface.Description = desc.TrimEnd('\r');
						var ifIP = Regex.Match(checkInterface.Configuration, @"(?<=address )[\/\d.]{0,99}", RegexOptions.Compiled);
						if (ifIP.Success)
						{
							string[] addressAndMask = ifIP.Value.Split('/');
							checkInterface.Address = addressAndMask[0];
							checkInterface.MaskLength = addressAndMask.Length >= 2 ? addressAndMask[1] : "";
						}
					}
					result = true;
					_interfaces.Add(shortIfName, checkInterface);
				}
				else result = true;
			}
			catch (Exception Ex)
			{
				string msg = string.Format("CiscoIOSRouter says : error requesting interface configuration for {0} on router {1} ({2}) : {3}", checkInterface.Name, HostName, ManagementIP, Ex.Message);
				DebugEx.WriteLine(msg);
			}
			return result;
		}

		/// <summary>
		/// Checks the _interfaces list using both short- and long interface names
		/// </summary>
		/// <param name="ifName"></param>
		/// <returns></returns>
		private RouterInterface GetRouterinterfaceFromCacheByName(string ifName)
		{
			string shortName = Common.CiscoInterfaceNameToShortVersion(ifName);
			string longname = Common.CiscoInterfaceNameToLongVersion(ifName);
			if (_interfaces.ContainsKey(shortName)) return _interfaces[shortName];
			else if (_interfaces.ContainsKey(longname)) return _interfaces[longname];
			else return null;
		}

		/// <summary>
		/// Must return the host name of the device
		/// </summary>
		/// <param name="session"></param>
		/// <returns></returns>
		public string HostName
		{
			get { return _hostName; }
		}

		/// <summary>
		/// Can implement any initialization required for implementing class. Must return true if the connected device is supported by the implementing class.
		/// </summary>
		/// <param name="session"></param>
		public bool Initialize(IScriptableSession session)
		{
			DebugEx.WriteLine(string.Format("{0}.Initialize() : querying device for session {1} ", GetType().FullName, session.ConnectionParameters.DeviceIP), DebugLevel.Full);
			_session = session;
			ScriptSettings = SettingsManager.GetCurrentScriptSettings();
			if (ScriptSettings != null)
			{
				_versionInfo = session.ExecCommand("show version");
				_hostName = session.GetHostName();
				bool isCisco = _versionInfo.ToLowerInvariant().Contains("cisco");
				DebugEx.WriteLine(string.Format("{0}.Initialize() : returning {1}, based on {2} ", GetType().FullName, isCisco, _versionInfo), DebugLevel.Full);
				return isCisco;
			}
			else
			{
				DebugEx.WriteLine(string.Format("Unable to initialize {0} because ScriptSettings could not be retrieved", GetType().FullName));
				return false;
			}
		}

		/// <summary>
		/// Must be implemented to return device inventory information
		/// </summary>
		public string Inventory
		{
			get
			{
				if (_inventory == null) _inventory = _session.ExecCommand("show inventory");
				return _inventory;
			}
		}

		/// <summary>
		/// Must return the Management IP of the router
		/// </summary>
		public string ManagementIP { get { return Session?.ConnectionParameters.DeviceIP; } }

		/// <summary>
		/// Must return the device model number
		/// </summary>
		/// <param name="session"></param>
		/// <returns></returns>
		public string ModelNumber
		{
			get
			{
				if (_modelNumber == null)
				{
					Match m = Regex.Match(Inventory, @"(?<=DESCR:).*", RegexOptions.Compiled);
					if (m.Success) _modelNumber = m.Value;
					else _modelNumber = "n/a";
					_modelNumber = _modelNumber?.Trim('\r');
				}
				return _modelNumber;
			}
		}

		/// <summary>
		/// Can return a text describing the current operation in progress
		/// </summary>
		public string OperationStatusLabel
		{
			get
			{
				return this._operationStatusLabel;
			}
		}

		/// <summary>
		/// Must return a string representing the device platform
		/// </summary>
		public string Platform { get { return "IOS"; } }

		public void RegisterNHRP(INeighborRegistry registry)
		{
			try
			{
				string standyInterfaces = _session.ExecCommand("show standby");
				string[] standbyIntfLines = standyInterfaces.SplitByLine();
				// 
				// Sample input for parsing
				//
				//GigabitEthernet0/0/1 - Group 44
				//  State is Active
				//	  5 state changes, last state change 4w4d
				//  Virtual IP address is 10.81.0.1
				//  Active virtual MAC address is 0000.0c07.ac2c(MAC In Use)
				//	  Local virtual MAC address is 0000.0c07.ac2c(v1 default)
				//  Hello time 1 sec, hold time 3 sec
				//	  Next hello sent in 0.256 secs
				//  Authentication text, string "ROWVA252"
				//  Preemption enabled, delay min 60 secs
				//  Active router is local
				//  Standby router is 10.81.0.3, priority 100 (expires in 3.040 sec)
				//  Priority 105 (configured 105)
				//			Track object 1 state Up decrement 10
				//  Group name is "hsrp-Gi0/0/1-44" (default)


				string VIPAddress = "";
				string GroupID = "";
				string PeerAddress = "";
				bool isActive = false;
				RouterInterface ri = null;
				foreach (string thisLine in standbyIntfLines)
				{
					if (thisLine.IndentLevel() == 0)
					{
						// interface definition is changing
						if (GroupID != "" && VIPAddress != "")
						{
							registry.RegisterNHRPPeer(this, ri, NHRPProtocol.HSRP, isActive, VIPAddress, GroupID, PeerAddress);
							VIPAddress = "";
							GroupID = "";
							PeerAddress = "";
							ri = null;
						}
						// 
						string[] words = thisLine.SplitBySpace();
						string ifName = words[0];
						ri = GetInterfaceByName(ifName);
						Match m = Regex.Match(thisLine, @"(?<=Group )\d{0,99}", RegexOptions.Compiled);
						if (m.Success) GroupID = m.Value;
						continue;
					}
					if (ri != null)
					{
						if (thisLine.ToLowerInvariant().Trim().StartsWith("virtual ip address is"))
						{
							Match m = Regex.Match(thisLine, @"\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b", RegexOptions.Compiled);
							if (m.Success) VIPAddress = m.Value;
							continue;
						}
						if (thisLine.ToLowerInvariant().Trim().StartsWith("active router is local"))
						{
							isActive = true;
							continue;
						}
						if (thisLine.ToLowerInvariant().Trim().StartsWith("standby router is"))
						{
							Match m = Regex.Match(thisLine, @"\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b", RegexOptions.Compiled);
							if (m.Success) PeerAddress = m.Value;
						}
					}

				}
				// register the last one
				if (ri != null && VIPAddress != "" && GroupID != "")
				{
					registry.RegisterNHRPPeer(this, ri, NHRPProtocol.HSRP, isActive, VIPAddress, GroupID, PeerAddress);
				}
			}
			catch (Exception Ex)
			{
				string msg = string.Format("CiscoIOSRouter says : error processing NHRP interfaces : {0}", Ex.Message);
				DebugEx.WriteLine(msg);
			}
		}

		/// <summary>
		/// Instructs the router object to reset its internal state and cache if any.
		/// All new queries against properties should return live data.
		/// </summary>
		public void Reset()
		{
			_hostName = null;
			_versionInfo = null;
			_inventory = null;
			_systemSerial = null;
			_modelNumber = null;
			_stackCount = -1;
			_bgpASNumber = null;
			_interfaces.Clear();
			_routerID.Clear();
			_runningNeighborProtocols.Clear();
		}

		/// <summary>
		/// Must return the router ID of the connected device for the specific protocol
		/// </summary>
		/// <param name="session"></param>
		/// <returns></returns>
		public string RouterID(NeighborProtocol protocol)
		{
			if (_routerID.Count == 0) CalculateRouterIDAndASNumber();
			return (_routerID.ContainsKey(protocol)) ? _routerID[protocol] : defaultlRouterID;
		}

		/// <summary>
		/// Must return the full routing table of the device
		/// </summary>
		/// <param name="session"></param>
		/// <returns></returns>
		public RouteTableEntry[] RoutingTable
		{
			get
			{
				List<RouteTableEntry> parsedRoutes = new List<RouteTableEntry>();
				try
				{
					string routes = "";
					#region Get route table
					string routeSummary = _session.ExecCommand("show ip route summary");
					// 
					// Example output
					//
					// xyz#sh ip route summary 
					// IP routing table name is default(0x0)
					// IP routing table maximum-paths is 32
					// Route Source    Networks Subnets     Replicates Overhead    Memory(bytes)
					// connected       0           6           0           528         1728
					// static          1           6           0           616         2016
					// application     0           0           0           0           0
					// bgp 199563      190399      501894      0           60921784    199380384

					//	External: 690892 Internal: 1401 Local: 0
					// internal        7047                                            53772096
					// Total           197447      501906      0           60922928    253156224
					// xyz#
					string routeTotals = routeSummary.SplitByLine().FirstOrDefault(l => l.ToLowerInvariant().StartsWith("total"));
					if (routeTotals != null)
					{
						string[] w = routeTotals.SplitBySpace();
						if (w.Length >= 2 && int.TryParse(w[1], out int nCount))
						{
							if (nCount > 30000)
							{
								// this would be too much to retrieve via terminal connection, get only default route
								routes = _session.ExecCommand("show ip route 0.0.0.0");
							}
							else routes = _session.ExecCommand("show ip route");
						}
					}
					else
					{
						routes = _session.ExecCommand("show ip route");
					}
					#endregion
					string[] routeLines = routes.SplitByLine();
					if (Version.ToLowerInvariant().Contains("ios-xe software"))
					{
						// Parsing output for Cisco IOS-XE Software
						if (routeLines.Length > 0)
						{
							// insert actual routes
							NeighborProtocol thisProtocol = NeighborProtocol.UNKNOWN;
							bool expectingNextHop = false;
							string prefix = "";
							int maskLength = -1;
							string subnettedPrefix = "";
							int subnettedMaskLength = -1;
							string nextHop = "";
							string adminDistance = "";
							string routeMetric = "";
							bool parserSuccess = false;
							string outInterface = "";
							foreach (string rLine in routeLines.Select(l => l.Trim()))
							{
								// if the line contains the expression "subnetted" then we will learn the subnet mask for upcoming route entries and continue the loop
								if (rLine.Contains("subnetted"))
								{
									// lets check if we find an ipAddress/MaskLength combination in the line
									Match prefixFound = Regex.Match(rLine, @"\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b\/\d{1,2}", RegexOptions.Compiled);
									if (prefixFound.Success)
									{
										string[] prefixAndMask = prefixFound.Value.Split('/');
										if (prefixAndMask.Length == 2 && int.TryParse(prefixAndMask[1], out subnettedMaskLength))
										{
											subnettedPrefix = prefixAndMask[0];
										}
									}
									// proceed to next rLine
									continue;
								}
								if (rLine.StartsWith("B"))
								{
									thisProtocol = NeighborProtocol.BGP;
									expectingNextHop = false;
								}
								else if (rLine.StartsWith("O") || rLine.StartsWith("IA") || rLine.StartsWith("N1") || rLine.StartsWith("N2") || rLine.StartsWith("E1") || rLine.StartsWith("E2"))
								{
									thisProtocol = NeighborProtocol.OSPF;
									expectingNextHop = false;
								}
								else if (rLine.StartsWith("D") || rLine.StartsWith("EX"))
								{
									thisProtocol = NeighborProtocol.EIGRP;
									expectingNextHop = false;
								}
								else if (rLine.StartsWith("R"))
								{
									thisProtocol = NeighborProtocol.RIP;
									expectingNextHop = false;
								}
								else if (rLine.StartsWith("L"))
								{
									thisProtocol = NeighborProtocol.LOCAL;
									expectingNextHop = false;
								}
								else if (rLine.StartsWith("C"))
								{
									thisProtocol = NeighborProtocol.CONNECTED;
									expectingNextHop = false;
								}
								else if (rLine.StartsWith("S"))
								{
									thisProtocol = NeighborProtocol.STATIC;
									expectingNextHop = false;
								}
								else if (rLine.StartsWith("[") && expectingNextHop) ; // this is an empty statement on purpose !
								else
								{
									thisProtocol = NeighborProtocol.UNKNOWN;
									expectingNextHop = false;
								}
								// reset variables if current line is not a continuation
								if (!expectingNextHop)
								{
									prefix = "";
									maskLength = -1;
									nextHop = "";
									adminDistance = "";
									routeMetric = "";
									parserSuccess = false;
									outInterface = "";
								}
								if (thisProtocol != NeighborProtocol.UNKNOWN)
								{
									if (thisProtocol == NeighborProtocol.LOCAL || thisProtocol == NeighborProtocol.CONNECTED)
									{
										// we expect only one ip addresses in these lines which is the prefix
										Match m = Regex.Match(rLine, @"\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b\/\d{1,2}", RegexOptions.Compiled);
										if (m.Success)
										{
											string s = m.Value;
											string[] prefixAndMask = s.Split('/');
											prefix = prefixAndMask[0];
											maskLength = int.Parse(prefixAndMask[1]);
											expectingNextHop = true;
											// this line should also contain the out interface as the last word
											string[] words = rLine.SplitByComma();
											outInterface = words[words.Length - 1];
											expectingNextHop = false;
											parserSuccess = true;
										}
									}
									else
									{
										if (!expectingNextHop)
										{
											// we expect two ip addresses in these lines, first is the prefix and second is next-hop
											// check for the prefix first
											Match m = Regex.Match(rLine, @"\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b\/\d{1,2}", RegexOptions.Compiled);
											if (m.Success)
											{
												string s = m.Value;
												string[] prefixAndMask = s.Split('/');
												prefix = prefixAndMask[0];
												maskLength = int.Parse(prefixAndMask[1]);
												expectingNextHop = true;
											}
											else
											{
												// check if we find an ip address in line and if it was a subnet of last prefix

												// unfortunately logic seems to be broken in cas of some IOS-XE, like below route table entry is totally crap :
												//     159.63.0.0 / 27 is subnetted, 2 subnets
												// S        159.63.248.32[1 / 0] via 212.162.30.89
												// S        159.63.248.96[1 / 0] via 212.162.30.89

											  m = Regex.Match(rLine, @"\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}", RegexOptions.Compiled);
												
												// Due to above issue , below check does not work and we need to trust the subnettedPrefix value anyhow
												// if (m.Success && IPOperations.IsIPAddressInNetwork(m.Value, subnettedPrefix, subnettedMaskLength))

												if (m.Success)
												{
													// the maskLength is still valid for this prefix
													prefix = m.Value;
													maskLength = subnettedMaskLength;
													expectingNextHop = true;
												}
											}
										}
										if (expectingNextHop)
										{
											// get next-hop
											Match m = Regex.Match(rLine, @"(?<=via )\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}", RegexOptions.Compiled);
											if (m.Success)
											{
												expectingNextHop = false;
												parserSuccess = true;
												nextHop = m.Value;
												// get preference
												m = Regex.Match(rLine, @"\[(.*?)\]");
												if (m.Success)
												{
													string[] preferences = m.Value.Split('/');
													adminDistance = preferences[0].TrimStart('[');
													routeMetric = preferences[1].TrimEnd(']');
												}
												// this line should also contain the out interface
												string[] words = rLine.SplitByComma();
												if (words.Length > 1)
												{
													outInterface = words[words.Length - 1];
													// discard outInterface if not a real interface name, like matches date pattern
													if (Regex.IsMatch(outInterface, @"(\d{1,2}w\d{1,2}d)|(\d{1,2}d\d{1,2}h)", RegexOptions.Compiled)) outInterface = "";
												}
											}
											else expectingNextHop = true; // only for debugging
										}

									}
								}
								if (parserSuccess)
								{
									try
									{
										RouteTableEntry re = new RouteTableEntry();
										re.RouterID = RouterID(thisProtocol);
										re.Prefix = prefix;
										re.MaskLength = maskLength;
										re.Protocol = thisProtocol.ToString();
										re.AD = adminDistance;
										re.Metric = routeMetric;
										re.NextHop = nextHop;
										re.OutInterface = outInterface;
										re.Best = true; // the show ip route output only lists best routes :-(
										re.Tag = "";
										parsedRoutes.Add(re);
									}
									catch (Exception Ex)
									{
										string msg = string.Format("CiscoIOSRouter.RoutingTable() : error processing route table : {0}", Ex.Message);
										DebugEx.WriteLine(msg);
									}
								}
							}
						}
					}
					else
					{
						// Parsing output for non IOS-XE Software
						if (routeLines.Length > 0)
						{
							// insert actual routes
							NeighborProtocol thisProtocol = NeighborProtocol.UNKNOWN;
							string prefix = "";
							int maskLength = -1;
							string nextHop = "";
							string adminDistance = "";
							string routeMetric = "";
							bool parserSuccess = false;
							string outInterface = "";
							foreach (string rLine in routeLines.Select(l => l.Trim()))
							{
								string[] words = rLine.SplitBySpace();
								// lets check if we find an ipAddress/MaskLength combination in the line
								Match prefixFound = Regex.Match(rLine, @"\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b\/\d{1,2}", RegexOptions.Compiled);
								// or just an ipAddress
								Match addressFound = Regex.Match(rLine, @"\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}", RegexOptions.Compiled);
								// if the line contains the expression "subnetted" then we will learn the subnet mask for upcoming route entries and continue the loop
								if (rLine.Contains("subnetted") && prefixFound.Success)
								{
									string[] addressAndMask = prefixFound.Value.Split('/');
									if (addressAndMask.Length == 2) int.TryParse(addressAndMask[1], out maskLength);
									// proceed to next rLine
									continue;
								}
								if (prefixFound.Success)
								{
									string[] addressAndMask = prefixFound.Value.Split('/');
									if (addressAndMask.Length == 2)
									{
										int.TryParse(addressAndMask[1], out maskLength);
										prefix = addressAndMask[0];
									}
								}
								else if (addressFound.Success)
								{
									prefix = addressFound.Value;
								}
								else continue;

								if (prefix != "")
								{
									parserSuccess = true;
									if (prefix == "0.0.0.0") maskLength = 0;
									// get next-hop
									Match nexthopFound = Regex.Match(rLine, @"(?<=via )\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}", RegexOptions.Compiled);
									if (nexthopFound.Success)
									{
										nextHop = nexthopFound.Value;
									}
									// get preference
									Match routeDetails = Regex.Match(rLine, @"\[(.*?)\]");
									if (routeDetails.Success)
									{
										string[] preferences = routeDetails.Value.Split('/');
										adminDistance = preferences[0].TrimStart('[');
										routeMetric = preferences[1].TrimEnd(']');
									}
									// this line should also contain the out interface
									outInterface = words[words.Length - 1];
								}
								else
								{
									// no ip address in this line, proceed to next
									continue;
								}
								// here we already know a mask length and the actual routed prefix, so check the protocol
								if (rLine.StartsWith("B"))
								{
									thisProtocol = NeighborProtocol.BGP;
								}
								else if (rLine.StartsWith("O") || rLine.StartsWith("IA") || rLine.StartsWith("N1") || rLine.StartsWith("N2") || rLine.StartsWith("E1") || rLine.StartsWith("E2"))
								{
									thisProtocol = NeighborProtocol.OSPF;
								}
								else if (rLine.StartsWith("D") || rLine.StartsWith("EX"))
								{
									thisProtocol = NeighborProtocol.EIGRP;
								}
								else if (rLine.StartsWith("R"))
								{
									thisProtocol = NeighborProtocol.RIP;
								}
								else if (rLine.StartsWith("L"))
								{
									thisProtocol = NeighborProtocol.LOCAL;
								}
								else if (rLine.StartsWith("C"))
								{
									thisProtocol = NeighborProtocol.CONNECTED;
								}
								else if (rLine.StartsWith("S"))
								{
									thisProtocol = NeighborProtocol.STATIC;
								}
								else
								{
									thisProtocol = NeighborProtocol.UNKNOWN;
								}
								if (thisProtocol != NeighborProtocol.UNKNOWN)
								{
									if (parserSuccess)
									{
										try
										{
											RouteTableEntry re = new RouteTableEntry();
											re.RouterID = RouterID(thisProtocol);
											re.Prefix = prefix;
											re.MaskLength = maskLength;
											re.Protocol = thisProtocol.ToString();
											re.AD = adminDistance;
											re.Metric = routeMetric;
											re.NextHop = nextHop;
											re.OutInterface = outInterface;
											re.Best = true; // the show ip route output only lists best routes :-(
											re.Tag = "";
											parsedRoutes.Add(re);
										}
										catch (Exception Ex)
										{
											string msg = string.Format("CiscoIOSRouter.RoutingTable() : error processing route table : {0}", Ex.Message);
											DebugEx.WriteLine(msg);
										}
									}
								}
							}
						}
					}
				}
				catch (CommandTimeoutException Ex)
				{
					DebugEx.WriteLine("CiscoIOSRouter.RoutingTable() : Command timed out while gathering route table : " + Ex.Message);
					throw;
				}
				catch (Exception Ex)
				{
					DebugEx.WriteLine("CiscoIOSRouter.RoutingTable() :  thrown an unexpected error while gathering route table : " + Ex.Message);
				}
				return parsedRoutes.ToArray();
			}
		}

		/// <summary>
		/// Must return all of the routed interfaces, including vlan, svi, loopback, etc...
		/// The returned list may or may not include interface configuration. Use GetInterfaceConfigureation if configuration was missing.
		/// </summary>
		/// <param name="session"></param>
		/// <returns></returns>
		public RouterInterface[] RoutedInterfaces
		{
			get
			{
				List<RouterInterface> fi = new List<RouterInterface>();
				try
				{
					string inetInterfaces = _session.ExecCommand("show ip int brief");


					foreach (string line in inetInterfaces.SplitByLine())
					{
						try
						{
							string[] words = line.SplitBySpace();
							if (words.Length >= 6)
							{
								// words should look like : GigabitEthernet0/0/0,100.65.0.46,YES,NVRAM,up,up   
								string ifName = words[0];
								string ifIP = words[1];
								IPAddress ipa;
								if (IPAddress.TryParse(ifIP, out ipa))
								{
									RouterInterface ri = new RouterInterface();
									ri.Name = ifName;
									ri.Address = ifIP;
									ri.Status = string.Format("{0},{1}", words[4], words[5]);
									ri.MaskLength = "";
									ri.Configuration = GetRouterinterfaceFromCacheByName(ri.Name)?.Configuration ?? "";
									fi.Add(ri);
								}
							}
						}
						catch (Exception Ex)
						{
							string msg = string.Format("CiscoIOSRouter says : error processing routed interfaces : {0}", Ex.Message);
							DebugEx.WriteLine(msg);
						}
					}
				}
				catch (Exception Ex)
				{
					string msg = string.Format("CiscoIOSRouter says : error processing routed interfaces : {0}", Ex.Message);
					DebugEx.WriteLine(msg);
				}
				return fi.ToArray();
			}
		}

		/// <summary>
		/// Session should return the encapsulated IScriptableSssion this router was Initialized for
		/// </summary>
		public IScriptableSession Session { get { return _session; } }

		/// <summary>
		/// Should return the number of devices in the stack
		/// </summary>
		/// <param name="session"></param>
		/// <returns></returns>
		public int StackCount
		{
			get
			{
				if (_stackCount == -1)
				{
					string stackedswitches = _session.ExecCommand("show switch");
					try
					{
						if (stackedswitches.ToLowerInvariant().StartsWith("switch/stack"))
							_stackCount = stackedswitches.SplitByLine().Count(l => l.SplitBySpace()[0].Trim('*').IsInt());
					}
					catch (Exception Ex)
					{
						_stackCount = 1;
						DebugEx.WriteLine(String.Format("CiscoIOS IRouter error : error parsing \"sh switch\" output : {0}", Ex.InnerExceptionsMessage()), DebugLevel.Debug);
					}
				}
				return _stackCount;
			}
		}

		/// <summary>
		/// Must return a string that describes the function of this protocol parser, like supported model, platform, version, protocol, etc...
		/// </summary>
		public string SupportTag => "Cisco, IOS Router support module v2.0";

		/// <summary>
		/// Must be implemented to return serial number information of the device
		/// </summary>
		/// <param name="session"></param>
		/// <returns></returns>
		public string SystemSerial
		{
			get
			{
				if (_systemSerial == null) CalculateSystemSerial();
				return _systemSerial;
			}
		}

		/// <summary>
		/// Must return a string representing the device type
		/// </summary>
		public string Type { get { return "Router"; } }

		/// <summary>
		/// Must return the router vendor. The vendor information must be aligned with PGT Vendors
		/// </summary>
		public string Vendor { get { return "Cisco"; } }

		/// <summary>
		/// Must return version information about a device
		/// </summary>
		/// <returns></returns>
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
			#region Determine default router ID
			string l3interfaces = _session.ExecCommand("sh ip interface brief");
			if (!string.IsNullOrEmpty(l3interfaces))
			{
				try
				{
					var loopbacks = l3interfaces.SplitByLine().Where(l => l.Trim().ToLowerInvariant().StartsWith("loopback"));
					if (loopbacks.Count() > 0)
					{
						// find the loopback with lowest number
						string lowestLoopback = loopbacks.OrderBy(l =>
						{
							string intfNumber = l.Trim().Remove(0, 8);
							if (int.TryParse(intfNumber, out int num)) return num;
							else return int.MaxValue;
						}).First();
						if (!string.IsNullOrEmpty(lowestLoopback))
						{
							defaultlRouterID = lowestLoopback.SplitBySpace()[1].Trim();
						}
					}
					else
					{
						// find interface with highest ip
						string highestIPInterface = l3interfaces.SplitByLine().OrderByDescending(l =>
						{
							string ifIPAddress = l.SplitBySpace()[1];
							if (IPAddress.TryParse(ifIPAddress, out IPAddress ipa))
							{
								byte[] addrBytes = ipa.GetAddressBytes();
								uint intAddr = BitConverter.IsLittleEndian ? BitConverter.ToUInt32(addrBytes.Reverse().ToArray(), 0) : BitConverter.ToUInt32(addrBytes, 0);
								return intAddr;
							}
							else return (uint)0;
						}).First();
						if (!string.IsNullOrEmpty(highestIPInterface))
						{
							defaultlRouterID = highestIPInterface.SplitBySpace()[1];
						}
					}
				}
				catch (Exception Ex)
				{
					DebugEx.WriteLine("CiscoIOSRouter.CalculateRouterIDAndASNumber() : error while parsing interface information : " + Ex.Message);
				}
			}
			if (defaultlRouterID == "") defaultlRouterID = ManagementIP;
			#endregion

			#region  get routerID for all routing protocols this router is running
			// ordering is important to ensure that BGP and OSPF precedes STATIC
			foreach (NeighborProtocol thisPprotocol in ActiveProtocols.Where(p => p is NeighborProtocol).OrderBy(p => p))
			{
				switch (thisPprotocol)
				{
					case NeighborProtocol.CDP:
						{
							_routerID[thisPprotocol] = defaultlRouterID;
							break;
						}
					case NeighborProtocol.BGP:
						{
							string bgpSummary = _session.ExecCommand("show ip bgp summary");
							Match m = Regex.Match(bgpSummary, @"(?<=BGP router identifier )[\d.]{0,99}", RegexOptions.Compiled);
							if (m.Success)
							{
								_routerID[thisPprotocol] = m.Value;
								defaultlRouterID = m.Value;
							}
							// get also the BGP AS number
							m = Regex.Match(bgpSummary, @"(?<=local AS number )[\d.]{0,99}", RegexOptions.Compiled);
							if (m.Success) _bgpASNumber = m.Value;
							break;
						}
					case NeighborProtocol.OSPF:
						{
							string ospfGeneral = _session.ExecCommand("show ip ospf | i ID");
							// expecting output like this:
							// Routing Process "ospf 200" with ID 10.9.254.251
							// Routing Process "ospf 100" with ID 192.168.1.1
							//
							// WARNING if more than one OSPF process is running, generate error
							//
							if (ospfGeneral.SplitByLine().Length == 1)
							{
								Match m = Regex.Match(ospfGeneral, @"(?<=ID )[\d.]{0,99}");
								if (m.Success)
								{
									_routerID[thisPprotocol] = m.Value;
									if (string.IsNullOrEmpty(defaultlRouterID)) defaultlRouterID = m.Value;
								}
							}
							else
							{
								throw new InvalidOperationException("More than one OSPF process is not supported by this parser");
							}
							break;
						}
					case NeighborProtocol.EIGRP:
						{
							string eigrpTopologyInfo = _session.ExecCommand("show ip eigrp topology | i ID");
							// expecting output like this:
							// IP - EIGRP Topology Table for AS(10) / ID(10.9.240.1)
							// IP - EIGRP Topology Table for AS(20) / ID(10.9.240.1)
							//
							// WARNING if more than one EIGRP process is running, generate error
							//
							if (eigrpTopologyInfo.SplitByLine().Length == 1)
							{
								Match m = Regex.Match(eigrpTopologyInfo, @"(?<=ID\()[\d.]{0,99}");
								if (m.Success)
								{
									_routerID[thisPprotocol] = m.Value;
									if (string.IsNullOrEmpty(defaultlRouterID)) defaultlRouterID = m.Value;
								}
							}
							else
							{
								throw new InvalidOperationException("More than one EIGRP process is not supported by this parser");
							}
							break;
						}
					case NeighborProtocol.RIP:
					case NeighborProtocol.STATIC:
						{
							_routerID[thisPprotocol] = defaultlRouterID; // fall back to default RID
							break;
						}
					default: _routerID[thisPprotocol] = null; break;
				}
			}
			#endregion
		}

		private void CalculateSystemSerial()
		{
			// some switches doe no support the "show inventory" command
			bool exec_error = Inventory.ToLowerInvariant().Contains("invalid input detected") || ScriptSettings.FailedCommandPattern.SplitBySemicolon().Any(w => Inventory.IndexOf(w) >= 0);
			if (exec_error)
			{
				DebugEx.WriteLine(String.Format("CiscoIOSRouter : router does not support \"show inventory\" command, parsing version information"), DebugLevel.Debug);
				// try to parse sh_version to get system serial numbers      
				try
				{
					_systemSerial = string.Join(",", Version.SplitByLine().Where(l => l.StartsWith("System serial number")).Select(l => l.Split(':')[1].Trim()));
				}
				catch (Exception Ex)
				{
					DebugEx.WriteLine(String.Format("CiscoIOSRouter : error searching serial number in \"sh version\" output : {0}", Ex.InnerExceptionsMessage()), DebugLevel.Debug);
				}
			}
			else
			{
				// This should return system serial most of the time
				try
				{
					if (StackCount > 0)
					{
						// if stackCount > 0 the switch supported the "show switch" command. Probably also understands "show module"
						string modules = _session.ExecCommand("show module");
						// some switches who support the "show switch" command may still do not understand "show modules"
						exec_error = modules.ToLowerInvariant().Contains("invalid input detected") || ScriptSettings.FailedCommandPattern.SplitBySemicolon().Any(w => modules.IndexOf(w) >= 0);
						if (exec_error)
						{
							DebugEx.WriteLine(String.Format("CiscoIOSRouter : router does not support \"sh module\" command, parsing version information"), DebugLevel.Debug);
							// try to parse sh_version to get system serial numbers
							_systemSerial = string.Join(",", Version.SplitByLine().Where(l => l.StartsWith("System serial number")).Select(l => l.Split(':')[1].Trim()));
						}
						else
						{
							// select lines starting with a number. These are assumed the be the switches in stack
							var switchList = modules.SplitByLine().Where(l => l.SplitBySpace()[0].Trim('*').IsInt());
							// each line contains the serial number in th 4th column
							_systemSerial = string.Join(",", switchList.Select(m => m.SplitBySpace()[3]));
						}
					}
					else _systemSerial = Inventory.SplitByLine().First(l => l.StartsWith("PID:")).Split(',')[2].Split(':')[1].Trim();
				}
				catch (Exception Ex)
				{
					_systemSerial = "parsing error";
					DebugEx.WriteLine(string.Format("Error parsing serial number : {0}", Ex.InnerExceptionsMessage()), DebugLevel.Error);
				}
				_systemSerial = _systemSerial?.TrimStart(';');
			}
		}
		#endregion
	}
}
