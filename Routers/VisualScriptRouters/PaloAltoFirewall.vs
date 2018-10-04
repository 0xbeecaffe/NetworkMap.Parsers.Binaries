<?xml version="1.0" standalone="yes"?>
<vScriptDS xmlns="http://tempuri.org/vScriptDS.xsd">
  <vScriptCommands>
    <vsID>0</vsID>
    <CommandID>fa445090-aac6-431f-803e-d1ecd2f474ae</CommandID>
    <Name>Start</Name>
    <DisplayLabel>Start</DisplayLabel>
    <Commands />
    <MainCode />
    <Origin_X>250</Origin_X>
    <Origin_Y>60</Origin_Y>
    <Size_Width>100</Size_Width>
    <Size_Height>40</Size_Height>
    <isStart>false</isStart>
    <isStop>false</isStop>
    <isSimpleCommand>false</isSimpleCommand>
    <isSimpleDecision>false</isSimpleDecision>
    <Variables />
    <Break>false</Break>
    <ExecPolicy>After</ExecPolicy>
    <CustomCodeBlock />
    <DemoMode>false</DemoMode>
    <Description />
    <WatchVariables />
    <Initializer />
    <FullTypeName>PGT.VisualScripts.vScriptStart</FullTypeName>
  </vScriptCommands>
  <vScriptCommands>
    <vsID>1</vsID>
    <CommandID>a8bb888f-acba-4041-9c40-0d6a916bc136</CommandID>
    <Name>UnknownTask</Name>
    <DisplayLabel>Unknown task - ERROR</DisplayLabel>
    <Commands />
    <MainCode>####################################################################################
#                                                                                  #
# This call should never executre if Router Module is implemented in a correct way #
#                                                                                  #
####################################################################################

raise ValueError("{0} vScripot Router received an unhandled Command request : {1}".format(Name, ConnectionInfo.Command))</MainCode>
    <Origin_X>543</Origin_X>
    <Origin_Y>112</Origin_Y>
    <Size_Width>172</Size_Width>
    <Size_Height>40</Size_Height>
    <isStart>false</isStart>
    <isStop>false</isStop>
    <isSimpleCommand>false</isSimpleCommand>
    <isSimpleDecision>false</isSimpleDecision>
    <Variables />
    <Break>false</Break>
    <ExecPolicy>After</ExecPolicy>
    <CustomCodeBlock />
    <DemoMode>false</DemoMode>
    <Description>This call should never executre if Router Module is implemented in a correct way</Description>
    <WatchVariables />
    <Initializer />
    <FullTypeName>PGT.VisualScripts.vScriptStop</FullTypeName>
  </vScriptCommands>
  <vScriptCommands>
    <vsID>2</vsID>
    <CommandID>ca7eb9ab-6c32-4203-b246-919d7e30497f</CommandID>
    <Name>SwitchTask</Name>
    <DisplayLabel>Switch task</DisplayLabel>
    <Commands />
    <MainCode>###########################################################
#                                                         #
# This is a central point to decide which call to perform #
# Connectors will be evaluated one by one in order.       #
# Take care of connector ordering !                       #
#                                                         #
###########################################################
pass</MainCode>
    <Origin_X>465</Origin_X>
    <Origin_Y>405</Origin_Y>
    <Size_Width>100</Size_Width>
    <Size_Height>50</Size_Height>
    <isStart>false</isStart>
    <isStop>false</isStop>
    <isSimpleCommand>false</isSimpleCommand>
    <isSimpleDecision>false</isSimpleDecision>
    <Variables />
    <Break>false</Break>
    <ExecPolicy>After</ExecPolicy>
    <CustomCodeBlock />
    <DemoMode>false</DemoMode>
    <Description>This is a central point to decide which call to perform Connectors will be evaluated one by one in order.  
Take care of connector ordering !   </Description>
    <WatchVariables />
    <Initializer />
    <FullTypeName>PGT.VisualScripts.vScriptCommand</FullTypeName>
  </vScriptCommands>
  <vScriptCommands>
    <vsID>3</vsID>
    <CommandID>02a4f2cf-e075-4253-b497-b17b410522d3</CommandID>
    <Name>ReturnSupportTag</Name>
    <DisplayLabel>Support Tag</DisplayLabel>
    <Commands />
    <MainCode>##############################################################################
#                                                                            #
# This call should return a descriptive text for this Router software module #
#                                                                            #
##############################################################################
global ActionResult

ActionResult = "{0} Router Support Module - Python vScript Parser v{1}".format(Name, scriptVersion)</MainCode>
    <Origin_X>647</Origin_X>
    <Origin_Y>177</Origin_Y>
    <Size_Width>147</Size_Width>
    <Size_Height>50</Size_Height>
    <isStart>false</isStart>
    <isStop>false</isStop>
    <isSimpleCommand>false</isSimpleCommand>
    <isSimpleDecision>false</isSimpleDecision>
    <Variables />
    <Break>false</Break>
    <ExecPolicy>After</ExecPolicy>
    <CustomCodeBlock />
    <DemoMode>false</DemoMode>
    <Description>This call should return a descriptive text for this Router software module</Description>
    <WatchVariables />
    <Initializer />
    <FullTypeName>PGT.VisualScripts.vScriptStop</FullTypeName>
  </vScriptCommands>
  <vScriptCommands>
    <vsID>4</vsID>
    <CommandID>6cf97c54-143f-44b3-9676-36be7032e63b</CommandID>
    <Name>ReturnInventory</Name>
    <DisplayLabel>Inventory</DisplayLabel>
    <Commands />
    <MainCode>################################################################
#                                                              #
# This call should be able to return device inventory string   #
#                                                              #
################################################################
global ActionResult

ActionResult = Version.GetVersion()</MainCode>
    <Origin_X>645</Origin_X>
    <Origin_Y>651</Origin_Y>
    <Size_Width>147</Size_Width>
    <Size_Height>50</Size_Height>
    <isStart>false</isStart>
    <isStop>false</isStop>
    <isSimpleCommand>false</isSimpleCommand>
    <isSimpleDecision>false</isSimpleDecision>
    <Variables />
    <Break>false</Break>
    <ExecPolicy>After</ExecPolicy>
    <CustomCodeBlock />
    <DemoMode>false</DemoMode>
    <Description>This call should be able to return device inventory string </Description>
    <WatchVariables />
    <Initializer />
    <FullTypeName>PGT.VisualScripts.vScriptStop</FullTypeName>
  </vScriptCommands>
  <vScriptCommands>
    <vsID>5</vsID>
    <CommandID>843c946b-980d-456a-b9d8-61b59b14d2ac</CommandID>
    <Name>ReturnVersion</Name>
    <DisplayLabel>Version</DisplayLabel>
    <Commands />
    <MainCode>#################################################################
#                                                               #
# This call should be able to return device version information #
#                                                               #
#################################################################
global ActionResult

# Initialize element has already updated the VersionInfo global variable
# so return that one.

ActionResult = Version.GetVersion()</MainCode>
    <Origin_X>761</Origin_X>
    <Origin_Y>513</Origin_Y>
    <Size_Width>147</Size_Width>
    <Size_Height>50</Size_Height>
    <isStart>false</isStart>
    <isStop>false</isStop>
    <isSimpleCommand>false</isSimpleCommand>
    <isSimpleDecision>false</isSimpleDecision>
    <Variables />
    <Break>false</Break>
    <ExecPolicy>After</ExecPolicy>
    <CustomCodeBlock />
    <DemoMode>false</DemoMode>
    <Description>This call should be able to return device version information</Description>
    <WatchVariables />
    <Initializer />
    <FullTypeName>PGT.VisualScripts.vScriptStop</FullTypeName>
  </vScriptCommands>
  <vScriptCommands>
    <vsID>6</vsID>
    <CommandID>17c60dc8-aa02-445f-bb02-2b908fcd5e2b</CommandID>
    <Name>ReturnSerial</Name>
    <DisplayLabel>System Serial</DisplayLabel>
    <Commands />
    <MainCode>############################################################################
