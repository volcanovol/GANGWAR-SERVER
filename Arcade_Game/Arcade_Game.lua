local ArcadeLoc = {  ---- اذا كنت تريد صنع الاركيد مع الماركر / If you want to make then arcade with marker
  {2779,2546.69,-1289,1060,90,"Spaceship",2,0},
  {2779,2543,-1299.09,1053.59,270,"Spaceship",2,0},
  {2779,376.60,-133.30,1000.5,180,"Spaceship",5,0}
}


local MarkerLoc = {  ----اذا كنت تريد صنع الماركر فقط بدون الاركيد /  If you only want to make markers without the arcade
  --{2492.399,-1671.30,12.40,"Spaceship",0,0}
}


--------------------------------------------- ضع آلة الممرات والعلامة في الإحداثيات أعلاه / Place the arcade machine and the marker in the coordinates above---------------------------------------
function AttachToVehicle(Son,Mother,x,y,w)
  attachElements(Son,Mother,x,y,w,0,0,0)
  setElementParent(Son,Mother)
end

for i, v in pairs(ArcadeLoc) do
  local Arcade = createObject(ArcadeLoc[i][1],ArcadeLoc[i][2],ArcadeLoc[i][3],ArcadeLoc[i][4],0,0,ArcadeLoc[i][5],false)
  setElementInterior(Arcade,ArcadeLoc[i][7])
  setElementDimension(Arcade,-1)
  
  local tar = createObject(ArcadeLoc[i][1],ArcadeLoc[i][2],ArcadeLoc[i][3],ArcadeLoc[i][4],0,0,0,false)
  AttachToVehicle(tar,Arcade,0,-1,0.1)
  local x,y,z = getElementPosition(tar)
  destroyElement(tar)
  
  local Marker = createMarker(x,y,z,"cylinder",1,255,0,0,0)
  setElementID(Marker,ArcadeLoc[i][6])
  setElementInterior(Marker,ArcadeLoc[i][7])
  setElementDimension(Marker,ArcadeLoc[i][8])
end


for i, v in pairs(MarkerLoc) do
  local Marker = createMarker(MarkerLoc[i][1],MarkerLoc[i][2],MarkerLoc[i][3],"cylinder",1,255,0,0,100)
  setElementID(Marker,MarkerLoc[i][4])
  setElementInterior(Marker,MarkerLoc[i][5])
  setElementDimension(Marker,MarkerLoc[i][6])
end


addEventHandler("onMarkerHit",resourceRoot,function (hitElement) -------- If the player touches the marker / اذا لمس اللاعب الماركر
  if (getElementType( hitElement ) == "player") and (isPedInVehicle(hitElement) == false) then
    local account = getPlayerAccount(hitElement)
    if (getElementID(source) == "Spaceship") then
      local SpaceshipScore = getAccountData(account, "SpaceshipScore") or 0
      triggerClientEvent("ArcadeSpaceshipStart",hitElement,SpaceshipScore)
    end
  end
end)