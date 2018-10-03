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
    <EditorSize>0:0</EditorSize>
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

raise ValueError("Junos Router received an unhandled Command request : {0}".format(ConnectionInfo.CustomActionID))</MainCode>
    <Origin_X>607</Origin_X>
    <Origin_Y>56</Origin_Y>
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
    <EditorSize>800:602</EditorSize>
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
    <EditorSize>618:818</EditorSize>
    <FullTypeName>PGT.VisualScripts.vScriptCommand</FullTypeName>
  </vScriptCommands>
  <vScriptCommands>
    <vsID>3</vsID>
    <CommandID>8efdee9c-4bd5-4c8d-9188-bbc2cbe9e79f</CommandID>
    <Name>Initialite</Name>
    <DisplayLabel>Initialize</DisplayLabel>
    <Commands />
    <MainCode>##############################################################################
#                                                                            #
# Initialize must decide whether this module can handle the connected device #
#                                                                            #
##############################################################################
global ActionResult
global HostName
global Registry

# ConnectionInfo.aParam will contain the NeighborReegistry object
# that can be used later to register NHRP peers for example

Registry = ConnectionInfo.aParam

#
# It is a good practice to update some global variables here.
#
# VersionInfo = Session.ExecCommand("show version")
#
# HostName can typically queried in this call
#
HostName = Session.GetHostName()

# Now we must decide if the current implementation can support the connected device
# and return a boolean value accordingly. This can be based on any device parameter.
#
# Example :
#
# _versionInfo = Session.ExecCommand("show version")
# isSupported = "junos" in _versionInfo.lower()
#

IsSupported = False

ActionResult = IsSupported</MainCode>
    <Origin_X>384</Origin_X>
    <Origin_Y>133</Origin_Y>
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
    <Description>Initialize must decide whether this module can handle the connected device</Description>
    <WatchVariables />
    <Initializer />
    <EditorSize>851:703</EditorSize>
    <FullTypeName>PGT.VisualScripts.vScriptCommand</FullTypeName>
  </vScriptCommands>
  <vScriptCommands>
    <vsID>4</vsID>
    <CommandID>6eee32a1-679c-4dfa-aaea-5694d8caa7d4</CommandID>
    <Name>Done</Name>
    <DisplayLabel>Done</DisplayLabel>
    <Commands />
    <MainCode />
    <Origin_X>427</Origin_X>
    <Origin_Y>57</Origin_Y>
    <Size_Width>149</Size_Width>
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
    <Description>All Done</Description>
    <WatchVariables />
    <Initializer />
    <EditorSize>831:460</EditorSize>
    <FullTypeName>PGT.VisualScripts.vScriptStop</FullTypeName>
  </vScriptCommands>
  <vScriptCommands>
    <vsID>5</vsID>
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

ActionResult = "TEMPLATE Router Support Module - Python vScript Parser " + scriptVersion</MainCode>
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
    <EditorSize>808:559</EditorSize>
    <FullTypeName>PGT.VisualScripts.vScriptStop</FullTypeName>
  </vScriptCommands>
  <vScriptCommands>
    <vsID>6</vsID>
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

Inventory = "n/a"
#
# Implement required logic to get the device inventory
#
ActionResult = Inventory</MainCode>
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
    <EditorSize>771:618</EditorSize>
    <FullTypeName>PGT.VisualScripts.vScriptStop</FullTypeName>
  </vScriptCommands>
  <vScriptCommands>
    <vsID>7</vsID>
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
ActionResult = VersionInfo</MainCode>
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
    <EditorSize>812:639</EditorSize>
    <FullTypeName>PGT.VisualScripts.vScriptStop</FullTypeName>
  </vScriptCommands>
  <vScriptCommands>
    <vsID>8</vsID>
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

Serial = "n/a"
#
# Implement required logic to get the correct serial number
#
ActionResult = Serial</MainCode>
    <Origin_X>512</Origin_X>
    <Origin_Y>713</Origin_Y>
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
    <EditorSize>823:676</EditorSize>
    <FullTypeName>PGT.VisualScripts.vScriptStop</FullTypeName>
  </vScriptCommands>
  <vScriptCommands>
    <vsID>9</vsID>
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