#                                                                          #
# This call should be able to return the serial numnber(s) of the device   #
#                                                                          #
############################################################################
global ActionResult

global ActionResult

_s = re.findall(r"(?&lt;=serial: ).*", Version.GetVersion())
if len(_s) &gt; 0:
 ActionResult = _s[0]
else:
  ActionResult = "n/a"</MainCode>
    <Origin_X>563</Origin_X>
    <Origin_Y>725</Origin_Y>
    <Size_Width>147</Size_Width>
    <Size_Height>50</Size_Height>
    <isStart>false</isStart>
    <isStop>false</isStop>
    <isSimpleCommand>false</isSimpleCommand>
    <isSimpleDecision>false</isSimpleDecision>
    <Variables />
    <Break>false</Break>
    <ExecPolicy>After</ExecPolicy>
    <CustomCodeBlock />
    <DemoMode>false</DemoMode>
    <Description>This call should be able to return the serial numnber(s) of the device </Description>
    <WatchVariables />
    <Initializer />
    <FullTypeName>PGT.VisualScripts.vScriptStop</FullTypeName>
  </vScriptCommands>
  <vScriptCommands>
    <vsID>7</vsID>
    <CommandID>0a008a33-b4ea-4606-a86a-6b4806b37469</CommandID>
    <Name>ReturnModelNumber</Name>
    <DisplayLabel>Model Number</DisplayLabel>
    <Commands />
    <MainCode>#####################################################################
#                                                                   #
# This call should be able to return Model number of this device    #
#                                                                   #
#####################################################################
global ActionResult

_m = re.findall(r"(?&lt;=model: ).*", Version.GetVersion())
if len(_m) &gt; 0:
 ActionResult = _m[0]
else:
  ActionResult = "n/a"</MainCode>
    <Origin_X>785</Origin_X>
    <Origin_Y>436</Origin_Y>
    <Size_Width>147</Size_Width>
    <Size_Height>50</Size_Height>
    <isStart>false</isStart>
    <isStop>false</isStop>
    <isSimpleCommand>false</isSimpleCommand>
    <isSimpleDecision>false</isSimpleDecision>
    <Variables />
    <Break>false</Break>
    <ExecPolicy>After</ExecPolicy>
    <CustomCodeBlock />
    <DemoMode>false</DemoMode>
    <Description>This call should be able to return Model number of this device</Description>
    <WatchVariables />
    <Initializer />
    <FullTypeName>PGT.VisualScripts.vScriptStop</FullTypeName>
  </vScriptCommands>
  <vScriptCommands>
    <vsID>8</vsID>
    <CommandID>6c275d41-4db4-49f3-8e1f-354ac2d0c456</CommandID>
    <Name>ReturnStackCount</Name>
    <DisplayLabel>Stack Count</DisplayLabel>
    <Commands />
    <MainCode>##############################################################################
#                                                                            #
# This call should be able to return the number of devices stacked together  #
#                                                                            #
##############################################################################
global ActionResult

stackCount == 1
#
# Implement required logic to get the correct number
#
ActionResult = stackCount;</MainCode>
    <Origin_X>319</Origin_X>
    <Origin_Y>716</Origin_Y>
    <Size_Width>147</Size_Width>
    <Size_Height>50</Size_Height>
    <isStart>false</isStart>
    <isStop>false</isStop>
    <isSimpleCommand>false</isSimpleCommand>
    <isSimpleDecision>false</isSimpleDecision>
    <Variables />
    <Break>false</Break>
    <ExecPolicy>After</ExecPolicy>
    <CustomCodeBlock />
    <DemoMode>false</DemoMode>
    <Description>This call should be able to return the number of devices stacked together</Description>
    <WatchVariables />
    <Initializer />
    <FullTypeName>PGT.VisualScripts.vScriptStop</FullTypeName>
  </vScriptCommands>
  <vScriptCommands>
    <vsID>9</vsID>
    <CommandID>6dd1d716-8ad6-40b6-87a7-ea75cc145a18</CommandID>
    <Name>Return_RoutingTable</Name>
    <DisplayLabel>Routing Table</DisplayLabel>
    <Commands />
    <MainCode>#############################################################################
#                                                                           #
# This call should be able to return the full routing table of the device.  #
#                                                                           #
#############################################################################
global ActionResult
from System.Net import IPAddress

parsedRoutes = []
# query full route table
routeLines = Session.ExecCommand("show routing route").splitlines()
# iterate through the network blocks
for thisLine in routeLines:
  try:
    words = filter(None, thisLine.split(" "))
    if len(words) &gt; 0:
      firstWord = words[0]
      # The line that contains a / character int he first word is a good candidate to check
      if "/" in firstWord:
        ipAdressAndMask = firstWord.split("/")
        prefixAddress = ipAdressAndMask[0]
        prefixLength = ipAdressAndMask[1]
        # create a reference variable to pass it to TryParse (this is an out parameter in .Net)
        ipa = clr.Reference[IPAddress]()
        # check if the last word is a valid ip address
        if IPAddress.TryParse(prefixAddress, ipa) and str(ipa.Value) == prefixAddress:    
          try:
            # the 4th word is the flag telling us the protocol type
            # flags: A:active, ?:loose, C:connect, H:host, S:static, ~:internal, R:rip, O:ospf, B:bgp, 
            #        Oi:ospf intra-area, Oo:ospf inter-area, O1:ospf ext-type-1, O2:ospf ext-type-2, E:ecmp
            isActiveRoute = words[3] == "A"
            if isActiveRoute:
              protocolType = words[4]
              thisLineProtocol = L3Discovery.NeighborProtocol.UNKNOWN
              if protocolType == "C" : thisLineProtocol = L3Discovery.NeighborProtocol.CONNECTED
              elif protocolType.startswith("O") : thisLineProtocol = L3Discovery.NeighborProtocol.OSPF
              elif protocolType == "H" : thisLineProtocol = L3Discovery.NeighborProtocol.DIRECT
              elif protocolType == "S" : thisLineProtocol = L3Discovery.NeighborProtocol.STATIC
              elif protocolType == "R" : thisLineProtocol = L3Discovery.NeighborProtocol.RIP
              elif protocolType == "B" : thisLineProtocol = L3Discovery.NeighborProtocol.BGP
              rte = L3Discovery.RouteTableEntry()
              rte.Protocol = str(thisLineProtocol)
              rte.RouterID = RouterIDAndASNumber.GetRouterID(rte.Protocol)
              rte.Prefix = prefixAddress
              rte.MaskLength = int(prefixLength)
              rte.NextHop = words[1]
              rte.Best = False # don't know actually
              rte.Tag = ""
              if len(words) &gt;= 6 : rte.OutInterface = words[5]
              rte.AD = ""
              rte.Metric = words[2]
              parsedRoutes.Add(rte)

          except Exception as Ex:
            message = "PaloAlto Router Module Error : could not parse a route table line because : " + str(Ex)
            System.Diagnostics.DebugEx.WriteLine(message)   

  except Exception as Ex:
    message = "PaloAlto Router Module Error : could not parse a route table line because : " + str(Ex)
    System.Diagnostics.DebugEx.WriteLine(message)
  
ActionResult = parsedRoutes</MainCode>
    <Origin_X>95</Origin_X>
    <Origin_Y>368</Origin_Y>
    <Size_Width>147</Size_Width>
    <Size_Height>50</Size_Height>
    <isStart>false</isStart>
    <isStop>false</isStop>
    <isSimpleCommand>false</isSimpleCommand>
    <isSimpleDecision>false</isSimpleDecision>
    <Variables />
    <Break>true</Break>
    <ExecPolicy>After</ExecPolicy>
    <CustomCodeBlock />
    <DemoMode>false</DemoMode>
    <Description>This call should be able to return the full routing table of the device</Description>
    <WatchVariables />
    <Initializer />
    <FullTypeName>PGT.VisualScripts.vScriptStop</FullTypeName>
  </vScriptCommands>
  <vScriptCommands>
    <vsID>10</vsID>
    <CommandID>db87cfaa-046f-4ab9-b6aa-3880066309e7</CommandID>
    <Name>Return_RoutedInterfaces</Name>
    <DisplayLabel>Routed Interfaces</DisplayLabel>
    <Commands />
    <MainCode>######################################################################
