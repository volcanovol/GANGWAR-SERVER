local screenW, screenH = guiGetScreenSize() -- ابعاد الشاشة
local Sx, Sy = (screenW/1920), (screenH/1080)
local size = (Sx + Sy)

createBlip(1901.2,-1127.5,24.5,59,2,255, 0, 0, 255,0,350)--علامة في الخريطة
createBlip(2493,-1686.4,13.5,62,2,255, 0, 0, 255,0,350)--علامة في الخريطة

--السهم عند الدخول غير مهم كثيرا
local Arrow = {
  {2541.5,-1304.09,1025.09,1},
  {2541.5,-1304.09,1025.09,2}
} 

for i, v in pairs(Arrow) do
  local Pickup = createPickup(Arrow[i][1],Arrow[i][2],Arrow[i][3],3,1318)
  setElementInterior(Pickup,2)
  setElementDimension(Pickup,Arrow[i][4])
end

local BaseMark = {
    {2528.0, -1289.50, 1030.60},
    {2580.89, -1285.30, 1043.3},
    {2521.1, -1281.8, 1053.7}
}

for i, coords in ipairs(BaseMark) do
    local MarkerBallas = createMarker(coords[1], coords[2], coords[3], "cylinder", 1, 160, 32, 240, 100)
    local MarkerGrove = createMarker(coords[1], coords[2], coords[3], "cylinder", 1, 0, 255, 0, 100)
    setElementDimension(MarkerGrove, 1)
    setElementDimension(MarkerBallas, 2)
    setElementInterior(MarkerBallas, 2)
    setElementInterior(MarkerGrove, 2)
end
---------------------------------------------------------------------------------------------------

--الأزرار
local MapSelec1 = guiCreateStaticImage(0.43, 0.32, 0.23, 0.12, "ivs.png", true) -- زر احد اجزاء الخريطة
local MapSelec2 = guiCreateStaticImage(0.34, 0.44, 0.33, 0.08, "ivs.png", true) -- زر احد اجزاء الخريطة
local MapSelec3 = guiCreateStaticImage(0.34, 0.53, 0.33, 0.07, "ivs.png", true) -- زر احد اجزاء الخريطة
local MapSelec4 = guiCreateStaticImage(0.34, 0.61, 0.33, 0.07, "ivs.png", true) -- زر احد اجزاء الخريطة
local MapSelec5 = guiCreateStaticImage(0.34, 0.68, 0.33, 0.09, "ivs.png", true) -- زر احد اجزاء الخريطة
local Exit = guiCreateStaticImage(0.74, 0.23, 0.05, 0.08, "x.png", true)
local BaseMenu = false


--اخفاء و اظهار الازرار
function ButtonVisible(Visible)
    guiSetVisible(MapSelec1,Visible)
    guiSetVisible(MapSelec2,Visible)
    guiSetVisible(MapSelec3,Visible)
    guiSetVisible(MapSelec4,Visible)
    guiSetVisible(MapSelec5,Visible)
    guiSetVisible(Exit,Visible)
end
ButtonVisible(false)


--اظهار مخطط المقر الخريطة
function ShowPlayerMap()
  showCursor ( true )
  BaseMenu = true
  ButtonVisible(true)
  toggleAllControls(false)
end
addEvent("ShowPlayerMap", true)
addEventHandler("ShowPlayerMap", localPlayer, ShowPlayerMap)


local guiElements = {
  [MapSelec1] = { index = 1, image = "BaseMap1.png", floor = "غرفة القيادة" },
  [MapSelec2] = { index = 2, image = "BaseMap2.png", floor = "غرفة الاستراحة والحواسيب" },
  [MapSelec3] = { index = 3, image = "BaseMap3.png", floor = "مصنع و معمل" },
  [MapSelec4] = { index = 4, image = "BaseMap4.png", floor = "مخزن الاسلحة" },
  [MapSelec5] = { index = 5, image = "BaseMap5.png", floor = "المخرج" },
  [Exit] = { index = nil }
}


-- الأزرار و التفاعل معها
addEventHandler("onClientGUIClick", resourceRoot, function ()
  local selectedElement = guiElements[source]
  
  if selectedElement then
    BaseSpawn = selectedElement.index
    triggerServerEvent("SpawnInBase", localPlayer, BaseSpawn)
  end
  
  DeletMenu()
end)


-- انيميشن الخريطة و المخطط
addEventHandler("onClientMouseEnter", resourceRoot, function ()
  local selectedElement = guiElements[source]
  
  if selectedElement then
    MapSelecImage = selectedElement.image
    Basefloor = selectedElement.floor
  end
end)


--حذف المخطط
function DeletMenu()
  showCursor (false)
  BaseMenu = false
  ButtonVisible(false)
  toggleAllControls(true)
end



--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
--////////////////////////////////////////////------------------------جرافيك الخريطة-----------------///////////////////////////////////////////////////////////////--
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--

addEventHandler("onClientRender", root,
  function()
  if BaseMenu == true then
    dxDrawImage(screenW * 0.3344, screenH * 0.3102, screenW * 0.3302, screenH * 0.4741, MapSelecImage, 0, 0, 0, tocolor(255, 255, 255, 255), false)
    dxDrawImage(screenW * 0.3344, screenH * 0.3102, screenW * 0.3302, screenH * 0.4741, "BaseMap.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    dxDrawText(Basefloor, screenW * 0.3344, screenH * 0.7935, screenW * 0.6646, screenH * 0.8556, tocolor(255, 255, 255, 255), size, "default", "center", "center", false, false, false, false, false)
    dxDrawImage(screenW * 0.2036, screenH * 0.4009, screenW * 0.1318, screenH * 0.0417, "MapLine.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    dxDrawText("غرفة الاستراحة والحواسيب", screenW * 0.2036, screenH * 0.3556, screenW * 0.3073, screenH * 0.4009, tocolor(255, 255, 255, 255), size, "default", "left", "bottom", false, false, false, false, false)
    dxDrawImage(screenW * 0.3375, screenH * 0.2769, screenW * 0.1318, screenH * 0.0417, "MapLine.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    dxDrawText("غرفة القيادة", screenW * 0.3375, screenH * 0.2315, screenW * 0.4411, screenH * 0.2769, tocolor(255, 255, 255, 255), size, "default", "left", "bottom", false, false, false, false, false)
    dxDrawImage(screenW * 0.2271, screenH * 0.6000, screenW * 0.1318, screenH * 0.0417, "MapLine.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    dxDrawText("مخزن الاسلحة", screenW * 0.2271, screenH * 0.5546, screenW * 0.3307, screenH * 0.6000, tocolor(255, 255, 255, 255), size, "default", "left", "bottom", false, false, false, false, false)
    dxDrawImage(screenW * 0.7900, screenH * 0.5185, screenW * -0.1313, screenH * 0.0417, "MapLine.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    dxDrawText("مصنع و معمل", screenW * 0.6896, screenH * 0.4741, screenW * 0.7932, screenH * 0.5194, tocolor(255, 255, 255, 255), size, "default",  "right", "bottom", false, false, false, false, false)
  end
  end
)
