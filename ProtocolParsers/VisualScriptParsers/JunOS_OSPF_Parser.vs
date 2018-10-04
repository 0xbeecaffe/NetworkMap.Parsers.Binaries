<?xml version="1.0" standalone="yes"?>
<vScriptDS xmlns="http://tempuri.org/vScriptDS.xsd">
  <vScriptCommands>
    <vsID>0</vsID>
    <CommandID>4672714a-bc08-4ec5-bea1-b8dd32b624b3</CommandID>
    <Name>Start</Name>
    <DisplayLabel>Start</DisplayLabel>
    <Commands />
    <MainCode />
    <Origin_X>19</Origin_X>
    <Origin_Y>249</Origin_Y>
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
  ActionResult = False</MainCode>
    <Origin_X>443</Origin_X>
    <Origin_Y>83</Origin_Y>
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
    <Origin_X>214</Origin_X>
    <Origin_Y>246</Origin_Y>
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
    <Origin_X>466</Origin_X>
    <Origin_Y>141</Origin_Y>
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

OperationStatusLabel = "Querying OSPF neighbors..."  
TextToParse = Session.ExecCommand("show ospf neighbor")
#--
OperationStatusLabel = "Querying OSPF interfaces..."
ospfInterfaces = Session.ExecCommand("show ospf interface")
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
    # Address,Interface,State,ID,Pri,Dead
    # 10.0.0.241,ae0.0,Full,10.0.0.254,128,34  
   
    # create a reference variable to pass it to TryParse (this is an out parameter in .Net)
    nIP = clr.Reference[System.Net.IPAddress]() # neighbor IP
    nID = clr.Reference[System.Net.IPAddress]() # neighbor ID
    # expect two ip addresses in line, first is neighbor IP, second is neighbor RID
    foundIPs = re.findall(r"\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}", line)
    if len(foundIPs) == 2 and System.Net.IPAddress.TryParse(foundIPs[0], nIP) and System.Net.IPAddress.TryParse(foundIPs[1], nID) :
      # This is a new peer, initialize variables
      OperationStatusLabel = "Querying router interface {0}...".format(words[1])
      ri = Router.GetInterfaceByName(words[1])
      if ri != None:
        # add OSPF Area info to RouterInterface
        if ospfInterfaces != None:
          ospfIntfLines = [str.lower(thisLine.strip()) for thisLine in ospfInterfaces.splitlines()]
          foundOspfIntfLine = next((thisIFLine for thisIFLine in ospfIntfLines if thisIFLine.startswith(ri.Name)), None)
          if foundOspfIntfLine != None:
            w = filter(None, foundOspfIntfLine.split(" "))
            # w array header  : Interface,State,Area,DR ID,BDR ID,Nbrs
            # w should be like: lo0.0,DRother,0.0.0.0,0.0.0.0,0.0.0.0,0  
            ri.OSPFArea = w[2]   
        # as nID and nIP are clr reference types, we need tp check the Value property        
        neighborRouterID = str(nID.Value)
        remoteNeighboringIP = str(nIP.Value)
        neighborState = words[2]
        description = ""
        OperationStatusLabel = "Registering OSPF neighbor {0}...".format(neighborRouterID)
        nRegistry.RegisterNeighbor(Router, L3Discovery.NeighborProtocol.OSPF, neighborRouterID, "", description, remoteNeighboringIP, ri, neighborState)
        
  except Exception as Ex:
    msg = "OSPFarser : Error while parsing ospf output line [{0}]. Error is : {1}".format(line, str(Ex))
    System.Diagnostics.DebugEx.WriteLine(msg) 
