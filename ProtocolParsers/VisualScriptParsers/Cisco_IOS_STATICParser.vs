<?xml version="1.0" standalone="yes"?>
<vScriptDS xmlns="http://tempuri.org/vScriptDS.xsd">
  <vScriptCommands>
    <vsID>0</vsID>
    <CommandID>4672714a-bc08-4ec5-bea1-b8dd32b624b3</CommandID>
    <Name>Start</Name>
    <DisplayLabel>Start</DisplayLabel>
    <Commands />
    <MainCode />
    <Origin_X>438</Origin_X>
    <Origin_Y>12</Origin_Y>
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
    <CommandID>a2f5f866-94c0-46a6-83ca-69e281ddc2e6</CommandID>
    <Name>Initialize</Name>
    <DisplayLabel>Initialize</DisplayLabel>
    <Commands />
    <MainCode>##############################################################################
#                                                                            #
# Initialize must decide whether this module can handle protocol parsing     #
# for the specified protocol using the given Router instance                 #
#                                                                            #
##############################################################################
global ActionResult
global Router
global ParsingForProtocols
global ParsingForVendor
global OperationStatusLabel
OperationStatusLabel = "Initializing..."

# Router object is passed in ConnectionInfo.aParam
Router = ConnectionInfo.aParam
# Set ActionResult to a boolean value to indicate if this parser can handle the request
if Router != None:
  # Requested protocol type is passed in ConnectionInfo.bParam
  if ConnectionInfo.bParam in ParsingForProtocols:
    ActionResult = Router.Vendor == ParsingForVendor
  else:
    ActionResult = False
else:
  ActionResult = False</MainCode>
    <Origin_X>624</Origin_X>
    <Origin_Y>91</Origin_Y>
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
    <Description>Initialize must decide whether this module can handle protocol parsing 
for the specified protocol using the given Router instance.</Description>
    <WatchVariables />
    <Initializer />
    <EditorSize>753:728</EditorSize>
    <FullTypeName>PGT.VisualScripts.vScriptStop</FullTypeName>
  </vScriptCommands>
  <vScriptCommands>
    <vsID>2</vsID>
    <CommandID>3de92841-b2aa-442d-af76-37a67e498361</CommandID>
    <Name>SwitchTask</Name>
    <DisplayLabel>Switch task</DisplayLabel>
    <Commands />
    <MainCode>###########################################################
#                                                         #
# This is a central point to decide which call to perform #
# Connectors will be evaluated one by one in order.       #
#                                                         #
###########################################################
pass</MainCode>
    <Origin_X>437</Origin_X>
    <Origin_Y>222</Origin_Y>
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
    <Description />
    <WatchVariables />
    <Initializer />
    <EditorSize>717:547</EditorSize>
    <FullTypeName>PGT.VisualScripts.vScriptCommand</FullTypeName>
  </vScriptCommands>
  <vScriptCommands>
    <vsID>3</vsID>
    <CommandID>0e1b7c85-f97c-4a7d-9262-13149567605e</CommandID>
    <Name>ReturnSupportTag</Name>
    <DisplayLabel>Support Tag</DisplayLabel>
    <Commands />
    <MainCode>#######################################################################################
#                                                                                     #
# This call should return a descriptive text for this Protocol Parser software module #
#                                                                                     #
#######################################################################################
global ScriptVersion
global ActionResult
global ModuleName

ActionResult =  ModuleName + " v" + ScriptVersion</MainCode>
    <Origin_X>653</Origin_X>
    <Origin_Y>285</Origin_Y>
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
    <Description>SupportTag should return a descriptive text for this Protocol Parser Module</Description>
    <WatchVariables />
    <Initializer />
    <EditorSize>866:576</EditorSize>
    <FullTypeName>PGT.VisualScripts.vScriptStop</FullTypeName>
  </vScriptCommands>
  <vScriptCommands>
    <vsID>4</vsID>
    <CommandID>a9279407-046b-4e50-b4e6-fcd0c543379a</CommandID>
    <Name>ParseProtocol</Name>
    <DisplayLabel>Parse</DisplayLabel>
    <Commands />
    <MainCode>
##############################################################################
#                                                                            #
# This call should implement logic to parse a Routing Protocol state         #
# and register the neighbors found by the routing protocol for discovery.    #
#                                                                            #
##############################################################################
global Router
global OperationStatusLabel

# The neighbor registry object is received in ConnectionInfo.aParam
# This must be used to register a new neighbor for further discovery.
nRegistry = ConnectionInfo.aParam
# A CancellationToken is received in ConnectionInfo.bParam
# The token should be checked repetitively whether cancellation was requested 
# by user and if yes, stop further processing.
cToken = ConnectionInfo.bParam

OperationStatusLabel = "Identifying router..."
#--  
TextToParse = Session.ExecCommand("show ip route static")
cToken.ThrowIfCancellationRequested()

