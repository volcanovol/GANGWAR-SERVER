
local screenW, screenH = guiGetScreenSize()-- حجم الشاشة
local Sx, Sy = (screenW/1920), (screenH/1080)
local size = (Sx + Sy)


local txt = ""
local TxtTimer

function InfoText(Ntxt, time, r, g, b)
  if TxtTimer then
    killTimer(TxtTimer)
  end
  txt = Ntxt
  TxtTimer = setTimer(function() txt = "" end, time, 1)
  txtColor = {r or 255, g or 255, b or 255}
end

addEvent("InfoText", true)
addEventHandler("InfoText", localPlayer, InfoText)



local Tuto = "" 
local TutoTimer
local DrawTuto = false
function TutoText(Ttxt,time)
  killTimer(TutoTimer)
  Tuto = Ttxt
  DrawTuto = true
  playSFX("genrl", 52, 15, false)
  if time > 0 then
    TutoTimer = setTimer(function() Tuto = "" DrawTuto = false end,time,1)
  end
end
addEvent("TutoText", true)
addEventHandler("TutoText", localPlayer, TutoText)


local MisTxt = ""
local MisMoney = ""
local MisRGB = {}
local Music = ""
local DrawMis = false
local MissionMeta = {
    ["passed_SA"]={MisTxt = "mission passed",MisRGB = {255, 169, 2},Music = nil,TimeM = 10000},
    ["passed_3"]={MisTxt = "mission passed",MisRGB = {81, 118, 134},Music = "GTA3Mission.mp3",TimeM = 11000},
    ["passed_Vic"]={MisTxt = "mission passed",MisRGB = {252, 149, 218},Music = "GTAVicMission.mp3",TimeM = 8500},
    ["failed"]={MisTxt = "mission failed",MisRGB = {255, 0, 0},Music = nil,TimeM = 10000}
}

function MissionText(state,mony)
  MisTxt = MissionMeta[state].MisTxt
  MisRGB = MissionMeta[state].MisRGB
  Music = MissionMeta[state].Music
  TimeM = MissionMeta[state].TimeM
  outputChatBox(Music)
  DrawMis = true
  if state ~= "failed" then
    MisMoney = mony
    if Music ~= nil then
      local sound = playSound(Music,false)
      setSoundVolume(sound,0.2)
    else
      playSFX("genrl", 75, 3, false)
    end
  end
  setTimer(function() DrawMis = false MisState = "" MisMoney = "" end ,TimeM,1)
end
addEvent("MissionPassed", true)
addEventHandler("MissionPassed", localPlayer, MissionText)



