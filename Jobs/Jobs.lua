
local Timers = {}
local MinutesRes = 0.5

addEventHandler("onVehicleExit", getRootElement(), function(player)
    if getElementData(player, "Mission") ~= 1 then return end

    local vehicleModel = getElementModel(source)
    local timerFunction

    if vehicleModel == 448 then
        timerFunction = EndPizzaJob
    elseif vehicleModel == 574 then
        timerFunction = endStreetCleaner
    elseif vehicleModel == 408 then
        timerFunction = End_Dustman_Job
    elseif vehicleModel == 525 then
        timerFunction = end_Towtruck_Job
    else
        return
    end

    Timers[source] = setTimer(timerFunction, (60 * 1000) * MinutesRes, 1, player)
end)


addEventHandler("onVehicleEnter", getRootElement(),function ()
  if isElement(source) then
    if isTimer(Timers[source]) then
      local TheTimer = Timers[source]
      killTimer(TheTimer)
      Timers[source] = nil
      outputChatBox("تم قتل المؤقت")
    end
  end
end)

function MikeBlipFor(child,mother,Siz)  ---- اصنع علامة للهدف
  local Blip = createBlipAttachedTo(child,0,Siz,101,185,231,255,10,5000)
  setElementVisibleTo(Blip, mother, true)
  setElementParent(Blip,child)
end