local StoreEntry = {
  {2244.2,-1665.9,15.7,"corona",0,0,"Grov_Clothing_In"},
  {207.7,-111.6,1005.3,"corona",0,15,"Grov_Clothing_Out"},
  {207.7,-100.8,1004.35,"cylinder",255,15,"Grov_Clothing_Bay"},

  {462.1,-1500.7,31,"corona",0,0,"Victim_Clothing_In"},
  {227.7,-8.2,1002.2,"corona",0,5,"Victim_Clothing_Out"},
  {206.6,-7.3,1000.33,"cylinder",255,5,"Victim_Clothing_Bay"},
  
  {499.4,-1361,16.4,"corona",0,0,"Prolaps_Clothing_In"},
  {207,-140.7,1003.5,"corona",0,3,"Prolaps_Clothing_Out"},
  {207,-129.7,1002.6,"cylinder",255,3,"Prolaps_Clothing_Bay"},
  
  {454.4,-1477.9,30.8,"corona",0,0,"DSstyle_Clothing_In"},
  {204.3,-169.2,1000.5,"corona",0,14,"DSstyle_Clothing_Out"},
  {204.3,-159.6,999.55,"cylinder",255,14,"DSstyle_Clothing_Bay"},
  
  {2112.8,-1211.1,24.1,"corona",0,0,"Urban_Clothing_In"},
  {203.8,-51,1001.8,"corona",0,1,"Urban_Clothing_Out"},
  {203.8,-43.5,1000.9,"cylinder",255,1,"Urban_Clothing_Bay"}
} 


for i, v in pairs(StoreEntry) do
  local Marker = createMarker(StoreEntry[i][1],StoreEntry[i][2],StoreEntry[i][3],StoreEntry[i][4],1,255,0,0,StoreEntry[i][5])
  setElementInterior(Marker,StoreEntry[i][6])
  setElementID(Marker,StoreEntry[i][7])
end


local StoreEntryMeta = {
    ["Grov_Clothing_In"]={StoreEntry = {15,207.6,-107.9,1005.1}},
    ["Grov_Clothing_Out"]={StoreEntry = {0,2245.2,-1663.2,15.5}},
    
    ["Victim_Clothing_In"]={StoreEntry = {5,224.1,-8.1,1002.2}},
    ["Victim_Clothing_Out"]={StoreEntry = {0,458.1,-1501.1,31}},
    
    ["Prolaps_Clothing_In"]={StoreEntry = {3,207.1,-138.4,1003.5}},
    ["Prolaps_Clothing_Out"]={StoreEntry = {0,500.8,-1357.7,16.1}},
    
    ["DSstyle_Clothing_In"]={StoreEntry = {14,204.4,-166.9,1000.5}},
    ["DSstyle_Clothing_Out"]={StoreEntry = {0,451.4,-1479.1,30.8}},
    
    ["Urban_Clothing_In"]={StoreEntry = {1,203.7,-48.6,1001.8}},
    ["Urban_Clothing_Out"]={StoreEntry = {0,2112.8,-1214,24}}
}

addEventHandler("onMarkerHit",resourceRoot,function (player)
    if (getElementType(player) == "player") and (isPedInVehicle(player) == false) then
      local ID = getElementID(source)
      if getMarkerType(source) == "corona" then
        local StoreEntry = StoreEntryMeta[ID].StoreEntry
        setElementInterior(player,StoreEntry[1],StoreEntry[2],StoreEntry[3],StoreEntry[4])
      elseif getMarkerType(source) == "cylinder" then
        triggerClientEvent(player,"Player_Clothing_Bay",player,ID)
      end
    end
end)


local ModelPriceMeta = {
    ["Grov_Clothing_Bay"]={price=1500},
    ["Urban_Clothing_Bay"]={price=1500},
    ["Prolaps_Clothing_Bay"]={price=2500},
    ["Victim_Clothing_Bay"]={price=3000},
    ["DSstyle_Clothing_Bay"]={price=5000}
}


addEvent("BaySkin", true)
addEventHandler("BaySkin", getRootElement(),function (id,clothingStore)
  local price = ModelPriceMeta[clothingStore].price
  local money = getPlayerMoney(source)
  if (money >= price) then
    takePlayerMoney(source,price)
    setElementModel(source,id)
  end
end)