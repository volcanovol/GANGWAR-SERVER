local Deathmatch = createTeam("Deathmatch",255,0,0)
local Map01Loc = {}
local Map02Loc = {}

local Pickups = {
  {2069.20,-1556.8,13.4},
  {1921.9,-1200.3,20.1},
  {2429.6,-1642.3,13.5},
  {1445.4,-1668.5,13.5}
}


local Markers = {
  {203.40,411.2,5.7,"corona"},
  {333.1,479.2,5.7,"corona"},
  {1104.9,1303.19,10.89,"corona"},
  {1176,1312.69,11.6,"corona"}
} 


for k,v in pairs(Pickups) do
  local Pickup = createPickup(Pickups[k][1],Pickups[k][2],Pickups[k][3],3,1313,0)
  setElementID(Pickup,"Deathmatch")
end


for i, v in pairs(Markers) do
  local Marker = createMarker(Markers[i][1],Markers[i][2],Markers[i][3],Markers[i][4],1,255,0,0,0)
  setElementInterior(Marker,20)
  setElementDimension(Marker,20)
  setElementID(Marker,"DeathmatchOut")
end


local AllPeds = getElementsByType("ped",resourceRoot)
for i, v in pairs(AllPeds) do
  local x,y,z = getElementPosition(AllPeds[i])
  local r = getElementRotation(AllPeds[i])
  local id = getElementModel(AllPeds[i])
  destroyElement(AllPeds[i])
  if id == 0 then
    table.insert(Map01Loc, {x, y, z,r})
  elseif id == 2 then
    table.insert(Map02Loc, {x, y, z,r})
  end
end

local currentMap = Map01Loc

addEventHandler( "onPickupUse",resourceRoot,function ( player )
    if getElementID(source) == "Deathmatch" then
      SavePlayerAccount(player)
      takeAllWeapons(player)
      setAccountData(getPlayerAccount(player), "MiniGame", 1)
      setElementDimension(player,20)
      setElementInterior(player,20)
      local skin = getElementModel(player)
      SpawnPlayerInMap(player,skin)
      setElementData(player,"Deathmatch",1)
      setPlayerTeam(player, Deathmatch)
      exports ["info_Text"]:InfoText(player,"أنت لوحدك تقاتل حتى الموت ضد أعدائك وكن الافضل",10000)
      exports ["info_Text"]:TutoText(player,"أنت الآن في طور الديث ماتش، عليك أن تقاتل وحيدًا ضد كل اللاعبين حتى تصبح الأفضل. يمكنك الخروج في أي وقت تريده باستخدام علامة الخروج الموجودة على الخريطة.",20000)
    end
end)

addEventHandler("onMarkerHit",resourceRoot,function (hitElement)
  if (getElementType( hitElement ) == "player") and not isPedInVehicle(hitElement) then
    local ID = getElementID(source)
    if ID == "DeathmatchOut" then
      local account = getPlayerAccount(hitElement)
      if account then 
        local playerX, playerY, playerZ = getAccountData(account, "x"), getAccountData(account, "y"), getAccountData(account, "z")
        local skin = getElementModel(hitElement)
        local teamName = getAccountData(account, "team")
        
        spawnPlayer(hitElement, playerX, playerY, playerZ, 0, skin, 0, 0)
        setElementData(hitElement,"Deathmatch",0)
        setAccountData(account, "MiniGame", 0)
        
        if teamName then
          local team = getTeamFromName(teamName)
            if team then
              setPlayerTeam(hitElement, team)
            end
        else
              setPlayerTeam(hitElement, nil)
        end
        
        local playerWeapons = fromJSON(getAccountData(account, "weapons") or "{}")
        for weaponID, weaponAmmo in pairs(playerWeapons) do
          giveWeapon(hitElement, weaponID, weaponAmmo)
        end
      end
    end
  end
end)


function SavePlayerAccount(player)
  local account = getPlayerAccount(player)
  if account then
  local playerX, playerY, playerZ = getElementPosition(player)
  local playerDimension = getElementDimension(player)
  local playerInterior = getElementInterior(player)
  local playerWeapons = {}
  for i=0, 12 do
    local weaponID = getPedWeapon(player, i)
    local weaponAmmo = getPedTotalAmmo(player, i)
    playerWeapons[weaponID] = weaponAmmo
  end
  if not isGuestAccount(account) then
    local team = getPlayerTeam(player)
      if team then
        local teamName = getTeamName(team)
        setAccountData(account, "team", teamName)
      end
  end
  setAccountData(account, "x", playerX + 3)
  setAccountData(account, "y", playerY)
  setAccountData(account, "z", playerZ)
  setAccountData(account, "dimension", playerDimension)
  setAccountData(account, "interior", playerInterior)
  setAccountData(account, "weapons", toJSON(playerWeapons))
  end
end


function SpawnPlayerInMap(player,skin)
  local Loc = currentMap [ math.random ( #currentMap ) ]
  spawnPlayer(player, Loc[1], Loc[2], Loc[3], Loc[4], skin, 20, 20)
end


addEventHandler("onPlayerWasted", getRootElement(), function ()
    if getElementData(source,"Deathmatch") == 1 then
      local skin = getElementModel(source)
      local player = source
      setTimer(function() SpawnPlayerInMap(player,skin) end, 5000, 1)
    end
end)