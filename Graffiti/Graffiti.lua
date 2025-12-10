local PlayerIn = {}

local TagMeta = {
    ["Ballas"]={TagId = 1524},
    ["Grove Street"]={TagId = 1528}
}

for i, object in ipairs(getElementsByType("object", resourceRoot)) do
  local x, y, z = getElementPosition(object)
  local xr, yr, zr = getElementRotation(object)
  local colSphere = createColSphere(x, y, z, 2)
  setElementParent(colSphere, createObject(1526, x, y, z, xr, yr, zr))
  destroyElement(object)
end

addEventHandler("onColShapeHit",resourceRoot,function(hitElement)
  if (getElementType( hitElement ) == "player") and not isPedInVehicle(hitElement) then
    local ColSphere = source
    PlayerIn[hitElement] = ColSphere
    local Tag = getElementParent(ColSphere)
    local TagId = getElementID(Tag)
    triggerClientEvent(hitElement,"GivPlayerName",hitElement,TagId)
  end
end)

addEventHandler("onColShapeLeave",resourceRoot,function(hitElement)
  if (getElementType( hitElement ) == "player") and not isPedInVehicle(hitElement) then
    PlayerIn[hitElement] = nil
  end
end)

addEvent("StartTage", true)
addEventHandler("StartTage", getRootElement(), function()
    local colSphere = PlayerIn[client]
    if colSphere then
        local tag = getElementParent(colSphere)
        local playerTeam = getPlayerTeam(client)
        if playerTeam then
            local playerTeamName = getTeamName(playerTeam)
            if playerTeamName == "Ballas" or playerTeamName == "Grove Street" then
                local tageTeam = getElementID(colSphere)
                if playerTeamName ~= tageTeam then
                    local playerName = getPlayerName(client)
                    local tagId = TagMeta[playerTeamName].TagId
                    setElementID(tag, playerName)
                    setElementModel(tag, tagId)
                    setElementID(colSphere, playerTeamName)
                    triggerClientEvent(client, "SprayCompleted", client)
                    if getPlayerWantedLevel(client) == 0 then
                        setPlayerWantedLevel(client, 1)
                    end
                end
            end
        end
    end
end)
