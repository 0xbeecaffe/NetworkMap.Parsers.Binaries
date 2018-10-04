<?xml version="1.0" standalone="yes"?>
<vScriptDS xmlns="http://tempuri.org/vScriptDS.xsd">
  <vScriptCommands>
    <vsID>0</vsID>
    <CommandID>fa445090-aac6-431f-803e-d1ecd2f474ae</CommandID>
    <Name>Start</Name>
    <DisplayLabel>Start</DisplayLabel>
    <Commands />
    <MainCode />
    <Origin_X>197</Origin_X>
    <Origin_Y>29</Origin_Y>
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
    <Description />
    <WatchVariables />
    <Initializer />
    <FullTypeName>PGT.VisualScripts.vScriptStart</FullTypeName>
  </vScriptCommands>
  <vScriptCommands>
    <vsID>1</vsID>
    <CommandID>a8bb888f-acba-4041-9c40-0d6a916bc136</CommandID>
    <Name>UnknownTask</Name>
    <DisplayLabel>Unknown task</DisplayLabel>
    <Commands />
    <MainCode>global ActionResult

ActionResult = None
raise ValueError("Junos Router received an unhandled Command request : {0}".format(ConnectionInfo.Command))</MainCode>
    <Origin_X>570</Origin_X>
    <Origin_Y>79</Origin_Y>
    <Size_Width>146</Size_Width>
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
    <vsID>2</vsID>
    <CommandID>ca7eb9ab-6c32-4203-b246-919d7e30497f</CommandID>
    <Name>SwitchTask</Name>
    <DisplayLabel>Switch task</DisplayLabel>
    <Commands />
    <MainCode />
    <Origin_X>440</Origin_X>
    <Origin_Y>353</Origin_Y>
    <Size_Width>100</Size_Width>
    <Size_Height>60</Size_Height>
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
    <CommandID>02a4f2cf-e075-4253-b497-b17b410522d3</CommandID>
    <Name>ReturnSupportTag</Name>
    <DisplayLabel>Support Tag</DisplayLabel>
    <Commands />
    <MainCode>global ActionResult

ActionResult = "Juniper, JunOS, Router Module for EX/QFX/MX/SRX- Python vScript Parser v{1}".format(Name, scriptVersion)</MainCode>
    <Origin_X>638</Origin_X>
    <Origin_Y>142</Origin_Y>
    <Size_Width>146</Size_Width>
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
    <vsID>4</vsID>
    <CommandID>6cf97c54-143f-44b3-9676-36be7032e63b</CommandID>
    <Name>ReturnInventory</Name>
    <DisplayLabel>Return Inventory</DisplayLabel>
    <Commands />
    <MainCode>global ActionResult
ActionResult = Inventory.GetInventory()</MainCode>
    <Origin_X>608</Origin_X>
    <Origin_Y>609</Origin_Y>
    <Size_Width>146</Size_Width>
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
    <vsID>5</vsID>
    <CommandID>843c946b-980d-456a-b9d8-61b59b14d2ac</CommandID>
    <Name>ReturnVersion</Name>
    <DisplayLabel>Version</DisplayLabel>
    <Commands />
    <MainCode>global ActionResult
ActionResult = Version.GetVersion()</MainCode>
    <Origin_X>737</Origin_X>
    <Origin_Y>481</Origin_Y>
    <Size_Width>146</Size_Width>
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
    <vsID>6</vsID>
    <CommandID>17c60dc8-aa02-445f-bb02-2b908fcd5e2b</CommandID>
    <Name>ReturnSerial</Name>
    <DisplayLabel>System Serial</DisplayLabel>
    <Commands />
    <MainCode>global ActionResult
ActionResult = SystemSerial.GetSystemSerial()</MainCode>
    <Origin_X>538</Origin_X>
    <Origin_Y>668</Origin_Y>
    <Size_Width>146</Size_Width>
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
    <vsID>7</vsID>
    <CommandID>463bb050-2f66-4617-b886-895d01ee2740</CommandID>
    <Name>Inventory</Name>
    <DisplayLabel>Inventory</DisplayLabel>
    <Commands />
    <MainCode />
    <Origin_X>27</Origin_X>
    <Origin_Y>781</Origin_Y>
    <Size_Width>149</Size_Width>
    <Size_Height>50</Size_Height>
    <isStart>false</isStart>
    <isStop>false</isStop>
    <isSimpleCommand>false</isSimpleCommand>
    <isSimpleDecision>false</isSimpleDecision>
    <Variables>DeviceInventory = None</Variables>
    <Break>false</Break>
    <ExecPolicy>After</ExecPolicy>
    <CustomCodeBlock>def GetInventory(self):
  if self.DeviceInventory == None : self.DeviceInventory = Session.ExecCommand("show chassis hardware")
  return self.DeviceInventory
  
def Reset(self):
  self.DeviceInventory = None</CustomCodeBlock>
    <DemoMode>false</DemoMode>
    <Description>Collects inventory information from connected device
