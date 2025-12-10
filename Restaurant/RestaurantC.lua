
--أسهم الدخول و الخروح
local Arrow = {
  {2105.39,-1806.5,13.60,0,29},
  {372.39,-133.5,1001.5,5},
  
  {2420,-1509,24,0,14},
  {364.89,-11.69,1001.90,9},
  
  {810.5,-1616.30,13.5,0,10},
  {363,-75.19,1001.5,10}
} 


for i, v in pairs(Arrow) do
  local Pickup = createPickup(Arrow[i][1],Arrow[i][2],Arrow[i][3],3,1318)
  setElementInterior(Pickup,Arrow[i][4])
  if Arrow[i][4] == 0 then
   createBlip(Arrow[i][1],Arrow[i][2],Arrow[i][3],Arrow[i][5],2,255, 0, 0, 255,0,350) 
  end
end


local pedsTable = {
{ model = 167, x = 368.20, y = -4.55, z = 1001.90, rot = 180, int = 9, anim1 = "shop", anim2 = "shp_serve_idle" },
{ model = 205, x = 376.5, y = -65.69, z = 1001.5, rot = 180, int = 10, anim1 = "shop", anim2 = "shp_serve_idle" },
{ model = 155, x = 372.70, y = -117.30, z = 1001.5, rot = 180, int = 5, anim1 = "shop", anim2 = "shp_serve_idle" },
{ model = 155, x = 376.70, y = -117.30, z = 1001.5, rot = 180, int = 5, anim1 = "shop", anim2 = "shp_serve_idle" },
{ model = 155, x = 375.10, y = -113.80, z = 1001.5, rot = 0, int = 5, anim1 = "casino", anim2 = "cards_win" }
}

-- حلقة لإنشاء الشخصيات وتعيين الرسومات الحركية الخاصة بها
for i, pedInfo in ipairs(pedsTable) do
  local ped = createPed(pedInfo.model, pedInfo.x, pedInfo.y, pedInfo.z, pedInfo.rot)
  setElementInterior(ped, pedInfo.int)
  setElementFrozen(ped, true)
  setPedAnimation(ped, pedInfo.anim1, pedInfo.anim2, -1, true, false, false, true)
end

----------------------------------------------------------------------------------
local restaurants = {
["PizzEat1"] = {voics = {5, 6, 7, 8, 9, 10, 11, 12, 13}, files = 17},
["PizzEat2"] = {voics = {5, 6, 7, 8, 9, 10, 11, 12, 13}, files = 17},
["CluckinEat"] = {voics = {4, 5, 7, 8, 9, 10, 11, 37}, files = 15},
["BurgerEat"] = {voics = {3, 4, 5, 6, 7, 8, 9}, files = 11}
}

addEvent("PlayerEatInRestaurant", true)
addEventHandler("PlayerEatInRestaurant", localPlayer, function (MarkerID)
  toggleAllControls(false)
  setTimer(setPedAnimation, 200, 1, localPlayer, "FOOD", "EAT_Pizza", -1, true, false, false, true)
  setTimer(setElementFrozen, 4000, 1, localPlayer, false)
  setTimer(setPedAnimation, 4000, 1, localPlayer)
  setTimer(toggleAllControls, 4000, 1, true)
  Voice(MarkerID)
end)

function Voice(MarkerID)
  local restaurant = restaurants[MarkerID]
  local voics = restaurant.voics
  local files = restaurant.files
  local newVoic = voics[math.random(#voics)]
  playSFX("spc_fa", files, newVoic, false)
  playSFX("script", 151, 0, false)
end


function pedDamaged()
  cancelEvent() 
end
addEventHandler("onClientPedDamage",resourceRoot, pedDamaged)
