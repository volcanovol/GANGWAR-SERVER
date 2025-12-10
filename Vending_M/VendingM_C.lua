
local SellerPed = {
  {168,2227.4,-1743.4,13.5,0},
  {168,2142.3,-1157.7,24,-90},
  {168,1589.7,-1286.4,17.5,180},
  {168,1001,-1848.1,12.8,160},
  {168,388.9,-2072.6,7.8,0}
}

for k,v in pairs(SellerPed)do
  local Ped = createPed(SellerPed[k][1],SellerPed[k][2],SellerPed[k][3],SellerPed[k][4],SellerPed[k][5])
  setElementFrozen(Ped,true)
end

addEventHandler("onClientPedDamage",resourceRoot, function ()
    cancelEvent() 
end)


addEvent("UseVendingM", true)
addEventHandler("UseVendingM", localPlayer, function(id)
    local animations = {
        VendingSoda = {
            sfx = {type = "script", id = 203},
            animations = {
                {anim = "vending", animName = "vend_use", delay = 200},
                {anim = "vending", animName = "vend_drink2_p", delay = 2500},
                {anim = nil, animName = nil, delay = 4500},
            },
            delay = 4500,
        },
        HotDog = {
            sfx = {type = "script", id = 151},
            animations = {
                {anim = "FOOD", animName = "EAT_Burger", delay = 200},
                {anim = nil, animName = nil, delay = 3000},
            },
            delay = 3000,
        },
    }

    local animationData = animations[id]
    if animationData then
        local sfxData = animationData.sfx
        if sfxData then
            playSFX(sfxData.type, sfxData.id, 0, false)
        end
        setElementFrozen(localPlayer, true)
        toggleAllControls(false)
        for _, animData in ipairs(animationData.animations) do
            setTimer(setPedAnimation, animData.delay, 1, localPlayer, animData.anim, animData.animName, -1, true, false, false, true, 100)
        end
        setTimer(setElementFrozen, animationData.delay, 1, localPlayer, false)
        setTimer(toggleAllControls, animationData.delay , 1, true)
    end
end)