if it has not yet been collected.</Description>
    <WatchVariables />
    <Initializer />
    <FullTypeName>PGT.VisualScripts.vScriptGeneralObject</FullTypeName>
  </vScriptCommands>
  <vScriptCommands>
    <vsID>8</vsID>
    <CommandID>daccfb47-51e5-4cd5-b1b8-bbeeadeda4bb</CommandID>
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
    <Origin_X>190</Origin_X>
    <Origin_Y>781</Origin_Y>
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
  if self.DeviceVersion == None : self.DeviceVersion = Session.ExecCommand("show version")
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
    <vsID>9</vsID>
    <CommandID>69cf4d2b-44e4-4cb9-826b-fc52e4351e36</CommandID>
    <Name>SystemSerial</Name>
    <DisplayLabel />
    <Commands />
    <MainCode>global ActionResult
global ConnectionDropped
global ScriptSuccess
global ConnectionInfo
global BreakExecution
global ScriptExecutor
global Session</MainCode>
    <Origin_X>356</Origin_X>
    <Origin_Y>781</Origin_Y>
    <Size_Width>146</Size_Width>
    <Size_Height>50</Size_Height>
    <isStart>false</isStart>
    <isStop>false</isStop>
    <isSimpleCommand>false</isSimpleCommand>
    <isSimpleDecision>false</isSimpleDecision>
    <Variables>SystemSerial = None
ModelNumber = None
ScriptSettings = None</Variables>
    <Break>false</Break>
    <ExecPolicy>After</ExecPolicy>
    <CustomCodeBlock>def Initialize(self):
  self.ScriptSettings = PGT.Common.SettingsManager.GetCurrentScriptSettings()
    
def GetSystemSerial(self):
  if (self.SystemSerial == None) : self.CalculateModelNumberAndSerial()
  return self.SystemSerial
  
def GetModelNumber(self):
  if self.ModelNumber == None : self.CalculateModelNumberAndSerial()
  return self.ModelNumber
  
def CalculateModelNumberAndSerial(self):
  ss = ""
  mn  = ""
  inv = Inventory.GetInventory()
  FPCs = re.findall(r"FPC \d.*", inv)
  for thisFPC in FPCs :
    words = filter(None, thisFPC.split(" "))
    ss += (";" + words[5])
    mn += (";" + words[6])
    
  self.SystemSerial = ss.strip(";")
  self.ModelNumber = mn.strip(";") 
  
def Reset(self):
  self.SystemSerial = None
  self.ModelNumber = None
  self.ScriptSettings = None
   
  
  </CustomCodeBlock>
    <DemoMode>false</DemoMode>
    <Description>Collects system information from connected device
if it has not yet been collected.</Description>
    <WatchVariables />
    <Initializer />
    <FullTypeName>PGT.VisualScripts.vScriptGeneralObject</FullTypeName>
  </vScriptCommands>
  <vScriptCommands>
    <vsID>10</vsID>
    <CommandID>0a008a33-b4ea-4606-a86a-6b4806b37469</CommandID>
    <Name>ReturnModelNumber</Name>
    <DisplayLabel>Model Number</DisplayLabel>
    <Commands />
    <MainCode>global ActionResult
ActionResult = SystemSerial.GetModelNumber()</MainCode>
    <Origin_X>762</Origin_X>
    <Origin_Y>410</Origin_Y>
    <Size_Width>146</Size_Width>
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
    <vsID>11</vsID>
    <CommandID>6c275d41-4db4-49f3-8e1f-354ac2d0c456</CommandID>
    <Name>ReturnStackCount</Name>
    <DisplayLabel>Stack Count</DisplayLabel>
    <Commands />
    <MainCode>global ActionResult
global _stackCount

if _stackCount == -1 :
  FPCs = re.findall(r"FPC \d.*", Inventory.GetInventory())
  _stackCount = len(FPCs)

ActionResult = _stackCount;</MainCode>
    <Origin_X>283</Origin_X>
    <Origin_Y>660</Origin_Y>
    <Size_Width>146</Size_Width>
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
    <WatchVariables>;self</WatchVariables>
    <Initializer />
    <FullTypeName>PGT.VisualScripts.vScriptStop</FullTypeName>
  </vScriptCommands>
  <vScriptCommands>
    <vsID>12</vsID>
    <CommandID>6dd1d716-8ad6-40b6-87a7-ea75cc145a18</CommandID>
    <Name>Return_RoutingTable</Name>
    <DisplayLabel>Routing Table</DisplayLabel>
    <Commands />
    <MainCode>global ActionResult

