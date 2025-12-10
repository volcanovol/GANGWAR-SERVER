local inPrison = false

local colData = {
    {262.3, 75.5, 1000, 3.9, 4.5, 5},
    {313.1, 130.3, 946.5, 85, 100, 8}
}

for i, data in ipairs(colData) do
    local col = createColCuboid(unpack(data))
    setElementID(col, "PrisonCol")
end

addEventHandler("onClientColShapeHit", resourceRoot, function(player)
    if getElementID(source) == "PrisonCol" and getElementType(player) == "player" and not isPedInVehicle(player) then
        inPrison = true
        playSound("PrisonDoor.mp3",false)
    end
end)

addEventHandler("onClientColShapeLeave", resourceRoot, function(player)
    if getElementID(source) == "PrisonCol" and getElementType(player) == "player" and not isPedInVehicle(player) then
        inPrison = false
    end
end)

addEventHandler("onClientPlayerDamage", localPlayer, function(attacker)
    if inPrison then
        cancelEvent()
    end
end)

