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
    <Origin_Y>346</Origin_Y>
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
    <MainCode>global ActionResult
global Router
global ParsingForProtocol
global ParsingForVendor
global OperationStatusLabel
OperationStatusLabel = "Initializing..."  

# Router object is passed in ConnectionInfo.aParam
Router = ConnectionInfo.aParam

if Router != None:
  # Requested protocol type is passed in ConnectionInfo.bParam
  # This parser only supports JunOS ruter vendor and OSPF protocol
  if ConnectionInfo.bParam in ParsingForProtocols:
    ActionResult = Router.Vendor == ParsingForVendor
  else:
    ActionResult = False
else:
  ActionResult = False

</MainCode>
    <Origin_X>461</Origin_X>
    <Origin_Y>124</Origin_Y>
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
    <Description>Initialize must decide whether this Protocol Parser
is capable of handling the Router and the requested
routing protocol  it has been invoked for.</Description>
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
    <MainCode />
    <Origin_X>206</Origin_X>
    <Origin_Y>341</Origin_Y>
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
    <Description>Based on the received information determines 
which action to take.</Description>
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
    <MainCode>global ScriptVersion
global ActionResult
global ModuleName

ActionResult =  ModuleName + " v" + ScriptVersion</MainCode>
    <Origin_X>392</Origin_X>
    <Origin_Y>72</Origin_Y>
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
    <Description>Returns a descriptive text about
the current Protocol Parser</Description>
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
    <MainCode>global Router
global OperationStatusLabel

# The neighbor registry object is received in ConnectionInfo.aParam
nRegistry = ConnectionInfo.aParam
# A CancellationToken is received in ConnectionInfo.bParam
cToken = ConnectionInfo.bParam
#--  
OperationStatusLabel = "Querying OSPF neighbors..."  
TextToParse = Session.ExecCommand("show ip ospf neighbor")
#--
OperationStatusLabel = "Querying OSPF interfaces..."
ospfInterfaces = Session.ExecCommand("show ip ospf interface brief")
#--
OperationStatusLabel = "Processing OSPF data..."
cToken.ThrowIfCancellationRequested()

ospf_lines = [str.lower(thisLine.strip()) for thisLine in TextToParse.splitlines()]
for line in ospf_lines:
  neighborRouterID = ""
  neighborState = ""
  remoteNeighboringIP = ""
  description = "";
  #--
  cToken.ThrowIfCancellationRequested()
  #--
  try:
    words = filter(None, line.split(" "))
    # Words should look like:
    #Neighbor ID,Pri,State,Dead Time,Address,Interface
    #172.20.0.255,128,FULL/BDR,00:00:34,172.20.0.14,TenGigabitEthernet0/1/0 
    neighborState = words[2]
    # create a reference variable to pass it to TryParse (this is an out parameter in .Net)
    nIP = clr.Reference[System.Net.IPAddress]() # neighbor IP
    nID = clr.Reference[System.Net.IPAddress]() # neighbor ID
    # expect two ip addresses in line, first is neighbor RID, second is neighbor IP
    foundIPs = re.findall(r"\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}", line)
    if len(foundIPs) == 2 and System.Net.IPAddress.TryParse(foundIPs[0], nID) and System.Net.IPAddress.TryParse(foundIPs[1], nIP) :
      # This is a new peer, initialize variables
      ifName = words[len(words)-1]
      OperationStatusLabel = "Querying router interface {0}...".format(ifName)
      ri = Router.GetInterfaceByName(ifName)
      if ri != None:
        # add OSPF Area info to RouterInterface
        if ospfInterfaces != None:
          ospfIntfLines = [str.lower(thisLine.strip()) for thisLine in ospfInterfaces.splitlines()]
          foundOspfIntfLine = next((thisIFLine for thisIFLine in ospfIntfLines if thisIFLine.startswith(ifName)), None)
          if foundOspfIntfLine != None:
            w = filter(None, foundOspfIntfLine.split(" "))
            #Interface    PID   Area            IP Address/Mask    Cost  State Nbrs F/C
            #Te0/1/0      100   172.20.0.0      172.20.0.1/28      1     DR    1/1
            ri.OSPFArea = w[2]   
        # as nID and nIP are clr reference types, we need tp check the Value property        
        neighborRouterID = str(nID.Value)
        remoteNeighboringIP = str(nIP.Value)
        description = ""
        OperationStatusLabel = "Registering OSPF neighbor {0}...".format(neighborRouterID)
        nRegistry.RegisterNeighbor(Router, L3Discovery.NeighborProtocol.OSPF, neighborRouterID, "", description, remoteNeighboringIP, ri, neighborState)
        
  except Exception as Ex:
    msg = "Cisco IOS OSPF vScript Parser : Error while parsing ospf output line [{0}]. Error is : {1}".format(line, str(Ex))
    System.Diagnostics.DebugEx.WriteLine(msg) 