parsedRoutes = []
# query full route table
routes = Session.ExecCommand("show route")
# define regex expressions for logical text blocks
networkBlockFilter = re.compile(r"\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b\/\d{1,2}")
protocolBlockFilter = re.compile(r"[*[](.*?)\]")
# network blocks are the top level blocks of the text output, get the iterator for them
networkBlockIterator = tuple(networkBlockFilter.finditer(routes))
networkMatchcount = len(networkBlockIterator)
networkMatchIndex = 0
# iterate through the network blocks
for thisNetworkMatch in networkBlockIterator:
  try:
    # thisNetworkMatch is now a MatchObject
    thisNetwork = thisNetworkMatch.group(0)
    # a route block is the text of routes between the position of this match start and the next match start
    routeBlockStart = thisNetworkMatch.start()
    routeBlockEnd = -1
    if (networkMatchIndex == networkMatchcount - 1):
      routeBlockEnd = len(routes)
    else:
      routeBlockEnd = networkBlockIterator[networkMatchIndex + 1].start()
    
    thisRouteBlock = routes[routeBlockStart : routeBlockEnd]      
    # protocol blocks appear inside a network block, get the iterator for them
    protocolBlockIterator = tuple(protocolBlockFilter.finditer(thisRouteBlock))
    # process networks
    protocolMatchcount = len(protocolBlockIterator)
    protocolMatchIndex = 0
    # iterte through the protocol blocks
    for thisProtocolMatch in protocolBlockIterator:
      try:
        # thisProtocolMatch is now a MatchObject
        protocolBlockHeader = thisProtocolMatch.group(0)
        isBestRoute = "*[" in protocolBlockHeader
        protocolBlockStart = thisProtocolMatch.start()
        # a protocol block is the text portion in actual routeBlock between the position of this match start and the next match start
        protocolBlockStart = thisProtocolMatch.start()
        protocolBlockEnd = -1
        if (protocolMatchIndex == protocolMatchcount - 1):
          protocolBlockEnd = len(thisRouteBlock)
        else:
          protocolBlockEnd = protocolBlockIterator[protocolMatchIndex + 1].start()   
        
        thisProtocolBlock =  thisRouteBlock[protocolBlockStart : protocolBlockEnd]
        thisProtocolNames = re.findall(r"[a-zA-Z,-]+", protocolBlockHeader)
        nextHopAddresses = re.findall(r"(?&lt;=to )[\d\.]{0,99}", thisProtocolBlock)
        routeTags = re.findall(r"(?&lt;=tag )[\d\.]{0,99}", thisProtocolBlock)
        outInterfaces = re.findall(r"(?&lt;=via ).*", thisProtocolBlock)
        routePreference = re.findall(r"[0-9]+", protocolBlockHeader)
        
        matchIndex = 0
        for thisOutInterface in outInterfaces:
          rte = L3Discovery.RouteTableEntry()
          # Protocol
          if len(thisProtocolNames) == 1 : rte.Protocol = thisProtocolNames[0]
          else : rte.Protocol = "UNKNOWN"
          # RouterID
          rte.RouterID = RouterIDAndASNumber.GetRouterID(rte.Protocol)
          # Prefix and Mask length
          prefixAndMask = thisNetwork.split("/")
          rte.Prefix = prefixAndMask[0]
          rte.MaskLength = int(prefixAndMask[1])
          # OutInterface
          rte.OutInterface = thisOutInterface
          # NextHop address
          if len(nextHopAddresses) &gt; matchIndex : rte.NextHop = nextHopAddresses[matchIndex]
          else : rte.NextHop = ""
          # Prefix parameters
          rte.Best = isBestRoute
          if len(routeTags) == 1 : rte.Tag = routeTags[0]
          else : rte.Tag = ""
          if len(routePreference) == 1 : rte.AD = routePreference[0]
          else : rte.AD = ""
          rte.Metric = ""
          parsedRoutes.Add(rte)
          matchIndex += 1
               
        protocolMatchIndex += 1
      except Exception as Ex:
        message = "JunOS Router Module Error : could not parse a route table Protocol block because : " + str(Ex)
        System.Diagnostics.DebugEx.WriteLine(message)   
    
    networkMatchIndex += 1
  except Exception as Ex:
    message = "JunOS Router Module Error : could not parse a route table Network block because : " + str(Ex)
    System.Diagnostics.DebugEx.WriteLine(message)
  
ActionResult = parsedRoutes</MainCode>
    <Origin_X>62</Origin_X>
    <Origin_Y>334</Origin_Y>
    <Size_Width>146</Size_Width>
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
    <vsID>13</vsID>
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

ActionResult = GetInterfaces.GetAllInterfaces()
ScriptSuccess = True</MainCode>
    <Origin_X>60</Origin_X>
    <Origin_Y>410</Origin_Y>
    <Size_Width>146</Size_Width>
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
    <EditorSize>{Width=802, Height=572}|{X=78,Y=78}</EditorSize>
    <FullTypeName>PGT.VisualScripts.vScriptStop</FullTypeName>
  </vScriptCommands>
  <vScriptCommands>
    <vsID>14</vsID>
    <CommandID>a2abda9f-20ed-4889-8e64-ac82f8cb2ade</CommandID>
    <Name>Return_RouterID</Name>
    <DisplayLabel>RouterID</DisplayLabel>
    <Commands />
    <MainCode>global ActionResult