</MainCode>
    <Origin_X>505</Origin_X>
    <Origin_Y>273</Origin_Y>
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
    <Description>Discover OSPF adjacencies and register peers for discovery</Description>
    <WatchVariables />
    <Initializer />
    <FullTypeName>PGT.VisualScripts.vScriptStop</FullTypeName>
  </vScriptCommands>
  <vScriptCommands>
    <vsID>5</vsID>
    <CommandID>8def390e-2884-43ad-bda1-e12cdf892b47</CommandID>
    <Name>ReturnProtocols</Name>
    <DisplayLabel>Supported Protocols</DisplayLabel>
    <Commands />
    <MainCode>global ParsingForProtocols
global ActionResult

ActionResult = ParsingForProtocols</MainCode>
    <Origin_X>482</Origin_X>
    <Origin_Y>206</Origin_Y>
    <Size_Width>136</Size_Width>
    <Size_Height>38</Size_Height>
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
    <vsID>6</vsID>
    <CommandID>0e509eae-8ea6-4daa-98fd-5791a6aab5ae</CommandID>
    <Name>UnknownTask</Name>
    <DisplayLabel>Unknown task</DisplayLabel>
    <Commands />
    <MainCode>global ActionResult

ActionResult = None
raise ValueError("Junos OSPF protocol parser module has received an unhandled Command request : {0}".format(ConnectionInfo.Command))</MainCode>
    <Origin_X>360</Origin_X>
    <Origin_Y>499</Origin_Y>
    <Size_Width>130</Size_Width>
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
    <CommandID>22b500c7-757c-495c-b9d2-314afdc7d8bb</CommandID>
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
    <Origin_X>39</Origin_X>
    <Origin_Y>486</Origin_Y>
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
  # clear contents
  self.OSPFAreaLSAs = {}
  # query OSPF database
  ospfAreaDatabase = Session.ExecCommand("show ospf database")
  currentArea = None
  currentLSATypeName = ""
  # LSAs = [item1, item2]
  LSAs = []
  # OSPFLSAdict = {"Router" : [item1, item2], "Network" : [item1, item2]}
  OSPFLSAdict = {}
  lines = [str.lower(thisLine.strip()) for thisLine in ospfAreaDatabase.splitlines()]
  for thisLine in lines:
    # header       : Type ID               Adv Rtr           Seq Age  Opt Cksum  Len
    # thisLine is like :Router   10.93.1.200      10.93.1.200      0x800005af  1113  0x8  0x6280  60   
    try:
      if thisLine.StartsWith("{master:"):
        continue
      if thisLine.startswith("ospf database"):
        # thisLine is like : OSPF database, Area 10.72.0.0
        o = filter(None, thisLine.split(","))
        a = filter(None, o[1].split(" "))
        thisAreaID = a[1].strip()
        if currentArea == None:
          currentArea = L3Discovery.OSPFArea()
          currentArea.AreaID = thisAreaID
          currentArea.AreaType = self.GetAreaType(currentArea.AreaID)
        elif thisAreaID != currentArea.AreaID :
          # Area ID is changing
          self.OSPFAreaLSAs[currentArea] = OSPFLSAdict
          # reset temporary lists
          OSPFLSAdict = {}
          LSAs = []
          currentArea = L3Discovery.OSPFArea()
          currentArea.AreaID = thisAreaID
          currentArea.AreaType = self.GetAreaType(currentArea.AreaID)         

      else:
        r = filter(None, thisLine.split(" "))
        # Tha LSA Type should be the first word in thisLine
        LSAType = r[0]
        # if we get "type" then this must be a header line, just skip it
        if LSAType != "type":
          if LSAType != currentLSATypeName:
            #LSAType is changing
            if (currentLSATypeName != ""):
              OSPFLSAdict[currentLSATypeName] = LSAs
              LSAs = []
            currentLSATypeName = LSAType
            
          if len(r) &gt;= 3 :           
            LSAID = r[1].strip("*")
            AdvRouter = r[2]
            newLSA = L3Discovery.OSPFLSA()
            newLSA.LSAType = currentLSATypeName
            newLSA.LSAID = LSAID
            newLSA.AdvRouter = AdvRouter
            LSAs.Add(newLSA)
    except Exception as Ex:
      msg = "JunOS OSPF vScript Parser : Error while processing ospf database. Error is : {0}".format(str(Ex))
      System.Diagnostics.DebugEx.WriteLine(msg) 
      
  # add the last area router ID-s
  if currentArea != None: 
    self.OSPFAreaLSAs[currentArea] = OSPFLSAdict
  