OperationStatusLabel = "Processing STATIC routes..."
static_lines = [str.lower(thisLine.strip()) for thisLine in TextToParse.splitlines()]
for line in static_lines:
  cToken.ThrowIfCancellationRequested()
  if line.startswith("s ") or line.startswith("s* "): 
    # expect two ip addresses in line, first is neighbor RID, second is neighbor IP
    foundNetwork = re.findall(r"\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b\/\d{1,2}", line)
    foundNexthop = re.findall(r"(?&lt;=via )[\d\.]{0,99}", line)
    if len(foundNetwork) == 1 and len(foundNexthop) == 1 :
      routeForNetwork = foundNetwork[0]
      nexthop = foundNexthop[0]
      # get the outgoing interface
      OperationStatusLabel = "Finding egress interface for {0}...".format(nexthop)
      cefEntry = Session.ExecCommand("show ip cef {0} | i via".format(nexthop))
      # Exaple output 1 : via 172.18.145.82, FastEthernet0/0, 0 dependencies
      # Exaple output 2 : via FastEthernet0/0, 0 dependencies
      cefwords = filter(None, cefEntry.split())
      outInterfaceName = ""
      ri = None
      if len(cefwords) &gt;= 4 :
        outInterfaceName = cefwords[len(cefwords) - 3]
        outInterfaceName = outInterfaceName.strip(",")
        OperationStatusLabel = "Querying interface {0}...".format(outInterfaceName)
        ri = Router.GetInterfaceByName(outInterfaceName)
        if ri != None:
          OperationStatusLabel = "Registering static neighbor {0}...".format(ri.Address)
          nRegistry.RegisterSTATICNeighbor(Router, routeForNetwork, nexthop, ri.Address, ri);
#
# No need to return anything via ActionResult
#</MainCode>
    <Origin_X>160</Origin_X>
    <Origin_Y>278</Origin_Y>
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
    <Description>Parse is responsible for implementing the logicrequired  to parse a Routing Protocol state
and register the neighbors found by the routing protocol for discovery.</Description>
    <WatchVariables />
    <Initializer />
    <EditorSize>1932:975</EditorSize>
    <FullTypeName>PGT.VisualScripts.vScriptStop</FullTypeName>
  </vScriptCommands>
  <vScriptCommands>
    <vsID>5</vsID>
    <CommandID>a236adee-1d6f-4c2a-8e90-c9fd13489289</CommandID>
    <Name>UnknownTask</Name>
    <DisplayLabel>Unknown task - ERROR</DisplayLabel>
    <Commands />
    <MainCode>global ActionResult
global ModuleName

ActionResult = None
raise ValueError("{0} has received an unhandled Command request : {1}".format(ModuleName, ConnectionInfo.Command))</MainCode>
    <Origin_X>189</Origin_X>
    <Origin_Y>92</Origin_Y>
    <Size_Width>172</Size_Width>
    <Size_Height>40</Size_Height>
    <isStart>false</isStart>
    <isStop>false</isStop>
    <isSimpleCommand>false</isSimpleCommand>
    <isSimpleDecision>false</isSimpleDecision>
    <Variables />
    <Break>true</Break>
    <ExecPolicy>After</ExecPolicy>
    <CustomCodeBlock />
    <DemoMode>false</DemoMode>
    <Description />
    <WatchVariables />
    <Initializer />
    <EditorSize>1059:530</EditorSize>
    <FullTypeName>PGT.VisualScripts.vScriptStop</FullTypeName>
  </vScriptCommands>
  <vScriptCommands>
    <vsID>6</vsID>
    <CommandID>36370047-eab4-446b-9797-7455b5926e84</CommandID>
    <Name>ReturnProtocols</Name>
    <DisplayLabel>Supported Protocols</DisplayLabel>
    <Commands />
    <MainCode>###############################################################################
#                                                                             #
# This call must return the list of routing protocols this module can support #
#                                                                             #
###############################################################################

global ParsingForProtocols
global ActionResult

ActionResult = ParsingForProtocols</MainCode>
    <Origin_X>304</Origin_X>
    <Origin_Y>448</Origin_Y>
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
    <Description>Supported Protocols must return the list of routing protocols 
this module can support</Description>
    <WatchVariables />
    <Initializer />
    <EditorSize>873:514</EditorSize>
    <FullTypeName>PGT.VisualScripts.vScriptStop</FullTypeName>
  </vScriptCommands>
  <vScriptCommands>
    <vsID>7</vsID>
    <CommandID>6b6e4f5b-aab8-463e-a92e-dfb7e99d0242</CommandID>
    <Name>Reset</Name>
    <DisplayLabel>Reset</DisplayLabel>
    <Commands />
    <MainCode>global ActionResult
