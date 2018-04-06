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
using System.Threading;

namespace L3Discovery.ProtocolParsers.JunOS.OSPF
{
	public class Junos_OSPFParser : IGenericProtocolParser, IOSPFProtocolParser
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

		public bool Initilize(IRouter router, RoutingProtocol protocol)
		{
			_router = router;
			if (protocol == RoutingProtocol.OSPF)
			{
				return router?.Vendor == "JunOS";
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
				string TextToParse = _router.Session.ExecCommand("show ospf neighbor");
				_OperationStatusLabel = "Querying OSPF interfaces...";
				string ospfInterfaces = _router.Session.ExecCommand("show ospf interface");
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
					DebugEx.WriteLine(String.Format("JUNOS_OSPF_PARSER : parsing OSPF neighbor row [ {0} ]", line), DebugLevel.Full);
					token.ThrowIfCancellationRequested();
					try
					{
						string[] words = line.SplitBySpace();
						if (words.Length < 4) continue; // this line is something else
																						// Words should be:
																						// Address,Interface,State,ID,Pri,Dead
																						// 10.0.0.241,ae0.0,Full,10.0.0.254,128,34
						neighborState = words[2];
						IPAddress nIP;
						IPAddress nID;
						if (System.Net.IPAddress.TryParse(words[0], out nIP) && System.Net.IPAddress.TryParse(words[3], out nID))
						{
							// This is a new peer, initialize variables
							_OperationStatusLabel = string.Format("Querying router interface {0}...", words[1]);
							RouterInterface ri = _router.GetInterfaceByName(words[1]);
							if (ri != null)
							{
								// add OSPF Area info to RouterInterface
								if (ospfInterfaces != "")
								{
									string ospfIntfLine = ospfInterfaces.SplitByLine().FirstOrDefault(l => l.Trim().StartsWith(ri.Name));
									if (!string.IsNullOrEmpty(ospfIntfLine))
									{
										string[] w = ospfIntfLine.SplitBySpace();
										// words array header  : Interface,State,Area,DR ID,BDR ID,Nbrs
										// words should be like: lo0.0,DRother,0.0.0.0,0.0.0.0,0.0.0.0,0
										ri.OSPFArea = w[2];
									}
								}
								neighborRouterID = nID.ToString();
								remoteNeighboringIP = nIP.ToString();
								description = "";
								_OperationStatusLabel = string.Format("Registering OSPF neighbor {0}...", neighborRouterID);
								registry.RegisterNeighbor(_router, RoutingProtocol.OSPF, neighborRouterID, "", description, remoteNeighboringIP, ri, neighborState);
							}
						}
					}
					catch (OperationCanceledException)
					{
						throw;
					}
					catch (Exception Ex)
					{
						string msg = String.Format("OSPFarser : Error while parsing ospf output line [{0}]. Error is : {1}", line, Ex.InnerExceptionsMessage());
						DebugEx.WriteLine(msg);
						_OperationStatusLabel = msg;
					}
				}
				_OperationStatusLabel = "JunOS OSPF route parser completed.";
			}
			catch (Exception Ex)
			{
				_OperationStatusLabel = "JunOS OSPF parser failed with error : " + Ex.Message;
			}
		}

		public void Reset()
		{
			_router = null;
			_OperationStatusLabel = "Init";
			_ospfAreaLSAs = new Dictionary<OSPFArea, Dictionary<string, List<OSPFLSA>>>();
		}

		public ISpecializedProtocolParser ProtocolDependentParser(RoutingProtocol protocol)
		{
			if (protocol == RoutingProtocol.OSPF) return this;
			else return null;
		}

		public RoutingProtocol[] SupportedProtocols => new RoutingProtocol[] { RoutingProtocol.OSPF };

		public string SupportTag => "Juniper, JunOS OSPF Protocol Parser module v0.92";

		#region IOSPFProtocolPArser implementation

		public void ProcessOSPFDatabase()
		{
			if (_router?.Session == null || !_router.Session.IsConnected()) throw new ArgumentException("Unable to parse OSPF. Either thisRouter or Session parameter is invalid");
			#region Query, parse and store LSAs
			string ospfOverView = _router.Session.ExecCommand("show ospf overview");
			string ospfAreaRouters = _router.Session.ExecCommand("show ospf database");
			string[] lines = ospfAreaRouters.SplitByLine();
			OSPFArea currentArea = null;
			string currentLSATypaName = "";
			List<OSPFLSA> LSAs = new List<OSPFLSA>();
			Dictionary<string, List<OSPFLSA>> OSPFLSAs = new Dictionary<string, List<OSPFLSA>>();
			foreach (string line in lines.Select(l => l.Trim()))
			{
				// header       : Type ID               Adv Rtr           Seq Age  Opt Cksum  Len
				// line is like :Router   10.93.1.200      10.93.1.200      0x800005af  1113  0x8  0x6280  60
				try
				{
					if (line.StartsWith("{master:")) continue;
					if (line.ToLowerInvariant().StartsWith("ospf database"))
					{
						// line is like : OSPF database, Area 10.72.0.0
						string[] o = line.SplitByComma();
						string[] a = o[1].SplitBySpace();
						string thisAreaID = a[1];
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
							LSAs = new List<OSPFLSA>();
							currentArea = new OSPFArea();
							currentArea.AreaID = thisAreaID.Trim();
							currentArea.AreaType = GetAreaType(currentArea.AreaID);
						}
					}
					else
					{
						// The LSA Type should be the first word in thisLine
						string[] r = line.ToLowerInvariant().SplitBySpace();
						string LSATypeName = r[0];
						if (LSATypeName != "type")
						{
							if (LSATypeName != currentLSATypaName)
							{
								// LSAType is changing
								if (currentLSATypaName != "")
								{
									OSPFLSAs[currentLSATypaName] = LSAs;
									LSAs = new List<OSPFLSA>();
								}
								currentLSATypaName = LSATypeName;
							}
							string LSAID = r[1].TrimStart('*');
							string AdvRouter = r[1].Trim();
							OSPFLSA thisLSA = new OSPFLSA() { LSAType = currentLSATypaName, LSAID = LSAID, AdvRouter = AdvRouter };
							LSAs.Add(thisLSA);
						}
					}
				}
				catch (Exception Ex)
				{
					DebugEx.WriteLine("JunOS IRouter : unable to parse OSPF database line :" + line);
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
					// parsing as per https://www.juniper.net/documentation/en_US/junos/topics/reference/command-summary/show-ospf-ospf3-overview.html
					if (AreaID == "0.0.0.0") return OSPFAreaType.Backbone;
					bool inDesiredAreaSection = false;
					foreach (string line in ospfOverView.SplitByLine().Select(l => l.ToLowerInvariant().Trim()))
					{
						if (line.StartsWith(string.Format("area: {0}", AreaID)))
						{
							if (inDesiredAreaSection) break;
							inDesiredAreaSection = true;
						}
						if (inDesiredAreaSection)
						{
							if (line.StartsWith("stub type:"))
							{
								string[] typeDesc = line.Split(':');
								if (typeDesc[1].Contains("normal stub")) return OSPFAreaType.Stub;
								if (typeDesc[1].Contains("not stub")) return OSPFAreaType.Normal;
								if (typeDesc[1].Contains("not so stubby") || typeDesc[1].Contains("nssa")) return OSPFAreaType.NSSA;
							}
						}
					}
					return OSPFAreaType.Unknown;
				}
				catch (Exception Ex)
				{
					DebugEx.WriteLine("JUNOS_OSPFParser.ProcessOSPFDatabase.GetAreaType() : unexpected error : " + Ex.Message);
					return OSPFAreaType.Unknown;
				}
				#endregion
			}
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
				return ((_ospfAreaLSAs[OSPFArea])[LSATypeName]).ToArray();
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