"""Return all the Areas the router belongs to """  
def GetAreas(self):
  # if OSPF datbase was not yet processed, do it now. It will populate self.OSPFAreaLSAs
  if len(self.OSPFAreaLSAs) == 0 : self.ProcessDatabase()
  Areas = self.OSPFAreaLSAs.keys()
  return Areas  
  
    
"""Return the list of LSAs for the requested Type and Area """  
def GetAreaLSAs(self, ospfArea, lsaTypeName):
  # if OSPF datbase was not yet processed, do it now. It will populate self.OSPFAreaLSAs
  if len(self.OSPFAreaLSAs) == 0 : self.ProcessDatabase()
  # get All LSAs for the requested Area
  AreaLSAs = self.OSPFAreaLSAs.get(ospfArea)
  RequestesAreaLSAs = []
  # get the LSA list for the requested LSA type
  if AreaLSAs != None : RequestesAreaLSAs = AreaLSAs.get(lsaTypeName)
  return RequestesAreaLSAs
  
"""Return the OSPFAreaType for the requested AREA ID """
def GetAreaType(self, ospfAreaID):
  if ospfAreaID == "0.0.0.0" :
    return L3Discovery.OSPFAreaType.Backbone
  if self.OSPFAreInfo == "" :
    self.OSPFAreInfo = Session.ExecCommand("show ospf overview")
  #	parsing as per https://www.juniper.net/documentation/en_US/junos/topics/reference/command-summary/show-ospf-ospf3-overview.html  
  try:
    lines = [str.lower(thisLine.strip()) for thisLine in self.OSPFAreInfo.splitlines()]
    OperationStatusLabel = "Processing OSPF Area information..."
    inDesiredAreaSection = False
    # parse OSPFAreInfo to get the ext block related to the requested areaID
    for thisLine in lines:
      if thisLine.startswith("area {0}".format(ospfAreaID)):
        if inDesiredAreaSection:
          break
        else:
          inDesiredAreaSection = True
          continue
      if inDesiredAreaSection:
        # No we are desired section
        if thisLine.startswith("stub type:") :
          typeDesc = thisLine.split(":")
          if "normal stub" in typeDesc[1] : 
            return L3Discovery.OSPFAreaType.Stub
          if "not stub" in typeDesc[1] : 
            return L3Discovery.OSPFAreaType.Normal
          if "not so stubby" in typeDesc[1] or "nssa" in typeDesc[1] : 
            return L3Discovery.OSPFAreaType.NSSA
      
    return L3Discovery.OSPFAreaType.Unknown
    
  except Exception as Ex:
    msg = "JunOS OSPF vScript Parser : Error while processing ospf area block. Error is : {0}".format(str(Ex))
    System.Diagnostics.DebugEx.WriteLine(msg)
    return L3Discovery.OSPFAreaType.Unknown  
 
"""Return all of the LSA Type Names for the specified Area """
def GetLSATypeNames(self, ospfArea):
  # if OSPF datbase was not yet processed, do it now. It will populate self.OSPFAreaLSAs
  if len(self.OSPFAreaLSAs) == 0 : self.ProcessDatabase()  
  # get All LSAs for the requested Area
  AreaLSAs = self.OSPFAreaLSAs.get(ospfArea)
  LSATypeNames = []
  if AreaLSAs != None : LSATypeNames = AreaLSAs.keys()
  return LSATypeNames
  
  