ModelNumber = ""
#
# Implement required logic to get the actual ModelNumber
#
ActionResult = ModelNumber</MainCode>
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
    <EditorSize>735:574</EditorSize>
    <FullTypeName>PGT.VisualScripts.vScriptStop</FullTypeName>
  </vScriptCommands>
  <vScriptCommands>
    <vsID>10</vsID>
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
    <Origin_X>332</Origin_X>
    <Origin_Y>713</Origin_Y>
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
    <EditorSize>695:562</EditorSize>
    <FullTypeName>PGT.VisualScripts.vScriptStop</FullTypeName>
  </vScriptCommands>
  <vScriptCommands>
    <vsID>11</vsID>
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

# The routing table should be returned as a list, consiting of RouteTableEntry objects
routingTable = []
#
# Implement required logic to query the route table and construct RouteTebleEntry objects
#
#try:
#  rte = L3Discovery.RouteTableEntry()
#  rte.Protocol = "OSPF"
#  rte.RouterID = GetRouterID(rte.Protocol)
#  rte.Prefix = "192.168.0.0"
#  rte.MaskLength = 32
#  rte.NextHop = "10.0.0.1"
#  rte.Best = True
#  rte.AD = "110"
#  rte.Metric = "100"
#  rte.Tag = ""
#  rte.OutInterface = "ge-0/0/47"
#  routingTable.Add(rte)
#                
#except Exception as Ex:
#  message = "Router Module Error : could not parse a route table Network block because : " + str(Ex)
#  System.Diagnostics.DebugEx.WriteLine(message)
# 
ActionResult = routingTable</MainCode>
    <Origin_X>95</Origin_X>
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
    <Description>This call should be able to return the full routing table of the device</Description>
    <WatchVariables />
    <Initializer />
    <EditorSize>971:818</EditorSize>
    <FullTypeName>PGT.VisualScripts.vScriptStop</FullTypeName>
  </vScriptCommands>
  <vScriptCommands>
    <vsID>12</vsID>
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

# This is going to be the result we pass back
routedInterfaces = []
#
# Implement required logic to query for routed interfaces and construct RouterInterface objects
#
#ri = L3Discovery.RouterInterface()
#ri.Name = "ge-0/0/10"
#ri.Address = "192.168.1.1"
#ri.Status =  "up up"
#ri.MaskLength = "32"
#routedInterfaces.Add(ri)

ActionResult = routedInterfaces </MainCode>
    <Origin_X>91</Origin_X>
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
    <Description>This call should be able to return the list of routed interfaces </Description>
    <WatchVariables />
    <Initializer />
    <EditorSize>874:670</EditorSize>
    <FullTypeName>PGT.VisualScripts.vScriptStop</FullTypeName>
  </vScriptCommands>
  <vScriptCommands>
    <vsID>13</vsID>
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

RouterID = {}
#
# Example : RouterID = {"OSPF":"10.0.0.254", "BGP":"20.0.0.254"}
#
# Implement required logic to get the actual RouterID
# Consider some caching mechanism to speed up execution.
#

# The protocol for which to get the RouterID
protocol = ConnectionInfo.aParam
ActionResult = RouterID[protocol]</MainCode>
    <Origin_X>716</Origin_X>
    <Origin_Y>583</Origin_Y>
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
    <Description> This call should be able to return RouterID of this device</Description>
    <WatchVariables />
    <Initializer />
    <EditorSize>644:588</EditorSize>
    <FullTypeName>PGT.VisualScripts.vScriptStop</FullTypeName>
  </vScriptCommands>
  <vScriptCommands>
    <vsID>14</vsID>
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

runningRoutingProtocols = []
#
# the List should contain elements of L3Discovery.RoutingProtocols enumeration
#
# Implement required logic to check for running protocols and add the respective element
#
# if OSPFRunning : runningRoutingProtocols.Add(L3Discovery.RoutingProtocols.OSPF)
# if RIPRunning :runningRoutingProtocols.Add(L3Discovery.RoutingProtocols.RIP)  
# if BGPRunning :runningRoutingProtocols.Add(L3Discovery.RoutingProtocols.BGP)
# if STATICExists :runningRoutingProtocols.Add(L3Discovery.RoutingProtocols.STATIC)  
#
ActionResult = runningRoutingProtocols</MainCode>
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
    <EditorSize>1011:842</EditorSize>
    <FullTypeName>PGT.VisualScripts.vScriptStop</FullTypeName>
  </vScriptCommands>
  <vScriptCommands>
    <vsID>15</vsID>
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
    <EditorSize>644:588</EditorSize>
    <FullTypeName>PGT.VisualScripts.vScriptStop</FullTypeName>
  </vScriptCommands>
  <vScriptCommands>
    <vsID>16</vsID>
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
    <EditorSize>644:588</EditorSize>
    <FullTypeName>PGT.VisualScripts.vScriptStop</FullTypeName>
  </vScriptCommands>
  <vScriptCommands>
    <vsID>17</vsID>
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