#                                                                    #
# This call should be able to return the list of routed interfaces   #
#                                                                    #
######################################################################
global ActionResult
global ScriptSuccess

ActionResult = GetInterfaces.GetRoutedInterfaces()
ScriptSuccess = True
</MainCode>
    <Origin_X>91</Origin_X>
    <Origin_Y>434</Origin_Y>
    <Size_Width>147</Size_Width>
    <Size_Height>50</Size_Height>
    <isStart>false</isStart>
    <isStop>false</isStop>
    <isSimpleCommand>false</isSimpleCommand>
    <isSimpleDecision>false</isSimpleDecision>
    <Variables />
    <Break>false</Break>
    <ExecPolicy>After</ExecPolicy>
    <CustomCodeBlock />
    <DemoMode>false</DemoMode>
    <Description>This call should be able to return the list of routed interfaces </Description>
    <WatchVariables />
    <Initializer />
    <FullTypeName>PGT.VisualScripts.vScriptStop</FullTypeName>
  </vScriptCommands>
  <vScriptCommands>
    <vsID>11</vsID>
    <CommandID>a2abda9f-20ed-4889-8e64-ac82f8cb2ade</CommandID>
    <Name>Return_RouterID</Name>
    <DisplayLabel>RouterID</DisplayLabel>
    <Commands />
    <MainCode>#################################################################
#                                                               #
# This call should be able to return the protocol dependent     #
# RouterID for this device. This means, that a router may have  #
# different router IDs for different routing protocols.         #
#                                                               #
#################################################################
global ActionResult

#
# Implement required logic to get the actual RouterID
# Consider some caching mechanism to speed up execution.
#

# The protocol for which to get the RouterID
protocol = ConnectionInfo.aParam
ActionResult = RouterIDAndASNumber.GetRouterID(protocol)</MainCode>
    <Origin_X>716</Origin_X>
    <Origin_Y>586</Origin_Y>
    <Size_Width>147</Size_Width>
    <Size_Height>47</Size_Height>
    <isStart>false</isStart>
    <isStop>false</isStop>
    <isSimpleCommand>false</isSimpleCommand>
    <isSimpleDecision>false</isSimpleDecision>
    <Variables />
    <Break>false</Break>
    <ExecPolicy>After</ExecPolicy>
    <CustomCodeBlock />
    <DemoMode>false</DemoMode>
    <Description> This call should be able to return RouterID of this device</Description>
    <WatchVariables />
    <Initializer />
    <FullTypeName>PGT.VisualScripts.vScriptStop</FullTypeName>
  </vScriptCommands>
  <vScriptCommands>
    <vsID>12</vsID>
    <CommandID>fa1c0cc6-5d9c-49c5-8671-fd7aa4948f63</CommandID>
    <Name>Return_ActiveRoutingProtocols</Name>
    <DisplayLabel>Routing Protocols</DisplayLabel>
    <Commands />
    <MainCode>############################################################################################
#                                                                                          #
# This call should be able to return the list of RoutingProtocols running on nthis router  #
#                                                                                          #
############################################################################################
global ActionResult
global _runningRoutingProtocols

if len(_runningRoutingProtocols) == 0 :
  response = Session.ExecCommand("show routing protocol ospf summary")
  if (response != ""): _runningRoutingProtocols.Add(L3Discovery.NeighborProtocol.OSPF)
    
  response = Session.ExecCommand("show routing protocol rip summary")
  if (response != ""): _runningRoutingProtocols.Add(L3Discovery.NeighborProtocol.RIP)  
  
  response = Session.ExecCommand("show routing protocol bgp summary")
  if (response != ""): _runningRoutingProtocols.Add(L3Discovery.NeighborProtocol.BGP)
  
  response = Session.ExecCommand("show lldp neighbors all")
  if (response != ""): _runningRoutingProtocols.Add(L3Discovery.NeighborProtocol.LLDP)
    
  response = Session.ExecCommand("show routing route type static count 1")
  _staticRouteCount = re.findall(r"(?&lt;=total routes shown: ).*", response)
  if len(_staticRouteCount) &gt; 0 : _staticRouteCount = _staticRouteCount[0]
  _sc = 0
  
  try:
    _sc = int(_staticRouteCount)
  except:
    _sc = -1
  
  if _sc &gt; 0 : _runningRoutingProtocols.Add(L3Discovery.NeighborProtocol.STATIC)  

ActionResult = _runningRoutingProtocols</MainCode>
    <Origin_X>216</Origin_X>
    <Origin_Y>648</Origin_Y>
    <Size_Width>147</Size_Width>
    <Size_Height>50</Size_Height>
    <isStart>false</isStart>
    <isStop>false</isStop>
    <isSimpleCommand>false</isSimpleCommand>
    <isSimpleDecision>false</isSimpleDecision>
    <Variables />
    <Break>false</Break>
    <ExecPolicy>After</ExecPolicy>
    <CustomCodeBlock />
    <DemoMode>false</DemoMode>
    <Description>This call should be able to return the list of RoutingProtocols running on nthis router</Description>
    <WatchVariables />
    <Initializer />
    <FullTypeName>PGT.VisualScripts.vScriptStop</FullTypeName>
  </vScriptCommands>
  <vScriptCommands>
    <vsID>13</vsID>
    <CommandID>999b46d8-1847-4a34-ab60-3e2ca74ceea0</CommandID>
    <Name>Return_BGPASNumber</Name>
    <DisplayLabel>BGP AS Number</DisplayLabel>
    <Commands />
    <MainCode>######################################################################
#                                                                    #
# This call should be able to return BGP AS number for this router   #
#                                                                    #
######################################################################
global ActionResult

ASN = ""
#
# Implement required logic to acquire BGP AS number
#
ActionResult = ASN
</MainCode>
    <Origin_X>98</Origin_X>
    <Origin_Y>513</Origin_Y>
    <Size_Width>147</Size_Width>
    <Size_Height>50</Size_Height>
    <isStart>false</isStart>
    <isStop>false</isStop>
    <isSimpleCommand>false</isSimpleCommand>
    <isSimpleDecision>false</isSimpleDecision>
    <Variables />
    <Break>false</Break>
    <ExecPolicy>After</ExecPolicy>
    <CustomCodeBlock />
    <DemoMode>false</DemoMode>
    <Description>This call should be able to return BGP AS number for this router</Description>
    <WatchVariables />
    <Initializer />
    <FullTypeName>PGT.VisualScripts.vScriptStop</FullTypeName>
  </vScriptCommands>
  <vScriptCommands>
    <vsID>14</vsID>
    <CommandID>b1e6cdc1-9376-441f-9758-93a7c38d178e</CommandID>
    <Name>Return_HostName</Name>
    <DisplayLabel>Host Name</DisplayLabel>
    <Commands />
    <MainCode>#################################################################
#                                                               #
# This call should be able to return host name of this router   #
#                                                               #
#################################################################
global ActionResult
global HstName

# Initialize element has already updated the HostName global variable
# so return that one.
ActionResult = HostName</MainCode>
    <Origin_X>139</Origin_X>
    <Origin_Y>582</Origin_Y>
    <Size_Width>147</Size_Width>
    <Size_Height>50</Size_Height>
    <isStart>false</isStart>
    <isStop>false</isStop>
    <isSimpleCommand>false</isSimpleCommand>
    <isSimpleDecision>false</isSimpleDecision>
    <Variables />
    <Break>false</Break>
    <ExecPolicy>After</ExecPolicy>
    <CustomCodeBlock />
    <DemoMode>false</DemoMode>
    <Description>This call should be able to return host name of this router</Description>
    <WatchVariables />
    <Initializer />
    <FullTypeName>PGT.VisualScripts.vScriptStop</FullTypeName>
  </vScriptCommands>
  <vScriptCommands>
    <vsID>15</vsID>
    <CommandID>dfdd4171-2a1b-4428-8463-d0dcaca9e22e</CommandID>
    <Name>Return_Platform</Name>
    <DisplayLabel>Platform</DisplayLabel>
    <Commands />
    <MainCode>#################################################################
