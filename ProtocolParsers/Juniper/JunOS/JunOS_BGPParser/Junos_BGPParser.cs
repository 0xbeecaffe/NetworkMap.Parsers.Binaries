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

    public string OperationStatusLabel => _OperationStatusLabel;

    public bool Initilize(IRouter router, Enum protocol)
    {
      _router = router;
      if (protocol is RoutingProtocol && (RoutingProtocol)protocol == RoutingProtocol.BGP)
      {
        return router?.Vendor == "JunOS";
      }
      else return false;
    }

    public void Parse(INeighborRegistry registry, CancellationToken token)
    {
      if (_router?.Session == null || !_router.Session.IsConnected()) throw new ArgumentException("Unable to parse BGP. Either thisRouter or Session parameter is invalid");
      else
      {
        try
        {
          _OperationStatusLabel = "Querying bgp neighbors...";
          string bgpNeighbors = _router.Session.ExecCommand("show bgp neighbor");
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
          BGPType _bgpType = BGPType.undetermined;


          foreach (string line in bgp_lines.Select(l => l.Trim()))
          {
            DebugEx.WriteLine(String.Format("BGPParser : parsing BGP neighbor row [ {0} ]", line), DebugLevel.Full);
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
                remoteAS = "";
                description = "";
                neighborState = "";
                sessionEstablished = true;
                skipRestOfLines = false;
                localInterfaceName = "";
                // Get local address
                Match m = Regex.Match(line, @"(?<=Local: )[\d.]{0,99}", RegexOptions.Compiled);
                if (m.Success) localNeighboringIP = m.Value;
                // Get peer address
                m = Regex.Match(line, @"(?<=Peer: )[\d.]{0,99}", RegexOptions.Compiled);
                if (m.Success) remoteNeighboringIP = m.Value;
                // Get AS Numbers
                var ASes = Regex.Matches(line, @"(?<=AS )[\d.]{0,99}", RegexOptions.Compiled);
                if (ASes.Count != 2) throw new InvalidOperationException("Cannot parse BGP output : unable to retrieve local and remote AS numbers.");
                remoteAS = ASes[0].Value;
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
                  DebugEx.WriteLine(String.Format("JunOSBGPParser : found a neighbor {0}AS{1} <-> {2}AS{3}", _router.RouterID(RoutingProtocol.BGP), _router.BGPAutonomousSystem, peerRouterID, remoteAS), DebugLevel.Informational);
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
                        if (localNeighboringIP != "") localInterfaceName = _router.GetInterfaceNameByIPAddress(localNeighboringIP);
                        break;
                      }
                  }
                }
                #endregion
              }

              if (sessionEstablished && (localInterfaceName == "" || peerRouterID == "" || remoteAS == "" || localNeighboringIP == "" || remoteNeighboringIP == "")) continue;

              // when the BGP session is not established we can't know the neighbor router ID, so name it after peering ip which should be unique anyway
              // We also won't know the localInterface at this point, so we need to query it by ip address
              if (!sessionEstablished)
              {
                peerRouterID = remoteNeighboringIP;
                if (localNeighboringIP != "") localInterfaceName = _router.GetInterfaceNameByIPAddress(localNeighboringIP);
              }
              // search database for peer router, select it or add new neighbor
              _OperationStatusLabel = string.Format("Querying router interface {0}...", localInterfaceName);
              RouterInterface ri = _router.GetInterfaceByName(localInterfaceName);
              _OperationStatusLabel = string.Format("Registering BGP neighbor {0}...", peerRouterID);
              registry.RegisterL3Neighbor(_router, RoutingProtocol.BGP, peerRouterID, remoteAS, description, remoteNeighboringIP, ri, neighborState);
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
      if (protocol is RoutingProtocol && (RoutingProtocol)protocol == RoutingProtocol.BGP) return this;
      else return null;
    }

    public string SupportTag => "Juniper, JunOS BGP Protocol Parser module v1.0";

    public Enum[] SupportedProtocols => new Enum[] { RoutingProtocol.BGP };

    internal enum BGPType { eBGP, iBGP, undetermined };
  }
}
