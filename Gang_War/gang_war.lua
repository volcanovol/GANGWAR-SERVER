createRadarArea(2222.30,-1840.5,330,230,0,255,0,150) -- المناطق الأساسية
createRadarArea(1856.90,-1339,200,300,138,43,226,150)
local spam = true
local groveAttack = true -- AttackPermission
local ballasAttack = true -- AttackPermission
local warTime = 10 --وقت حرب العصابات
local areaRestTime = 60 -- الوقت اللازم للهجوم على نفس المنطقة مجددا

--المناطق--
local RadarAreas = {
  {"Grove Street", 1040, -1851, 12, 250, 270, 40, "Area1"}, --Areas1
  {"Ballas", 593.5, -655, 12, 250, 250, 50, "Area2"},
  {"Grove Street", 2308, -1379, 20, 139, 220,50, "Area3"},
  {"Ballas", 1956.2, -2161.6, 12, 150, 200,40, "Area4"},
  {"Grove Street", 2210, -105, 25, 187, 207,40, "Area5"},
  {"Ballas", 145.6, -1818, 0.5, 210, 120,40, "Area6"}
}

function getAreaColor(AreaGang)
  local colors = {
    ["Grove Street"] = {0, 255, 0},
    ["Ballas"] = {100, 32, 240}
  }
  return colors[AreaGang][1], colors[AreaGang][2], colors[AreaGang][3]
end

-- صناعة المناطق
for i, areaData in ipairs(RadarAreas) do
  local gangName = areaData[1]
  local R, G, B = getAreaColor(gangName)
  local x, y, z, width, height, depth, elementID = areaData[2], areaData[3], areaData[4], areaData[5], areaData[6], areaData[7], areaData[8]

  local radarArea = createRadarArea(x, y, width, height, R, G, B,80)
  local colCuboid = createColCuboid(x, y, z, width, height, depth)
  setElementID(colCuboid,elementID)
  setElementData(colCuboid, "radarArea", radarArea)
  setElementData(colCuboid, "areaTeam", gangName)
  setElementData(colCuboid, "areaScore",0)
end


function getPlayerTeamName(player)
  if getElementType(player) == "player" then
    local playerTeam = getPlayerTeam(player)
    if playerTeam then
      return getTeamName(playerTeam)
    end
  end
end


--عندما يدخل أو يخرج اللاعب من المنطقة 
addEventHandler("onColShapeHit", resourceRoot, function(enteredPlayer)
  if isElement(enteredPlayer) and getElementType(enteredPlayer) == "player" then
    setElementData(enteredPlayer, "areaIn", source)
  end
end)

addEventHandler("onColShapeLeave", resourceRoot, function(leftPlayer)
  if isElement(leftPlayer) and getElementType(leftPlayer) == "player" then
    setElementData(leftPlayer, "areaIn", false)
  end
end)



local attackPermission = {
  ["Grove Street"] = true,
  ["Ballas"] = true
}

function getAttackPermission(areaTeam)
  return attackPermission[areaTeam]
end

function setAttackPermission(areaTeam, state)
  attackPermission[areaTeam] = state
end


function AreaAttack(player, commandName)
  if spam then
    spam = false
    setTimer(function() spam = true end, 1000, 1)

    local area = getElementData(player, "areaIn")
    if area then
      local areaTeam = getElementData(area, "areaTeam")
      local playerTeam = getPlayerTeam(player)
      local playerTeamName = getTeamName(playerTeam)

      if playerTeamName == areaTeam then
        exports ["info_Text"]:InfoText(player,"لا يمكنك السيطرة على منطقتك",10000,173,71,66)
      elseif playerTeamName ~= areaTeam and (playerTeamName == "Grove Street" or playerTeamName == "Ballas") then
        local permission = getAttackPermission(areaTeam)
        local radarArea = getElementData(area, "radarArea")
        local R, G, B, A = getRadarAreaColor(radarArea)
        
        if A >= 150 then
          exports ["info_Text"]:InfoText(player,"عد لاحقًا، هذه المنطقة جديدة",10000,173,71,66)
          return
        end
        
        if permission then
          setAttackPermission(areaTeam, false)
          setRadarAreaFlashing(radarArea, true)
          setTimer(setWinneTeam, (60*1000)* warTime, 1, area, areaTeam)
        else
          exports ["info_Text"]:InfoText(player,"لا يمكنك هناك بالفعل منطقة تحت الهجوم",10000,173,71,66)
        end
      end
    end
  end
end
addCommandHandler("attack", AreaAttack)





function setWinneTeam(Area, areaTeam)
  local playerCount = {
    ["Grove Street"] = 0,
    ["Ballas"] = 0
  }

  local playersInArea = getElementsWithinColShape(Area, "player")
  local winningTeam

  for _, player in ipairs(playersInArea) do
    local playerTeam = getPlayerTeam(player)
    local teamName = getTeamName(playerTeam)

    if teamName == "Grove Street" then
      playerCount["Grove Street"] = playerCount["Grove Street"] + 1
    elseif teamName == "Ballas" then
      playerCount["Ballas"] = playerCount["Ballas"] + 1
    end
  end

  local score = getElementData(Area, "areaScore")
  
  if (score > 0 and  areaTeam == "Grove Street" and playerCount["Grove Street"] > 0 ) or (areaTeam == "Grove Street" and playerCount["Ballas"] > 0) then
    winningTeam = "Ballas"
  elseif (score > 0 and  areaTeam == "Ballas" and playerCount["Ballas"] > 0) or (areaTeam == "Ballas" and playerCount["Grove Street"] > 0) then
    winningTeam = "Grove Street"
  else
    winningTeam = areaTeam
  end
  WarEnd(Area ,areaTeam, winningTeam)
end


function WarEnd(Area ,areaTeam, winningTeam) --- نهاية المعركة بعد تحديد الرابح و ارجاع المنطقة الى العادي
  local radarArea = getElementData(Area, "radarArea")
  local R, G, B = getAreaColor(winningTeam)
  setElementData(Area, "areaTeam", winningTeam)
  setElementData(Area, "areaScore",0)
  setAttackPermission(areaTeam,true)
  setRadarAreaColor(radarArea,R,G,B,150)
  setRadarAreaFlashing(radarArea,false)
  setTimer(setRadarAreaColor,(60*1000)* areaRestTime,1,radarArea,R,G,B,80)
end



local allowedTeams = { "Grove Street", "Ballas" }

function isTeamAllowed(teamName)
    for _, allowedTeam in ipairs(allowedTeams) do
        if allowedTeam == teamName then
            return true
        end
    end
    return false
end

addEventHandler("onPlayerWasted", root, function(ammo, attacker)
    local area = getElementData(source, "areaIn")
    if not area then
        return
    end

    if not isRadarAreaFlashing(getElementData(area, "radarArea")) then
        return
    end

    local playerTeamName = getPlayerTeamName(source)
    local attackerTeamName = getPlayerTeamName(attacker)

    if playerTeamName == attackerTeamName and isTeamAllowed(playerTeamName) and isTeamAllowed(attackerTeamName) then
        scoreCount(area, playerTeamName, attackerTeamName)
    end
end)




function scoreCount(Area,playerTeamName,attackerTeamName)
  local areaTeam = getElementData(Area, "areaTeam")
  local areaScore = getElementData(Area, "areaScore")
  
  if areaTeam == playerTeamName then
    areaScore = areaScore + 1
  else
    areaScore = areaScore - 1
  end
  setElementData(Area, "areaScore",areaScore)
end