#                                                               #
# This call should be able to return Platform of this device    #
#                                                               #
#################################################################
global ActionResult

Platform = "PaloAlto"
#
# Platform is typically connected to the vendor name
# This values serves as information only and does not influence
# network discorey in any way.
#
ActionResult = Platform</MainCode>
    <Origin_X>721</Origin_X>
    <Origin_Y>237</Origin_Y>
    <Size_Width>147</Size_Width>
    <Size_Height>50</Size_Height>
    <isStart>false</isStart>
    <isStop>false</isStop>
    <isSimpleCommand>false</isSimpleCommand>
    <isSimpleDecision>false</isSimpleDecision>
    <Variables />
    <Break>false</Break>
    <ExecPolicy>After</ExecPolicy>
    <CustomCodeBlock />
    <DemoMode>false</DemoMode>
    <Description>This call should be able to return Platform of this device </Description>
    <WatchVariables />
    <Initializer />
    <FullTypeName>PGT.VisualScripts.vScriptStop</FullTypeName>
  </vScriptCommands>
  <vScriptCommands>
    <vsID>16</vsID>
    <CommandID>f1ac0ff6-d637-4a5d-b87d-e060ca2986f3</CommandID>
    <Name>Return_Type</Name>
    <DisplayLabel>Type</DisplayLabel>
    <Commands />
    <MainCode>#############################################################
#                                                           #
# This call should be able to return Type of this device    #
#                                                           #
#############################################################
global ActionResult

DeviceType = "Firewall"
#
# DeviceTyper is typically "Router" or "Switch"
# This values serves as information only and does not influence
# network discorey in any way.
#
ActionResult = DeviceType</MainCode>
    <Origin_X>763</Origin_X>
    <Origin_Y>301</Origin_Y>
    <Size_Width>147</Size_Width>
    <Size_Height>50</Size_Height>
    <isStart>false</isStart>
    <isStop>false</isStop>
    <isSimpleCommand>false</isSimpleCommand>
    <isSimpleDecision>false</isSimpleDecision>
    <Variables />
    <Break>false</Break>
    <ExecPolicy>After</ExecPolicy>
    <CustomCodeBlock />
    <DemoMode>false</DemoMode>
    <Description>This call should be able to return Type of this device </Description>
    <WatchVariables />
    <Initializer />
    <FullTypeName>PGT.VisualScripts.vScriptStop</FullTypeName>
  </vScriptCommands>
  <vScriptCommands>
    <vsID>17</vsID>
    <CommandID>d509949e-d797-4299-9345-678e3d60dd3b</CommandID>
    <Name>Return_Vendor</Name>
    <DisplayLabel>Vendor</DisplayLabel>
    <Commands />
    <MainCode>#####################################################################
#                                                                   #
# This call should be able to returnVendor name of this device      #
#                                                                   #
#####################################################################
global ActionResult

Vendor = "PaloAlto"
#
# WARNING !
#
# The Vendor name returned must match one of the Vendor names
# listed in PGT Configuration (see Tools/Options/Vendor )
#
# For a new vendor register the vendor name there first.
#
ActionResult = Vendor</MainCode>
    <Origin_X>785</Origin_X>
    <Origin_Y>368</Origin_Y>
    <Size_Width>147</Size_Width>
    <Size_Height>50</Size_Height>
    <isStart>false</isStart>
    <isStop>false</isStop>
    <isSimpleCommand>false</isSimpleCommand>
    <isSimpleDecision>false</isSimpleDecision>
    <Variables />
    <Break>false</Break>
    <ExecPolicy>After</ExecPolicy>
    <CustomCodeBlock />
    <DemoMode>false</DemoMode>
    <Description>This call should be able to returnVendor name of this device  </Description>
    <WatchVariables />
    <Initializer />
    <FullTypeName>PGT.VisualScripts.vScriptStop</FullTypeName>
  </vScriptCommands>
  <vScriptCommands>
    <vsID>18</vsID>
    <CommandID>bba6338e-bb3c-4577-b739-dbfa543f4de5</CommandID>
    <Name>Return_InterfaceByName</Name>
    <DisplayLabel>Interface By Name</DisplayLabel>
    <Commands />
    <MainCode>############################################################################################
#                                                                                          #
# This call should be able to return the RouterInterface object for the desired interface  #
#                                                                                          #
############################################################################################
global ActionResult

# the interface name to be queried is received in ConnectionInfo.aParam
# strip any leading or trailing spaces, otherwise command execution will fail
ifName = ConnectionInfo.aParam.strip()

#return the interface
ActionResult = GetInterfaces.GetInterfaceByName(ifName)</MainCode>
    <Origin_X>112</Origin_X>
    <Origin_Y>301</Origin_Y>
    <Size_Width>147</Size_Width>
    <Size_Height>50</Size_Height>
    <isStart>false</isStart>
    <isStop>false</isStop>
    <isSimpleCommand>false</isSimpleCommand>
    <isSimpleDecision>false</isSimpleDecision>
    <Variables />
    <Break>false</Break>
    <ExecPolicy>After</ExecPolicy>
    <CustomCodeBlock />
    <DemoMode>false</DemoMode>
    <Description>This call should be able to return the RouterInterface object for the desired interface </Description>
    <WatchVariables />
    <Initializer />
    <FullTypeName>PGT.VisualScripts.vScriptStop</FullTypeName>
  </vScriptCommands>
  <vScriptCommands>
    <vsID>19</vsID>
    <CommandID>0649a39e-13e2-4ff5-8b22-5e00775917cd</CommandID>
    <Name>Return_InterfaceNameByIPAddress</Name>
    <DisplayLabel>Interface Name By IP</DisplayLabel>
    <Commands />
    <MainCode>##################################################################################
#                                                                                #
# This call should be able to return an interface name based on its IP address   #
#                                                                                #
##################################################################################
global ActionResult

# the interface ip address to be queried is received in ConnectionInfo.aParam
ifAddress = ConnectionInfo.aParam

#return the interface name
ActionResult = GetInterfaces.GetInterfaceNameByAddress(ifAddress)</MainCode>
    <Origin_X>152</Origin_X>
    <Origin_Y>237</Origin_Y>
    <Size_Width>147</Size_Width>
    <Size_Height>50</Size_Height>
    <isStart>false</isStart>
    <isStop>false</isStop>
    <isSimpleCommand>false</isSimpleCommand>
    <isSimpleDecision>false</isSimpleDecision>
    <Variables />
    <Break>false</Break>
    <ExecPolicy>After</ExecPolicy>
    <CustomCodeBlock />
    <DemoMode>false</DemoMode>
    <Description>This call should be able to return an interface name based on its IP address</Description>
    <WatchVariables />
    <Initializer />
    <FullTypeName>PGT.VisualScripts.vScriptStop</FullTypeName>
  </vScriptCommands>
  <vScriptCommands>
    <vsID>20</vsID>
    <CommandID>bd4bb60a-dbe1-4da9-ae35-bdf41a8c5959</CommandID>
    <Name>Return_InterfaceConfiguration</Name>
    <DisplayLabel>Interface configuration</DisplayLabel>
    <Commands />
    <MainCode>#############################################################################
#                                                                           #
# This call should be able to update the interface configuration field      #
# of a given RouterInterface object.                                        #
# A returned bool value should indicate whether the update was successful   #                                      
#                                                                           #
#############################################################################

global ActionResult

# the interface to be queried is received in ConnectionInfo.aParam
queryInterface = ConnectionInfo.aParam

try:
  queryInterface.Configuration = GetInterfaces.GetInterfaceConfiguration(queryInterface.Name)
  ActionResult = True
except:
  ActionResult = False</MainCode>
    <Origin_X>214</Origin_X>
    <Origin_Y>177</Origin_Y>
    <Size_Width>147</Size_Width>
    <Size_Height>50</Size_Height>
    <isStart>false</isStart>
    <isStop>false</isStop>
    <isSimpleCommand>false</isSimpleCommand>
    <isSimpleDecision>false</isSimpleDecision>
    <Variables />
    <Break>false</Break>
    <ExecPolicy>After</ExecPolicy>
    <CustomCodeBlock />
    <DemoMode>false</DemoMode>
    <Description>This call should be able to update the interface configuration field of a given RouterInterface object.
