<?xml version="1.0" standalone="yes"?>
<vScriptDS xmlns="http://tempuri.org/vScriptDS.xsd">
  <vScriptCommands>
    <vsID>0</vsID>
    <CommandID>4672714a-bc08-4ec5-bea1-b8dd32b624b3</CommandID>
    <Name>Start</Name>
    <DisplayLabel>Start</DisplayLabel>
    <Commands />
    <MainCode />
    <Origin_X>24</Origin_X>
    <Origin_Y>291</Origin_Y>
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
    <Origin_X>359</Origin_X>
    <Origin_Y>42</Origin_Y>
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
    <Origin_X>206</Origin_X>
    <Origin_Y>284</Origin_Y>
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
    <Origin_X>483</Origin_X>
    <Origin_Y>227</Origin_Y>
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
nRegistry = ConnectionInfo.aParam
# A CancellationToken is received in ConnectionInfo.bParam
cToken = ConnectionInfo.bParam

OperationStatusLabel = "Querying OSPF neighbors..."  
TextToParse = Session.ExecCommand("show routing protocol ospf neighbor")
#--
OperationStatusLabel = "Processing OSPF data..."
cToken.ThrowIfCancellationRequested()

# loop variables
blockSeparator = "======"
neighborRouterID = ""
neighborState = ""
remoteNeighboringIP = ""
areaID = ""
description = ""
lineNum = 0

# iterate through lines
ospf_lines = [str.lower(thisLine.strip()) for thisLine in TextToParse.splitlines()]
for line in ospf_lines:
  lineNum += 1
  #--
  cToken.ThrowIfCancellationRequested()
  #--
  try:
    words = filter(None, line.split(":"))
    if lineNum == len(ospf_lines) or blockSeparator in words[0]:
      # this is a new block
      if neighborRouterID != "":
        # register actual neighbor
        # try to figure out the outgoing interface for this adjacency
        OperationStatusLabel = "Finding outgoing interface for {0}...".format(remoteNeighboringIP)
        response = Session.ExecCommand("show arp all | match {0}".format(remoteNeighboringIP))
        if response != "":
          rWords = filter(None, response.split(" "))
          outInterfaceName = rWords[0]     
          # find the RouterInterface by name   
          ri = Router.GetInterfaceByName(outInterfaceName)   
          if ri != None:
            # add the areaID
            ri.OSPFArea = areaID
            OperationStatusLabel = "Registering OSPF neighbor {0}...".format(neighborRouterID)
            nRegistry.RegisterNeighbor(Router, L3Discovery.NeighborProtocol.OSPF, neighborRouterID, "", description, remoteNeighboringIP, ri, neighborState)   
          else:
            msg = "PAloAlto.OSPFarser : cannot find RouterInterface for interface name : {0}".format(outInterfaceName)
            System.Diagnostics.DebugEx.WriteLine(msg) 
        else:
          msg = "PAloAlto.OSPFarser : cannot find outgoing interface for OSPF neighbor : {0}".format(remoteNeighboringIP)
          System.Diagnostics.DebugEx.WriteLine(msg) 
       
        # clear loop variables  
        blockSeparator = "======"
        neighborRouterID = ""
        neighborState = ""
        remoteNeighboringIP = ""
        areaID = ""
        description = "";    
    else:
      # populate loop variables
      if len(words) &gt;= 2:
        if words[0] == "neighbor address" : remoteNeighboringIP = words[1].strip()
        if words[0] == "neighbor router id" : neighborRouterID = words[1].strip()
        if words[0] == "status" : neighborState = words[1].strip()
        if words[0] == "area id" : areaID = words[1].strip()

        
  except Exception as Ex:
    msg = "OSPFarser : Error while parsing ospf output line [{0}]. Error is : {1}".format(line, str(Ex))
    System.Diagnostics.DebugEx.WriteLine(msg) 
#</MainCode>
    <Origin_X>489</Origin_X>
    <Origin_Y>303</Origin_Y>
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
    <Description>Parse is responsible for implementing the logicrequired  to parse a Routing Protocol state
and register the neighbors found by the routing protocol for discovery.</Description>
    <WatchVariables />
    <Initializer />
    <EditorSize>{Width=702, Height=794}|{X=313,Y=203}</EditorSize>
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
    <Origin_X>401</Origin_X>
    <Origin_Y>509</Origin_Y>
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
    <Origin_X>458</Origin_X>
    <Origin_Y>156</Origin_Y>
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
    <FullTypeName>PGT.VisualScripts.vScriptStop</FullTypeName>
  </vScriptCommands>
  <vScriptCommands>
    <vsID>7</vsID>
    <CommandID>261dd3fe-ee65-486e-9d1a-151316c9c97d</CommandID>
    <Name>Return_OSPFAreas</Name>
    <DisplayLabel>OSPF Areas</DisplayLabel>
    <Commands />
    <MainCode>global ActionResult

