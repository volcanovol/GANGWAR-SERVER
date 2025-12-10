
local ColCuboid = {
  {2557.6,-1286.6,2,4.5,2,"Step1WeapJob"},
  {2549.6,-1286.6,2,4.5,2,"Step1WeapJob"},
  {2549.7,-1305.2,2,4.5,2,"Step1WeapJob"},
  {2557.3,-1305.2,2,4.5,2,"Step1WeapJob"},
  {2552.7,-1296,7,1.5,2,"Step2WeapJob"},
  {2552.7,-1292,7,1.5,2,"Step2WeapJob"},
  {2564.6,-1295.3,2,4.5,2,"DeliverWeapJob"},
  {2531,-1307.5,40,30,10,"StopWeapJob"}
} 

for i, v in pairs(ColCuboid) do
  local Col = createColCuboid(ColCuboid[i][1],ColCuboid[i][2],1043,ColCuboid[i][3],ColCuboid[i][4],ColCuboid[i][5])
  setElementInterior(Col,2)
  setElementDimension(Col,1)
  setElementID(Col,ColCuboid[i][6])
end


local Markers = {
  {2567.7, -1281, 1043.15, "StartWeapJob"}
} 

for _, MarkerData in ipairs(Markers) do
  local Marker = createMarker(MarkerData[1], MarkerData[2], MarkerData[3], "cylinder", 1,0,0,0,0)
  setElementInterior(Marker, 2)
  setElementID(Marker, MarkerData[4])
end


addEvent("StartWorkingWeapJob", true)
addEventHandler("StartWorkingWeapJob", getRootElement(), function ()
    setElementData(client,"Weapons_Factory","Step1WeapJob")
    triggerClientEvent(client,"StartTutoWorkingWeapJob",client)
end)



local WeapJobMeta = {
    ["Step1WeapJob"]={TimeFroz = 5000,ID = "Step2WeapJob",Rot = -90,Animation = {"casino", "slot_bet_01","CARRY", "crry_prtial"}},
    ["Step2WeapJob"]={TimeFroz = 10000,ID = "DeliverWeapJob",Rot = nil,Animation = {"casino", "slot_bet_01","CARRY", "crry_prtial"}},
    ["DeliverWeapJob"]={TimeFroz = 1000,ID = "Step1WeapJob",Rot = -90,Animation = {"CARRY", "putdwn",nil, nil}}
}

addEventHandler("onColShapeHit", resourceRoot, function(player)
  local ColID = getElementID(source)
  local PlayerID = getElementData(player, "Weapons_Factory")
  if ColID == PlayerID then
    local jobMeta = WeapJobMeta[ColID]
    local ID = jobMeta.ID
    local TimeFroz = jobMeta.TimeFroz
    local Rot = jobMeta.Rot
    local Animation = jobMeta.Animation
    triggerClientEvent(player, "PlayerisWorkingWeapJob", player, ColID, TimeFroz, Rot)
    setElementData(player, "Weapons_Factory", ID)
    setPedWeaponSlot(player, 0)
    setElementFrozen(player, true)
    setPedAnimation(player, Animation[1], Animation[2], -1, true, false, false, true)
    setTimer(setElementFrozen, TimeFroz, 1, player, false)
    setTimer(setPedAnimation, TimeFroz, 1, player, Animation[3], Animation[4], 1, true, false, false, true)
    if ColID == "DeliverWeapJob" then
      local playerTeam = getPlayerTeam(player)
      local TeamName = getTeamName(playerTeam)
      UpgradeArmory(TeamName,1)
      givePlayerMoney(player,50)
    end
  end
end)



addEventHandler("onColShapeLeave", resourceRoot, function(player)
    if getElementID(source) == "StopWeapJob" and getElementData(player, "Weapons_Factory") then
      setElementData(player, "Weapons_Factory", false)
      triggerClientEvent(player,"StopWorkingWeapJob",player)
    end
end)