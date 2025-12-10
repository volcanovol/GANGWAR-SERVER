local PlayerBay = false
local PedOrder = 1
local PedId = 7
local priceTxt = "100"
local clothingStore = "Grov_Clothing_Bay"



local Arrow = {
  {2244.4,-1665.3,15.5,0},-- 
  {207.7,-110.8,1005.1,15},
  
  {461.6,-1500.8,31,0},-- 
  {227.3,-8.2,1002.2,5},
  
  {499.7,-1360.5,16.4,0},-- 
  {207,-140.3,1003.5,3},
  
  {454.1,-1478,30.8,0},-- 
  {204.3,-168.7,1000.5,14},
  
  {2112.8,-1211.6,24,0},-- 
  {203.8,-50.6,1001.8,1}
} 

for i, v in pairs(Arrow) do
  local Pickup = createPickup(Arrow[i][1],Arrow[i][2],Arrow[i][3],3,1318,0)
  setElementInterior(Pickup,Arrow[i][4])
  if Arrow[i][4] == 0 then
    createBlip(Arrow[i][1],Arrow[i][2],Arrow[i][3],45,2,255, 0, 0, 255,0,350)
  end
end


local PedModel = createPed(7,217.5,-99.4,1005.3,0,0,180,true)
setElementInterior(PedModel,15)
setElementDimension(PedModel,2)


local clothingBayMeta = {
    ["Grov_Clothing_Bay"] = {
        CameraMatrix = {215.5, -100.5, 1005.9, 217.5, -98.7, 1005.3},
        PedList = {2,7,13,22,21,25,28,41,47,67,69,195,273,93,105,106,107,},
        PedLocation = {15, 217.5, -98.7, 1005.3, 180},
        PedPrice = 1000
    },
    ["Victim_Clothing_Bay"] = {
        CameraMatrix = {210.5, -6.2, 1001.7, 209.2, -4.3, 1001.2},
        PedList = {59,98,185,223,233,240,263,91,20,46,169,12,40,55,151,215,242,82,83,84},
        PedLocation = {5, 209.2, -4.3, 1001.2, 214},
        PedPrice = 3000
    },
    ["Prolaps_Clothing_Bay"] = {
        CameraMatrix = {200, -133.5, 1004, 198.1, -132.1, 1003.5},
        PedList = {18,26,35,45,51,52,49,80,81,96,97,99,203,204,214,38,36,37},
        PedLocation = {3, 198.1, -132.1, 1003.5, 238.5},
        PedPrice = 2000
    },
    ["DSstyle_Clothing_Bay"] = {
        CameraMatrix = {207.4, -163.8, 1001, 209.5, -162.8, 1000.5},
        PedList = {120,219,187,186,148,111,150,153,141,147,57,68,76,228,227,17},
        PedLocation = {14, 209.5, -162.8, 1000.5, 116},
        PedPrice = 5000
    },
    ["Urban_Clothing_Bay"] = {
        CameraMatrix = {212.7, -39.9, 1002.4, 213.9, -42.2, 1002},
        PedList = {19,23,24,29,30,48,60,66,73,86,101,102,103,104,180,170,184,191,193},
        PedLocation = {1, 213.9, -42.2, 1002, 22},
        PedPrice = 4000
    }
}



-- صنع شخصيات تقف في الخلفية
local PedBack = { 
  {211,208.8,-98.7,1005.3,180,15,"shop" ,"shp_serve_idle"}, -- المتجر 1 في الجروف ستريت
  {9,202.5,-105.5,1005.1,180,15,"int_shop" ,"shop_loop"},
  {15,212.9,-107.3,1005.1,0,15,"int_shop" ,"shop_looka"},
  {7,218,-101.4,1005.3,-90,15,"int_shop" ,"shop_lookb"},
  
  {211,204.8,-7.25,1001.2,-90,5,"shop" ,"shp_serve_idle"}, -- المتجر 1 في الجروف ستريت
  {9,213.4,-4.3,1001.2,0,5,"int_shop" ,"shop_loop"},
  {15,209.3,-8,1005.2,90,5,"int_shop" ,"shop_looka"},
  
  {211,204.3,-157.9,1000.5,180,14,"shop" ,"shp_serve_idle"}, -- المتجر 4 الملابس الفاخرة
  {9,201.45,-164.2,1000.5,-90,14,"int_shop" ,"shop_loop"},
  
  {211,203.3,-41.7,1001.8,180,1,"shop" ,"shp_serve_idle"}, -- المتجر 5 المنطقة الريفية
  {9,208.7,-44.9,1001.8,0,1,"int_shop" ,"shop_loop"}
}