ActionResult = OSPFProcessor.GetAreas()
</MainCode>
    <Origin_X>502</Origin_X>
    <Origin_Y>378</Origin_Y>
    <Size_Width>125</Size_Width>
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
    <Description>Should return the OSPF Areas the current router is member of</Description>
    <WatchVariables />
    <Initializer />
    <FullTypeName>PGT.VisualScripts.vScriptStop</FullTypeName>
  </vScriptCommands>
  <vScriptCommands>
    <vsID>8</vsID>
    <CommandID>d59d6d5c-8a80-41c7-be6e-99383e0b169b</CommandID>
    <Name>Return_OSPFLSATypes</Name>
    <DisplayLabel>Return OSPF LSA types</DisplayLabel>
    <Commands />
    <MainCode>global ActionResult

# the OSPF Area ID to be queried is received in ConnectionInfo.aParam
ospfArea = ConnectionInfo.aParam

ActionResult = OSPFProcessor.GetLSATypeNames(ospfArea)</MainCode>
    <Origin_X>452</Origin_X>
    <Origin_Y>449</Origin_Y>
    <Size_Width>164</Size_Width>
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
    <Description>Should returns the list of existing LSA Types for the requested OSPF Area</Description>
    <WatchVariables />
    <Initializer />
    <FullTypeName>PGT.VisualScripts.vScriptStop</FullTypeName>
  </vScriptCommands>
  <vScriptCommands>
    <vsID>9</vsID>
    <CommandID>701a9e3a-f8e6-4fba-8f4a-dce0e57c1b01</CommandID>
    <Name>Return_OSPFLSA</Name>
    <DisplayLabel>Return Requested LSAs</DisplayLabel>
    <Commands />
    <MainCode>global ActionResult

# the OSPF Area ID to be queried is received in ConnectionInfo.aParam
ospfArea = ConnectionInfo.aParam
# the requested LSA Type Name is received in ConnectionInfo.bParam
LSAType = ConnectionInfo.bParam
# return the LSAs
ActionResult = OSPFProcessor.GetAreaLSAs(ospfArea, LSAType)</MainCode>
    <Origin_X>346</Origin_X>
    <Origin_Y>555</Origin_Y>
    <Size_Width>164</Size_Width>
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
    <Description>Should return the list of OSPF LSAs of the requested type
for the requested Area ID</Description>
    <WatchVariables />
    <Initializer />
    <FullTypeName>PGT.VisualScripts.vScriptStop</FullTypeName>
  </vScriptCommands>
  <vScriptCommands>
    <vsID>10</vsID>
    <CommandID>48189624-9c1e-426c-a8ea-2308304f15fc</CommandID>
    <Name>OSPFProcessor</Name>
    <DisplayLabel>Process OSPF Database</DisplayLabel>
    <Commands />
    <MainCode>global ActionResult
global ConnectionDropped
global ScriptSuccess
global ConnectionInfo
global BreakExecution
global ScriptExecutor
global Session</MainCode>
    <Origin_X>45</Origin_X>
    <Origin_Y>647</Origin_Y>
    <Size_Width>166</Size_Width>
    <Size_Height>50</Size_Height>
    <isStart>false</isStart>
    <isStop>false</isStop>
    <isSimpleCommand>false</isSimpleCommand>
    <isSimpleDecision>false</isSimpleDecision>
    <Variables># OSPFAreaLSAs contains OSPFLSA dictionaries entries keyed by AREA IDs. The internal dictinary is then keyed by LSAType - like Router, or Network.
OSPFAreaLSAs = {}
# example content :
# LSAs = [item1, item2]
# OSPFLSAs = {"Router" : [OSPFLSA1, OSPFLSA2], "Network" : [OSPFLSA1, OSPFLSA2]}
# OSPFAreaLSAs = {"0.0.0.0" : {"Router" : [OSPFLSA1, OSPFLSA2], "Network" : [OSPFLSA1, OSPFLSA2]}, "10.0.0.0" : {"Router" : [OSPFLSA1, OSPFLSA2], "Network" : [OSPFLSA1, OSPFLSA2]}}</Variables>
    <Break>false</Break>
    <ExecPolicy>After</ExecPolicy>
    <CustomCodeBlock>"""Query and Process the OSPF Database"""
def ProcessDatabase(self): 
  #
  # Override this 
  #
  # Execute necessary commands on the device to get the OSPF database and process it
  # to popolate self.OSPFAreaLSAs dictionary
  #
  #
  pass  
  
    