global ConnectionDropped
global ScriptSuccess
global ConnectionInfo
global BreakExecution</MainCode>
    <Origin_X>610</Origin_X>
    <Origin_Y>430</Origin_Y>
    <Size_Width>155</Size_Width>
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
    <EditorSize>568:460</EditorSize>
    <FullTypeName>PGT.VisualScripts.vScriptStop</FullTypeName>
  </vScriptCommands>
  <vScriptConnector>
    <cID>0</cID>
    <ConnectorID />
    <Name>Start_Copy_of_SwitchTask</Name>
    <DisplayLabel />
    <Left>0</Left>
    <Right>2</Right>
    <Condition>return True</Condition>
    <Variables />
    <Break>false</Break>
    <Order>0</Order>
    <Description />
    <WatchVariables />
    <EditorSize>0:0</EditorSize>
  </vScriptConnector>
  <vScriptConnector>
    <cID>1</cID>
    <ConnectorID />
    <Name>SwitchTask_ReturnSupportTag</Name>
    <DisplayLabel>GetSupportTag</DisplayLabel>
    <Left>2</Left>
    <Right>3</Right>
    <Condition>return ConnectionInfo.Command == "GetSupportTag"</Condition>
    <Variables />
    <Break>false</Break>
    <Order>1</Order>
    <Description />
    <WatchVariables />
    <EditorSize>671:460</EditorSize>
  </vScriptConnector>
  <vScriptConnector>
    <cID>2</cID>
    <ConnectorID />
    <Name>SwitchTask_Initialize</Name>
    <DisplayLabel>Initialize</DisplayLabel>
    <Left>2</Left>
    <Right>1</Right>
    <Condition>return ConnectionInfo.Command == "Initialize"</Condition>
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
    <Name>SwitchTask_ParseProtocol</Name>
    <DisplayLabel>Parse</DisplayLabel>
    <Left>2</Left>
    <Right>4</Right>
    <Condition>return ConnectionInfo.Command == "Parse"</Condition>
    <Variables />
    <Break>false</Break>
    <Order>3</Order>
    <Description />
    <WatchVariables />
    <EditorSize>671:460</EditorSize>
  </vScriptConnector>
  <vScriptConnector>
    <cID>4</cID>
    <ConnectorID />
    <Name>SwitchTask_ReturnProtocols</Name>
    <DisplayLabel>GetSupportedProtocols</DisplayLabel>
    <Left>2</Left>
    <Right>6</Right>
    <Condition>return ConnectionInfo.Command == "GetSupportedProtocols"</Condition>
    <Variables />
    <Break>false</Break>
    <Order>4</Order>
    <Description />
    <WatchVariables />
    <EditorSize>671:460</EditorSize>
  </vScriptConnector>
  <vScriptConnector>
    <cID>5</cID>
    <ConnectorID />
    <Name>SwitchTask_UnknownTask</Name>
    <DisplayLabel>Unknown</DisplayLabel>
    <Left>2</Left>
    <Right>5</Right>
    <Condition>return True</Condition>
    <Variables />
    <Break>false</Break>
    <Order>8</Order>
    <Description />
    <WatchVariables />
    <EditorSize>671:460</EditorSize>
  </vScriptConnector>
  <vScriptConnector>
    <cID>6</cID>
    <ConnectorID />
    <Name>SwitchTask_Reset</Name>
    <DisplayLabel>Reset</DisplayLabel>
    <Left>2</Left>
    <Right>7</Right>
    <Condition>return ConnectionInfo.Command == "Reset"</Condition>
    <Variables />
    <Break>false</Break>
    <Order>6</Order>
    <Description />
    <WatchVariables />
    <EditorSize>671:460</EditorSize>
  </vScriptConnector>
  <Parameters>
    <ScriptName>CiscoIOS_STATICParser</ScriptName>
    <GlobalCode>ScriptVersion = "0.92"
# Describe the Module Name
ModuleName = "Cisco IOS STATIC Protocol Parser Module - Python vScript Parser"
# Describes current operation status
OperationStatusLabel = "Init"
# The Router instance associated to this parser. Set in Initialize
Router = None
#This is the protocol supported by this module
ParsingForProtocols = [L3Discovery.RoutingProtocol.STATIC]
#This is the vendor name supported by this module
ParsingForVendor = "Cisco"</GlobalCode>
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
    <DebuggingAllowed>true</DebuggingAllowed>
    <LogFileName />
    <WatchVariables />
    <Language>Python</Language>
    <IsTemplate>false</IsTemplate>
    <IsRepository>false</IsRepository>
    <EditorScaleFactor>0.8799996</EditorScaleFactor>
    <Description>This vScript template can be used as a starting point for
creating a new routing protocol Parser Module for Network Map.
This is required to add support for a new routing protocol to a
vendor already supported. See also Router Module template.</Description>
    <EditorSize>{Width=838, Height=612}</EditorSize>
  </Parameters>
</vScriptDS>