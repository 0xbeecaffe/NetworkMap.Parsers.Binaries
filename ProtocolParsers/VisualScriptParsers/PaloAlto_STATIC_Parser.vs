<?xml version="1.0" standalone="yes"?>
<vScriptDS xmlns="http://tempuri.org/vScriptDS.xsd">
  <vScriptCommands>
    <vsID>0</vsID>
    <CommandID>4672714a-bc08-4ec5-bea1-b8dd32b624b3</CommandID>
    <Name>Start</Name>
    <DisplayLabel>Start</DisplayLabel>
    <Commands />
    <MainCode />
    <Origin_X>45</Origin_X>
    <Origin_Y>254</Origin_Y>
    <Size_Width>146</Size_Width>
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
    <Origin_X>393</Origin_X>
    <Origin_Y>71</Origin_Y>
    <Size_Width>146</Size_Width>
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
    <Description>Initialize must decide whether this module can handle protocol parsing 
for the specified protocol using the given Router instance.</Description>
    <WatchVariables />
    <Initializer />
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
    <Origin_X>268</Origin_X>
    <Origin_Y>254</Origin_Y>
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
    <Origin_X>486</Origin_X>
    <Origin_Y>216</Origin_Y>
    <Size_Width>146</Size_Width>
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
    <Description>SupportTag should return a descriptive text for this Protocol Parser Module</Description>
    <WatchVariables />
    <Initializer />
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
from System.Net import IPAddress

# The neighbor registry object is received in ConnectionInfo.aParam
nRegistry = ConnectionInfo.aParam
# A CancellationToken is received in ConnectionInfo.bParam
cToken = ConnectionInfo.bParam

OperationStatusLabel = "Querying STATIC routes..."  
response = Session.ExecCommand("show routing route type static")
#--
OperationStatusLabel = "Processing routes..."
cToken.ThrowIfCancellationRequested()

routeBlock = False
currentHeaderFields = []
currentHeaderLine = ""
static_lines = [str.lower(thisLine.strip()) for thisLine in response.splitlines()]
for thisLine in static_lines:
  try:
    # a line with the first word of "destination " signals the routing block, and gives us the header
    if thisLine.startswith("destination "):
      currentHeaderLine = thisLine
      currentHeaderFields = filter(None, currentHeaderLine.split(" "))
      routeBlock = True
      continue

    # a line with the first word of "total" signals the end of the routing block, so skip the rest
    if thisLine.startswith("total"):
      routeBlock = False
      break      
      
    if routeBlock:
      words = filter(None, thisLine.split(" "))
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
            # the length of currentHeaderFields can guide us if we are parsing the correct information
            # expected header : destination nexthop metric flags age interface next-AS 
            # hesader length should be 7
            if len(currentHeaderFields) == 7:
              # -- routeForNetwork is the prefix for this static route entry (destination)
              routeForNetwork = firstWord
              # -- parse nextHop --
              s = currentHeaderLine.index("nexthop")
              e = currentHeaderLine.index("metric")
              nextHop = thisLine[s:e].strip()
              # -- parse outInterface --
              s = currentHeaderLine.index("interface")
              e = currentHeaderLine.index("next-as")
              outInterfaceName = thisLine[s:e].strip()    
              # --          
              OperationStatusLabel = "Querying interface {0}...".format(outInterfaceName)
              ri = Router.GetInterfaceByName(outInterfaceName)
              if ri != None:
                OperationStatusLabel = "Registering static neighbor {0}...".format(ri.Address)
                nRegistry.RegisterSTATICNeighbor(Router, routeForNetwork, nextHop, ri.Address, ri);
                  
          except Exception as Ex:
            message = "PaloAlto STATIC route parser error : could not parse route table line &lt; {0} &gt;. Error is : {1} ".format(thisLine, str(Ex))
            System.Diagnostics.DebugEx.WriteLine(message)        
      
      
  except Exception as Ex:
    msg = "PaloAlto STATIC route parser error : could not process line &lt; {0} &gt;. Error is : {1}".format(thisLine, str(Ex))  
    System.Diagnostics.DebugEx.WriteLine(msg) 

