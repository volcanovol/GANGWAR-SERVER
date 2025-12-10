local Street_Cleaners = {}
local GarbageId = {2670,2672,2673,2674,2675,2676,2677}
local AllMarkers = getElementsByType("marker", resourceRoot)
for i, v in pairs(AllMarkers) do
  local x, y, z = getElementPosition(v)
  local id = getElementID(v)
  if id == "Street_Cleaner" then
    table.insert(Street_Cleaners, {x, y, z, "Street_Cleaner"})
    destroyElement(v)
  end
end

--createJobsClothes(1642.8,-1889.7,13.6,0,0,309)

function CreateCleanerMarker(player)
    local Loc = Street_Cleaners[math.random(#Street_Cleaners)]
    local Marker = createMarker(Loc[1], Loc[2], Loc[3], "cylinder", 3, 255, 0, 0, 0, resourceRoot)
    MakeGarbage(Marker,Loc[1], Loc[2], Loc[3],2)
    setElementID(Marker, Loc[4])
    setElementVisibleTo(Marker, player, true)
    MikeBlipFor(Marker, player, 2)
    setElementData(player, "Street_Cleaner", Marker)
end

function MakeGarbage(Marker, x, y, z, n)
  local GarbageVariant = {0,0,2,1,-1,-2,0.5,-0.5}
  for i = 1, n do
    local id = GarbageId[math.random(#GarbageId)]
    local p = GarbageVariant[math.random(#GarbageVariant)]
    local Garbage = createObject(id, x + p, y + p, z + 0.1, 0, 0, 0, true)
    setElementParent(Garbage,Marker)
  end
end

addEvent("Start_Street_Cleaner_Job", true)
addEventHandler("Start_Street_Cleaner_Job", getRootElement(),function ()
  if (getElementData(source,"Mission") == 0) then
    setElementData(source,"Mission",1)
    CreateCleanerMarker(source)
  end
end)


addEventHandler("onMarkerHit", resourceRoot, function(player)
    local CleanerMarker = getElementData(player, "Street_Cleaner")
    if (CleanerMarker == source and getElementType(player) == "player" and isPedInVehicle(player)) then
        if (getElementID(source) == "Street_Cleaner") then
            destroyElement(source)
            triggerClientEvent(player,"Street_Been_Cleaned", player)
            CreateCleanerMarker(player)
        end
    end
end)


function endStreetCleaner(player)
  if isElement(player) then
    local Marker = getElementData(player,"Street_Cleaner")
    destroyElement(Marker)
    setElementData(player,"Mission",0)
  end
end

