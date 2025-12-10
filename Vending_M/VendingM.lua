local Price = 1

local AllMarkers = getElementsByType("marker", resourceRoot)
for i, v in pairs(AllMarkers) do
  local x, y, z = getElementPosition(v)
  local id = getMarkerType(v)
  local int = getElementInterior(v)
  if id == "cylinder" then
    local Marker = createMarker(x, y, z,"corona",1,255,0,0,0)
    setElementID(Marker,"VendingSoda")
    setElementInterior(Marker,int)
    destroyElement(v)
  elseif id == "corona" then
    local Marker = createMarker(x, y, z,"corona",1,255,0,0,0)
    setElementID(Marker,"HotDog")
    setElementInterior(Marker,int)
    destroyElement(v)
  end
end


addEventHandler("onMarkerHit",resourceRoot,function (player)
  if (getElementType( player ) == "player") and not isPedInVehicle(player) then
  local Money = getPlayerMoney(player)
  if Money >= Price then
    local id = getElementID(source)
    setPedWeaponSlot(player,0)
    local hp = getElementHealth(player)
    hp = hp + 20
    setTimer(setElementHealth,2500,1,player,hp)
    takePlayerMoney(player,1)
    triggerClientEvent(player,"UseVendingM",player,id)
  else 
    exports ["info_Text"]:InfoText(player,"أنت لا تملك ما يكفي من المال تحتاج الى 1 دولار",10000)
  end
  end
end)

