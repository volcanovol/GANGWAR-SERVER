local weapons = {
  {217.5,75.7,1005,31,6},
  {217.5,78.5,1005,29,6},
  {217.5,81.3,1005,22,6},
  {217.5,69.7,1005,11,6}
} 


for i, v in pairs(weapons) do
  local Pickup = createPickup(weapons[i][1],weapons[i][2],weapons[i][3],2,weapons[i][4],5000,90)
  setElementInterior(Pickup,weapons[i][5])
end


addEventHandler("onPickupHit", resourceRoot, function(player)
    local playerTeam = getPlayerTeam(player)
    if playerTeam then
        local teamName = getTeamName(playerTeam)
        if teamName == "Police" then
            local weapon = getPickupWeapon(source)
            local slot = getSlotFromWeapon(weapon)
            local ammo = getPedTotalAmmo(player, slot)
            if ammo >= 50 then
                cancelEvent()
                exports["info_Text"]:InfoText(player, "لا يمكنك أن تأخذ الكثير من الذخيرة", 10000)
            end
        else
            cancelEvent()
            exports["info_Text"]:InfoText(player, "هذه الأسلحة مخصصة للشرطة فقط", 10000)
        end
    else
        cancelEvent()
        exports["info_Text"]:InfoText(player, "هذه الأسلحة مخصصة للشرطة فقط", 10000)
    end
end)