# The protocol for which to get the RouterID
protocol = ConnectionInfo.aParam
ActionResult = RouterIDAndASNumber.GetRouterID(protocol)</MainCode>
    <Origin_X>693</Origin_X>
    <Origin_Y>547</Origin_Y>
    <Size_Width>146</Size_Width>
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
    <EditorSize>{Width=904, Height=676}|{X=52,Y=52}</EditorSize>
    <FullTypeName>PGT.VisualScripts.vScriptStop</FullTypeName>
  </vScriptCommands>
  <vScriptCommands>
    <vsID>15</vsID>
    <CommandID>fa1c0cc6-5d9c-49c5-8671-fd7aa4948f63</CommandID>
    <Name>Return_ActiveRoutingProtocols</Name>
    <DisplayLabel>Active Protocols</DisplayLabel>
    <Commands />
    <MainCode>global ActionResult
global _runningRoutingProtocols

if len(_runningRoutingProtocols) == 0 :
  response = Session.ExecCommand("show ospf overview")
  if (not ("not running" in response)): 
    _runningRoutingProtocols.Add(L3Discovery.NeighborProtocol.OSPF)
    
  response = Session.ExecCommand("show rip neighbor")
  if (not ("not running" in response)): 
    _runningRoutingProtocols.Add(L3Discovery.NeighborProtocol.RIP)  
  
  response = Session.ExecCommand("show bgp neighbor")
  if (not ("not running" in response)): 
    _runningRoutingProtocols.Add(L3Discovery.NeighborProtocol.BGP)
    
  response = Session.ExecCommand("show lldp")
  lldpenabled = re.findall(r"LLDP\s+:\s+Enabled", response)
  if len(lldpenabled) == 1 : 
    _runningRoutingProtocols.Add(L3Discovery.NeighborProtocol.LLDP)
    
  response = Session.ExecCommand("show configuration routing-options static")
  if (not ("not running" in response)): 
    _runningRoutingProtocols.Add(L3Discovery.NeighborProtocol.STATIC)  

ActionResult = _runningRoutingProtocols</MainCode>
    <Origin_X>196</Origin_X>
    <Origin_Y>609</Origin_Y>
    <Size_Width>146</Size_Width>
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
    <EditorSize>{Width=950, Height=728}|{X=283,Y=176}</EditorSize>
    <FullTypeName>PGT.VisualScripts.vScriptStop</FullTypeName>
  </vScriptCommands>
  <vScriptCommands>
    <vsID>16</vsID>
    <CommandID>999b46d8-1847-4a34-ab60-3e2ca74ceea0</CommandID>
    <Name>Return_BGPASNumber</Name>
    <DisplayLabel>BGP AS Number</DisplayLabel>
    <Commands />
    <MainCode>global ActionResult

ActionResult = RouterIDAndASNumber.GetBGPASNumber()
</MainCode>
    <Origin_X>86</Origin_X>
    <Origin_Y>481</Origin_Y>
    <Size_Width>146</Size_Width>
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
    <vsID>17</vsID>
    <CommandID>b1e6cdc1-9376-441f-9758-93a7c38d178e</CommandID>
    <Name>Return_HostName</Name>
    <DisplayLabel>Host Name</DisplayLabel>
    <Commands />
    <MainCode>global ActionResult
global _hostName

ActionResult = _hostName</MainCode>
    <Origin_X>129</Origin_X>
    <Origin_Y>547</Origin_Y>
    <Size_Width>146</Size_Width>
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
    <vsID>18</vsID>
    <CommandID>dfdd4171-2a1b-4428-8463-d0dcaca9e22e</CommandID>
    <Name>Return_Platform</Name>
    <DisplayLabel>Platform</DisplayLabel>
    <Commands />
    <MainCode>global ActionResult

ActionResult = "JunOS"</MainCode>
    <Origin_X>709</Origin_X>
    <Origin_Y>203</Origin_Y>
    <Size_Width>146</Size_Width>
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
    <vsID>19</vsID>
    <CommandID>f1ac0ff6-d637-4a5d-b87d-e060ca2986f3</CommandID>
    <Name>Return_Type</Name>
    <DisplayLabel>Type</DisplayLabel>
    <Commands />
    <MainCode>global ActionResult

# Type can be Switch, Router or Firewall, depending on Model
v = Version.GetVersion()
modelLine = next((line for line in v.splitlines() if "Model:" in line), None)
if modelLine != None:
   model = modelLine.split(":")[1].strip()
   if model.startswith("ex") or model.startswith("qfx"):
     ActionResult = "Switch"
   elif model.startswith("srx") :
     ActionResult = "Firewall"
   elif model.startswith("mx") :
     ActionResult = "Router"
   else:
     ActionResult = "Unknown"
else:
  ActionResult = "Unknown"
</MainCode>
    <Origin_X>746</Origin_X>
    <Origin_Y>271</Origin_Y>
    <Size_Width>146</Size_Width>
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
    <vsID>20</vsID>
    <CommandID>d509949e-d797-4299-9345-678e3d60dd3b</CommandID>
    <Name>Return_Vendor</Name>
    <DisplayLabel>Vendor</DisplayLabel>
    <Commands />
    <MainCode>global ActionResult

