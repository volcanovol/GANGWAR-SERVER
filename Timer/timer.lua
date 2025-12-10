local screenW, screenH = guiGetScreenSize()
local size = (screenW + screenH) / 3000
local min, sec, delay = 0, 0, true
local timerHud, timer = false

addEventHandler("onClientRender", root, function()
  if timerHud then
    dxDrawImage(screenW * 0.8641, screenH * 0.3370, screenW * 0.0849, screenH * 0.0463, "black.png", 0, 0, 0, tocolor(255, 255, 255, 200), false)
    dxDrawText(string.format("%02d:%02d", min, sec), screenW * 0.8688, screenH * 0.3417, screenW * 0.9437, screenH * 0.3796, tocolor(255, 255, 255, 255), size * 2, "pricedown", "center", "center", false, false, false, false, false)
  end
end)

function TimerGo(newMin)
  min, sec, timerHud, delay = newMin, 0, true, true
  if timer then killTimer(timer) end
  timer = setTimer(function()
    if sec > 0 then
      sec = sec - 1
    elseif sec == 0 and min > 0 then
      min, sec = min - 1, 59
    elseif sec == 0 and min == 0 then
      timerHud = false
      killTimer(timer)
    end
    delay = true
  end, 1000, 0)
end
addEvent("timerGo", true)
addEventHandler("timerGo", root, timerGo)

function TimerStop()
  timerHud, min, sec, delay = false, 0, 0, true
  if timer then killTimer(timer) end
end
addEvent("timerStop", true)
addEventHandler("timerStop", root, timerStop)