A returned bool value should indicate whether the update was successful.</Description>
    <WatchVariables />
    <Initializer />
    <FullTypeName>PGT.VisualScripts.vScriptStop</FullTypeName>
  </vScriptCommands>
  <vScriptCommands>
    <vsID>21</vsID>
    <CommandID>6122cc1d-1453-4454-8a3c-cad171fdc84c</CommandID>
    <Name>Copy_of_Initialize</Name>
    <DisplayLabel>Initialize</DisplayLabel>
    <Commands />
    <MainCode>global ActionResult
global HostName

_versionInfo = Version.GetVersion()
HostName = Session.GetHostName()

if "paloaltonetworks" in _versionInfo.lower():
  prompt = Session.GetFullPrompt()
  if "active" in prompt :
    ActionResult = True
  else:
    # Current parser and object module do not support working with the passive firewall
    ActionResult = False
else :
  ActionResult = False</MainCode>
    <Origin_X>345</Origin_X>
    <Origin_Y>113</Origin_Y>
    <Size_Width>122</Size_Width>
    <Size_Height>40</Size_Height>
    <isStart>false</isStart>
    <isStop>false</isStop>
    <isSimpleCommand>false</isSimpleCommand>
    <isSimpleDecision>false</isSimpleDecision>
    <Variables />
    <Break>false</Break>
    <ExecPolicy>After</ExecPolicy>
    <CustomCodeBlock />
    <DemoMode>false</DemoMode>
    <Description />
    <WatchVariables />
    <Initializer />
    <FullTypeName>PGT.VisualScripts.vScriptStop</FullTypeName>
  </vScriptCommands>
  <vScriptCommands>
    <vsID>22</vsID>
    <CommandID>75e1f93c-a59b-419b-b685-9e1f1016ef36</CommandID>
    <Name>Reset</Name>
    <DisplayLabel>Reset</DisplayLabel>
    <Commands />
    <MainCode>global _versionInfo
global _hostName
global _stackCount
global _runningRoutingProtocols
global _interfaceConfigurations

_versionInfo = ""
_hostName = ""
_stackCount = -1
_runningRoutingProtocols = []
_interfaceConfigurations = {}

Version.Reset()
RouterIDAndASNumber.Reset()
GetInterfaces.Reset()</MainCode>
    <Origin_X>441</Origin_X>
    <Origin_Y>65</Origin_Y>
    <Size_Width>121</Size_Width>
    <Size_Height>40</Size_Height>
    <isStart>false</isStart>
    <isStop>false</isStop>
    <isSimpleCommand>false</isSimpleCommand>
    <isSimpleDecision>false</isSimpleDecision>
    <Variables />
    <Break>false</Break>
    <ExecPolicy>After</ExecPolicy>
    <CustomCodeBlock />
    <DemoMode>false</DemoMode>
    <Description>This object should reset the vScript to its original state by 
clearing any and variables populated during a previous run</Description>
    <WatchVariables />
    <Initializer />
    <FullTypeName>PGT.VisualScripts.vScriptStop</FullTypeName>
  </vScriptCommands>
  <vScriptCommands>
    <vsID>23</vsID>
    <CommandID>99c284e2-0e84-4007-9024-91457aabf7d9</CommandID>
    <Name>Version</Name>
    <DisplayLabel />
    <Commands />
    <MainCode>global ActionResult
global ConnectionDropped
global ScriptSuccess
global ConnectionInfo
global BreakExecution
global ScriptExecutor
global Session</MainCode>
    <Origin_X>248</Origin_X>
    <Origin_Y>849</Origin_Y>
    <Size_Width>149</Size_Width>
    <Size_Height>50</Size_Height>
    <isStart>false</isStart>
    <isStop>false</isStop>
    <isSimpleCommand>false</isSimpleCommand>
    <isSimpleDecision>false</isSimpleDecision>
    <Variables>DeviceVersion = None</Variables>
    <Break>false</Break>
    <ExecPolicy>After</ExecPolicy>
    <CustomCodeBlock>def GetVersion(self):
  if self.DeviceVersion == None : self.DeviceVersion = Session.ExecCommand("show system info")
  return self.DeviceVersion
  
def Reset(self):
  self.DeviceVersion = None</CustomCodeBlock>
    <DemoMode>false</DemoMode>
    <Description>Collects version information from connected device
if it has not yet been collected.</Description>
    <WatchVariables />
    <Initializer />
    <FullTypeName>PGT.VisualScripts.vScriptGeneralObject</FullTypeName>
  </vScriptCommands>
  <vScriptCommands>
    <vsID>24</vsID>
    <CommandID>19abb8f3-af0d-4d28-b21f-dfce56ff784e</CommandID>
    <Name>RouterIDAndASNumber</Name>
    <DisplayLabel>Router ID + BGP AS</DisplayLabel>
    <Commands />
    <MainCode>global ActionResult
global ConnectionDropped
global ScriptSuccess
global ConnectionInfo
global BreakExecution
global ScriptExecutor
global Session</MainCode>
    <Origin_X>642</Origin_X>
    <Origin_Y>849</Origin_Y>
    <Size_Width>150</Size_Width>
    <Size_Height>50</Size_Height>
    <isStart>false</isStart>
    <isStop>false</isStop>
    <isSimpleCommand>false</isSimpleCommand>
    <isSimpleDecision>false</isSimpleDecision>
    <Variables># RouterID is a dictionary keyed by RoutingProtocol as a string
RouterID = {}
BGPASNumber = ""
# static Router ID is used for STATIC routing
staticRouterID = ""</Variables>
    <Break>false</Break>
    <ExecPolicy>After</ExecPolicy>
    <CustomCodeBlock>def GetRouterID(self, protocol):
  if len(self.RouterID) == 0 : self.CalculateRouterIDAndASNumber()
  rid = self.RouterID.get(str(protocol), "")
  return rid
  
def GetBGPASNumber(self):
  if self.BGPASNumber == None : self.CalculateRouterIDAndASNumber()
  return self.BGPASNumber
  
def CalculateRouterIDAndASNumber(self):
  global _runningRoutingProtocols
 
  # first get the ip address from system info, we will use it when dynamic routing protocol is in use
  response = Session.ExecCommand("show system info | match ip-address:")
  words = filter(None, response.split(":"))
  if  len(words) == 2 : self.staticRouterID = words[1].strip()
  
  # sort the routing protocols by preference (its integer value)
  sRoutingProtocols = sorted(_runningRoutingProtocols, key=lambda p: int(p))
  for thisProtocol in sRoutingProtocols:  
    if thisProtocol == L3Discovery.NeighborProtocol.BGP:
      bgpSummary = Session.ExecCommand("show routing protocol bgp summary")
      rid = re.findall(r"(?&lt;=router id: )[\ ,d.]{0,99}", bgpSummary)
      if len(rid) &gt; 0 : 
        self.RouterID[str(thisProtocol)] = rid[0].strip()
        if self.staticRouterID == "" : self.staticRouterID = rid[0]
      # get AS number
      #
      # TODO : this is not tested and is most probably INCORRECT way to get the AS number !
      #
      ASes = re.findall(r"(?&lt;=autonomous-system: )[\ ,\d.]{0,99}",  bgpNeighbors)
      if len(ASes) &gt;= 0 : self.BGPASNumber = ASes[0]
      
    elif thisProtocol == L3Discovery.NeighborProtocol.OSPF:
      ospfStatus = Session.ExecCommand("show routing protocol ospf summary")
      rid = re.findall(r"(?&lt;=router id: )[\ ,\d.]{0,99}", ospfStatus)
      if len(rid) &gt; 0 : 
        self.RouterID[str(thisProtocol)] = rid[0].strip()
        if self.staticRouterID == "" : self.staticRouterID = rid[0]

    elif thisProtocol == L3Discovery.NeighborProtocol.RIP:
      ripfStatus = Session.ExecCommand("show routing protocol rip summary")
      rid = re.findall(r"(?&lt;=router id: )[\ ,\d.]{0,99}", ripStatus)
      if len(rid) &gt; 0 : 
        self.RouterID[str(thisProtocol)] = rid[0].strip()
        if self.staticRouterID == "" : self.staticRouterID = rid[0]
        
    elif thisProtocol == L3Discovery.NeighborProtocol.LLDP:
      lldpMAC = Session.ExecCommand("show system info | match mac-address")
      rid = re.findall(r"[a-fA-F0-9]{2}:[a-fA-F0-9]{2}:[a-fA-F0-9]{2}:[a-fA-F0-9]{2}:[a-fA-F0-9]{2}:[a-fA-F0-9]{2}", lldpMAC)
      if len(rid) == 1:
        self.RouterID[str(thisProtocol)] = rid[0].strip()
      
    elif thisProtocol == L3Discovery.NeighborProtocol.STATIC:
      self.RouterID[str(thisProtocol)] = self.staticRouterID
      
    else :
      self.RouterID[str(thisProtocol)] = self.staticRouterID
        