Platform = ""
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
    <EditorSize>644:588</EditorSize>
    <FullTypeName>PGT.VisualScripts.vScriptStop</FullTypeName>
  </vScriptCommands>
  <vScriptCommands>
    <vsID>18</vsID>
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

DeviceType = "Router"
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
    <EditorSize>644:588</EditorSize>
    <FullTypeName>PGT.VisualScripts.vScriptStop</FullTypeName>
  </vScriptCommands>
  <vScriptCommands>
    <vsID>19</vsID>
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

Vendor = ""
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
    <EditorSize>644:658</EditorSize>
    <FullTypeName>PGT.VisualScripts.vScriptStop</FullTypeName>
  </vScriptCommands>
  <vScriptCommands>
    <vsID>20</vsID>
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
ifName = ConnectionInfo.aParam
# this is the RouterInterface object to be returned
ri = L3Discovery.RouterInterface()
#
# Implement required logic to update all interface fields
#
# ri.Configuration = ""
# ri.Description = ""
# ri.Address = ""
# ri.MaskLength = 32
#
#return the interface
#
ActionResult = ri</MainCode>
    <Origin_X>116</Origin_X>
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
    <EditorSize>839:705</EditorSize>
    <FullTypeName>PGT.VisualScripts.vScriptStop</FullTypeName>
  </vScriptCommands>
  <vScriptCommands>
    <vsID>21</vsID>
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
ifName= ""
#
# Implement required logic to get interface name, then return it
#
ActionResult = ifName.strip()</MainCode>
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
    <EditorSize>756:775</EditorSize>
    <FullTypeName>PGT.VisualScripts.vScriptStop</FullTypeName>
  </vScriptCommands>
  <vScriptCommands>
    <vsID>22</vsID>
    <CommandID>bd4bb60a-dbe1-4da9-ae35-bdf41a8c5959</CommandID>
    <Name>Return_InterfaceConfiguration</Name>
    <DisplayLabel>Interface configuration</DisplayLabel>
    <Commands />
    <MainCode>#############################################################################
#                                                                           #
# This call should be able to update the interface configuration field      #
# of a given RouterInterface object.                                        #
# A returned bool value should indicate whether the update was successful   #                                      #
#                                                                           #
#############################################################################

global ActionResult

# the interface object is received in ConnectionInfo.aParam
queryInterface = ConnectionInfo.aParam

try:
  ifConfig =  ""
  #
  # Implement required logic to get interface configuration from device
  # Consider using an internal cache for configurations to speed up
  # repetitive queries for the same interface.
  #
  # ...then update the Configuration field of the object and return True
  queryInterface.Configuration = ifConfig
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
    <EditorSize>684:753</EditorSize>
    <FullTypeName>PGT.VisualScripts.vScriptStop</FullTypeName>
  </vScriptCommands>
  <vScriptCommands>
    <vsID>23</vsID>
    <CommandID>30454073-24c3-46bb-ab9e-08ea554d79f4</CommandID>
    <Name>Reset</Name>
    <DisplayLabel>Reset</DisplayLabel>
    <Commands />
    <MainCode>#####################################################
#                                                   #
# Reset must reset the module to its original state #
#                                                   #
#####################################################

