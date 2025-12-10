
local PhoneSound = playSFX3D("script", 93, 0,0,0,-100, true)
local Blip
local CallTime = 4000
setSoundMaxDistance(PhoneSound,50)

local ObjectList = {} 



for i, v in pairs(ObjectList) do
  --local Obj = createObject(ObjectList[i][1],ObjectList[i][2],ObjectList[i][3],ObjectList[i][4],0,0,ObjectList[i][5],false)
end


local function Control(sit)
  toggleControl("forwards",sit) 
  toggleControl("backwards",sit) 
  toggleControl("left",sit) 
  toggleControl("right",sit) 
end

addEvent("PlaySoundPhone", true)
addEventHandler("PlaySoundPhone", root,function (x,y,z)
   setElementPosition(PhoneSound,x,y,z)
end)

addEvent("MissionPhoneStart", true)
addEventHandler("MissionPhoneStart", root,function ()
  Control(false)
  setElementFrozen(localPlayer,true)
  local sound = playSound("phonecall.mp3")
  setPedAnimation(localPlayer,"ped" ,"phone_talk", -1, true, false, false, true,100)
  setTimer(setPedAnimation,CallTime,1,localPlayer,nil ,nil , -1, true, false, false, true,100)
  setTimer(Control,CallTime,1,true)
  setTimer(stopSound,CallTime,1,sound)
  setTimer(setElementFrozen,CallTime,1,localPlayer,false)
  setTimer(playSound,CallTime,1,"endcall.mp3")
  setTimer ( function()
    exports ["Timer"]:TimerGo((60*1000)*5/60000)
	end, 5000, 1 )
  --exports ["info_Text"]:TutoText("عمود الهاتف يظهر بشكل عشوائي على الخريطة من خلاله يمكنك انجاز مهمات بسيطة مقابل المال. تنقسم المهمات إلى نوعين (قتل شخصية مهمة / تفجير مركبة).",20000)
end)

addEvent("MissionPassed", true)
addEventHandler("MissionPassed", root,function (state,mony)
  exports ["info_Text"]:MissionText(state,mony)
  exports ["Timer"]:TimerStop()
end)




addEvent("PhoneBlip", true)
addEventHandler("PhoneBlip", root,function (state,x,y)
  if state == "Make" then
    Blip = exports.customblips:createCustomBlip ( x,y, 16, 16,"phone.png",350) 
  elseif state == "delete" then
    exports.customblips:destroyCustomBlip (Blip)
  end
end)