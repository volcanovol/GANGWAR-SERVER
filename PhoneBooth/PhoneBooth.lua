local Timers = {}
local MissionTime = 5
local PhoneTime = 0.2
local MissionTypes = {"car","kill"} --- أنواع المهمات
local Marker
local PhoneMoney = {4000,3500,3000,4500,5000}


local MarkerLoc = {} -- مواقع علامة الهاتف
local AllMarkers = getElementsByType("marker",resourceRoot)
for i, v in pairs(AllMarkers) do
  local x,y,z = getElementPosition(AllMarkers[i])
  destroyElement(AllMarkers[i])
  table.insert(MarkerLoc, {x, y, z,"phonebooth"})
end

------------------------------------------------معلومات المهمة الهدف و السيارات-----------------------------------
local usedTargets = {}
local TargetLoc = {}
local TargetSkins = {12,20,37,68,17,150,187,186,215,216,228,223} -- سكن الهجف
local AllPeds = getElementsByType("ped",resourceRoot)
for i, v in pairs(AllPeds) do
  local x,y,z = getElementPosition(AllPeds[i])
  destroyElement(AllPeds[i])
  table.insert(TargetLoc, {x, y, z})
end

local usedCars = {}
local CarsLoc = {}
local CarsSkins = {580,482,451,434,408,442} -- سكن السيارات
local AllCars = getElementsByType("vehicle",resourceRoot)
for i, v in pairs(AllCars) do
  local x,y,z = getElementPosition(AllCars[i])
  destroyElement(AllCars[i])
  table.insert(CarsLoc, {x, y, z})
end
-----------------------------------------------------------------------------------------------------------------------


