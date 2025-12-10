
-------------------------------------سبون للاسلحة----------------------------------------------
local HandWeapons = {
  {2542,-1286.90,1031.40,5}, -- المضرب
  {2545,-1286.90,1031.40,4}, -- السكين
  {2549.80,-1300.90,1031.40,11} -- الميد كيت
} 

for i, v in pairs(HandWeapons) do
  local Pickup = createPickup(HandWeapons[i][1],HandWeapons[i][2],HandWeapons[i][3],2,HandWeapons[i][4],10000,1)
  local Pickup2 = createPickup(HandWeapons[i][1],HandWeapons[i][2],HandWeapons[i][3],2,HandWeapons[i][4],10000,1)
  setElementInterior(Pickup,2)
  setElementDimension(Pickup,1)
  setElementInterior(Pickup2,2)
  setElementDimension(Pickup2,2)
  
  setElementID(Pickup,"Ineffective")
  setElementID(Pickup2,"Ineffective")
end


local Weapons = {
  {2564.29,-1298.59,1031.40,32,"G-Tec-9","B-Tec-9"},
  {2564.29,-1296.29,1031.40,25,"G-Shotgun","B-Shotgun"},
  {2564.29,-1293.29,1031.40,29,"G-MP5","B-MP5"},
  {2564.29,-1290,1031.40,30,"G-AK-47","B-AK-47"},
  {2564.29,-1287,1031.40,34,"G-Sniper","B-Sniper"},
  {2553.19,-1287.19,1031.40,22,90,"Ineffective","Ineffective"},
  {2549.89,-1287.19,1031.40,22,90,"Ineffective","Ineffective"}
} 

for i, v in pairs(Weapons) do
  local Pickup = createPickup(Weapons[i][1],Weapons[i][2],Weapons[i][3],2,Weapons[i][4],10000,90)
  local Pickup2 = createPickup(Weapons[i][1],Weapons[i][2],Weapons[i][3],2,Weapons[i][4],10000,90)
  setElementInterior(Pickup,2)
  setElementDimension(Pickup,1)
  setElementID(Pickup,Weapons[i][5])
  setElementInterior(Pickup2,2)
  setElementDimension(Pickup2,2)
  setElementID(Pickup2,Weapons[i][6])
end


------------------------تطبيق التطويرات على مخزن الاسلحة--------------------------------------------------------------

local Grovearmory = 100 -- مخزن الجروف ستريت
local Ballasarmory = 100 -- مخزن البالاس

local ArmoryMeta = {
    ["Grove Street"] = {wp1 = "G-Tec-9", wp2 = "G-Shotgun", wp3 = "G-MP5", wp4 = "G-AK-47", wp5 = "G-Sniper"},
    ["Ballas"] = {wp1 = "B-Tec-9", wp2 = "B-Shotgun", wp3 = "B-MP5", wp4 = "B-AK-47", wp5 = "B-Sniper"}
}

function UpgradeApply(Gang)
    local armory = getArmory(Gang)
    local weapons = {ArmoryMeta[Gang].wp1, ArmoryMeta[Gang].wp2, ArmoryMeta[Gang].wp3, ArmoryMeta[Gang].wp4, ArmoryMeta[Gang].wp5}

    for i, weapon in ipairs(weapons) do
        local Pickup = getElementByID(weapon)
        local interiorLevel = 1

        if armory >= GetRequiredArmoryLevel(i) then
            interiorLevel = 2
        end

        setElementInterior(Pickup, interiorLevel)
    end
end


function getArmory(Gang)
    if Gang == "Grove Street" then
        return Grovearmory
    elseif Gang == "Ballas" then
        return Ballasarmory
    end
end

function setArmory(Gang, value)
    if Gang == "Grove Street" then
        Grovearmory = value
    elseif Gang == "Ballas" then
        Ballasarmory = value
    end
end

function GetRequiredArmoryLevel(index)
    local levels = {10, 20, 30, 50, 80}
    return levels[index]
end

function UpgradeArmory(Gang, Upgrade)
    local armory = getArmory(Gang)
    armory = armory + Upgrade
    setArmory(Gang, armory)
    UpgradeApply(Gang)
    outputChatBox(Grovearmory)
    outputChatBox(Ballasarmory)
end


function DowngradeArmory(Gang)
  local armory = getArmory(Gang)
  armory = armory - 3
  setArmory(Gang, armory)
  UpgradeApply(Gang)
  outputChatBox(Grovearmory)
  outputChatBox(Ballasarmory)
end


UpgradeApply("Grove Street")
UpgradeApply("Ballas")

-------------------منع الاعب من اخذ الكثير من الاسلحة و التحقق منها----------------------

addEventHandler("onPickupHit", resourceRoot, function(player)
      local weapon = getPickupWeapon(source)
      local slot = getSlotFromWeapon(weapon)
      local ammo = getPedTotalAmmo(player, slot)
      if ammo >= 50 then
        cancelEvent()
        exports["info_Text"]:InfoText(player, "لا يمكنك أن تأخذ الكثير من الذخيرة", 10000)
      elseif getElementID(source) ~= "Ineffective" then
        local playerTeam = getPlayerTeam(player)
        if playerTeam then
          local TeamName = getTeamName(playerTeam)
          DowngradeArmory(TeamName)
        end
      end
end)