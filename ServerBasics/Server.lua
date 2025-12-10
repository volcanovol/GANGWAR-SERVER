------------------- اعدادات عالم اللعبة ------------------
setMaxPlayers(200)
setFPSLimit(60)
setMinuteDuration(60000) -- 1 minute in game is equal to 1 minute in real time
local serverTime = getRealTime() -- Get the current time from the server
setTime(serverTime.hour, serverTime.minute)

------------------صنع عصابات السيرفر-------------------
local Grove = createTeam("Grove Street",0,255,0)
local Ballas = createTeam("Ballas",160,32,240)
local Mafia = createTeam("Mafia",64,64,64)
local Police = createTeam ("Police", 0, 0, 255 )

--setTeamFriendlyFire ( Grove , false )
--setTeamFriendlyFire ( Ballas , false )
--setTeamFriendlyFire ( Police , false )

exports ["scoreboard"]:scoreboardForceTeamsHidden(true)

function onPlayerQuit()
    local account = getPlayerAccount(source)
    if account then
        setAccountData(account, "money", getPlayerMoney(source))
        setAccountData(account, "Model", getElementModel(source))
        if getAccountData(account, "MiniGame") == 0 then
            savePlayerWeapons(source, account)
            savePlayerLocation(source, account)
            savePlayerTeam(source,account)
        end
    end
end
addEventHandler("onPlayerQuit", root, onPlayerQuit)

function savePlayerWeapons(player, account)
    local playerWeapons = {}
    for i=0, 12 do
        local weaponID = getPedWeapon(player, i)
        local weaponAmmo = getPedTotalAmmo(player, i)
        playerWeapons[weaponID] = weaponAmmo
    end
    setAccountData(account, "weapons", toJSON(playerWeapons))
end

function savePlayerLocation(player, account)
    local playerX, playerY, playerZ = getElementPosition(player)
    if playerX ~= 0 and playerY ~= 0 and playerZ ~= 0 then
        setAccountData(account, "x", playerX)
        setAccountData(account, "y", playerY)
        setAccountData(account, "z", playerZ)
        setAccountData(account, "dimension", getElementDimension(player))
        setAccountData(account, "interior", getElementInterior(player))
    end
end

function savePlayerTeam(player,account)
    if not isGuestAccount(account) then
        local team = getPlayerTeam(player)
        if team then
            local teamName = getTeamName(team)
            setAccountData(account, "team", teamName)
        end
    end
end

function onPlayerLogin()
    local account = getPlayerAccount(source)
    
    if account then
        local playerX, playerY, playerZ = getAccountData(account, "x"), getAccountData(account, "y"), getAccountData(account, "z")

        if not playerX then
            triggerClientEvent(source,"New_Player_Select_Skin", source)
        else
            local playerModel = getAccountData(account, "Model") or 23
            local playerMoney = getAccountData(account, "money") or 0
            local playerDimension = getAccountData(account, "dimension") or 0
            local playerInterior = getAccountData(account, "interior") or 0
            local playerWeapons = fromJSON(getAccountData(account, "weapons") or "{}")
            local teamName = getAccountData(account, "team")
            
            spawnPlayer(source, playerX, playerY, playerZ, 0, playerModel, playerInterior, playerDimension)
            fadeCamera(source, true)
            setCameraTarget(source, source)
            setPlayerMoney(source, playerMoney)
            setAccountData(account, "MiniGame", 0)
            setElementData(source,"Mission",0)
            
            if teamName then
              local team = getTeamFromName(teamName)
              if team then
                  setPlayerTeam(source, team)
              end
            end
            giveWeapon(source, 16, 999)
           -- giveWeapon(source, 31, 999)
           -- giveWeapon(source, 28, 999)
           -- giveWeapon(source, 41, 999)
           -- giveWeapon(source, 11, 1)
           -- givePlayerMoney(source,99999)
          --spawnPlayer(source,1544.3, -1675.6, 13.6, -90, playerModel, 0)
            for weaponID, weaponAmmo in pairs(playerWeapons) do
                giveWeapon(source, weaponID, weaponAmmo)
            end
        end
    end
end
addEventHandler("onPlayerLogin", root, onPlayerLogin)


addEvent("New_Player_Select_Complete", true)
addEventHandler("New_Player_Select_Complete", root, function(Skin)
    local spawns = {
        {1640, -2331.19, 13.5},
        {1644.40, -2331, 13.5}
    }
    spawnPlayer(source, unpack(spawns[math.random(#spawns)]))
    setElementModel(source,Skin)
    setPlayerMoney(source, 1539)
    setAccountData(getPlayerAccount(source), "MiniGame", 0)
    fadeCamera(source, true)
    setCameraTarget(source, source)
    setElementData(source,"Mission",0)
end)

addEventHandler("onPlayerWasted", root, function()
    local account = getPlayerAccount(source)
    local playerTeam = getPlayerTeam(source)
    local playerModel = getAccountData(account, "Model") or 23
    local respawnPos, respawnDimension, respawnInterior
    if not account or getAccountData(account, "MiniGame") == 1 then
        return
    end
    
    if playerTeam then
        local teamName = getTeamName(playerTeam)
        if teamName == "Grove Street" or teamName == "Ballas" then
            respawnPos = { x = 2536, y = -1294, z = 1031.4, r = -90 }
            respawnInterior = 2
            respawnDimension = teamName == "Grove Street" and 1 or 2
        elseif teamName == "Police" then
            respawnPos = { x = 246.7, y = 67.3, z = 1003.6, r = 0 }
            respawnDimension = 0
            respawnInterior = 6
        end
    else
        local x, y, z = getElementPosition(source)
        local hospital = getNearestHospital(x, y, z)
        if hospital then
            respawnPos = { x = hospital.x, y = hospital.y, z = hospital.z, r = hospital.r }
        end
    end
    if respawnPos then
        setTimer(spawnPlayer,5000, 1,source , respawnPos.x, respawnPos.y, respawnPos.z, respawnPos.r, playerModel, respawnInterior, respawnDimension)
    end
end)


function getNearestHospital(x, y, z)
  
    local hospitals = {
        {x=2027.4, y=-1421.09, z=17,r=135}, -- Example hospital locations
        {x=1178.3, y=-1324, z=14.1,r=0}
    }
    
    local nearestHospital = false
    local shortestDistance = 99999
    
    -- Loop through all hospitals and calculate the distance to each one
    for i, hospital in ipairs(hospitals) do
        local distance = getDistanceBetweenPoints3D(x, y, z, hospital.x, hospital.y, hospital.z)
        
        -- If this hospital is closer than the current nearest hospital, update the variables
        if distance < shortestDistance then
            nearestHospital = hospital
            shortestDistance = distance
        end
    end
    
    return nearestHospital
end


addEventHandler("onPlayerSpawn", root,function ()
    local player = source
    triggerClientEvent(player, "enableSpawnProtection", player, true)
    setElementAlpha(player,100)
    setTimer(function()
        if isElement(player) then
        setElementAlpha(player,255)
    end end, 10000, 1)
end)