ActionResult = "JunOS"</MainCode>
    <Origin_X>761</Origin_X>
    <Origin_Y>334</Origin_Y>
    <Size_Width>146</Size_Width>
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
    <vsID>21</vsID>
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
    <Origin_X>90</Origin_X>
    <Origin_Y>271</Origin_Y>
    <Size_Width>146</Size_Width>
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
    <EditorSize>{Width=849, Height=602}|{X=338,Y=338}</EditorSize>
    <FullTypeName>PGT.VisualScripts.vScriptStop</FullTypeName>
  </vScriptCommands>
  <vScriptCommands>
    <vsID>22</vsID>
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
    <Origin_X>139</Origin_X>
    <Origin_Y>203</Origin_Y>
    <Size_Width>146</Size_Width>
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
    <vsID>23</vsID>
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
    <Origin_X>179</Origin_X>
    <Origin_Y>143</Origin_Y>
    <Size_Width>146</Size_Width>
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
    <vsID>24</vsID>
    <CommandID>d76d19d5-a5bf-458a-be34-94f8f0a30234</CommandID>
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
    <Origin_X>518</Origin_X>
    <Origin_Y>781</Origin_Y>
    <Size_Width>150</Size_Width>
    <Size_Height>50</Size_Height>
    <isStart>false</isStart>
    <isStop>false</isStop>
    <isSimpleCommand>false</isSimpleCommand>
    <isSimpleDecision>false</isSimpleDecision>
    <Variables># RouterID is a dictionary keyed by RoutingProtocol as a string
RouterID = {}
BGPASNumber = ""</Variables>
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

  # Global router ID is a the router ID of the most preferred routeing protocol
  globalRouterID = ConnectionInfo.DeviceIP
  
  routingOptions = Session.ExecCommand("show configuration routing-options")
  rid = re.findall(r"(?&lt;=router-id )[\d.]{0,99}", routingOptions)
  if len(rid) &gt; 0 : globalRouterID = rid[0]

  # sort the routing protocols by preference (its integer value)
  sRoutingProtocols = sorted(_runningRoutingProtocols, key=lambda p: int(p))
  for thisProtocol in sRoutingProtocols:  
    if thisProtocol == L3Discovery.NeighborProtocol.BGP:
      bgpNeighbors = Session.ExecCommand("show bgp neighbor")
      rid = re.findall(r"(?&lt;=Local ID: )[\d.]{0,99}", bgpNeighbors)
      if len(rid) &gt; 0 : self.RouterID[str(thisProtocol)] = rid[0]
      elif globalRouterID != "" : self.RouterID[str(thisProtocol)] = globalRouterID
      # get AS number
      ASes = re.findall(r"(?&lt;=AS )[\d.]{0,99}",  bgpNeighbors)
      if len(ASes) &gt;= 2 : self.BGPASNumber = ASes[1]
      else : 
        ASes = re.findall(r"(?&lt;=autonomous-system )[\d.]{0,99}", routingOptions)
        if len(ASes) &gt; 0 : self.BGPASNumber = ASes[0]
      
    elif thisProtocol == L3Discovery.NeighborProtocol.OSPF:
      ospfStatus = Session.ExecCommand("show ospf overview")
      rid = re.findall(r"(?&lt;=Router ID: )[\d.]{0,99}", ospfStatus)
      if len(rid) &gt; 0 : self.RouterID[str(thisProtocol)] = rid[0]
      elif globalRouterID != "" : self.RouterID[str(thisProtocol)] = globalRouterID
      
    elif thisProtocol == L3Discovery.NeighborProtocol.LLDP:
      lldpInfo = Session.ExecCommand("show lldp local-information")
      lldpStatus = re.findall(r"(?:Chassis ID\s+: )([0-9a-f]+:[0-9a-f]+:[0-9a-f]+:[0-9a-f]+:[0-9a-f]+:[0-9a-f]+)", lldpInfo)
      if len(lldpStatus) &gt; 0 : self.RouterID[str(thisProtocol)] = lldpStatus[0]


    elif thisProtocol == L3Discovery.NeighborProtocol.RIP:
      self.RouterID[str(thisProtocol)] = globalRouterID       
      
    elif thisProtocol == L3Discovery.NeighborProtocol.STATIC:
      self.RouterID[str(thisProtocol)] = globalRouterID 
      
    else :
      self.RouterID[str(thisProtocol)] = globalRouterID   
        
def Reset(self):
  self.RouterID = {}
  self.BGPASNumber = ""</CustomCodeBlock>
    <DemoMode>false</DemoMode>
    <Description />
    <WatchVariables />
    <Initializer />
    <EditorSize>{Width=1191, Height=796}|{X=205,Y=77}</EditorSize>
    <FullTypeName>PGT.VisualScripts.vScriptGeneralObject</FullTypeName>
  </vScriptCommands>
  <vScriptCommands>
    <vsID>25</vsID>
    <CommandID>99e3a404-ae04-455f-bea8-6b791a4c42e0</CommandID>
    <Name>Initialize</Name>
    <DisplayLabel>Initialize</DisplayLabel>
    <Commands />
    <MainCode>global ActionResult
