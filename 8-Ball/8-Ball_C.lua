local Spam = true

local GarageMeta = {
    ["8-Ball"]={Garage=3}
}

exports.customblips:createCustomBlip ( 1846.80, -1856.40, 16, 16,"radar_bomb.png",350) 
setGarageOpen(3,true)
engineImportTXD(engineLoadTXD('8-Ball.txd'), 183)
engineReplaceModel(engineLoadDFF('8-Ball.dff', 183), 183)


-- شخصية جانبية
local PedBack = { 
  {183,1842.80,-1852,13.39,90,0,"crack","bbalbat_idle_02"},
}

for k,v in pairs(PedBack) do
  local Ped = createPed(PedBack[k][1],PedBack[k][2],PedBack[k][3],PedBack[k][4],PedBack[k][5])
  setElementInterior(Ped,PedBack[k][6])
  setElementFrozen(Ped,true)
  setPedAnimation(Ped,PedBack[k][7] ,PedBack[k][8], -1, true, false, false, true)
end

addEventHandler("onClientPedDamage",resourceRoot,function ()
    cancelEvent() 
end)


addEvent("8-BallStart", true)
addEventHandler("8-BallStart", localPlayer,function (ID)
  local car = getPedOccupiedVehicle(localPlayer)
  setElementFrozen(car,true)
  setTimer(setElementFrozen,4500,1,car,false)
  playSFX("script", 150, 0, false)
  local Garage = GarageMeta[ID].Garage
  setGarageOpen(Garage,false)
  setTimer(setGarageOpen,4000,1,Garage,true)
  exports ["info_Text"]:InfoText("تم تركيب القنبلة بنجاح",5000)
end)


bindKey("lalt", "down",function ()
  if isPedInVehicle(localPlayer) and Spam then
    local Car = getPedOccupiedVehicle(localPlayer)
    if getElementData(Car,"8-Ball_Explosive_Car") then
      triggerServerEvent("ActivateBomb",localPlayer)
      playSFX("script", 217, 0, false)
      exports ["info_Text"]:InfoText("تم تفعيل القنبلة ستنفجر بعد 10 ثواني",5000)
    end
    Spam = false
    setTimer(function () Spam = true end,3000,1)
  end
end)

addEvent("8-BallNoMonry", true)
addEventHandler("8-BallNoMonry", localPlayer,function (price)
  local car = getPedOccupiedVehicle(localPlayer)
  setElementFrozen(car,true)
  setTimer(setElementFrozen,1000,1,car,false)
  exports ["info_Text"]:InfoText("دولار"..price.."أنت لا تملك ما يكفي من المال تحتاج الى",5000)
end)