</MainCode>
    <Origin_X>518</Origin_X>
    <Origin_Y>261</Origin_Y>
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
    <Description>Discover OSPF adjacencies and register peers for discovery</Description>
    <WatchVariables />
    <Initializer />
    <EditorSize>{Width=1116, Height=851}|{X=130,Y=130}</EditorSize>
    <FullTypeName>PGT.VisualScripts.vScriptStop</FullTypeName>
  </vScriptCommands>
  <vScriptCommands>
    <vsID>5</vsID>
    <CommandID>58e9be86-73f7-4c61-9334-e6a207cfaf18</CommandID>
    <Name>ReturnProtocols</Name>
    <DisplayLabel>Supported Protocols</DisplayLabel>
    <Commands />
    <MainCode>global ParsingForProtocols
global ActionResult

ActionResult = ParsingForProtocols</MainCode>
    <Origin_X>525</Origin_X>
    <Origin_Y>336</Origin_Y>
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
    <Description>Returns the list of routing protocols
that are actively running on the router</Description>
    <WatchVariables />
    <Initializer />
    <FullTypeName>PGT.VisualScripts.vScriptStop</FullTypeName>
  </vScriptCommands>
  <vScriptCommands>
    <vsID>6</vsID>
    <CommandID>88d6e50e-8635-4812-bcb6-a09a43be81b7</CommandID>
    <Name>UnknownTask</Name>
    <DisplayLabel>Unknown task</DisplayLabel>
    <Commands />
    <MainCode>global ActionResult

ActionResult = None
raise ValueError("CiscoIOS OSPF Parser module has received an unhandled Command request : {0}".format(ConnectionInfo.Command))</MainCode>
    <Origin_X>453</Origin_X>
    <Origin_Y>551</Origin_Y>
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
    <Description>A Command was received by this Protocol Parser
that is not handled. This is an ERROR condition.</Description>
    <WatchVariables />
    <Initializer />
    <FullTypeName>PGT.VisualScripts.vScriptStop</FullTypeName>
  </vScriptCommands>
  <vScriptCommands>
    <vsID>7</vsID>
    <CommandID>1a445e8a-3d14-4ba1-9e31-84cda5984f01</CommandID>
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
    <Origin_X>28</Origin_X>
    <Origin_Y>589</Origin_Y>
    <Size_Width>166</Size_Width>
    <Size_Height>50</Size_Height>
    <isStart>false</isStart>
    <isStop>false</isStop>
    <isSimpleCommand>false</isSimpleCommand>
    <isSimpleDecision>false</isSimpleDecision>
    <Variables># OSPFAreaLSAs contains OSPFLSA dictionaries entries keyed by OSPFArea objects. The internal dictinary is then keyed by LSAType - like Router, or Network.
