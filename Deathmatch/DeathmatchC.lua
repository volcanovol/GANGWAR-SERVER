
local Arrow = {
  {332.40,479.30,5.6},
  {204.2,411.2,5.6},
  
  {1104.9,1302.59,10.89},
  {1175.59,1312.73,11.5}
} 

for i, v in pairs(Arrow) do
  local Pickup = createPickup(Arrow[i][1],Arrow[i][2],Arrow[i][3],3,1318,0)
  setElementInterior(Pickup,20)
  setElementDimension(Pickup,20)
end