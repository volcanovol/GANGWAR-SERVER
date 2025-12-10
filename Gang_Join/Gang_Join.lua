local MINUTES_TO_WAIT = 60

local Pickups = {
  {2493,-1686.4,13.5,0,"Grove Street"},
  {1901.2,-1127.5,24.5,0,"Ballas"},
  --{256.5,64.4,1003.6,6,"Police"}
  {1549.3,-1669.7,13.6,0,"Police"}
}

for k,v in pairs(Pickups) do
  local Pickup = createPickup(Pickups[k][1],Pickups[k][2],Pickups[k][3],3,1314,0)
  setElementInterior(Pickup,Pickups[k][4])
  setElementID(Pickup,Pickups[k][5])
end


addEventHandler("onPickupUse", resourceRoot, function(player)
    if (getElementType(player) == "player") and (isPedInVehicle(player) == false) then
        local account = getPlayerAccount(player)
        if account then
            local teamName = getElementID(source)
            local team = getTeamFromName(teamName)
            local playerTeam = getPlayerTeam(player)
            if team ~= playerTeam and isAllowedToChangeTeam(account,player) then
                setPlayerTeam(player, team)
                setAccountData(account, "team", teamName)
                exports ["info_Text"]:InfoText(player,""..teamName.." / أنت الأن من عصابة",10000)
                local currentDate = os.time()
                setAccountData(account, "teamChangeDate", currentDate)
            end
        end
    end
end)


function isAllowedToChangeTeam(account, player)
    local lastTeamChangeDate = getAccountData(account, "teamChangeDate") or 0
    local currentTime = os.time()
    local timeDiff = os.difftime(currentTime, lastTeamChangeDate)
    local minutesDiff = math.floor(timeDiff / 60)
    local remainingTime = MINUTES_TO_WAIT - minutesDiff
    if remainingTime <= 0 then
        return true
    else
        local remainingMinutes = remainingTime % 60
        local remainingHours = math.floor(remainingTime / 60)
        local message = "يجب عليك الانتظار "
        if remainingHours > 0 then
            message = message .. remainingHours .. " ساعات و "
        end
        message = message .. remainingMinutes .. " دقائق على الأقل قبل تغيير فريقك مرة أخرى."
        exports ["info_Text"]:InfoText(player,message,10000)
    return false
  end
end