"""Reset object state """
def Reset(self):
  self.OSPFAreaLSAs = {}
  self.OSPFAreInfo = ""</CustomCodeBlock>
    <DemoMode>false</DemoMode>
    <Description />
    <WatchVariables />
    <Initializer />
    <FullTypeName>PGT.VisualScripts.vScriptGeneralObject</FullTypeName>
  </vScriptCommands>
  <vScriptCommands>
    <vsID>8</vsID>
    <CommandID>0ae817fb-7e0c-4390-9e93-83810bcdf2df</CommandID>
    <Name>Return_OSPFAreas</Name>
    <DisplayLabel>OSPF Areas</DisplayLabel>
    <Commands />
    <MainCode>global ActionResult

ActionResult = OSPFProcessor.GetAreas()
</MainCode>
    <Origin_X>482</Origin_X>
    <Origin_Y>339</Origin_Y>
    <Size_Width>125</Size_Width>
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
    <CommandID>b0fe4bde-5cfb-42a5-8155-1de6b7f4e2ec</CommandID>
    <Name>OSPFLSAs</Name>
    <DisplayLabel>Return OSPF LSA types</DisplayLabel>
    <Commands />
    <MainCode>global ActionResult

# the OSPF Area ID to be queried is received in ConnectionInfo.aParam
ospfArea = ConnectionInfo.aParam

ActionResult = OSPFProcessor.GetLSATypeNames(ospfArea)</MainCode>
    <Origin_X>363</Origin_X>
    <Origin_Y>36</Origin_Y>
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
    <Description>Returns the list of existing LSA Types for the requested OSPF Area</Description>
    <WatchVariables />
    <Initializer />
    <FullTypeName>PGT.VisualScripts.vScriptStop</FullTypeName>
  </vScriptCommands>
  <vScriptCommands>
    <vsID>10</vsID>
    <CommandID>2891e683-ecfc-4c0c-ae12-e5019cbd610f</CommandID>
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
    <Origin_X>436</Origin_X>
    <Origin_Y>402</Origin_Y>
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
    <Description>Returns the list of OSPF LSAs of the requested type
for the requested Area ID</Description>
    <WatchVariables />
    <Initializer />
    <FullTypeName>PGT.VisualScripts.vScriptStop</FullTypeName>
  </vScriptCommands>
  <vScriptCommands>
    <vsID>11</vsID>
    <CommandID>b03de8da-9b96-49c9-978e-451bd31c231b</CommandID>
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
    <Origin_X>421</Origin_X>
    <Origin_Y>455</Origin_Y>
    <Size_Width>113</Size_Width>
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
    <Right>6</Right>
    <Condition>return True</Condition>
    <Variables />
    <Break>true</Break>
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
    <Right>10</Right>
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
    <Name>SwitchTask_OSPFLSAs</Name>
    <DisplayLabel>GetOSPFLSATypes</DisplayLabel>
    <Left>2</Left>
    <Right>9</Right>
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
    <Right>8</Right>
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
    <ScriptName>JunOS_OSPF_Parser</ScriptName>
    <GlobalCode>ScriptVersion = "2.0"
ModuleName =  "Juniper, JunOS OSPF Protocol Parser Module - Python vScript Parser"
# Describes current operation status
OperationStatusLabel = "Working"
# The Router instance associated to this parser. Set in Initialize
Router = None
#This is the protocol supported by this module
ParsingForProtocols = [L3Discovery.NeighborProtocol.OSPF]
#This is the vendor name supported by this module
ParsingForVendor = "JunOS"</GlobalCode>
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
    <EditorScaleFactor>0.9953653</EditorScaleFactor>
    <Description>This Protocol Parser can handle JunOS routers 
and switches running OSPF protocol.</Description>
    <EditorSize>{Width=680, Height=666}</EditorSize>
    <PropertiesEditorSize>{Width=665, Height=460}|{X=627,Y=350}</PropertiesEditorSize>
  </Parameters>
</vScriptDS>