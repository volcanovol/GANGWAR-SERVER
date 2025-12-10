--الماركر للدخول و الخروج
local BaseMark = {
  {2528.0, -1289.50, 1030.60, "cylinder", 1, 0, 0, 0, 100, "Short", 2},
  {2580.89, -1285.30, 1043.3, "cylinder", 1, 0, 0, 0, 100, "Short", 2},
  {2521.1, -1281.8, 1053.7, "cylinder", 1, 0, 0, 0, 100, "Short", 2},
  {2541.30, -1304, 1025.099, "corona", 1, 0, 0, 0, 100, "OutMark", 2},
  {1910.4, -1127.5, 23.75, "cylinder", 2, 160, 32, 240, 50, "InMarkBallas", 0},
  {2499.2, -1685.4, 12.5, "cylinder", 2, 0, 255, 0, 50, "InMarkGrove", 0}
}

for i, v in ipairs(BaseMark) do
  local Marker = createMarker(v[1], v[2], v[3], v[4], v[5], v[6], v[7], v[8], v[9])
  setElementID(Marker, v[10])
  setElementInterior(Marker, v[11])
end

function getPlayerTeamName(player)
  local team = getPlayerTeam(player)
  return team and getTeamName(team) or false
end

addEventHandler("onMarkerHit", resourceRoot, function(hitElement)
    local markerType = getMarkerType(source)
    if getElementType(hitElement) == "player" and not isPedInVehicle(hitElement) then
        local teamName = getPlayerTeamName(hitElement)
        local id = getElementID(source)

        if markerType == "corona" then
            if teamName == "Ballas" then
                setElementInterior(hitElement, 0, 1910.6, -1130.2, 24.7)
                setElementRotation(hitElement,0,0,180)
            elseif teamName == "Grove Street" then
                setElementInterior(hitElement, 0, 2499.3, -1681, 13.4)
                setElementRotation(hitElement,0,0,0)
            end
            setElementDimension(hitElement, 0)
        elseif markerType == "cylinder" then
            if id == "Short" or (id == "InMarkGrove" and teamName == "Grove Street") or (id == "InMarkBallas" and teamName == "Ballas") then
                triggerClientEvent(hitElement, "ShowPlayerMap", hitElement)
            else
                triggerClientEvent(hitElement, "InfoText", hitElement, "لا يمكنك الدخول الى هنا انت لست من العصابة", 10000)
            end
        end
    end
end)


--بعد ان يختار اللاعب مكان السبون
local BaseSpawnMeta = {
    {2581, -1300.4, 1061,90},
    {2519, -1286, 1054.6,-90},
    {2581.3, -1290, 1044.1,90},
    {2526.2, -1293.8, 1031.45,-90},
    {2544.6, -1304.1, 1025.1,90}
}

addEvent("SpawnInBase", true)
addEventHandler("SpawnInBase", getRootElement(), function(loc)
    local TeamName = getPlayerTeamName(source)
    local Dimension = TeamName == "Ballas" and 2 or TeamName == "Grove Street" and 1
    local BaseSpawn = BaseSpawnMeta[loc]
    if Dimension then
        setElementPosition(source, BaseSpawn[1], BaseSpawn[2], BaseSpawn[3])
        setElementRotation(source,0,0,BaseSpawn[4])
        setElementInterior(source, 2)
        setElementDimension(source, Dimension)
    end
end)

