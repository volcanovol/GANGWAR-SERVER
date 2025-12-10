local car = createVehicle(525,1829.5,-2045.40,13.5)

local BrokenCarLocs = {}
local BrokenCarId = {549,445,474,605,604,582,478,404,529,467}
local AllVehicles = getElementsByType("vehicle", resourceRoot)
for i, v in pairs(AllVehicles) do
  local x, y, z = getElementPosition(v)
  local xr, yr, zr = getElementRotation(v)
  local id = getElementModel(v)
  if id == 549 then
    table.insert(BrokenCarLocs, {x, y, z,zr, "BrokenCar_Towtruck_Job"})
    destroyElement(v)
  end
end

--createJobsClothes(1765.3,-2040.7,13.5,0,0,50)

function createBrokenCar(player)
  local Loc = BrokenCarLocs[math.random(#BrokenCarLocs)]
  local id = BrokenCarId[math.random(#BrokenCarId)]
  local Vehicle = createVehicle(id,Loc[1],Loc[2],Loc[3],0,0,Loc[4])
  setElementID(Vehicle,Loc[5])
  setElementData(Vehicle,"Towtruck_Job_player",player)
  setElementData(player,"Towtruck_Job_Vehicle",Vehicle)
  setElementHealth(Vehicle,450)
  setVehicleDoorState(Vehicle, 0, 2)
  setVehicleLocked(Vehicle,true)
  setVehicleDamageProof(Vehicle,true)
  MikeBlipFor(Vehicle, player, 2)
end

function createDeliveryMarker(player,Vehicle)
    local Marker = createMarker(1780.29, -2051, 12.6, "cylinder", 5, 255, 0, 0, 100, resourceRoot)
    setElementVisibleTo(Marker, player, true)
    MikeBlipFor(Marker, player, 2)
    setElementParent(Marker,Vehicle)
end


-- بدء المهمة
addEvent("start_Towtruck_Job", true)
addEventHandler("start_Towtruck_Job", getRootElement(), function ()
  if getElementData(source, "Mission") == 0 then
    setElementData(source, "Mission", 1)
    createBrokenCar(source)
  end
end)



function detachTrailer(Vehicle)
  local player = getVehicleController(Vehicle)
  if getElementData(source,"Towtruck_Job_player") == player and getElementID(source) == "BrokenCar_Towtruck_Job" then
    setElementID(source,"Towtruck_Job")
    createDeliveryMarker(player,source)
  end
end
addEventHandler("onTrailerAttach",  resourceRoot, detachTrailer)



addEventHandler("onMarkerHit", resourceRoot, function(Vehicle)
    if getElementType(Vehicle) == "vehicle" and getElementID(Vehicle) == "Towtruck_Job" then
      local player = getElementData(Vehicle, "Towtruck_Job_player")
      destroyElement(Vehicle)
      --destroyElement(source)
      createBrokenCar(player)
    end
end)



function end_Towtruck_Job(player)
  if isElement(player) then
    local Vehicle = getElementData(player,"Towtruck_Job_Vehicle")
    destroyElement(Vehicle)
    setElementData(player,"Mission",0)
  end
end
