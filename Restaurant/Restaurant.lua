--------------------علامة الدخول و الخروج--------------------------
local Restaurants = {
  {2105.80,-1806.46,13.80,"corona",0,0,"PizzIn"},
  {372.35,-134,1001.70,"corona",0,5,"PizzOut"},
  {372.70,-119,1000.55,"cylinder",100,5,"PizzEat1"},
  {376.70,-119,1000.55,"cylinder",100,5,"PizzEat2"},
  
  {2419.5,-1509,24,"corona",0,0,"CluckinIn"},
  {364.89,-12,1001.90,"corona",0,9,"CluckinOut"},
  {368.10,-6.25,1000.9,"cylinder",100,9,"CluckinEat"},
   
  {810.20,-1616.20,13.5,"corona",0,0,"BurgerIn"},
  {362.70,-75.40,1001.5,"corona",0,10,"BurgerOut"},
  {376.5,-67.80,1000.60,"cylinder",100,10,"BurgerEat"}
} 

for i, v in pairs(Restaurants) do
  local Marker = createMarker(Restaurants[i][1],Restaurants[i][2],Restaurants[i][3],Restaurants[i][4],1,255,0,0,Restaurants[i][5])
  setElementInterior(Marker,Restaurants[i][6])
  setElementID(Marker,Restaurants[i][7])
end


local RestauraMeta = {
    ["PizzIn"]={Restaura = {5,372.20,-132.10,1001.5}},
    ["PizzOut"]={Restaura = {0,2104,-1806.5,13.60}},
    ["CluckinIn"]={Restaura = {9,364.70,-9.3,1001.9}},
    ["CluckinOut"]={Restaura = {0,2421.19,-1508.90,24}},
    ["BurgerIn"]={Restaura = {10,364.60,-73.90,1001.5}},
    ["BurgerOut"]={Restaura = {0,813.59,-1616.30,13.60}}
}

addEventHandler("onMarkerHit",resourceRoot,function (player)
  if (getElementType(player) == "player") and not isPedInVehicle(player) then
    local ID = getElementID(source)
    local Mtype = getMarkerType(source)
    if Mtype == "corona" then
      local Restaura = RestauraMeta[ID].Restaura
      setElementInterior(player,Restaura[1],Restaura[2],Restaura[3],Restaura[4])
    elseif Mtype == "cylinder" then
      local money = getPlayerMoney(player)
      if money >= 10 then
        triggerClientEvent(player,"PlayerEatInRestaurant",player,ID)
        setPedWeaponSlot(player,0)
        setElementHealth(player,100)
        takePlayerMoney(player,10)
      else
        exports ["info_Text"]:InfoText(player,"أنت لا تملك ما يكفي من المال تحتاج الى 10 دولار",10000)
      end
    end
  end
end)