OSPFAreaLSAs = {}
# example content :
# LSAs = [item1, item2]
# OSPFLSAs = {"Router" : [OSPFLSA1, OSPFLSA2], "Network" : [OSPFLSA1, OSPFLSA2]}
# OSPFAreaLSAs = {"0.0.0.0, Backone" : {"Router" : [OSPFLSA1, OSPFLSA2], "Network" : [OSPFLSA1, OSPFLSA2]}, "10.0.0.0, Normal" : {"Router" : [OSPFLSA1, OSPFLSA2], "Network" : [OSPFLSA1, OSPFLSA2]}}

# OSPFAreaInfo will contain the output of "show ip ospf" command and is used to find Area related informations
OSPFAreInfo = ""</Variables>
    <Break>false</Break>
    <ExecPolicy>After</ExecPolicy>
    <CustomCodeBlock>"""Query and Process the OSPF Database"""
def ProcessDatabase(self): 
  global OperationStatusLabel
  # clear contents
  self.OSPFAreaLSAs = {}
  # query OSPF database
  OperationStatusLabel = "Querying OSPF database..."
  ospfAreaDatabase = Session.ExecCommand("show ip ospf database")
  currentArea = None
  currentLSATypeName = ""
  # LSAs = [item1, item2]
  LSAs = []
  # OSPFLSAs = {"Router" : [item1, item2], "Network" : [item1, item2]}
  OSPFLSAdict = {}
  lines = [str.lower(thisLine.strip()) for thisLine in ospfAreaDatabase.splitlines()]
  OperationStatusLabel = "Processing OSPF database..."
  for thisLine in lines:
    # header : Link ID         ADV Router      Age Seq#       Checksum Link count
    # line is like :100.65.0.46     100.65.0.46     238         0x8000EBC3 0x00D97D 1  
    try:
      if "link states (area " in thisLine:
        # thisLine is like : Router Link States (Area 172.20.0.0)
        areaName = re.findall(r"(?&lt;=\().*?(?=\))", thisLine)[0]
        thisAreaID = re.findall(r"(?&lt;=area )[\d.]{0,99}", areaName)[0]
        thisLSATypeName = re.match(r"^.*(?=(link))", thisLine).group()
        if currentArea == None:
          currentArea = L3Discovery.OSPFArea()
          currentArea.AreaID = thisAreaID.strip()
          currentArea.AreaType = self.GetAreaType(currentArea.AreaID)
          
        elif thisAreaID.strip() != currentArea.AreaID:
          # area ID is changing
          self.OSPFAreaLSAs[currentArea] = OSPFLSAdict
          OSPFLSAdict = {}
          currentArea = L3Discovery.OSPFArea()
          currentArea.AreaID = thisAreaID.strip()
          currentArea.AreaType = self.GetAreaType(currentArea.AreaID)
        
        if currentLSATypeName != thisLSATypeName:
          # LSA Type is changing
          OSPFLSAdict[currentLSATypeName] = LSAs
          LSAs = []
          currentLSATypeName = thisLSATypeName.strip()
          
      elif "link states" in thisLine:
        # line is like : Type-5 AS External Link States
        # area is not changing, only the LSA Type
        thisLSATypeName = re.findall(r"^.*(?=(link))", thisLine)[0]
        if currentLSATypeName != "" and currentLSATypeName != thisLSATypeName:
          # LSA Type is changing
          OSPFLSAdict[currentLSATypeName] = LSAs
          currentLSATypeName = thisLSATypeName.strip()
        LSAs = []
      else:
        words = filter(None, thisLine.split(" "))
        firstWord = words[0].strip()
        #if first word is ip address, then this is an LSA entry
        ip = clr.Reference[System.Net.IPAddress]()
        if System.Net.IPAddress.TryParse(firstWord, ip):
          # The LSA ID should be the first word in thisLine
          LSAID = firstWord
          # The Adv Router should be the second word in thisLine
          AdvRouter = words[1].strip()
          thisLSA = L3Discovery.OSPFLSA()
          thisLSA.LSAType = currentLSATypeName
          thisLSA.LSAID = LSAID
          thisLSA.AdvRouter = AdvRouter
          LSAs.Add(thisLSA)
          
    except Exception as Ex:
      msg = "Cisco IOS OSPF vScript Parser : Error while processing ospf database. Error is : {0}".format(str(Ex))
      System.Diagnostics.DebugEx.WriteLine(msg) 
      
  # add the last area router ID-s
  if currentArea != None: self.OSPFAreaLSAs[currentArea] = OSPFLSAdict
  
  
    
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

