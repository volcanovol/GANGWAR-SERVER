--صناعة علامات تسليم المسروقات
local MarkerGang = {
  {2445.6, -1761.8, 12.6, "Grove Street"},
  {1997.6, -1092.5, 23.8, "Ballas"}
}

for i, markerData in ipairs(MarkerGang) do
  local x, y, z, id = markerData[1], markerData[2], markerData[3], markerData[4]
  local marker = createMarker(x, y, z, "cylinder", 5, 255, 0, 0, 50)
  setElementID(marker, id)
end


--مراجعة المسروقات و تحديد الاسعار
function GangLootReward(player, vehicle, vehicleData, teamName)
  local rewards = {
    ["WeaponTruck"] = 1000,
    ["DrugTruck"] = 2000,
    ["MoneyTruck"] = 3000,
    ["LuxuryCar"] = 3000,
    ["SportsCar"] = 2000
  }

  local reward = rewards[vehicleData]
  outputChatBox(reward)
  if not reward then
    return
  end

  givePlayerMoney(player, reward)

  if vehicleData == "WeaponTruck" then
    exports["Gang_Weapons"]:UpgradeArmory(teamName, 100)
  end
  DeleteAndSpawnVehicle(vehicle,vehicleData)
end


function getPlayerTeamName(player)
  local playerTeam = getPlayerTeam(player)
  return playerTeam and getTeamName(playerTeam) or false
end

-- عند تسليم المسروقات
addEventHandler("onMarkerHit", resourceRoot, function(player)
  if isElement(player) and getElementType(player) == "player" and isPedInVehicle(player) then
    local markerID = getElementID(source)
    local teamName = getPlayerTeamName(player)

    if teamName == markerID then
      local vehicle = getPedOccupiedVehicle(player)
      local vehicleData = getElementData(vehicle, "gangLoot")
      GangLootReward(player, vehicle, vehicleData, teamName)
    else
      exports["info_Text"]:InfoText(player, "لا يمكنك تسليم المسروقات لأنك لست من العصابة", 10000)
    end
  end
end)