for k,v in pairs(PedBack) do
  local Ped = createPed(PedBack[k][1],PedBack[k][2],PedBack[k][3],PedBack[k][4],PedBack[k][5])
  setElementInterior(Ped,PedBack[k][6])
  setElementFrozen(Ped,true)
  setPedAnimation(Ped,PedBack[k][7] ,PedBack[k][8], -1, true, false, false, true)
end


-- بداية اللاعب في شراء الملابس السكينات
addEvent("Player_Clothing_Bay", true)
addEventHandler("Player_Clothing_Bay", localPlayer,function(ID)
    local CameraMatrix = clothingBayMeta[ID].CameraMatrix
    local PedLocation = clothingBayMeta[ID].PedLocation
    clothingStore = ID
    setElementDimension(PedModel,0)
    setCameraMatrix(CameraMatrix[1],CameraMatrix[2],CameraMatrix[3],CameraMatrix[4],CameraMatrix[5],CameraMatrix[6],0,90)
    setElementInterior(PedModel,PedLocation[1],PedLocation[2],PedLocation[3],PedLocation[4])
    setElementRotation(PedModel,0,0,PedLocation[5])
    showChat (false) 
    toggleAllControls(false)
    setPlayerHudComponentVisible("radar",false)
    PlayerBay = true
    exports ["info_Text"]:TutoText("أفدم عجلة الفأرة للتبديل بين الأسلحة / للشراء اضغط على سابيس / للخروج اضغط على أكس",0)
end)


function NextPed()
    local PedList = clothingBayMeta[clothingStore].PedList
    if PlayerBay and PedOrder < #PedList then
        PedOrder = PedOrder + 1
        PedId = PedList[PedOrder]
        setElementModel(PedModel, PedId)
        priceTxt = clothingBayMeta[clothingStore].PedPrice
        exports ["info_Text"]:InfoText("السعر".. priceTxt.." دولار ",10000)
    end
end
bindKey("d", "down", NextPed)
bindKey("mouse_wheel_down", "down", NextPed)

function PreviousPed()
    local PedList = clothingBayMeta[clothingStore].PedList
    if PlayerBay and PedOrder > 1 then
        PedOrder = PedOrder - 1
        PedId = PedList[PedOrder]
        setElementModel(PedModel, PedId)
        priceTxt = clothingBayMeta[clothingStore].PedPrice
        exports ["info_Text"]:InfoText("السعر".. priceTxt.." دولار ",10000)
    end
end
bindKey("a", "down", PreviousPed)
bindKey("mouse_wheel_up", "down", PreviousPed)


bindKey("space", "down",function()
  if PlayerBay == true then
    local money = getPlayerMoney(localPlayer)
    local price = tonumber(priceTxt)
    local id
    if (money >= price) then
      id = getElementModel(PedModel)
      playSFX("genrl", 53, 6, false)
      triggerServerEvent("BaySkin",localPlayer,id,clothingStore)
      ExitClothingStore()
    else
      exports ["info_Text"]:InfoText(" أنت لا تملك ما يكفي من المال تحتاج الى ".. priceTxt.." دولار ",10000)
      playSFX("genrl", 53, 2, false)
    end
  end
end)


function ExitClothingStore()
  if PlayerBay == true then
    PlayerBay = false
    PedOrder = 1
    showChat (true) 
    toggleAllControls(true)
    setCameraTarget(localPlayer,localPlayer)
    setPlayerHudComponentVisible("radar",true)
    exports ["info_Text"]:TutoText("",10)
    setElementDimension(PedModel,2)
  end
  end
bindKey("f", "down",ExitClothingStore)




addEventHandler("onClientPedDamage",resourceRoot,function ()
    cancelEvent() 
end)