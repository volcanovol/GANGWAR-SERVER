local prisonTimers = {}


local prisonTimeMeta = {
  [1] = {prisonTime = (60*1000)*0.5},
  [2] = {prisonTime = (60*1000)*1},
  [3] = {prisonTime = (60*1000)*3},
  [4] = {prisonTime = (60*1000)*4},
  [5] = {prisonTime = (60*1000)*5},
  [6] = {prisonTime = (60*1000)*6}
}


function formatTime(time)
  local seconds = math.floor((time / 1000) % 60)
  local minutes = math.floor((time / (1000 * 60)) % 60)
  local hours = math.floor((time / (1000 * 60 * 60)) % 24)
  return string.format("%02d:%02d:%02d", hours, minutes, seconds)
end


function getPrisonLocation(Level)
  local prisonSpawn = {}
  if Level == 1 then
    prisonSpawn = {
      {264, 78.8, 1001, 180,6},
      {264, 77.5, 1001, 180,6},
      {264, 76.5, 1001, 180,6}
    }
  elseif Level > 1 then
    prisonSpawn = {
      {353.2, 224, 947.8, 180,7},
      {350.2, 224, 947.8, 180,7},
      {356, 224, 947.8, 180,7}
    }
  end

  local location = prisonSpawn[math.random(#prisonSpawn)]
  return location
end



function sendPlayerToPrison(player)
  local account = getPlayerAccount(player)
  if not account then
    return true
  end
  local Level = getPlayerWantedLevel(player)
  if Level > 0 then
  local skin = getElementModel(player)
  local location = getPrisonLocation(Level)
  local prisonTime = prisonTimeMeta[Level].prisonTime
  spawnPlayer(player, location[1], location[2], location[3], location[4], skin, location[5])
  prisonTimers[player] = setTimer(function() if isElement(player) then spawnPlayer(player, 1544.3, -1675.6, 13.6, 90, skin) end end, prisonTime, 1)
  setPlayerWantedLevel(player, 0)
  setAccountData(account, "prisonTimeDate", os.time())
  setAccountData(account, "prisonTime", prisonTime)
  local message = ("تم وضعك في السجن. الوقت المتبقي: " .. formatTime(prisonTime))
  exports ["info_Text"]:InfoText(player,message,10000)
  end
end


addEventHandler("onPlayerLogin", root, function()
  local player = source
  local account = getPlayerAccount(player)
  if not account then
    return true
  end
  local remainingTime = getAccountData(account, "prisonTime") or 0
  if remainingTime > 0 then
    local skin = getElementModel(player)
    prisonTimers[player] = setTimer(function() if isElement(player) then spawnPlayer(player, 1544.3, -1675.6, 13.6, 90, skin) end end, remainingTime, 1)
    local message = ("أنت في السجن. الوقت المتبقي: " .. formatTime(remainingTime))
    exports ["info_Text"]:InfoText(player,message,10000)
    setAccountData(account, "prisonTimeDate", os.time())
    setAccountData(account, "prisonTime", remainingTime)
  end
end)


addEventHandler("onPlayerQuit", root,function()
  local account = getPlayerAccount(source)
  if not account then
    return true
  end
  local lastPrisonTimeDate = getAccountData(account, "prisonTimeDate") or 0
  local prisonTime = getAccountData(account, "prisonTime") or 0
  local currentTime = getRealTime().timestamp
  local remainingTime = prisonTime - (currentTime - lastPrisonTimeDate) * 1000 - 1000
  setAccountData(account, "prisonTime", remainingTime)
  setAccountData(account, "prisonTimeDate", currentTime)
  if remainingTime > 0 and isTimer(prisonTimers[source]) then
    killTimer(prisonTimers[source])
    prisonTimers[source] = nil
  end
end)


local colData = {
    {262.3, 75.5, 1000, 3.9, 4.5, 5},
    {313.1, 130.3, 946.5, 85, 100, 8}
}

for i, data in ipairs(colData) do
    local col = createColCuboid(unpack(data))
    setElementID(col, "PrisonCol")
end

addEventHandler("onColShapeHit", resourceRoot,function (player)
    if getElementID(source) == "PrisonCol" and getElementType( player ) == "player" and not isPedInVehicle(player) then
      local account = getPlayerAccount(player)
      if not account then
        return true
      end
      local prisonTime = getAccountData(account, "prisonTime") or 0
      if prisonTime <= 0 then
        setElementInterior(player,0,1544.3, -1675.6, 13.6)
      end
    end
end)




local mark = createMarker(1536.3,-1655.7,13,"cylinder",2,0,0,255,100)
addEventHandler("onMarkerHit",mark,function(player)
  --  if not getPlayerWantedLevel(player) == 0 then
      sendPlayerToPrison(player)
  --  end
end)