def Reset(self):
  self.RouterID = {}
  self.BGPASNumber = ""
  self.staticRouterID = ""</CustomCodeBlock>
    <DemoMode>false</DemoMode>
    <Description>This object is responsible to retrieve protocol
dependent RouterID and parse BGP AS number</Description>
    <WatchVariables />
    <Initializer />
    <EditorSize>{Width=1275, Height=851}|{X=26,Y=26}</EditorSize>
    <FullTypeName>PGT.VisualScripts.vScriptGeneralObject</FullTypeName>
  </vScriptCommands>
  <vScriptCommands>
    <vsID>25</vsID>
    <CommandID>99d17b29-26fb-40f8-a24b-9b9547aabe6e</CommandID>
    <Name>GetInterfaces</Name>
    <DisplayLabel>Get interface details</DisplayLabel>
    <Commands />
    <MainCode />
    <Origin_X>449</Origin_X>
    <Origin_Y>853</Origin_Y>
    <Size_Width>144</Size_Width>
    <Size_Height>50</Size_Height>
    <isStart>false</isStart>
    <isStop>false</isStop>
    <isSimpleCommand>false</isSimpleCommand>
    <isSimpleDecision>false</isSimpleDecision>
    <Variables># List of FWInterface objects
FWInterfaces = []   </Variables>
    <Break>false</Break>
    <ExecPolicy>After</ExecPolicy>
    <CustomCodeBlock># Add your custom methods to object like below
class FWInterface(object):
  def __init__(self):
    self.Name = ""
    self.ID = ""    
    self.Speed = ""
    self.Duplex = ""
    self.State = ""
    self.MAC = ""
    self.VSYS = ""
    self.Zone = ""
    self.Forwarding = ""
    self.Tag = ""
    self.Address = ""
    self.MaskLength = ""

"""Collects interface details for all interfaces """
def ParseInterfaces(self) :
  from  PGT.Common import IPOperations
  # get all interface data
  response = Session.ExecCommand("show interface all")
  interfaceBlock = False
  currentHeaderFields = []
  currentHeaderLine = ""
  tunnelMAC = ""
  loopbackMAC = ""
  intf_lines = [str.lower(thisLine.strip()) for thisLine in response.splitlines()]
  for thisLine in intf_lines:  
    try:
      # a line with dashes is just a separator, skip it
      if thisLine.startswith("------"): 
        continue
      
      # a line with the first word of "name " signals an interface block, and gives us the header
      if thisLine.startswith("name "):
        currentHeaderLine = thisLine
        currentHeaderFields = filter(None, currentHeaderLine.split(" "))
        interfaceBlock = True
        continue
      
      # skip the rest
      if thisLine.startswith("aggregation"):
        interfaceBlock = False
        continue
        
      # an empty line can also signal the end of an interface block   
      if interfaceBlock and thisLine == "":
        interfaceBlock = False
        continue
      
      # parse interface data in block
      if interfaceBlock:
        lineWords = filter(None, thisLine.split(" "))
        # the first item is interface name in each block
        ifName = lineWords[0]
        thisFWInterface = next((intf for intf in self.FWInterfaces if intf.Name == ifName), None)
        if thisFWInterface == None:
          # interface not found by name, create new one
          thisFWInterface = self.FWInterface()
          thisFWInterface.Name = ifName
          if ifName.startswith("tunnel."):
            thisFWInterface.MAC = tunnelMAC
          if ifName.startswith("loopback."):
            thisFWInterface.MAC = loopbackMAC
            
          self.FWInterfaces.Add(thisFWInterface)
        
        # the length of currentHeaderFields can guide us, which block we are in now
        if len(currentHeaderFields) == 5:
          # this is the physical IF parameters block
          # header :name,id,speed/duplex/state,mac,address    
          # ID        
          s = currentHeaderLine.index("id")
          e = currentHeaderLine.index("speed/duplex/state")
          thisFWInterface.ID = thisLine[s:e].strip() 
          # speed/duplex/state
          s = currentHeaderLine.index("speed/duplex/state")
          e = currentHeaderLine.index("mac")
          SDS = thisLine[s:e].strip().split("/")
          thisFWInterface.Speed = SDS[0]
          if len(SDS) &gt;= 2 : thisFWInterface.Duplex = SDS[1]
          if len(SDS) &gt;= 3 : thisFWInterface.State = SDS[2]
          # MAC
          s = currentHeaderLine.index("mac")
          e = len(thisLine)  
          thisFWInterface.MAC = thisLine[s:e].strip()
          # memorize MAC address for cloned interfaces
          if ifName == "tunnel":
            tunnelMAC = thisFWInterface.MAC
          if ifName == "loopback":
            loopbackMAC = thisFWInterface.MAC
          
        elif len(currentHeaderFields) == 7 :
          # this is the logical IF parameters block
          # header : name,id,vsys,zone,forwarding,tag,address  
          # vsys
          s = currentHeaderLine.index("vsys")
          e = currentHeaderLine.index("zone")
          thisFWInterface.VSYS = thisLine[s:e].strip()
          # zone
          s = currentHeaderLine.index("zone")
          e = currentHeaderLine.index("forwarding")           
          thisFWInterface.Zone = thisLine[s:e].strip()
          # forwarding
          s = currentHeaderLine.index("forwarding")
          e = currentHeaderLine.index("tag")
          thisFWInterface.Forwarding = thisLine[s:e].strip()
          # tag
          s = currentHeaderLine.index("tag")
          e = currentHeaderLine.index("address")        
          thisFWInterface.Tag = thisLine[s:e].strip()
          # address
          s = currentHeaderLine.index("address")
          e = len(thisLine)
          addr = thisLine[s:e].strip()
          if addr != "n/a":
            addressAndMask = addr.split('/')
            thisFWInterface.Address = addressAndMask[0]
            thisFWInterface.MaskLength = addressAndMask[1]
    except Exception as Ex:
      msg = "PaloAltoFirewall vScript Parser : Error while processing interface information. Error is : {0}".format(str(Ex))
      System.Diagnostics.DebugEx.WriteLine(msg) 
      
  # --- Get management interface details ---
  response = Session.ExecCommand("show interface management")
  if response != "":
    MGMTInterface = self.FWInterface()
    intf_lines = [str.lower(thisLine.strip()) for thisLine in response.splitlines()]
    for thisLine in intf_lines:   
      if thisLine.startswith("ip address"): 
        words = thisLine.split(":")
        MGMTInterface.Address = words[1].strip()
      if thisLine.startswith("netmask"): 
        words = thisLine.split(":")
        netMask = words[1]
        MGMTInterface.MaskLength = str(IPOperations.GetMaskLength(netMask))
        MGMTInterface.Name = "Management"
        self.FWInterfaces.Add(MGMTInterface)
        break        
            