global ActionResult
ActionResult = None
HostName = ""
VersionInfo = ""</MainCode>
    <Origin_X>526</Origin_X>
    <Origin_Y>135</Origin_Y>
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
    <Description>Reset must reset the module to its original state</Description>
    <WatchVariables />
    <Initializer />
    <EditorSize>826:631</EditorSize>
    <FullTypeName>PGT.VisualScripts.vScriptCommand</FullTypeName>
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
    <EditorSize>671:460</EditorSize>
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
    <EditorSize>671:460</EditorSize>
  </vScriptConnector>
  <vScriptConnector>
    <cID>2</cID>
    <ConnectorID />
    <Name>SwitchTask_SupportTag</Name>
    <DisplayLabel>GetSupportTag</DisplayLabel>
    <Left>2</Left>
    <Right>5</Right>
    <Condition>return ConnectionInfo.CustomActionID == "GetSupportTag"</Condition>
    <Variables />
    <Break>false</Break>
    <Order>2</Order>
    <Description />
    <WatchVariables />
    <EditorSize>671:460</EditorSize>
  </vScriptConnector>
  <vScriptConnector>
    <cID>3</cID>
    <ConnectorID />
    <Name>SwitchTask_Initialize</Name>
    <DisplayLabel>Initialize</DisplayLabel>
    <Left>2</Left>
    <Right>3</Right>
    <Condition>return ConnectionInfo.CustomActionID == "Initialize"</Condition>
    <Variables />
    <Break>false</Break>
    <Order>0</Order>
    <Description />
    <WatchVariables />
    <EditorSize>671:460</EditorSize>
  </vScriptConnector>
  <vScriptConnector>
    <cID>4</cID>
    <ConnectorID />
    <Name>Initialite_Done</Name>
    <DisplayLabel />
    <Left>3</Left>
    <Right>4</Right>
    <Condition>return True</Condition>
    <Variables />
    <Break>false</Break>
    <Order>1</Order>
    <Description />
    <WatchVariables />
    <EditorSize>671:460</EditorSize>
  </vScriptConnector>
  <vScriptConnector>
    <cID>5</cID>
    <ConnectorID />
    <Name>SwitchTask_ReturnInventory</Name>
    <DisplayLabel>Get Inventory</DisplayLabel>
    <Left>2</Left>
    <Right>6</Right>
    <Condition>return ConnectionInfo.CustomActionID == "GetInventory"</Condition>
    <Variables />
    <Break>false</Break>
    <Order>9</Order>
    <Description />
    <WatchVariables />
    <EditorSize>671:460</EditorSize>
  </vScriptConnector>
  <vScriptConnector>
    <cID>6</cID>
    <ConnectorID />
    <Name>SwitchTask_GetSystemSerial</Name>
    <DisplayLabel>Get Serial</DisplayLabel>
    <Left>2</Left>
    <Right>8</Right>
    <Condition>return ConnectionInfo.CustomActionID == "GetSystemSerial"</Condition>
    <Variables />
    <Break>false</Break>
    <Order>10</Order>
    <Description />
    <WatchVariables />
    <EditorSize>671:460</EditorSize>
  </vScriptConnector>
  <vScriptConnector>
    <cID>7</cID>
    <ConnectorID />
    <Name>SwitchTask_ReturnVersion</Name>
    <DisplayLabel>Get version</DisplayLabel>
    <Left>2</Left>
    <Right>7</Right>
    <Condition>return ConnectionInfo.CustomActionID == "GetVersion"</Condition>
    <Variables />
    <Break>false</Break>
    <Order>7</Order>
    <Description />
    <WatchVariables />
    <EditorSize>671:460</EditorSize>
  </vScriptConnector>
  <vScriptConnector>
    <cID>8</cID>
    <ConnectorID />
    <Name>SwitchTask_ReturnModelNumber</Name>
    <DisplayLabel>Get Model Number</DisplayLabel>
    <Left>2</Left>
    <Right>9</Right>
    <Condition>return ConnectionInfo.CustomActionID == "GetModelNumber"</Condition>
    <Variables />
    <Break>false</Break>
    <Order>6</Order>
    <Description />
    <WatchVariables />
    <EditorSize>671:460</EditorSize>
  </vScriptConnector>
  <vScriptConnector>
    <cID>9</cID>
    <ConnectorID />
    <Name>SwitchTask_ReturnStackCount</Name>
    <DisplayLabel>Get Stack Count</DisplayLabel>
    <Left>2</Left>
    <Right>10</Right>
    <Condition>return ConnectionInfo.CustomActionID == "GetStackCount"</Condition>
    <Variables />
    <Break>false</Break>
    <Order>11</Order>
    <Description />
    <WatchVariables />
    <EditorSize>671:460</EditorSize>
  </vScriptConnector>
  <vScriptConnector>
    <cID>10</cID>
    <ConnectorID />
    <Name>SwitchTask_Return_RoutingTable</Name>
    <DisplayLabel>Get Routing Table</DisplayLabel>
    <Left>2</Left>
    <Right>11</Right>
    <Condition>return ConnectionInfo.CustomActionID == "GetRoutingTable"</Condition>
    <Variables />
    <Break>false</Break>
    <Order>16</Order>
    <Description />
    <WatchVariables />
    <EditorSize>671:460</EditorSize>
  </vScriptConnector>
  <vScriptConnector>
    <cID>11</cID>
    <ConnectorID />
    <Name>SwitchTask_Return_RoutedInterfaces</Name>
    <DisplayLabel>Get Routed Interfaces</DisplayLabel>
    <Left>2</Left>
    <Right>12</Right>
    <Condition>return ConnectionInfo.CustomActionID == "GetRoutedInterfaces"</Condition>
    <Variables />
    <Break>false</Break>
    <Order>15</Order>
    <Description />
    <WatchVariables />
    <EditorSize>671:460</EditorSize>
  </vScriptConnector>
  <vScriptConnector>
    <cID>12</cID>
    <ConnectorID />
    <Name>SwitchTask_Return_RouterID</Name>
    <DisplayLabel>Get Router ID</DisplayLabel>
    <Left>2</Left>
    <Right>13</Right>
    <Condition>return ConnectionInfo.CustomActionID == "GetRouterID"</Condition>
    <Variables />
    <Break>false</Break>
    <Order>8</Order>
    <Description />
    <WatchVariables />
    <EditorSize>671:460</EditorSize>
  </vScriptConnector>
  <vScriptConnector>
    <cID>13</cID>
    <ConnectorID />
    <Name>SwitchTask_Return_ActiveRoutingProtocols</Name>
    <DisplayLabel>Ge tActive Routing Protocols</DisplayLabel>
    <Left>2</Left>
    <Right>14</Right>
    <Condition>return ConnectionInfo.CustomActionID == "GetActiveRoutingProtocols"</Condition>
    <Variables />
    <Break>false</Break>
    <Order>12</Order>
    <Description />
    <WatchVariables />
    <EditorSize>671:460</EditorSize>
  </vScriptConnector>
  <vScriptConnector>
    <cID>14</cID>
    <ConnectorID />
    <Name>SwitchTask_Return_BGPASNumber</Name>
    <DisplayLabel>Get BGP AS</DisplayLabel>
    <Left>2</Left>
    <Right>15</Right>
    <Condition>return ConnectionInfo.CustomActionID == "GeBGPASNumber"</Condition>
    <Variables />
    <Break>false</Break>
    <Order>14</Order>
    <Description />
    <WatchVariables />
    <EditorSize>671:460</EditorSize>
  </vScriptConnector>
  <vScriptConnector>
    <cID>15</cID>
    <ConnectorID />
    <Name>SwitchTask_Return_HostName</Name>
    <DisplayLabel>Get HostName</DisplayLabel>
    <Left>2</Left>
    <Right>16</Right>
    <Condition>return ConnectionInfo.CustomActionID == "GetHostName"</Condition>
    <Variables />
    <Break>false</Break>
    <Order>13</Order>
    <Description />
    <WatchVariables />
    <EditorSize>671:460</EditorSize>
  </vScriptConnector>
  <vScriptConnector>
    <cID>16</cID>
    <ConnectorID />
    <Name>SwitchTask_Return_Platform</Name>
    <DisplayLabel>Get Platform</DisplayLabel>
    <Left>2</Left>
    <Right>17</Right>
    <Condition>return ConnectionInfo.CustomActionID == "GetPlatform"</Condition>
    <Variables />
    <Break>false</Break>
    <Order>3</Order>
    <Description />
    <WatchVariables />
    <EditorSize>671:460</EditorSize>
  </vScriptConnector>
  <vScriptConnector>
    <cID>17</cID>
    <ConnectorID />
    <Name>SwitchTask_Return_Type</Name>
    <DisplayLabel>Get Type</DisplayLabel>
    <Left>2</Left>
    <Right>18</Right>
    <Condition>return ConnectionInfo.CustomActionID == "GetType"</Condition>
    <Variables />
    <Break>false</Break>
    <Order>4</Order>
    <Description />
    <WatchVariables />
    <EditorSize>671:460</EditorSize>
  </vScriptConnector>
  <vScriptConnector>
    <cID>18</cID>
    <ConnectorID />
    <Name>SwitchTask_Return_Vendor</Name>
    <DisplayLabel>Get Vendor</DisplayLabel>
    <Left>2</Left>
    <Right>19</Right>
    <Condition>return ConnectionInfo.CustomActionID == "GetVendor"</Condition>
    <Variables />
    <Break>false</Break>
    <Order>5</Order>
    <Description />
    <WatchVariables />
    <EditorSize>671:460</EditorSize>
  </vScriptConnector>
  <vScriptConnector>
    <cID>19</cID>
    <ConnectorID />
    <Name>SwitchTask_Return_InterfaceByName</Name>
    <DisplayLabel>Get If By Name</DisplayLabel>
    <Left>2</Left>
    <Right>20</Right>
    <Condition>return ConnectionInfo.CustomActionID == "GetInterfaceByName"</Condition>
    <Variables />
    <Break>false</Break>
    <Order>17</Order>
    <Description />
    <WatchVariables />
    <EditorSize>671:460</EditorSize>
  </vScriptConnector>
  <vScriptConnector>
    <cID>20</cID>
    <ConnectorID />
    <Name>SwitchTask_Return_InterfaceByIPAddress</Name>
    <DisplayLabel>Get If Bí IP</DisplayLabel>
    <Left>2</Left>
    <Right>21</Right>
    <Condition>return ConnectionInfo.CustomActionID == "GetInterfaceNameByIPAddress"</Condition>
    <Variables />
    <Break>false</Break>
    <Order>18</Order>
    <Description />
    <WatchVariables />
    <EditorSize>671:460</EditorSize>
  </vScriptConnector>
  <vScriptConnector>
    <cID>21</cID>
    <ConnectorID />
    <Name>SwitchTask_Return_InterfaceConfiguration</Name>
    <DisplayLabel>Get If Config</DisplayLabel>
    <Left>2</Left>
    <Right>22</Right>
    <Condition>return ConnectionInfo.CustomActionID == "GetInterfaceConfiguration"</Condition>
    <Variables />
    <Break>false</Break>
    <Order>19</Order>
    <Description />
    <WatchVariables />
    <EditorSize>671:460</EditorSize>
  </vScriptConnector>
  <vScriptConnector>
    <cID>22</cID>
    <ConnectorID />
    <Name>SwitchTask_Reset</Name>
    <DisplayLabel>Reset</DisplayLabel>
    <Left>2</Left>
    <Right>23</Right>
    <Condition>return ConnectionInfo.CustomActionID == "Reset"</Condition>
    <Variables />
    <Break>false</Break>
    <Order>1</Order>
    <Description />
    <WatchVariables />
    <EditorSize>671:460</EditorSize>
  </vScriptConnector>
  <vScriptConnector>
    <cID>23</cID>
    <ConnectorID />
    <Name>Reset_Done</Name>
    <DisplayLabel />
    <Left>23</Left>
    <Right>4</Right>
    <Condition>return True</Condition>
    <Variables />
    <Break>false</Break>
    <Order>1</Order>
    <Description />
    <WatchVariables />
    <EditorSize>671:460</EditorSize>
  </vScriptConnector>
  <Parameters>
    <ScriptName>Cisco_ASA</ScriptName>
    <GlobalCode>###################################
#                                 #
# Declare global variables here   #
#                                 #
###################################
scriptVersion = "v2.0"
VersionInfo = ""
HostName = ""
# This will be the NeighborRegistry object passed in Initialize
Registry = None</GlobalCode>
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
    <EditorScaleFactor>0.8680001</EditorScaleFactor>
    <Description>This vScript template can be used as a starting point for creating a 
new Router  module for Network Map. This is required to add support
for a new vendor. 
You will also need to add routing protocol Parser Module to fully support 
network discovery fo that vendor.</Description>
    <EditorSize>{Width=941, Height=772}</EditorSize>
  </Parameters>
</vScriptDS>