"""Return the OSPF Area Type name for the requested AREA ID """
def GetAreaType(self, ospfAreaID):
  if ospfAreaID == "0.0.0.0" :
    return "Backbone"
  if self.OSPFAreInfo == "" :
    self.OSPFAreInfo = Session.ExecCommand("show ip ospf")
  
  # this is what we will return
  areaTypeName = ""
    
  try:
    lines = [str.lower(thisLine.strip()) for thisLine in self.OSPFAreInfo.splitlines()]
    OperationStatusLabel = "Processing OSPF Area information..."
    scanningAreaBlock = False
    areaBlock = []
    # parse OSPFAreInfo to get the ext block related to the requested areaID
    for thisLine in lines:
        if thisLine.startswith("area {0}".format(ospfAreaID)):
          if scanningAreaBlock:
            break
          else:
            scanningAreaBlock = True
            continue
        if scanningAreaBlock:
          areaBlock.Add(thisLine)
    # No we have the text block relevant to requested areaID
    areaTypeName = ["NSSA" for thisLine in areaBlock if "nssa" in thisLine]
    if areaTypeName == "":
      areaTypeName = ["Stub" for thisLine in areaBlock if "stub" in thisLine]
    if areaTypeName == "":
      areaTypeName = ["Totlly stubby" for thisLine in areaBlock if "totally" in thisLine]
      
    areaTypeName = "Normal"
    
  except Exception as Ex:
    msg = "Cisco IOS OSPF vScript Parser : Error while processing ospf area block. Error is : {0}".format(str(Ex))
    System.Diagnostics.DebugEx.WriteLine(msg)
    areaTypeName = "n/a"
    
  return areaTypeName
    
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
    <vsID>8</vsID>
    <CommandID>61c8703b-410e-41c3-b3b2-b0485b46ce0f</CommandID>
    <Name>Return_OSPFAreas</Name>
    <DisplayLabel>OSPF Areas</DisplayLabel>
    <Commands />
    <MainCode>global ActionResult

ActionResult = OSPFProcessor.GetAreas()
</MainCode>
    <Origin_X>524</Origin_X>
    <Origin_Y>412</Origin_Y>
    <Size_Width>164</Size_Width>
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
    <Description>Returns the OSPF Areas the current router is member of</Description>
    <WatchVariables />
    <Initializer />
    <FullTypeName>PGT.VisualScripts.vScriptStop</FullTypeName>
  </vScriptCommands>
  <vScriptCommands>
    <vsID>9</vsID>
    <CommandID>3d17c0fc-460d-49e3-b16e-bc93d7bc4122</CommandID>
    <Name>Return_OSPFLSATypes</Name>
    <DisplayLabel>Return OSPF LSA types</DisplayLabel>
    <Commands />
    <MainCode>global ActionResult

# the OSPF Area ID to be queried is received in ConnectionInfo.aParam
ospfArea = ConnectionInfo.aParam

ActionResult = OSPFProcessor.GetLSATypeNames(ospfArea)</MainCode>
    <Origin_X>480</Origin_X>
    <Origin_Y>485</Origin_Y>
    <Size_Width>164</Size_Width>
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
    <Description>Returns the list of existing LSA Types for the requested OSPF Area</Description>
    <WatchVariables />
    <Initializer />
    <FullTypeName>PGT.VisualScripts.vScriptStop</FullTypeName>
  </vScriptCommands>
  <vScriptCommands>
    <vsID>10</vsID>
    <CommandID>2c9396b9-a15a-44f6-8bc4-65a9fc7c7450</CommandID>
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
    <Origin_X>385</Origin_X>
    <Origin_Y>605</Origin_Y>
    <Size_Width>164</Size_Width>
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
    <Description>Returns the list of OSPF LSAs of the requested type
