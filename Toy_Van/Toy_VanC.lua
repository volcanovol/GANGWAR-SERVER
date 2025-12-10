local IsToyUse = false -- هل انت تستخدم اللعبة
local Spam = true

bindKey("lalt", "down",function ()
  if isPedInVehicle(localPlayer) and Spam then
  if getElementData(getPedOccupiedVehicle(localPlayer),"ToyCar") then
    triggerServerEvent("ExplodVehicle",localPlayer,localPlayer)
  end 
  Spam = false
  setTimer(function () Spam = true end,3000,1)
  end
end)


addEvent("toyCarSpawn", true)
addEventHandler("toyCarSpawn", localPlayer, function()
    IsToyUse = true
    exports ["info_Text"]:InfoText("لتفجير اللعبة / لديك 5 دقائق حتى تنفجر تلقائيا".."(Alt)".."اضغط على",10000)
    exports ["info_Text"]:TutoText("لقد وجدت شاحنة الألعاب المتفجرة هي منتشرة في الخريطة وتظهر بشكل عشوائي. يمكنك استخدامها لمقاتلة اعدائك وازعاجهم بدون التعرض للضرر. ولكن انتبه لأن المركبة المتفجرة ستنفجر تلقائيا بعد اكتمال الوقت.",20000)
    exports ["Timer"]:TimerGo(3)
    Control(false)
end)


addEvent("toyCarExplod", true)
addEventHandler("toyCarExplod", localPlayer, function()
    local Car = getPedOccupiedVehicle(localPlayer)
    setCameraTarget(Car)
    setTimer(setCameraTarget,3000,1,localPlayer)
    playSFX("script", 217, 0, false)
    exports ["Timer"]:TimerGo(0)
    IsToyUse = false
    Control(true)
end)


addEventHandler("onClientPlayerDamage", localPlayer, function () --لا يمكنك قتل اللاعب الذي داخل اللعبة
  if IsToyUse == true then
    cancelEvent() 
  end
end)


function Control(sit)--ايقاف التحكم الخاص باللعبة
  toggleControl("vehicle_secondary_fire",sit)
  toggleControl("enter_exit", sit) 
end