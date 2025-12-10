local Time = 10000
local price = 800

local BallGarag = {
  {1850,-1858.30,12.5,5,5,4,"8-Ball"}
} 

for i, v in pairs(BallGarag) do
  local Garage = createColCuboid(BallGarag[i][1],BallGarag[i][2],BallGarag[i][3],BallGarag[i][4],BallGarag[i][5],BallGarag[i][6])
  setElementID(Garage,BallGarag[i][7])
end

addEventHandler("onColShapeHit",resourceRoot,function (player)
  if (getElementType(player) == "player") and isPedInVehicle(player) then
    local money = getPlayerMoney(player)
    if money >= price then
      takePlayerMoney(player,price)
      local ID = getElementID(source)
      triggerClientEvent(player,"8-BallStart",player,ID)
      local Car = getPedOccupiedVehicle(player)
      setElementData(Car,"8-Ball_Explosive_Car",true)
    else
      triggerClientEvent(player,"8-BallNoMonry",player,price)
    end
  end
end)


addEvent("ActivateBomb", true)
addEventHandler("ActivateBomb", getRootElement(),function ()
  local Car = getPedOccupiedVehicle(client)
  if getElementData(Car,"8-Ball_Explosive_Car") then
    setTimer(blowVehicle,Time,1,Car)
  end
end)