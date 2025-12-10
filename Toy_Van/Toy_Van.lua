local Timers = {}
local respawnTime = 20 -- وقت إعادة ظهور الشاحنات
local explodTime = 3
local price = 500

local ToyMeta = {
    ["ToyVanCar"] = 441,
    ["ToyVanPlen"] = 464,
    ["ToyVanHel"] = 465
}

local toyVans = {
    {2741.69, -1851.09, 9.69, 1, "ToyVanCar"},
    {2792.5, -1428.69, 40.15, 3, "ToyVanPlen"},
    {1979.09, -2211.80, 13.63, 2, "ToyVanHel"}
}

for _, vanInfo in ipairs(toyVans) do
    local van = createVehicle(459, vanInfo[1], vanInfo[2], vanInfo[3], 0, 0,0, "Toy Van")
    --local blip = createBlip(vanInfo[1], vanInfo[2], vanInfo[3], 0, 2, 255, 0, 0, 255)
    --setElementParent(blip, van)
    setVehicleColor(van, vanInfo[4], 0, 0, 0)
    setVehicleDamageProof(van, true)
    setElementFrozen(van, true)
    setElementID(van, vanInfo[5])
end

  
--اعادة نشر الشاحنات كل فترة
local vanPositions = {
    {"ToyVanCar", 2741.69, -1851.09, 9.69, 0},
    {"ToyVanCar", 1598.5, -1779.5, 13.56, 0},
    {"ToyVanCar", 1913.90, -1414.5, 13.64, 90},
    {"ToyVanPlen", 2792.5, -1428.69, 40.15, 0},
    {"ToyVanPlen", 2260.30, -1103.69, 38.04, 64},
    {"ToyVanPlen", 1659.40, -1695, 20.54, 360},
    {"ToyVanHel", 1979.09, -2211.80, 13.63, 0},
    {"ToyVanHel", 1206.69, -978.90, 43.56, 0},
    {"ToyVanHel", 1032.30, -1929.30, 13.03, 180},
}

local function respawnVehicles()
    for _, position in ipairs(vanPositions) do
        local id, x, y, z, rz = unpack(position)
        local van = getElementByID(id)
        setElementPosition(van, x, y, z)
        setElementRotation(van, 0, 0, rz)
    end
    setTimer(respawnVehicles, (60*1000)*respawnTime, 1)
end

setTimer(respawnVehicles, (60*1000)*respawnTime, 1)


-- امر بتفجير اللعبة و طرد اللاعب
function ExplodVehicle(player)
    if isTimer(Timers[player]) then
      local TheTimer = Timers[player]
      killTimer(TheTimer)
      Timers[player] = nil
      
      triggerClientEvent(player,"toyCarExplod",player)
      local ToyCar = getPedOccupiedVehicle(player)
      removePedFromVehicle (player)
      local toyCorona = getElementData(player,"RespawnToyVan")
      local x,y,z = getElementPosition(toyCorona)
      setElementPosition(player,x,y,z + 0.2)
      setElementFrozen(ToyCar,true)
      local xt, yt, zt = getElementPosition(ToyCar)
      setTimer(createExplosion,200,1,xt, yt, zt,0,player)
      setTimer(function () setElementAlpha (player,255) setElementFrozen(player,false) destroyElement(toyCorona)  destroyElement(ToyCar) end,3000,1)
    end
end

addEvent("ExplodVehicle", true)
addEventHandler("ExplodVehicle", getRootElement(),function () local player = client ExplodVehicle(player) end)


-- سبون اللعبة و ادخال اللاعب فيها
function spawnToyVanCar(player, toyId,x,y,z)
    setElementAlpha(player,0)
    local ToyCar = createVehicle(toyId, x, y, z)
    setElementID(ToyCar,"ToyCar")
    setElementData(ToyCar,"ToyCar",true)
    warpPedIntoVehicle(player,ToyCar)
    setVehicleLocked(ToyCar,true)
    setVehicleDamageProof(ToyCar,true)
    
    Timers[player] = setTimer(ExplodVehicle,(60*1000)*explodTime, 1,player,ToyCar,x,y,z)
    triggerClientEvent(player,"toyCarSpawn",player)
end


addEventHandler("onVehicleEnter", resourceRoot, function(player)
    if getPlayerMoney(player) >= price and getElementModel(source) == 459 then
      takePlayerMoney(player, price)
      setElementFrozen(player, true)
      local toyId = ToyMeta[getElementID(source)]
      local toyCorona = createMarker(0, 0, 0, "corona", 1, 255, 255, 0, 0)
      attachElements(toyCorona, source, 0, -4, -0.5)
      local x,y,z = getElementPosition(toyCorona)
      setElementData(player,"RespawnToyVan",toyCorona)
      spawnToyVanCar(player, toyId,x,y,z)
    else
      exports ["info_Text"]:InfoText(player," أنت لا تملك ما يكفي من المال تحتاج الى ".. price .." دولار ",10000)
      removePedFromVehicle(player)
    end
end)


-- منع اللاعب من الخروج أو الدخول الى المركبة
function exitingVehicle()
  if getElementID(source) == "ToyCar" then
    cancelEvent()
  end
end
addEventHandler("onVehicleStartEnter", resourceRoot, exitingVehicle)
addEventHandler("onVehicleStartExit", resourceRoot, exitingVehicle)