"""Returns a RouterInterface object for the interface specified by its name"""        
def GetInterfaceByName(self, ifName):
  if len(self.FWInterfaces) == 0 : self.ParseInterfaces()
  foundFWInterface = next((intf for intf in self.FWInterfaces if intf.Name == ifName), None)
  return self.FWInterface2RouterInterface(foundFWInterface)
  
""" Returns a RouterInterface object for the interface specified by its ip address """    
def GetInterfaceNameByAddress(self, ipAddress):
  if len(self.FWInterfaces) == 0 : self.ParseInterfaces()
  ifName = ""
  foundFWInterface = next((intf for intf in self.FWInterfaces if intf.Address == ipAddress), None)
  if foundFWInterface != None:
    ifName = foundFWInterface.Name
  return ifName     

""" Return a synthetic configuration of an interface """
def GetInterfaceConfiguration(self, ifName):
  if len(self.FWInterfaces) == 0 : self.ParseInterfaces()
  ifConfig = ""
  foundFWInterface = next((intf for intf in self.FWInterfaces if intf.Name == ifName), None)
  if foundFWInterface != None:
    ifConfig = "{0}{\r\n  ID={1}\r\n  Address={2}/{3}\r\n}".format(foundFWInterface.Name, foundFWInterface.ID, foundFWInterface.Address, foundFWInterface.MaskLength )
  return ifConfig 

"""  Map an FWInterface object to L3Discovery.RouterInterface object"""
def FWInterface2RouterInterface(self, fwInterface):
  if fwInterface == None : return None
  # -- 
  ri = L3Discovery.RouterInterface()
  ri.Name = fwInterface.Name
  ri.Address = fwInterface.Address
  ri.Status =  fwInterface.State
  ri.MaskLength = fwInterface.MaskLength
  ri.Description = " ".join([fwInterface.Name, fwInterface.ID, fwInterface.VSYS, fwInterface.Zone])
  return ri
  
""" Return interfaces in the form of list of RouterInterface"""
def GetRoutedInterfaces(self):
  if len(self.FWInterfaces) == 0 : self.ParseInterfaces() 
  routedInterfaces = filter(lambda x: x.Address != "", self.FWInterfaces)
  return map(self.FWInterface2RouterInterface, routedInterfaces)
  
def Reset(self):
  self.FWInterfaces = []</CustomCodeBlock>
    <DemoMode>false</DemoMode>
    <Description>This object will parse interface details</Description>
    <WatchVariables />
    <Initializer />
    <FullTypeName>PGT.VisualScripts.vScriptGeneralObject</FullTypeName>
  </vScriptCommands>
  <vScriptCommands>
    <vsID>26</vsID>
    <CommandID>82bc327f-ca2d-48d0-ba65-7f952d80492f</CommandID>
    <Name>RegisterNHRP</Name>
    <DisplayLabel>Register NHRP</DisplayLabel>
    <Commands />
    <MainCode>global ActionResult
