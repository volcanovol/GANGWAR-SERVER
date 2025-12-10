local MinutesExp = 1
Policevehicle = createMarker(1585.2,-1677.75,4.9,"cylinder",2,0,0,255,50)

addEventHandler("onMarkerHit",Policevehicle,function(player)
    local playerTeam = getPlayerTeam(player)
    if playerTeam then
        local teamName = getTeamName(playerTeam)
        if teamName == "Police" then
          triggerClientEvent(player,"policeVehicleStart",player)
        else
            cancelEvent()
            exports["info_Text"]:InfoText(player, "أنت لست شرطي", 10000)
        end
    else
        cancelEvent()
        exports["info_Text"]:InfoText(player, "أنت لست شرطي", 10000)
    end
end)



addEvent("policeVehicleBuy", true)
addEventHandler("policeVehicleBuy", getRootElement(),function (Price,vehicleListId)
  local money = getPlayerMoney(source)
  if (money >= Price) then
    local oldVehicle = getElementData(client,"policeVehicle")
    if isElement(oldVehicle) then
      destroyElement(oldVehicle)
    end
    takePlayerMoney(source,Price)
    local vehicle = createVehicle(vehicleListId,1600.9,-1684,5.9,0,0,90)
    setElementData(client,"policeVehicle",vehicle)
    warpPedIntoVehicle(client,vehicle)
  end
end)

addEventHandler("onPlayerQuit", getRootElement(),function ()
    local oldVehicle = getElementData(source,"policeVehicle")
    if isElement(oldVehicle) then
      destroyElement(oldVehicle)
    end
end)



local vehicleList = {596, 598, 599, 427, 490, 528, 601}

function isModelInList(model, list)
    for i, v in ipairs(list) do
        if v == model then
            return true
        end
    end
    return false
end

addEventHandler("onVehicleEnter", resourceRoot,function (player, seat, vehicle)
    if seat == 0 and getPlayerTeam(player) ~= getTeamFromName("Police") then
        local model = getElementModel(source)
        if isModelInList(model, vehicleList) then
            setPlayerWantedLevel(player, 2) -- زيادة مستوى الجريمة للشرطة
        end
    end
end)

addEventHandler("onVehicleExplode", resourceRoot,function ()
  setTimer(destroyElement,(60*1000)*MinutesExp, 1, source)
end)