"""Return the list of LSAs for the requested Type and Area """  
def GetAreaLSAs(self, ospfArea, lsaTypeName):
  # if OSPF datbase was not yet processed, do it now. It will populate self.OSPFAreaLSAs
  if len(self.OSPFAreaLSAs) == 0 : self.ProcessDatabase()
  # get All LSAs for the requested Area
  AreaLSAs = self.OSPFAreaLSAs.get(ospfArea)
  RequestedAreaLSAs = []
  # get the LSA list for the requested LSA type
  if AreaLSAs != None : RequestedAreaLSAs = AreaLSAs.get(lsaTypeName)
  return RequestedAreaLSAs
  
  

"""Return all of the LSA Type Names for the specified Area """
def GetLSATypeNames(self, ospfArea):
  # if OSPF datbase was not yet processed, do it now. It will populate self.OSPFAreaLSAs
  if len(self.OSPFAreaLSAs) == 0 : self.ProcessDatabase()  
  # get All LSAs for the requested Area
  AreaLSAs = self.OSPFAreaLSAs.get(ospfArea)
  LSATypeNames = []
  if AreaLSAs != None : LSATypeNames = AreaLSAs.keys()
  return LSATypeNames
  
  

"""Return all the Areas the router belongs to """  
def GetAreas(self):
  # if OSPF datbase was not yet processed, do it now. It will populate self.OSPFAreaLSAs
  if len(self.OSPFAreaLSAs) == 0 : self.ProcessDatabase()
  Areas = self.OSPFAreaLSAs.keys()
  return Areas
  

  
def Reset(self):
  # old code self.OSPFAreaRouterID = {}
  self.OSPFAreaLSAs = {}</CustomCodeBlock>
    <DemoMode>false</DemoMode>
    <Description>Process OSPF Database in order to collect Area IDs and different LSAs</Description>
    <WatchVariables />
    <Initializer />
    <FullTypeName>PGT.VisualScripts.vScriptGeneralObject</FullTypeName>
  </vScriptCommands>
  <vScriptCommands>
    <vsID>11</vsID>
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
OSPFProcessor.Reset()
ActionResult = None
Router = None</MainCode>
    <Origin_X>437</Origin_X>
    <Origin_Y>93</Origin_Y>
    <Size_Width>128</Size_Width>
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
    <Name>SwitchTask_Return_OSPFLSA</Name>
    <DisplayLabel>GetOSPFLSAs</DisplayLabel>
    <Left>2</Left>
    <Right>9</Right>
    <Condition>return ConnectionInfo.Command == "GetOSPFLSAs"</Condition>
    <Variables />
    <Break>false</Break>
    <Order>5</Order>
    <Description />
    <WatchVariables />
  </vScriptConnector>
  <vScriptConnector>
    <cID>7</cID>
    <ConnectorID />
    <Name>SwitchTask_Return_OSPFLSATypes</Name>
    <DisplayLabel>GetOSPFLSATypes</DisplayLabel>
    <Left>2</Left>
    <Right>8</Right>
    <Condition>return ConnectionInfo.Command == "GetOSPFLSATypes"</Condition>
    <Variables />
    <Break>false</Break>
    <Order>6</Order>
    <Description />
    <WatchVariables />
  </vScriptConnector>
  <vScriptConnector>
    <cID>8</cID>
    <ConnectorID />
    <Name>SwitchTask_Return_OSPFAreas</Name>
    <DisplayLabel>GetOSPFAreas</DisplayLabel>
    <Left>2</Left>
    <Right>7</Right>
    <Condition>return ConnectionInfo.Command == "GetOSPFAreas"</Condition>
    <Variables />
    <Break>false</Break>
    <Order>7</Order>
    <Description />
    <WatchVariables />
  </vScriptConnector>
  <vScriptConnector>
    <cID>9</cID>
    <ConnectorID />
    <Name>SwitchTask_Reset</Name>
    <DisplayLabel>Reset</DisplayLabel>
    <Left>2</Left>
    <Right>11</Right>
    <Condition>return ConnectionInfo.Command == "Reset"</Condition>
    <Variables />
    <Break>false</Break>
    <Order>2</Order>
    <Description />
    <WatchVariables />
  </vScriptConnector>
  <Parameters>
    <ScriptName>PaloAlto_OSPF_Parser</ScriptName>
    <GlobalCode>ScriptVersion = "2.0"
# Describe the Module Name
ModuleName = "PaloAlto OSPF Protocol Parser Support Module - Python vScript Parser"
# Describes current operation status. The name of this variable is fixed !
# PGT will search specifically for "OperationStatusLabel"
OperationStatusLabel = "Working"
# The Router instance associated to this parser. Set in Initialize
Router = None
#This is the protocol supported by this module
ParsingForProtocols = [L3Discovery.NeighborProtocol.OSPF]
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
    <EditorSize>{Width=710, Height=681}</EditorSize>
    <PropertiesEditorSize>{Width=665, Height=460}|{X=627,Y=350}</PropertiesEditorSize>
  </Parameters>
</vScriptDS>