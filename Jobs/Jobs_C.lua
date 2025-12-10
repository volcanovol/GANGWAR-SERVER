local Spam = true

bindKey("lalt", "down",function ()
  if (isPedInVehicle(localPlayer) == true) and Spam == true then
    Spam = false
    setTimer(function() Spam = true end, 5000, 1)
    if (getElementData(localPlayer,"Mission") == 0) then
      local Vehicle = getPedOccupiedVehicle(localPlayer)
      local id = getElementModel(Vehicle)
      if id == 448 then
        triggerServerEvent("StartPizzaJob",localPlayer)
      elseif id == 574 then
        triggerServerEvent("Start_Street_Cleaner_Job",localPlayer)
      elseif id == 408 then
        triggerServerEvent("Start_Dustman_Job",localPlayer)
      elseif id == 525 then
        triggerServerEvent("start_Towtruck_Job",localPlayer)
        outputChatBox("ok")
      end
    end
  end
end)