global _hostName

_versionInfo = Version.GetVersion()
_hostName = Session.GetHostName();
if "junos" in _versionInfo.lower():
  ActionResult = True
else :
  ActionResult = False</MainCode>
    <Origin_X>312</Origin_X>
    <Origin_Y>74</Origin_Y>
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
    <vsID>26</vsID>
    <CommandID>a3696ee7-5dab-4785-a63f-0b145e6cb134</CommandID>
    <Name>Reset</Name>
    <DisplayLabel>Reset</DisplayLabel>
    <Commands />
    <MainCode>global _versionInfo
global _hostName
global _stackCount
global _runningRoutingProtocols

_versionInfo = None
_hostName = None
_stackCount = -1
_runningRoutingProtocols = []

Inventory.Reset()
Version.Reset()
SystemSerial.Reset()
RouterIDAndASNumber.Reset()
GetInterfaces.Reset()</MainCode>
    <Origin_X>443</Origin_X>
    <Origin_Y>47</Origin_Y>
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
    <Description />
    <WatchVariables />
    <Initializer />
    <FullTypeName>PGT.VisualScripts.vScriptStop</FullTypeName>
  </vScriptCommands>
  <vScriptCommands>
    <vsID>27</vsID>
    <CommandID>12a6fafd-acab-45fc-8df7-19915dbf632f</CommandID>
    <Name>RegisterNHRP</Name>
    <DisplayLabel>Register NHRP</DisplayLabel>
    <Commands />
    <MainCode># The NetworkRegistry object is received in ConnectionInfo.aParam
nRegistry = ConnectionInfo.aParam

# The IRouter object required by nRegistry.RegisterNHRPPeer() call is received in ConnectionInfo.bParam
iRouter = ConnectionInfo.bParam

# collect VRRP information
vrrpSummary = Session.ExecCommand("show vrrp summary")
VIPAddress = ""
GroupID = ""
PeerAddress = ""
isActive = False
ri = None

for thisLine in vrrpSummary.splitlines():
  try:
    indentLevel = len(thisLine) - len(thisLine.lstrip(' '))
    if indentLevel == 0:
      # interface definition is changing
      if GroupID != "" and VIPAddress != "":
        nRegistry.RegisterNHRPPeer(iRouter, ri, L3Discovery.NHRPProtocol.VRRP, isActive, VIPAddress, GroupID, PeerAddress)
        VIPAddress = ""
        GroupID = ""
        PeerAddress = ""
        ri = None
      # -- 
      words = filter(None, thisLine.split(" "))
      if len(words) &gt;= 3 :
        ifName = words[0]
        isActive = "master" in thisLine.lower()
        ri = GetInterfaces.GetInterfaceByName(ifName)
        GroupID = words[2]
      continue
    if ri != None:
      words = filter(None, thisLine.split(" "))
      if len(words) == 2:
        role = words[0]
        if role == "lcl" :
          pass
        elif role == "mas" :
          PeerAddress = words[1]
        elif role == "vip" :
          VIPAddress = words[1]
               
  except Exception as Ex:
    message = "JunOS Router Module Error : could not parse NHRP information &lt;{0}&gt; because : {1} ".format(thisLine, str(Ex))
    System.Diagnostics.DebugEx.WriteLine(message)
    
# -- register the last one
if ri != None and VIPAddress != "" and GroupID != "" :
  nRegistry.RegisterNHRPPeer(iRouter, ri, L3Discovery.NHRPProtocol.VRRP, isActive, VIPAddress, GroupID, PeerAddress)    
</MainCode>
    <Origin_X>410</Origin_X>
    <Origin_Y>706</Origin_Y>
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
    <Description>This call will check if VRRP protocol is running on device
and will register VIP addresses</Description>
    <WatchVariables />
    <Initializer />
    <FullTypeName>PGT.VisualScripts.vScriptStop</FullTypeName>
  </vScriptCommands>
  <vScriptCommands>
    <vsID>28</vsID>
    <CommandID>f48a95a7-36ad-49ad-b066-49b123f2b0c0</CommandID>
    <Name>GetInterfaces</Name>
    <DisplayLabel>Get interfaces</DisplayLabel>
    <Commands />
    <MainCode />
    <Origin_X>688</Origin_X>
    <Origin_Y>782</Origin_Y>
    <Size_Width>146</Size_Width>
    <Size_Height>50</Size_Height>
    <isStart>false</isStart>
    <isStop>false</isStop>
    <isSimpleCommand>false</isSimpleCommand>
    <isSimpleDecision>false</isSimpleDecision>
    <Variables># These are the interfaces collected by ParseInterfaces() method
Interfaces = []
# All interfaces configuration. Unparsed, as returned by CLI command
AllInterfaceConfiguration = ""
# Interface config cache, keyed by Interface Name
_interfaceConfigurations = {}</Variables>
    <Break>false</Break>
    <ExecPolicy>After</ExecPolicy>
    <CustomCodeBlock>"""Collects interface details for all inet interfaces, except the interface configuration """