addEventHandler("onClientRender", root,function()
  dxDrawText(txt, (screenW * 0.2328) + 1, (screenH * 0.9306) + 1, (screenW * 0.7786) + 1, (screenH * 0.9593) + 1, tocolor(0, 0, 0, 255), size, "arial", "center", "center", false, false, false, false, false)
  dxDrawText(txt, screenW * 0.2328, screenH * 0.9306, screenW * 0.7786, screenH * 0.9593, tocolor(txtColor[1], txtColor[2], txtColor[3], 255), size, "arial", "center", "center", false, false, false, false, false)
  
  if DrawTuto == true then     
    dxDrawImage(screenW * 0.0242, screenH * 0.0139, screenW * 0.2852, screenH * 0.1708, "black.png", 0, 0, 0, tocolor(255, 255, 255, 200), false)
    dxDrawText(Tuto, screenW * 0.0320, screenH * 0.0278, screenW * 0.3016, screenH * 0.1708, tocolor(255, 255, 255, 255), size, "arial", "right", "top", false, true, false, false, false)
  end  
  if DrawMis == true then
        dxDrawText(MisTxt, (screenW * 0.2437) - 1, (screenH * 0.2611) - 1, (screenW * 0.7578) - 1, (screenH * 0.3806) - 1, tocolor(0, 0, 0, 255), (size*2), "pricedown", "center", "center", false, false, false, false, false)
        dxDrawText(MisTxt, (screenW * 0.2437) + 1, (screenH * 0.2611) - 1, (screenW * 0.7578) + 1, (screenH * 0.3806) - 1, tocolor(0, 0, 0, 255), (size*2), "pricedown", "center", "center", false, false, false, false, false)
        dxDrawText(MisTxt, (screenW * 0.2437) - 1, (screenH * 0.2611) + 1, (screenW * 0.7578) - 1, (screenH * 0.3806) + 1, tocolor(0, 0, 0, 255), (size*2), "pricedown", "center", "center", false, false, false, false, false)
        dxDrawText(MisTxt, (screenW * 0.2437) + 1, (screenH * 0.2611) + 1, (screenW * 0.7578) + 1, (screenH * 0.3806) + 1, tocolor(0, 0, 0, 255), (size*2), "pricedown", "center", "center", false, false, false, false, false)
        dxDrawText(MisTxt, screenW * 0.2437, screenH * 0.2611, screenW * 0.7578, screenH * 0.3806, tocolor(MisRGB[1], MisRGB[2], MisRGB[3], 255), (size*2), "pricedown", "center", "center", false, false, false, false, false)
        dxDrawText(MisMoney, (screenW * 0.2437) - 1, (screenH * 0.3806) - 1, (screenW * 0.7578) - 1, (screenH * 0.4889) - 1, tocolor(0, 0, 0, 255), (size*2), "pricedown", "center", "center", false, false, false, false, false)
        dxDrawText(MisMoney, (screenW * 0.2437) + 1, (screenH * 0.3806) - 1, (screenW * 0.7578) + 1, (screenH * 0.4889) - 1, tocolor(0, 0, 0, 255), (size*2), "pricedown", "center", "center", false, false, false, false, false)
        dxDrawText(MisMoney, (screenW * 0.2437) - 1, (screenH * 0.3806) + 1, (screenW * 0.7578) - 1, (screenH * 0.4889) + 1, tocolor(0, 0, 0, 255), (size*2), "pricedown", "center", "center", false, false, false, false, false)
        dxDrawText(MisMoney, (screenW * 0.2437) + 1, (screenH * 0.3806) + 1, (screenW * 0.7578) + 1, (screenH * 0.4889) + 1, tocolor(0, 0, 0, 255), (size*2), "pricedown", "center", "center", false, false, false, false, false)
        dxDrawText(MisMoney, screenW * 0.2437, screenH * 0.3806, screenW * 0.7578, screenH * 0.4889, tocolor(255, 255, 255, 255), (size*2), "pricedown", "center", "center", false, false, false, false, false)
  end
  dxDrawText("", (screenW * 0.8781) - 1, (screenH * 0.1944) - 1, (screenW * 0.9891) - 1, (screenH * 0.2463) - 1, tocolor(0, 0, 0, 255), size, "pricedown", "center", "center", false, false, false, false, false)
  dxDrawText("", (screenW * 0.8781) + 1, (screenH * 0.1944) - 1, (screenW * 0.9891) + 1, (screenH * 0.2463) - 1, tocolor(0, 0, 0, 255), size, "pricedown", "center", "center", false, false, false, false, false)
  dxDrawText("", (screenW * 0.8781) - 1, (screenH * 0.1944) + 1, (screenW * 0.9891) - 1, (screenH * 0.2463) + 1, tocolor(0, 0, 0, 255), size, "pricedown", "center", "center", false, false, false, false, false)
  dxDrawText("", (screenW * 0.8781) + 1, (screenH * 0.1944) + 1, (screenW * 0.9891) + 1, (screenH * 0.2463) + 1, tocolor(0, 0, 0, 255), size, "pricedown", "center", "center", false, false, false, false, false)
  dxDrawText("", screenW * 0.8781, screenH * 0.1944, screenW * 0.9891, screenH * 0.2463, tocolor(255, 255, 255, 255), size, "pricedown", "center", "center", false, false, false, false, false)
end)