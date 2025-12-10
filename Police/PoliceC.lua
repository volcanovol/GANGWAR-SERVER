
createBlip(1564.59,-1675.19,61.90,30,2,255, 0, 0, 255,0,350)

local RadarAreas = {
  {1530,-1730,65,130}
} 
for i, v in pairs(RadarAreas) do
  local RadarArea = createRadarArea(RadarAreas[i][1],RadarAreas[i][2],RadarAreas[i][3],RadarAreas[i][4],0,0,255,100)
end

local Arrow = {
  {1555.2,-1675.65,16.20,0},
  {246.85,62.5,1003.6,6},
  
  {1565,-1684.3,28.4,0},
  {246.4,87.8,1003.6,6},
  
  {1568.65,-1690,6.2,0},
  {242.3,66.38,1003.6,6}
} 


for i, v in pairs(Arrow) do
  local Pickup = createPickup(Arrow[i][1],Arrow[i][2],Arrow[i][3],3,1318,0)
  setElementInterior(Pickup,Arrow[i][4])
end


local Peds = {
  {280,232.8,71.3,1005,180,6,"cop_ambient" ,"coplook_think"},
 -- {280,230.8,76.4,1005,0,6,"INT_OFFICE", "OFF_Sit_Type_Loop"},
  {280,234.69,76.69,1005,218,6,"cop_ambient" ,"coplook_shake"},
  {280,230.7,65.2,1005,336,6,"cop_ambient" ,"coplook_nod"}, -- اللي واقف جنب اللاعب الجديد
  
  {280,254.1,73.9,1003.6,180,6,"cop_ambient" ,"copbrowse_loop"}, --- في غرفة تغيير الملابس
  
  {280,251.3,67.5,1003.6,-270,6,"cop_ambient" ,"coplook_loop"}, --- الي في غرفة الاستقبال
 -- {280,254 - 0.3,69.65,1003.4,-90,6,"int_office" ,"off_sit_idle_loop"} -- اللي عند الكرسي في غرفة الاستقبال
  {280,1544.3,-1632,13.4,-270,0,"cop_ambient" ,"coplook_loop"},
  {280,1580.5,-1634.2,13.6,0,0,"cop_ambient" ,"coplook_loop"}
}


for k,v in pairs(Peds) do
  local Ped = createPed(Peds[k][1],Peds[k][2],Peds[k][3],Peds[k][4],Peds[k][5])
  setElementInterior(Ped,Peds[k][6])
  setElementFrozen(Ped,true)
  setPedAnimation(Ped,Peds[k][7] ,Peds[k][8], -1, true, false, false, true)
end

addEventHandler("onClientPedDamage",resourceRoot,function ()
    cancelEvent() 
end)