local garages = {8, 11, 12,47}
for _, garage in ipairs(garages) do
  setGarageOpen(garage, true)
end

local blips = {
  {2065.189, -1831.50, 12.5},
  {1911.19, -1776.09, 12.40},
  {2450.80, -1461.09, 22.899},
  {487, -1740.30, 10.20},
  {1025.30, -1023.20, 38.29},
  {720.1, -454.6, 23.2}
}
for _, coords in ipairs(blips) do
  createBlip(coords[1], coords[2], coords[3], 63, 2, 255, 0, 0, 255, 0, 350)
end


local GarageMeta = {
    ["Idlewood"]={Garage=8},
    ["NoDoor"]={Garage=nil},
    ["SantaMaria"]={Garage=12},
    ["Temple"]={Garage=11},
    ["Dillimore"]={Garage=47}
}


addEvent("SprayStart", true)
addEventHandler("SprayStart", localPlayer,function (ID)
  local car = getPedOccupiedVehicle(localPlayer)
  setElementFrozen(car,true)
  local playerX, playerY, playerZ = getElementPosition(localPlayer)
  local SpEfect = createEffect("carwashspray",playerX, playerY, playerZ - 5,0,0,0,0,true)
  setTimer(destroyElement,4000,1,SpEfect)
  setTimer(setElementFrozen,4500,1,car,false)
  setTimer(playSFX,3500,1,"genrl", 52, 9, false)
  playSFX("script", 150, 0, false)
  local Garage = GarageMeta[ID].Garage
  if Garage ~= nil then
    setGarageOpen(Garage,false)
    setTimer(setGarageOpen,4000,1,Garage,true)
  end
end)