for the requested Area ID</Description>
    <WatchVariables />
    <Initializer />
    <FullTypeName>PGT.VisualScripts.vScriptStop</FullTypeName>
  </vScriptCommands>
  <vScriptCommands>
    <vsID>11</vsID>
    <CommandID>54f3ae65-bbaf-49a3-819c-0e636d5f6b1a</CommandID>
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
    <Origin_X>499</Origin_X>
    <Origin_Y>187</Origin_Y>
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
    <Order>1</Order>
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
    <Order>0</Order>
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
    <Right>5</Right>
    <Condition>return ConnectionInfo.Command == "GetSupportedProtocols"</Condition>
    <Variables />
    <Break>false</Break>
    <Order>2</Order>
    <Description />
    <WatchVariables />
  </vScriptConnector>
  <vScriptConnector>
    <cID>5</cID>
    <ConnectorID />
    <Name>SwitchTask_UnknownTask</Name>
    <DisplayLabel>Unknown</DisplayLabel>
    <Left>2</Left>
    <Right>6</Right>
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
    <Name>SwitchTask_OSPFLSAs</Name>
    <DisplayLabel>GetOSPFLSATypes</DisplayLabel>
    <Left>2</Left>
    <Right>9</Right>
    <Condition>return ConnectionInfo.Command == "GetOSPFLSATypes"</Condition>
    <Variables />
    <Break>false</Break>
    <Order>5</Order>
    <Description />
    <WatchVariables />
  </vScriptConnector>
  <vScriptConnector>
    <cID>7</cID>
    <ConnectorID />
    <Name>SwitchTask_Return_OSPFAreas</Name>
    <DisplayLabel>GetOSPFAreas</DisplayLabel>
    <Left>2</Left>
    <Right>8</Right>
    <Condition>return ConnectionInfo.Command == "GetOSPFAreas"</Condition>
    <Variables />
    <Break>false</Break>
    <Order>4</Order>
    <Description />
    <WatchVariables />
  </vScriptConnector>
  <vScriptConnector>
    <cID>8</cID>
    <ConnectorID />
    <Name>SwitchTask_Return_OSPFLSA</Name>
    <DisplayLabel>GetOSPFLSAs</DisplayLabel>
    <Left>2</Left>
    <Right>10</Right>
    <Condition>return ConnectionInfo.Command == "GetOSPFLSAs"</Condition>
    <Variables />
    <Break>false</Break>
    <Order>6</Order>
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
    <Order>7</Order>
    <Description />
    <WatchVariables />
  </vScriptConnector>
  <Parameters>
    <ScriptName>Cisco_IOS_OSPF_Parser</ScriptName>
    <GlobalCode>ScriptVersion = "2.0"
# Describe the Module Name
ModuleName = "Cisco IOS OSPF Protocol Parser Module - Python vScript Parser"
# Describes current operation status
OperationStatusLabel = "Init"
# The Router instance associated to this parser. Set in Initialize
Router = None
#This is the protocol supported by this module
ParsingForProtocols = [ L3Discovery.NeighborProtocol.OSPF ]
#This is the vendor name supported by this module
ParsingForVendor = "Cisco"</GlobalCode>
    <BreakPolicy>Before</BreakPolicy>
    <CustomNameSpaces>#####################################################################
#                                                                   #
# Below imports a typically required for a Protocol PArser Module   #
#                                                                   #
#####################################################################
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
    <EditorScaleFactor>0.9159999</EditorScaleFactor>
    <Description />
    <EditorSize>{Width=1932, Height=977}</EditorSize>
    <PropertiesEditorSize>{Width=665, Height=460}|{X=627,Y=350}</PropertiesEditorSize>
  </Parameters>
</vScriptDS>