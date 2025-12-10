
local job = false --- هل اللاعب يعمل ؟

local Arrows = {
  {2557.99,-1283.79,1046,3,1318,1,"Step1WeapJobArrow"},
  {2555.8,-1293.59,1046,3,1318,1,"Step2WeapJobArrow"},
  {2565.5,-1293,1046,3,1318,1,"DeliverWeapJobArrow"}
} 

for i, v in pairs(Arrows) do
  local Arrow = createPickup(Arrows[i][1],Arrows[i][2],Arrows[i][3],Arrows[i][4],Arrows[i][5],Arrows[i][6])
  setElementInterior(Arrow,2)
  setElementID(Arrow,Arrows[i][7])
  setElementDimension(Arrow,1)
end  

local Step1Arrow = {
  {2549.90,-1283.79,1046,3,1318,1},
  {2557.99,-1303.59,1046,3,1318,1},
  {2549.90,-1303.59,1046,3,1318,1}
} 

for i, v in pairs(Step1Arrow) do
  local Arrow = createPickup(Step1Arrow[i][1],Step1Arrow[i][2],Step1Arrow[i][3],Step1Arrow[i][4],Step1Arrow[i][5],Step1Arrow[i][6])
  setElementInterior(Arrow,2)
  local ParentArrow = getElementByID("Step1WeapJobArrow")
  setElementParent(Arrow,ParentArrow)
  setElementDimension(Arrow,1)
end

local MarkerList = {
  {2567.7, -1281, 1043.15, 1},
  {2567.7, -1281, 1043.15, 2}
}

for i, markerData in pairs(MarkerList) do
  local x, y, z, dimension = markerData[1], markerData[2], markerData[3], markerData[4]
  local marker = createMarker(x, y, z, "cylinder", 1, 255, 0, 0, 50)
  setElementInterior(marker, 2)
  setElementDimension(marker, dimension)
  setElementID(marker, "Marker_Weapons_Factory")
end



addEventHandler("onClientMarkerHit",resourceRoot,function(player)
    if (getElementType(player) == "player") and not isPedInVehicle(player) and (job == false) and getElementDimension(player) == getElementDimension(source) then
      exports ["info_Text"]:InfoText("لبدء وظيفة مصنع الأسلحة ..ALT..",10000)
      exports ["info_Text"]:TutoText("وظيفة مصنع الأسلحة: من خلالها يمكنك مساعدة عصابتك في الحصول على أسلحة مجانية داخل المخزن مقابل الحصول على أرباح جيدة.",20000)
    end
end)

local spam = true
bindKey("lalt", "down",function ()
  if spam then
    spam = false
    setTimer(function() spam = true end,5000,1)
    
    local Marker = getElementByID("StartWeapJob")
    if (isElementWithinMarker(localPlayer,Marker)) and (job == false) then
      triggerServerEvent("StartWorkingWeapJob",localPlayer)
    end
  end
end)

local tutorialJobMeta = {
    ["Step1WeapJob"]={txt="ب/ ركب القطع في الألة التي في الوسط",ID = "Step2WeapJobArrow",Delet = {"DeliverWeapJobArrow","Step1WeapJobArrow"}},
    ["Step2WeapJob"]={txt="ج/ ضع السلاح في المخزن",ID = "DeliverWeapJobArrow",Delet = {"Step2WeapJobArrow","Step1WeapJobArrow"}},
    ["DeliverWeapJob"]={txt="أ / أخرج قطع السلاح من الخزانة",ID = "Step1WeapJobArrow",Delet = {"DeliverWeapJobArrow","Step2WeapJobArrow"}}
}

function tutorialWeapJob(ColID)
  local txt = tutorialJobMeta[ColID].txt
  local ID = tutorialJobMeta[ColID].ID
  local Delet = tutorialJobMeta[ColID].Delet
  local Dimension = getElementDimension(localPlayer)
  local Arrow = getElementByID(ID)
  setElementDimension(Arrow, Dimension)
  exports["info_Text"]:InfoText(txt, 10000)
  playSFX("genrl", 52, 18, false)
  AddBoxs(ColID)
  for i, v in pairs(Delet) do
    Arrow = getElementByID(Delet[i])
    setElementDimension(Arrow, 5)
  end
end


addEvent("StartTutoWorkingWeapJob", true)
addEventHandler("StartTutoWorkingWeapJob", localPlayer, function ()
  tutorialWeapJob("DeliverWeapJob")
  job = true
  playSFX("script", 144, 0, false)
end)


addEvent("PlayerisWorkingWeapJob", true)
addEventHandler("PlayerisWorkingWeapJob", localPlayer, function (ColID,TimeFroz,Rot)
  toggleAllControls(localPlayer,false)
  setElementRotation(localPlayer,0,0,Rot)
  setTimer(toggleAllControls,TimeFroz,1,localPlayer,true)
  setTimer(tutorialWeapJob,TimeFroz,1,ColID)
  DeletBoxs()
end)




----------------------------------الصندوق حمله و تركه -------------------------------------
Box1 = createObject(2358, 2558.5,-1290.7,1043.25,0,0,0,false)
setElementInterior(Box1 ,2)
setElementDimension(Box1 ,5)

function playerControl(bool)
  toggleControl ( "fire",bool) 
  toggleControl ( "jump",bool) 
  toggleControl ( "crouch",bool) 
end

function AddBoxs(id)
  local Dimension = getElementDimension(localPlayer)
  if id == "Step2WeapJob" or id == "Step1WeapJob" then
    exports.bone_attach:attachElementToBone(Box1, localPlayer, 4, 0, 0.4, -0.6, -90, 0, 0)
    setElementDimension(Box1, Dimension)
    playerControl(false)
  elseif id == "DeliverWeapJob" then
    DeletBoxs()
  end
end

function DeletBoxs()
    exports.bone_attach:detachElementFromBone(Box1)
    setElementDimension(Box1 ,5)
    playerControl(true)
end



addEvent("StopWorkingWeapJob", true)
addEventHandler("StopWorkingWeapJob", localPlayer, function ()
    exports ["info_Text"]:InfoText("لقد خرجت من الوظيفة يمكنك العودة في أي وقت",10000)
    playSFX("genrl", 52, 15, false)
    playSFX("script", 144, 2, false)
    DeletBoxs()
    job = false
  for i, v in pairs(Arrows) do
    Arrow = getElementByID(Arrows[i][7])
    if Arrows[i][7] ~= "StartWeapJobArrow" then
      setElementDimension(Arrow,5)
    end
  end
end)
