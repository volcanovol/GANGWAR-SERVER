local pedListGrove = { 
  {107, 2568.5, -1294.4, 1037.8, 180, 2,1, "dealer", "dealer_idle_01"}, -- عند غرفة الشاشات فوق مخزن الاسلحة
  {105, 2572, -1282.4, 1031.4, 0, 2,1, "shop", "shp_serve_idle"}, -- عند الصناديق
  {106, 2571.2, -1292.1, 1037.8, -90, 2,1, "gangs", "smkcig_prtl"}, -- عند الشاشات
  
  {107, 2573, -1296, 1044.1, 90, 2,1, "gangs", "smkcig_prtl"}, -- عند مدخل المصنع
  {106, 2536, -1291, 1044.1, -90, 2,1, "dealer", "dealer_idle_01"}, -- فوق المصنع
  {105, 2525.3, -1297.4, 1048.3, -90, 2,1, "cop_ambient" ,"coplook_think"}, -- عند المكتب
  
  {106, 2535.1, -1297.2, 1054.6, 0, 2,1, "gangs","leanidle"}, -- غرفة الاستراحة عند المدخل
  {105, 2550.35, -1299.5, 1054.6, 90, 2,1, "gangs","leanidle"}, -- غرفة الاستراحة عند المدخل
  
  {195, 2556.5, -1301.4, 1061, 90, 2,1, "casino", "cards_win"}, -- البنت
  {172, 2539.7, -1286.6, 1054.6, 90, 2,1, "shop" ,"shp_serve_idle"} -- النادل
}

for k, v in ipairs(pedListGrove) do
  local Ped = createPed(v[1], v[2], v[3], v[4], v[5])
  setElementInterior(Ped, v[6])
  setElementDimension(Ped, v[7])
  setElementFrozen(Ped, true)
  setPedAnimation(Ped, v[8], v[9], -1, true, false, false, true)
end

local pedListBallas = { 
  {102, 2568.5, -1294.4, 1037.8, 180, 2,2, "dealer", "dealer_idle_01"}, -- عند غرفة الشاشات فوق مخزن الاسلحة
  {103, 2572, -1282.4, 1031.4, 0, 2,2, "shop", "shp_serve_idle"}, -- عند الصناديق
  {104, 2571.2, -1292.1, 1037.8, -90, 2,2, "gangs", "smkcig_prtl"}, -- عند الشاشات
  
  {103, 2573, -1296, 1044.1, 90, 2,2, "gangs", "smkcig_prtl"}, -- عند مدخل المصنع
  {102, 2536, -1291, 1044.1, -90, 2,2, "dealer", "dealer_idle_01"}, -- فوق المصنع
  {103, 2525.3, -1297.4, 1048.3, -90, 2,2, "cop_ambient" ,"coplook_think"}, -- عند المكتب
  
  {104, 2535.1, -1297.2, 1054.6, 0, 2,2, "gangs","leanidle"}, -- غرفة الاستراحة عند المدخل
  {103, 2550.35, -1299.5, 1054.6, 90, 2,2, "gangs","leanidle"}, -- غرفة الاستراحة عند المدخل
  
  {13, 2556.5, -1301.4, 1061, 90, 2,2, "casino", "cards_win"}, -- البنت
  {172, 2539.7, -1286.6, 1054.6, 90, 2,2, "shop" ,"shp_serve_idle"} -- النادل
}


for k, v in ipairs( pedListBallas) do
  local Ped = createPed(v[1], v[2], v[3], v[4], v[5])
  setElementInterior(Ped, v[6])
  setElementDimension(Ped, v[7])
  setElementFrozen(Ped, true)
  setPedAnimation(Ped, v[8], v[9], -1, true, false, false, true)
end


addEventHandler("onClientPedDamage",resourceRoot,function ()
    cancelEvent() 
end)