----------------------------------------------------تحديث موقع علامة الهاتف------------------------------------------------------
function MarkerUpdate()
  local Loc = MarkerLoc [ math.random ( #MarkerLoc ) ]
  Marker = createMarker(Loc[1],Loc[2],Loc[3],"cylinder",1,255,0,0,100)
  local Col = createColSphere(Loc[1],Loc[2],Loc[3],30)
  setElementID(Marker,Loc[4])
  setElementID(Col,Loc[4])
  setElementParent(Col,Marker)
  triggerClientEvent("PhoneBlip",root,"Make",Loc[1],Loc[2])
end
MarkerUpdate()

function MikeBlipFor(ped,Leader,Siz)  ---- اصنع علامة للهدف
  local Blip = createBlipAttachedTo(ped,0,Siz,255,0,0,250,10,5000,resourceRoot)
  setElementVisibleTo(Blip, Leader, true)
  setElementParent(Blip,ped)
end

---------------------------------------------------اذا دخل اللاعب في العلامات----------------------------------------------------
addEventHandler("onColShapeHit",resourceRoot,function (hitElement)
   local Leader = getElementData(source,"Col_data")
  if getElementType(hitElement) == "player" and (getElementID(source) == "phonebooth") then
    local x,y,z = getElementPosition(source)
    triggerClientEvent("PlaySoundPhone",hitElement,x,y,z)
  elseif hitElement == Leader and (getElementID(source) == "kill") then
    local x,y,z = getElementPosition(source)
    destroyElement(source)
    killingMission(hitElement,x,y,z)
  elseif hitElement == Leader and (getElementID(source) == "car") then
    local x,y,z = getElementPosition(source)
    destroyElement(source)
    CarMission(hitElement,x,y,z)
  end
end)

addEventHandler("onColShapeLeave",resourceRoot,function (hitElement)
  if getElementType(hitElement) == "player" and (getElementID(source) == "phonebooth") then
       triggerClientEvent("PlaySoundPhone",hitElement,0,0,-1000)
  end
end)

addEventHandler("onMarkerHit",resourceRoot,function (hitElement)
  if (getElementType( hitElement ) == "player") and (isPedInVehicle(hitElement) == false) and (getElementID(source) == "phonebooth") and (getElementData(hitElement,"Mission") == 0) then
    setElementData(hitElement,"Mission",1)
    outputChatBox("انت في مهمة")
    triggerClientEvent("MissionPhoneStart",hitElement)
    destroyElement(source)
    triggerClientEvent("PlaySoundPhone",hitElement,0,0,-1000)
    triggerClientEvent("PhoneBlip",root,"delete")
    setTimer(StartMission,5000,1,hitElement)
  end
end)

----------------------------------------------------------------------------------------------------------------
function tableContains(tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
    return false
end

function StartMission(Leader) -----------عند بداية المهمة
  math.randomseed(getTickCount())
  local Type = MissionTypes [ math.random ( #MissionTypes ) ]
  outputChatBox(Type)
  if Type == "kill" then
    if #usedTargets == #TargetLoc then
        usedTargets = {}
    end
    local coordIndex
    local newCoord
    repeat  -- loop until a non-duplicate coordinate is found
        coordIndex = math.random(#TargetLoc) -- randomly select a coordinate index from the available coordinates
        newCoord = TargetLoc[coordIndex]
    until not tableContains(usedTargets, newCoord)
    table.insert(usedTargets, newCoord) -- add the new coordinate to the list of used coordinates
    
    local Col = createColSphere(newCoord[1], newCoord[2], newCoord[3],80)
    setElementID(Col,Type)
    setElementParent(Col,Leader)
    MikeBlipFor(Col,Leader,3)
    setElementData(Col,"Col_data",Leader)
    setElementData(Leader,"Leader_data",Col)
  elseif Type == "car" then
    if #usedCars == #CarsLoc then
        usedCars = {}
    end
    local coordIndex
    local newCoord
    repeat  -- loop until a non-duplicate coordinate is found
        coordIndex = math.random(#CarsLoc) -- randomly select a coordinate index from the available coordinates
        newCoord = CarsLoc[coordIndex]
    until not tableContains(usedCars, newCoord)
    table.insert(usedCars, newCoord) -- add the new coordinate to the list of used coordinates
    local Loc = CarsLoc [ math.random ( #CarsLoc ) ]
    
    local Col = createColSphere(newCoord[1], newCoord[2], newCoord[3],80)
    setElementID(Col,Type)
    setElementParent(Col,Leader)
    MikeBlipFor(Col,Leader,3)
    setElementData(Col,"Col_data",Leader)
    setElementData(Leader,"Leader_data",Col)
  end
  setTimer(MarkerUpdate,(60*1000)*PhoneTime,1)
  Timers[Leader] = setTimer(TimeEnd,(60*1000)*MissionTime, 1,Leader)
end

function killingMission(Leader,x,y,z) ------ مهمة قتل
  outputChatBox("killingMission")
  local Skin = TargetSkins [ math.random ( #TargetSkins ) ]
  local Target = createPed(Skin,x,y,z)
  setElementFrozen(Target,true)
  MikeBlipFor(Target,Leader,1)
  setElementData(Target,"Target_data",Leader)
  setElementData(Leader,"Leader_data",Target)
end

function CarMission(Leader,x,y,z) --- مهمة تفجير سيارة
  outputChatBox("CarMission")
  local Loc = CarsLoc [ math.random ( #CarsLoc ) ]
  local Skin = CarsSkins [ math.random ( #CarsSkins ) ]
  local car = createVehicle(Skin,x,y,z)
  setTimer(setElementFrozen,1000,1,car,true)
  setVehicleLocked(car,true)
  MikeBlipFor(car,Leader,1)
  setElementData(car,"car_data",Leader)
  setElementData(Leader,"Leader_data",car)
end

--------------------------------------أسباب الفوز---------------------------------------------
addEventHandler("onPedWasted", resourceRoot,function (Ammo,killer)  ----- عند موت الهدف
  if getElementData(source,"Target_data") then
    local Leader = getElementData(source,"Target_data")
    local Money = PhoneMoney [ math.random ( 1,#PhoneMoney ) ]
    triggerClientEvent("MissionPassed",Leader ,"passed_3",Money)
    givePlayerMoney(Leader,Money)
    setElementData(Leader,"Mission",0)
    if isTimer(Timers[Leader]) then
      local TheTimer = Timers[Leader]
      killTimer(TheTimer)
      Timers[Leader] = nil
    end
  end
  local Stars = getPlayerWantedLevel(killer)
  if (Stars < 4) and (getElementType( killer ) == "player") then
    setPlayerWantedLevel(killer,Stars + 2)
  end
  setTimer(destroyElement,5000,1,source)
end)

addEventHandler("onVehicleExplode", resourceRoot,function ()  ---- عند انفجار السيارة
  if getElementData(source,"car_data") then
    local Leader = getElementData(source,"car_data")
    local Money = PhoneMoney [ math.random ( 1,#PhoneMoney ) ]
      triggerClientEvent("MissionPassed",Leader,"passed_Vic",3000)
      givePlayerMoney(Leader,Money)
      setElementData(Leader,"Mission",0)
    if isTimer(Timers[Leader]) then
      local TheTimer = Timers[Leader]
      killTimer(TheTimer)
      Timers[Leader] = nil
    end
    local Stars = getPlayerWantedLevel(Leader)
    if (Stars < 4) and (getElementType( Leader ) == "player") then
      setPlayerWantedLevel(Leader,Stars + 2)
    end
  end 
  setTimer(destroyElement,5000,1,source)
end)

------------------------------------أسباب الخسارة------------------------------------------------

addEventHandler("onPlayerWasted",root,function()  --- اذا مات اللاعب
  if getElementData(source,"Leader_data") then
    local Element = getElementData(source,"Leader_data")
    destroyElement(Element)
    triggerClientEvent("MissionPassed",source,"failed",nil,"")
    setElementData(source,"Mission",0)
    if isTimer(Timers[source]) then
      local TheTimer = Timers[source]
      killTimer(TheTimer)
      Timers[source] = nil
    end
  end
end)


function TimeEnd(Leader) ---- اذا انتهى الوقت
  if getElementData(Leader,"Leader_data") then
    setElementData(Leader,"Mission",0)
    outputChatBox("TimeEnd")
    local Element = getElementData(Leader,"Leader_data")
    destroyElement(Element)
    triggerClientEvent("MissionPassed",Leader,"failed",nil,"")
  end
end

-------------------------------------------------------------------------------------------------

addEventHandler("onPlayerSpawn",root,function()  
  local x,y,z = getElementPosition(Marker)
  triggerClientEvent("PhoneBlip",source,"Make",x,y)
end)


function onPedSeePlayer(thePlayer)
   if (getElementType(thePlayer) == "player") then
      setPedAnimation(source, "FIGHT_B", "FightB_React_Left", -1, false, true, false, false)
      setPedControlState(source, "forwards", true)
      setPedControlState(source, "fire", true)
   end
end
addEventHandler("onPedSeePlayer", resourceRoot, onPedSeePlayer)