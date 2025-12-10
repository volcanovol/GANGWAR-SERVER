
local PedList = {
  {300,2555.60,-1288.60,1031.40,180,1},
  {102,2555.60,-1288.60,1031.40,180,2},
  {302,2567.7, -1280.5, 1044.1, 180, 1},
  {302,2567.7, -1280.5, 1044.1, 180, 2}
} 

for i, v in pairs(PedList) do
  local Ped = createPed(PedList[i][1],PedList[i][2],PedList[i][3],PedList[i][4],PedList[i][5])
  setElementInterior(Ped,2)
  setElementDimension(Ped,PedList[i][6])
  setElementFrozen(Ped,true)
  setPedAnimation(Ped,"gangs","leanidle", -1, true, false, false, true)
end


function pedDamaged()
    cancelEvent() 
end
addEventHandler("onClientPedDamage",resourceRoot, pedDamaged)