
addEventHandler('onClientResourceStart', resourceRoot,function ()
    local txd = engineLoadTXD('medkit.txd')
    engineImportTXD(txd, 322)
    local dff = engineLoadDFF('medkit.dff', 322)
    engineReplaceModel(dff, 322)
end)

bindKey("mouse1", "down",function ()
    local slot = getPedWeaponSlot(localPlayer)
    local health = getElementHealth(localPlayer)
    if slot == 10 and health < 90 then
        setTimer(triggerServerEvent, 1000, 1,"MedUse", localPlayer)
        setPedAnimation(localPlayer, "misc", "pass_rifle_ply", -1, true, false, false, true, 250)
        setTimer(setPedAnimation, 1300, 1, localPlayer)
    end
end)
