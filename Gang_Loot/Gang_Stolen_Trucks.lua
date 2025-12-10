local MinutesRes = 0.2
local Timers = {}
local weaponTruckPosition = {}
--local weaponTruckPosition = {{2456.6,-1784.9,14.1,0},{2464.5,-1784.6,14.1,0},{2475.4,-1785.1,14.1,0}}

for i, vehicle in ipairs(getElementsByType("vehicle", resourceRoot)) do
  local x, y, z = getElementPosition(vehicle)
  local xr, yr, zr = getElementRotation(vehicle)
  local id = getElementModel(vehicle)

  if id == 455 then
    table.insert(weaponTruckPosition, {x, y, z, zr})
  end

  destroyElement(vehicle)
end


function AttachToVehicle(Son,Mother,x,y,w) ----ربط مع المركبة
  attachElements(Son,Mother,x,y,w,0,0,0)
  setElementParent(Son,Mother)
end


function SpawnTrucks(vehiclePosition, blipID, vehicleModel, vehicleID, r, g, b, botList)
  if #vehiclePosition > 0 then
    local i = math.random(1, #vehiclePosition)
    local x, y, z, zr = vehiclePosition[i][1], vehiclePosition[i][2], vehiclePosition[i][3], vehiclePosition[i][4]
    
    local vehicle = createVehicle(vehicleModel, x, y, z, 0, 0, zr)
    
    local coordinates = {x = x, y = y, z = z, zr = zr}
    setElementData(vehicle, "WeaponTruckLoc", toJSON(coordinates))
    table.remove(vehiclePosition, i)
    
    setElementData(vehicle, "gangLoot", vehicleID)
    
    if r ~= nil then
        setVehicleColor(vehicle, r, g, b)
    end

    local blip = createBlipAttachedTo(vehicle,blipID,2,0,0,0,250,0,300)
    setElementParent(blip,vehicle)
    setElementFrozen(vehicle,true)
    --BotGuards(vehicle, botList)
  end
end

function DeleteAndSpawnVehicle(vehicle, vehicleData)
    if vehicleData == "WeaponTruck" then
        setTimer(function() SpawnTrucks(weaponTruckPosition, 51, 455, "WeaponTruck", 97, 94, 62, 1) end,5000,1)
        
        local myTableData = fromJSON(getElementData(vehicle, "WeaponTruckLoc"))
        table.insert(weaponTruckPosition, {myTableData.x, myTableData.y, myTableData.z, myTableData.zr})
        destroyElement(vehicle)
    end
end

for i = 1, 2 do
    SpawnTrucks(weaponTruckPosition, 51, 455, "WeaponTruck", 97, 94, 62, 1)
end




function isVehicleEmpty( vehicle ) ----- هل المركبة فارغة؟
	if not isElement( vehicle ) or getElementType( vehicle ) ~= "vehicle" then
		return true
	end
	return not (next(getVehicleOccupants(vehicle)) and true or false)
end

addEventHandler("onVehicleExplode",resourceRoot,function () -- عند انفجار المركبة احذفها و اصنع جديدة
    local vehicle = source
    local vehicleData = getElementData(vehicle,"gangLoot")
    setTimer(function() DeleteAndSpawnVehicle(vehicle,vehicleData) end,5000,1)
end)


addEventHandler("onVehicleEnter", resourceRoot, -- عند دخول اللاعب الى المركبة  عطل مؤقت الرسبون ثم أحذف العلامة من الخريطة
function ()
  if isElement(source) then
    if isElementFrozen(source) then setElementFrozen(source,false) end
    if isTimer(Timers[source]) then
      local TheTimer = Timers[source]
      killTimer(TheTimer)
      Timers[source] = nil
    end
  end
end)

addEventHandler("onVehicleExit", resourceRoot, -- عند خروج اللاعب من المركبة فعل مؤقت الرسبون
function ()
  if isVehicleEmpty(source) then
    vehicle = source
    local vehicleData = getElementData(vehicle,"gangLoot")
    Timers[source] = setTimer(function() DeleteAndSpawnVehicle(vehicle, vehicleData) end,(60*1000)*MinutesRes, 1)
  end
end)