def ParseInterfaces(self) :
  from System.Net import IPAddress
  # Get the interfaces configuration
  if self.AllInterfaceConfiguration == "" : self.ParseInterfaceConfigurations()
  # Query the device interfaces
  interfaces = Session.ExecCommand("show interfaces terse").splitlines()
  # Because JunOS reports the VRRP VIP addresses in "show interface terse" output, it is necessary to 
  # check interface ip of VRRP enabled interfaces
  vrrpSummary = Session.ExecCommand("show vrrp summary | match lcl").splitlines()
  # Parse the result and fill up self.Interfaces list
  for line in interfaces:  
    words = filter(None, line.split(" "))
    if len(words) &gt;= 4:
      ifName = words[0]
      if self.IsInterrestingInterface(ifName):
        ifProtocol = words[3]
        # ifProtocol could be inet, eth-switch, aenet
        if ifProtocol == "inet" and len(words) &gt;= 5:
          # words should look like : xe-0/0/25.0,up,up,inet,172.20.1.18/31 
          ifIPAndMask = words[4].Split("/")
          # create a reference variable to pass it to TryParse (this is an out parameter in .Net)
          ipa = clr.Reference[IPAddress]()
          # check if this is a valid ip address
          if IPAddress.TryParse(ifIPAndMask[0], ipa):
            ri = L3Discovery.RouterInterface()
            # store the physical interface name, remove trailing ".0"
            ri.Name = re.sub("\.0$","", ifName)
            # check if VRRP runs on interface
            vrrpLine = next((line for line in vrrpSummary if line.startswith(ifName)), None)
            if vrrpLine != None:
              # VRRP is running on interface, use the lcl address
              # Address should be the last word
              vrrpLineWords = filter(None, vrrpLine.split(" "))
              ri.Address = vrrpLineWords[len(vrrpLineWords)-1]
            else :
              # VRRP is not running on interface, use address from "show interface terse"
              ri.Address = ifIPAndMask[0]
            ri.Status =  "{0},{1}".format(words[1], words[2])
            if len(ifIPAndMask) &gt;= 2 : ri.MaskLength = ifIPAndMask[1]
            else : ri.MaskLength = ""
            ri.Configuration = self._interfaceConfigurations.get(ri.Name, "")
            self.Interfaces.Add(ri)           
        elif ifProtocol == "eth-switch" :
          # words should look like : ge-3/0/36.0,up,up,eth-switch        
          ri = L3Discovery.RouterInterface()
          # store the physical interface name, remove trailing ".0"
          ri.Name = re.sub("\.0$","", ifName)
          ri.Address = ""
          ri.MaskLength = ""
          ri.Status =  "{0},{1}".format(words[1], words[2])
          ri.Configuration = self._interfaceConfigurations.get(ri.Name, "")
          self.Interfaces.Add(ri)        
        elif ifProtocol == "aenet" :
          # words should look like : xe-3/0/44.0,up,up,aenet,--&gt;,ae3.0      
          ri = L3Discovery.RouterInterface()
          # store the physical interface name
          ri.Name = re.sub("\.0$","", ifName)
          ri.Address = ""
          ri.MaskLength = ""
          ri.Status =  "{0},{1}".format(words[1], words[2])
          ri.AggregateID = words[5]
          ri.Configuration = self._interfaceConfigurations.get(ri.Name, "")
          self.Interfaces.Add(ri)        
            
  # Process descriptions
  interfaceDescriptions = Session.ExecCommand("show interfaces descriptions").splitlines()     
  for line in interfaceDescriptions:
    words = filter(None, line.split(" "))
    if len(words) &gt;= 4:
      ifName = words[0]
      foundInterface = next((intf for intf in self.Interfaces if intf.Name == ifName), None)
      if foundInterface != None : foundInterface.Description = " ".join([t for t in words if words.index(t) &gt;= 3])

""" Return the list of RouterInterfaces that have a valid IPAddress"""
def GetRoutedInterfaces(self):
  if len(self.Interfaces) == 0 : self.ParseInterfaces()
  routedInterfaces = filter(lambda x: x.Address != "", self.Interfaces)
  return routedInterfaces

""" Return the list of device interfaces"""
def GetAllInterfaces(self):
  if len(self.Interfaces) == 0 : self.ParseInterfaces()
  return self.Interfaces
  
"""Returns a RouterInterface object for the interface specified by its name"""        
def GetInterfaceByName(self, ifName):
  if len(self.Interfaces) == 0 : self.ParseInterfaces()
  foundInterface = next((intf for intf in self.Interfaces if intf.Name == ifName), None)
  return foundInterface
  
""" Returns a RouterInterface object for the interface specified by its ip address """    
def GetInterfaceNameByAddress(self, ipAddress):
  if len(self.Interfaces) == 0 : self.ParseInterfaces()
  ifName = ""
  foundInterface = next((intf for intf in self.Interfaces if intf.Address == ipAddress), None)
  if foundInterface != None:
    ifName = foundInterface.Name
  return ifName 

