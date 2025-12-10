local HouseLocs = {}

local AllMarkers = getElementsByType("marker", resourceRoot)
for i, v in pairs(AllMarkers) do
  local x, y, z = getElementPosition(v)
  local id = getElementID(v)
  if id == "Pizza_House" then
    table.insert(HouseLocs, {x, y, z, "Pizza_House"})
    destroyElement(v)
  end
end

--createJobsClothes(378.9,-114.1,1001.5,5,0,155)
--createJobsClothes(2114.6,-1822.8,13.6,0,0,155)

function createPizzaMarker(player, location, markerID)
    local Marker = createMarker(location[1], location[2], location[3], "cylinder", 2, 255, 0, 0, 100, resourceRoot)
    setElementID(Marker, markerID)
    setElementVisibleTo(Marker, player, true)
    MikeBlipFor(Marker, player, 2)
    setElementData(player, "Pizza_Marker", Marker)
end

function NextHousePizzaJob(player)
    local Loc = HouseLocs[math.random(#HouseLocs)]
    createPizzaMarker(player, Loc, Loc[4])
end

function GetStockPizzaJob(player)
    createPizzaMarker(player, {2114, -1825.3, 12.6}, "StockMarker")
end


addEvent("StartPizzaJob", true)
addEventHandler("StartPizzaJob", getRootElement(),function ()
  if (getElementData(source,"Mission") == 0) then
    setElementData(source,"Mission",1)
    setElementData(source,"Pizza_stock",5)
    NextHousePizzaJob(source)
  end
end)


addEventHandler("onMarkerHit", resourceRoot, function(player)
    local pizzaMarker = getElementData(player, "Pizza_Marker")
    if (pizzaMarker == source and getElementType(player) == "player" and not isPedInVehicle(player)) then
        if (getElementID(source) == "Pizza_House") then
            local x, y, z = getElementPosition(source)
            destroyElement(source)
            local stock = getElementData(player, "Pizza_stock") - 1
            setElementData(player, "Pizza_stock", stock)
            triggerClientEvent(player,"Pizza_was_delivered", player)
            if (stock > 0) then
                NextHousePizzaJob(player)
            else
                GetStockPizzaJob(player)
            end
        elseif (getElementID(source) == "StockMarker") then
            setElementData(player, "Pizza_stock", 5)
            NextHousePizzaJob(player)
            destroyElement(source)
            triggerClientEvent(player,"Get_Stock_Pizza", player)
            
        end
    end
end)

function EndPizzaJob(player)
  if isElement(player) then
    local Marker = getElementData(player,"Pizza_Marker")
    destroyElement(Marker)
    setElementData(player,"Mission",0)
  end
end