#
# No need to return anything via ActionResult
#</MainCode>
    <Origin_X>484</Origin_X>
    <Origin_Y>299</Origin_Y>
    <Size_Width>146</Size_Width>
    <Size_Height>43</Size_Height>
    <isStart>false</isStart>
    <isStop>false</isStop>
    <isSimpleCommand>false</isSimpleCommand>
    <isSimpleDecision>false</isSimpleDecision>
    <Variables />
    <Break>true</Break>
    <ExecPolicy>After</ExecPolicy>
    <CustomCodeBlock />
    <DemoMode>false</DemoMode>
    <Description>Parse is responsible for implementing the logicrequired  to parse a Routing Protocol state
and register the neighbors found by the routing protocol for discovery.</Description>
    <WatchVariables />
    <Initializer />
    <EditorSize>{Width=772, Height=617}|{X=52,Y=52}</EditorSize>
    <FullTypeName>PGT.VisualScripts.vScriptStop</FullTypeName>
  </vScriptCommands>
  <vScriptCommands>
    <vsID>5</vsID>
    <CommandID>a236adee-1d6f-4c2a-8e90-c9fd13489289</CommandID>
    <Name>UnknownTask</Name>
    <DisplayLabel>Unknown task</DisplayLabel>
    <Commands />
    <MainCode>global ActionResult
global ModuleName

ActionResult = None
raise ValueError("{0} has received an unhandled Command request : {1}".format(ModuleName, ConnectionInfo.Command))</MainCode>
    <Origin_X>389</Origin_X>
    <Origin_Y>448</Origin_Y>
    <Size_Width>146</Size_Width>
    <Size_Height>43</Size_Height>
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
    <Origin_X>453</Origin_X>
    <Origin_Y>135</Origin_Y>
    <Size_Width>146</Size_Width>
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
    <Description>Supported Protocols must return the list of routing protocols 
this module can support</Description>
    <WatchVariables />
    <Initializer />
    <FullTypeName>PGT.VisualScripts.vScriptStop</FullTypeName>
  </vScriptCommands>
  <vScriptCommands>
    <vsID>7</vsID>
    <CommandID>b5741130-1379-4d0d-9c5d-cb54707476ff</CommandID>
    <Name>Reset</Name>
    <DisplayLabel>Reset</DisplayLabel>
    <Commands />
    <MainCode>global ActionResult
global ConnectionDropped
global ScriptSuccess
global ConnectionInfo
global BreakExecution
global OperationStatusLabel
global Router

OperationStatusLabel = "Working"
ActionResult = None
Router = None</MainCode>
    <Origin_X>456</Origin_X>
    <Origin_Y>388</Origin_Y>
    <Size_Width>146</Size_Width>
    <Size_Height>39</Size_Height>
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
    <Order>0</Order>
    <Description />
    <WatchVariables />
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
    <Order>1</Order>
    <Description />
    <WatchVariables />
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
    <Order>2</Order>
    <Description />
    <WatchVariables />
  </vScriptConnector>
  <Parameters>
    <ScriptName>PaloAlto_STATIC_Parser</ScriptName>
    <GlobalCode>ScriptVersion = "2.0"
# Describe the Module Name
ModuleName = "PaloAlto STATIC Protocol Parser Support Module - Python vScript Parser"
# Describes current operation status. The name of this variable is fixed !
# PGT will search specifically for "OperationStatusLabel"
OperationStatusLabel = "Working"
# The Router instance associated to this parser. Set in Initialize
Router = None
#This is the protocol supported by this module
ParsingForProtocols = [L3Discovery.NeighborProtocol.STATIC]
#This is the vendor name supported by this module
ParsingForVendor = "PaloAlto"</GlobalCode>
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
    <EditorScaleFactor>0.7959995</EditorScaleFactor>
    <Description>This vScript template can be used as a starting point for
creating a new routing protocol Parser Module for Network Map.
This is required to add support for a new routing protocol to a
vendor already supported. See also Router Module template.</Description>
    <EditorSize>{Width=629, Height=540}</EditorSize>
    <PropertiesEditorSize>{Width=665, Height=460}|{X=627,Y=350}</PropertiesEditorSize>
  </Parameters>
</vScriptDS>