""" Return the configuration of an interface """
def GetInterfaceConfiguration(self, ifName):
  if self.AllInterfaceConfiguration == "" : self.ParseInterfaceConfigurations()
  ifConfig = _interfaceConfigurations.get(ifName, "")
  return ifConfig 

""" Executes CLI command to query all interfaces configuration from device """  
def ParseInterfaceConfigurations(self):
  self.AllInterfaceConfiguration = Session.ExecCommand("show configuration interfaces")
  # Clear configuration dictionary
  self._interfaceConfigurations = {}
  currentIntfName = ""
  currentConfiguration = []
  vlanInterfaceConfiguration = []
  for thisLine in self.AllInterfaceConfiguration.splitlines():
    if thisLine == "}" :  continue
    lineindent = len(thisLine) - len(thisLine.strip())
    if lineindent == 0 :
      # This should be a new interface
      if currentIntfName != "":
        if currentIntfName == "vlan" or currentIntfName == "irb":
          # Need to separate by units
          unitName = ""
          for vlanIntfLine in currentConfiguration:
            if vlanIntfLine.strip() == "}" : continue
            if vlanIntfLine.strip().startswith("unit"):
              # This should be a new unit
              if unitName != "":
                # Add current vlan interface to _interfaceConfigurations
                unitNumber = re.findall(r"\d+", unitName)[0]
                vlanIntfName = currentIntfName + "." + unitNumber
                self._interfaceConfigurations[vlanIntfName] = "\r\n".join(vlanInterfaceConfiguration)
              if "{" in vlanIntfLine:
                unitName =  vlanIntfLine[0:vlanIntfLine.index("{")].strip()
              elif ";" in vlanIntfLine:
                unitName =  vlanIntfLine[0:vlanIntfLine.index(";")].strip()
              vlanInterfaceConfiguration = []
            else:
              vlanInterfaceConfiguration.append(vlanIntfLine.strip())
        else:
          self._interfaceConfigurations[currentIntfName] = "\r\n".join(currentConfiguration)
      if "{" in thisLine:
        currentIntfName = thisLine[0:thisLine.index("{")].strip()
      elif ";" in thisLine:
        currentIntfName = thisLine[0:thisLine.index(";")].strip()
      # Validate what we got
      if not self.IsInterrestingInterface(currentIntfName) : 
        currentIntfName = ""
      # Clear current configuration
      currentConfiguration = []
    else:
      currentConfiguration.append(thisLine)

""" Determines if a given name is an interface name we want to parse"""
def IsInterrestingInterface(self, intfName):
  return intfName.startswith("ge-") or intfName.startswith("xe-") or intfName.startswith("et-") or intfName.startswith("ae") or intfName.startswith("irb") or intfName.startswith("vlan") or intfName.startswith("lo")
    
def Reset(self) :
  self.Interfaces = []
  self.AllInterfaceConfiguration = ""
</CustomCodeBlock>
    <DemoMode>false</DemoMode>
    <Description />
    <WatchVariables />
    <Initializer />
    <EditorSize>{Width=1067, Height=956}|{X=273,Y=-19}</EditorSize>
    <FullTypeName>PGT.VisualScripts.vScriptGeneralObject</FullTypeName>
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
    <Name>SwitchTask_Stop_0</Name>
    <DisplayLabel>Initialize</DisplayLabel>
    <Left>2</Left>
    <Right>25</Right>
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
    <Right>10</Right>
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
    <Right>11</Right>
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
    <Right>12</Right>
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
    <Right>13</Right>
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
    <Right>14</Right>
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
    <Right>15</Right>
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
    <Right>16</Right>
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
    <Right>17</Right>
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
    <Right>18</Right>
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
    <Right>19</Right>
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
    <Right>20</Right>
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
    <Right>21</Right>
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
    <Right>22</Right>
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
    <Right>23</Right>
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
    <Name>SwitchTask_Stop_2</Name>
    <DisplayLabel>Reset</DisplayLabel>
    <Left>2</Left>
    <Right>26</Right>
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
    <Right>27</Right>
    <Condition>return ConnectionInfo.Command == "RegisterNHRP"</Condition>
    <Variables />
    <Break>false</Break>
    <Order>22</Order>
    <Description />
    <WatchVariables />
  </vScriptConnector>
  <Parameters>
    <ScriptName>JunOS</ScriptName>
    <GlobalCode># last changed : 2018.10.04
scriptVersion = "2.2"
#--
_hostName = None
_stackCount = -1

# The routing protocols run by this router
_runningRoutingProtocols = []</GlobalCode>
    <BreakPolicy>Before</BreakPolicy>
    <CustomNameSpaces>import re
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
    <EditorScaleFactor>0.3228367</EditorScaleFactor>
    <Description>This vScript implements a NetworkMap Router Module
capable of handling Juniper EX/MX/SRX devices runing JunOS.</Description>
    <EditorSize>{Width=437, Height=505}</EditorSize>
    <PropertiesEditorSize>{Width=665, Height=460}|{X=507,Y=275}</PropertiesEditorSize>
  </Parameters>
</vScriptDS>