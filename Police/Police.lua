local interiors = {
  {1555.59, -1675.59, 16.20, "corona", 0, 0, "basePoliceIn"},
  {246.80, 62.20, 1003.6, "corona", 0, 6, "basePoliceOut"},

  {1565, -1683.9, 28.4, "corona", 0, 0, "basePoliceIn2"},
  {246.4, 88.45, 1003.6, "corona", 0, 6, "basePoliceOut2"},
  
  {1568.65, -1689.5, 6.2, "corona", 0, 0, "basePoliceIn3"},
  {241.9, 66.35, 1003.7, "corona", 0, 6, "basePoliceOut3"}
} 

for i, interior in ipairs(interiors) do
  local marker = createMarker(interior[1], interior[2], interior[3], interior[4], 1, 255, 0, 0, interior[5])
  setElementInterior(marker, interior[6])
  setElementID(marker, interior[7])
end

local interiorMeta = {
  ["basePoliceIn"] = {interior = {6, 246.800, 64.699, 1003.59,0}},
  ["basePoliceOut"] = {interior = {0, 1552.59, -1675.59, 16.20,90}},
  ["basePoliceIn2"] = {interior = {6, 246.4, 86.4, 1003.6,180}},
  ["basePoliceOut2"] = {interior = {0, 1565.1, -1686, 28.4,180}},
  ["basePoliceIn3"] = {interior = {6, 244.3, 66.3, 1003.6,-90}},
  ["basePoliceOut3"] = {interior = {0, 1568.6, -1692.4, 5.9,180}}
} 


addEventHandler("onMarkerHit", resourceRoot, function(player)
  if getElementType(player) == "player" and not isPedInVehicle(player) then
    local id = getElementID(source)
    if getMarkerType(source) == "corona" and getPlayerTeam(player) == getTeamFromName("Police") then
      local interior = interiorMeta[id].interior
      setElementInterior(player, interior[1], interior[2], interior[3], interior[4])
      setElementRotation(player,0,0,interior[5])
    end
  end
end)


-- اعطاء نجوم للغريب اذا دخل مركز الشرطة
local wantedCol = createColCuboid(1582, -1641.5, 12.3, 12, 3, 5)

addEventHandler("onColShapeHit", wantedCol,function (player)
  if getElementType(player) ~= "player" then
    return
  end
  local playerTeam = getPlayerTeam(player)
  if not playerTeam or getTeamName(playerTeam) ~= "Police" then
    if getPlayerWantedLevel(player) < 2 then
      setPlayerWantedLevel(player, 2)
      exports ["info_Text"]:InfoText(player,"أنت لست من الشرطة ممنوع الدخول ستعاقب",10000)
    end
  end
end)