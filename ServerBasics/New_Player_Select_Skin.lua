local screenW, screenH = guiGetScreenSize()
local Sx, Sy = (screenW/1920), (screenH/1080)
local size = (Sx + Sy)
local IsPlayerNew = false
local Gender = "ذكر"
local Skin = 23
local MaleSkins = {23,2,7,19,22,170,24}
local FemaleSkins = {56,13,93,190,191,193,195}
local SkinOrder = 1

-----------------------------------------------

local NewPlayerSkin = createPed(Skin,232.19,66.4,1005,0)
setElementInterior(NewPlayerSkin,6)
setElementFrozen(NewPlayerSkin,true)
setPedAnimation(NewPlayerSkin,"dealer","dealer_idle", -1, true, false, false, true)

-----------------------------------------------

GUIEditor = {
    staticimage = {}
}
GUIEditor.staticimage[1] = guiCreateStaticImage(0.17, 0.39, 0.03, 0.05, "gfx/img/right_arrow.png", true)

GUIEditor.staticimage[2] = guiCreateStaticImage(0.07, 0.39, 0.03, 0.05, "gfx/img/left_arrow.png", true)

GUIEditor.staticimage[3] = guiCreateStaticImage(0.17, 0.50, 0.03, 0.05, "gfx/img/right_arrow.png", true)

GUIEditor.staticimage[4] = guiCreateStaticImage(0.07, 0.50, 0.03, 0.05, "gfx/img/left_arrow.png", true)

GUIEditor.staticimage[5] = guiCreateStaticImage(0.09, 0.71, 0.15, 0.07, "gfx/img/inv.png", true)

function ButtonVisible(vis)
  for k,v in pairs(GUIEditor.staticimage) do
    guiSetVisible(GUIEditor.staticimage[k],vis)
  end
end
ButtonVisible(false)

local function ShowMenu()
  IsPlayerNew = true
  setCameraMatrix(232.5,68,1005.5,232.5,66.4,1005.3,0,90)
  ButtonVisible(true)
  exports ["info_Text"]:TutoText("اختر شخصيتك الجديدة يمكنك تغيير شكلها لاحقا من خلال متجر الملابس",0)
end


addEvent("New_Player_Select_Skin", true)
addEventHandler("New_Player_Select_Skin", localPlayer,function()
  setCameraMatrix(241,79.9,1006.4,231.5,73.09,1005,0,90)
  --setCameraShakeLevel ( 10 )
  setElementInterior(localPlayer, 6)
  setTimer(showChat,1000,1,false)
  setTimer(showCursor,1000,1,true)
  setTimer(fadeCamera,1000,1,true)
  setPlayerHudComponentVisible("radar",false)
  exports ["info_Text"]:TutoText("أهلا بك في سيرفر حرب العصابات من تطوير ميمون كاش",0)
  setTimer(ShowMenu,7000,1)
end)



addEventHandler ( "onClientGUIClick", resourceRoot,function()
    
  if (source == GUIEditor.staticimage[1]) or (source == GUIEditor.staticimage[2]) then
    Gender = (Gender == "أنثى") and "ذكر" or "أنثى"
  elseif (source == GUIEditor.staticimage[3]) and (SkinOrder >= 1 and SkinOrder ~= 7) then
    SkinOrder = SkinOrder + 1
  elseif (source == GUIEditor.staticimage[4]) and (SkinOrder <= 7 and SkinOrder ~= 1) then
    SkinOrder = SkinOrder - 1
  end
  
  Skin = (Gender == "أنثى") and FemaleSkins[SkinOrder] or MaleSkins[SkinOrder]
  setElementModel(NewPlayerSkin, Skin)
  local animDict = (Gender == "أنثى") and "ped" or "dealer"
  local animName = (Gender == "أنثى") and "xpressscratch" or "dealer_idle"
  setPedAnimation(NewPlayerSkin, animDict, animName, -1, true, false, false, true)
end)


addEventHandler ( "onClientGUIClick", GUIEditor.staticimage[5],function()
  triggerServerEvent("New_Player_Select_Complete",localPlayer,Skin)  
  IsPlayerNew = false
  showChat(true)
  ButtonVisible(false)
  showCursor(false)
  setPlayerHudComponentVisible("radar",true)
  exports ["info_Text"]:TutoText("",10)
end)

addEventHandler("onClientRender", root,
    function()
      if IsPlayerNew == true then
        dxDrawImage(screenW * 0.0250, screenH * 0.2431, screenW * 0.2852, screenH * 0.5472, "gfx/img/black.png", 0, 0, 0, tocolor(255, 0, 0, 200), false)
        dxDrawImage(screenW * 0.0250, screenH * 0.2431, screenW * 0.2852, screenH * 0.1028, "gfx/img/black.png", 0, 0, 0, tocolor(255, 0, 0, 200), false)
        dxDrawImage(screenW * 0.0250, screenH * 0.3597, screenW * 0.2852, screenH * 0.1028, "gfx/img/black.png", 0, 0, 0, tocolor(255, 0, 0, 200), false)
        dxDrawImage(screenW * 0.0250, screenH * 0.4764, screenW * 0.2852, screenH * 0.1028, "gfx/img/black.png", 0, 0, 0, tocolor(255, 0, 0, 200), false)
        dxDrawText("تصميم الشخصية الجديدة", screenW * 0.0328, screenH * 0.2569, screenW * 0.3023, screenH * 0.3319, tocolor(255, 255, 255, 255), size*1.5, "arial", "center", "center", false, false, false, false, false)
        dxDrawText("الجنس", screenW * 0.2469, screenH * 0.3736, screenW * 0.3023, screenH * 0.4486, tocolor(255, 255, 255, 255), size*1.5, "arial", "right", "center", false, false, false, false, false)
        dxDrawText("الشكل", screenW * 0.2453, screenH * 0.4903, screenW * 0.3023, screenH * 0.5653, tocolor(255, 255, 255, 255), size*1.5, "arial", "right", "center", false, false, false, false, false)
        dxDrawText(Gender, screenW * 0.1055, screenH * 0.3736, screenW * 0.1609, screenH * 0.4486, tocolor(255, 255, 255, 255), size*1.5, "arial", "center", "center", false, false, false, false, false)
        dxDrawText(SkinOrder, screenW * 0.1055, screenH * 0.4889, screenW * 0.1609, screenH * 0.5639, tocolor(255, 255, 255, 255), size*1.5, "arial", "center", "center", false, false, false, false, false)
        dxDrawImage(screenW * 0.0922, screenH * 0.7139, screenW * 0.1477, screenH * 0.0681, "gfx/img/black.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawText("دخول", screenW * 0.1000, screenH * 0.7278, screenW * 0.2320, screenH * 0.7681, tocolor(255, 255, 255, 255), size*1.5, "default", "center", "center", false, false, false, false, false)
      end
    end
)