global ConnectionDropped
global ScriptSuccess
global ConnectionInfo
global BreakExecution</MainCode>
    <Origin_X>442</Origin_X>
    <Origin_Y>775</Origin_Y>
    <Size_Width>139</Size_Width>
    <Size_Height>43</Size_Height>
    <isStart>false</isStart>
    <isStop>false</isStop>
    <isSimpleCommand>false</isSimpleCommand>
    <isSimpleDecision>false</isSimpleDecision>
    <Variables />
    <Break>false</Break>
    <ExecPolicy>After</ExecPolicy>
    <CustomCodeBlock />
    <DemoMode>false</DemoMode>
    <Description />
    <WatchVariables />
    <Initializer />
    <FullTypeName>PGT.VisualScripts.vScriptStop</FullTypeName>
  </vScriptCommands>
  <vScriptConnector>
    <cID>0</cID>
    <ConnectorID />
    <Name>Start_GetSupportTag</Name>
    <DisplayLabel />
    <Left>0</Left>
    <Right>2</Right>
    <Condition>return True</Condition>
    <Variables />
    <Break>false</Break>
    <Order>0</Order>
    <Description />
    <WatchVariables />
  </vScriptConnector>
  <vScriptConnector>
    <cID>1</cID>
    <ConnectorID />
    <Name>SwitchTask_Unknown</Name>
    <DisplayLabel>Unknown</DisplayLabel>
    <Left>2</Left>
    <Right>1</Right>
    <Condition>return True</Condition>
    <Variables />
    <Break>false</Break>
    <Order>23</Order>
    <Description />
    <WatchVariables />
  </vScriptConnector>
  <vScriptConnector>
    <cID>2</cID>
    <ConnectorID />
    <Name>SwitchTask_SupportTag</Name>
    <DisplayLabel>GetSupportTag</DisplayLabel>
    <Left>2</Left>
    <Right>3</Right>
    <Condition>return ConnectionInfo.Command == "GetSupportTag"</Condition>
    <Variables />
    <Break>false</Break>
    <Order>2</Order>
    <Description />
    <WatchVariables />
  </vScriptConnector>
  <vScriptConnector>
    <cID>3</cID>
    <ConnectorID />
    <Name>SwitchTask_Copy_of_Initialize</Name>
    <DisplayLabel>Initialize</DisplayLabel>
    <Left>2</Left>
    <Right>21</Right>
    <Condition>return ConnectionInfo.Command == "Initialize"</Condition>
    <Variables />
    <Break>false</Break>
    <Order>0</Order>
    <Description />
    <WatchVariables />
  </vScriptConnector>
  <vScriptConnector>
    <cID>4</cID>
    <ConnectorID />
    <Name>SwitchTask_ReturnInventory</Name>
    <DisplayLabel>Get Inventory</DisplayLabel>
    <Left>2</Left>
    <Right>4</Right>
    <Condition>return ConnectionInfo.Command == "GetInventory"</Condition>
    <Variables />
    <Break>false</Break>
    <Order>9</Order>
    <Description />
    <WatchVariables />
  </vScriptConnector>
  <vScriptConnector>
    <cID>5</cID>
    <ConnectorID />
    <Name>SwitchTask_GetSystemSerial</Name>
    <DisplayLabel>Get Serial</DisplayLabel>
    <Left>2</Left>
    <Right>6</Right>
    <Condition>return ConnectionInfo.Command == "GetSystemSerial"</Condition>
    <Variables />
    <Break>false</Break>
    <Order>10</Order>
    <Description />
    <WatchVariables />
  </vScriptConnector>
  <vScriptConnector>
    <cID>6</cID>
    <ConnectorID />
    <Name>SwitchTask_ReturnVersion</Name>
    <DisplayLabel>Get version</DisplayLabel>
    <Left>2</Left>
    <Right>5</Right>
    <Condition>return ConnectionInfo.Command == "GetVersion"</Condition>
    <Variables />
    <Break>false</Break>
    <Order>7</Order>
    <Description />
    <WatchVariables />
  </vScriptConnector>
  <vScriptConnector>
    <cID>7</cID>
    <ConnectorID />
    <Name>SwitchTask_ReturnModelNumber</Name>
    <DisplayLabel>Get Model Number</DisplayLabel>
    <Left>2</Left>
    <Right>7</Right>
    <Condition>return ConnectionInfo.Command == "GetModelNumber"</Condition>
    <Variables />
    <Break>false</Break>
    <Order>6</Order>
    <Description />
    <WatchVariables />
  </vScriptConnector>
  <vScriptConnector>
    <cID>8</cID>
    <ConnectorID />
    <Name>SwitchTask_ReturnStackCount</Name>
    <DisplayLabel>Get Stack Count</DisplayLabel>
    <Left>2</Left>
    <Right>8</Right>
    <Condition>return ConnectionInfo.Command == "GetStackCount"</Condition>
    <Variables />
    <Break>false</Break>
    <Order>11</Order>
    <Description />
    <WatchVariables />
  </vScriptConnector>
  <vScriptConnector>
    <cID>9</cID>
    <ConnectorID />
    <Name>SwitchTask_Return_RoutingTable</Name>
    <DisplayLabel>Get Routing Table</DisplayLabel>
    <Left>2</Left>
    <Right>9</Right>
    <Condition>return ConnectionInfo.Command == "GetRoutingTable"</Condition>
    <Variables />
    <Break>false</Break>
    <Order>16</Order>
    <Description />
    <WatchVariables />
  </vScriptConnector>
  <vScriptConnector>
    <cID>10</cID>
    <ConnectorID />
    <Name>SwitchTask_Return_RoutedInterfaces</Name>
    <DisplayLabel>Get Routed Interfaces</DisplayLabel>
    <Left>2</Left>
    <Right>10</Right>
    <Condition>return ConnectionInfo.Command == "GetRoutedInterfaces"</Condition>
    <Variables />
    <Break>false</Break>
    <Order>15</Order>
    <Description />
    <WatchVariables />
  </vScriptConnector>
  <vScriptConnector>
    <cID>11</cID>
    <ConnectorID />
    <Name>SwitchTask_Return_RouterID</Name>
    <DisplayLabel>Get Router ID</DisplayLabel>
    <Left>2</Left>
    <Right>11</Right>
    <Condition>return ConnectionInfo.Command == "GetRouterID"</Condition>
    <Variables />
    <Break>false</Break>
    <Order>8</Order>
    <Description />
    <WatchVariables />
  </vScriptConnector>
  <vScriptConnector>
    <cID>12</cID>
    <ConnectorID />
    <Name>SwitchTask_Return_ActiveRoutingProtocols</Name>
    <DisplayLabel>Ge tActive Protocols</DisplayLabel>
    <Left>2</Left>
    <Right>12</Right>
    <Condition>return ConnectionInfo.Command == "GetActiveProtocols"</Condition>
    <Variables />
    <Break>false</Break>
    <Order>12</Order>
    <Description />
    <WatchVariables />
  </vScriptConnector>
  <vScriptConnector>
    <cID>13</cID>
    <ConnectorID />
    <Name>SwitchTask_Return_BGPASNumber</Name>
    <DisplayLabel>Get BGP AS</DisplayLabel>
    <Left>2</Left>
    <Right>13</Right>
    <Condition>return ConnectionInfo.Command == "GeBGPASNumber"</Condition>
    <Variables />
    <Break>false</Break>
    <Order>14</Order>
    <Description />
    <WatchVariables />
  </vScriptConnector>
  <vScriptConnector>
    <cID>14</cID>
    <ConnectorID />
    <Name>SwitchTask_Return_HostName</Name>
    <DisplayLabel>Get HostName</DisplayLabel>
    <Left>2</Left>
    <Right>14</Right>
    <Condition>return ConnectionInfo.Command == "GetHostName"</Condition>
    <Variables />
    <Break>false</Break>
    <Order>13</Order>
    <Description />
    <WatchVariables />
  </vScriptConnector>
  <vScriptConnector>
    <cID>15</cID>
    <ConnectorID />
    <Name>SwitchTask_Return_Platform</Name>
    <DisplayLabel>Get Platform</DisplayLabel>
    <Left>2</Left>
    <Right>15</Right>
    <Condition>return ConnectionInfo.Command == "GetPlatform"</Condition>
    <Variables />
    <Break>false</Break>
    <Order>3</Order>
    <Description />
    <WatchVariables />
  </vScriptConnector>
  <vScriptConnector>
    <cID>16</cID>
    <ConnectorID />
    <Name>SwitchTask_Return_Type</Name>
    <DisplayLabel>Get Type</DisplayLabel>
    <Left>2</Left>
    <Right>16</Right>
    <Condition>return ConnectionInfo.Command == "GetType"</Condition>
    <Variables />
    <Break>false</Break>
    <Order>4</Order>
    <Description />
    <WatchVariables />
  </vScriptConnector>
  <vScriptConnector>
    <cID>17</cID>
    <ConnectorID />
    <Name>SwitchTask_Return_Vendor</Name>
    <DisplayLabel>Get Vendor</DisplayLabel>
    <Left>2</Left>
    <Right>17</Right>
    <Condition>return ConnectionInfo.Command == "GetVendor"</Condition>
    <Variables />
    <Break>false</Break>
    <Order>5</Order>
    <Description />
    <WatchVariables />
  </vScriptConnector>
  <vScriptConnector>
    <cID>18</cID>
    <ConnectorID />
    <Name>SwitchTask_Return_InterfaceByName</Name>
    <DisplayLabel>Get If By Name</DisplayLabel>
    <Left>2</Left>
    <Right>18</Right>
    <Condition>return ConnectionInfo.Command == "GetInterfaceByName"</Condition>
    <Variables />
    <Break>false</Break>
    <Order>17</Order>
    <Description />
    <WatchVariables />
  </vScriptConnector>
  <vScriptConnector>
    <cID>19</cID>
    <ConnectorID />
    <Name>SwitchTask_Return_InterfaceByIPAddress</Name>
    <DisplayLabel>Get If Bí IP</DisplayLabel>
    <Left>2</Left>
    <Right>19</Right>
    <Condition>return ConnectionInfo.Command == "GetInterfaceNameByIPAddress"</Condition>
    <Variables />
    <Break>false</Break>
    <Order>18</Order>
    <Description />
    <WatchVariables />
  </vScriptConnector>
  <vScriptConnector>
    <cID>20</cID>
    <ConnectorID />
    <Name>SwitchTask_Return_InterfaceConfiguration</Name>
    <DisplayLabel>Get If Config</DisplayLabel>
    <Left>2</Left>
    <Right>20</Right>
    <Condition>return ConnectionInfo.Command == "GetInterfaceConfiguration"</Condition>
    <Variables />
    <Break>false</Break>
    <Order>19</Order>
    <Description />
    <WatchVariables />
  </vScriptConnector>
  <vScriptConnector>
    <cID>21</cID>
    <ConnectorID />
    <Name>SwitchTask_Copy_of_Stop_2</Name>
    <DisplayLabel>Reset</DisplayLabel>
    <Left>2</Left>
    <Right>22</Right>
    <Condition>return ConnectionInfo.Command == "Reset"</Condition>
    <Variables />
    <Break>false</Break>
    <Order>1</Order>
    <Description />
    <WatchVariables />
  </vScriptConnector>
  <vScriptConnector>
    <cID>22</cID>
    <ConnectorID />
    <Name>SwitchTask_RegisterNHRP</Name>
    <DisplayLabel>Register NHRP</DisplayLabel>
    <Left>2</Left>
    <Right>26</Right>
    <Condition>return ConnectionInfo.Command == "RegisterNHRP"</Condition>
    <Variables />
    <Break>false</Break>
    <Order>22</Order>
    <Description />
    <WatchVariables />
  </vScriptConnector>
  <Parameters>
    <ScriptName>PaloAltoFirewall</ScriptName>
    <GlobalCode>###################################
#                                 #
# Declare global variables here   #
#                                 #
###################################
scriptVersion = "2.0"
VersionInfo = ""
HostName = ""

# The routing protocols run by this router
_runningRoutingProtocols = []
# Interface config cache, keyed by Interface Name
_interfaceConfigurations = {}
# Routed interfaces
_routedInterfaces = []</GlobalCode>
    <BreakPolicy>Before</BreakPolicy>
    <CustomNameSpaces>############################################################
#                                                          #
# Below imports a typically required for a Router Module   #
#                                                          #
############################################################
import re
import sys
import clr
clr.AddReferenceToFileAndPath("Common.dll")
clr.AddReferenceToFileAndPath("PGTNetworkMap.dll")
import PGT.Common
import L3Discovery
import System.Net</CustomNameSpaces>
    <CustomReferences />
    <DebuggingAllowed>false</DebuggingAllowed>
    <LogFileName />
    <WatchVariables />
    <Language>Python</Language>
    <IsTemplate>false</IsTemplate>
    <IsRepository>false</IsRepository>
    <EditorScaleFactor>0.6640003</EditorScaleFactor>
    <Description>This vScript is responsible to parse configuration
items from a Palo Alto PAN firewall</Description>
    <EditorSize>{Width=735, Height=677}</EditorSize>
    <PropertiesEditorSize>{Width=665, Height=460}|{X=627,Y=350}</PropertiesEditorSize>
  </Parameters>
</vScriptDS>