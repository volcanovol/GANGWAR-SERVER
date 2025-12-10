
addEvent("MedUse", true)
addEventHandler("MedUse", getRootElement(),function ()
 local slot = getPedWeaponSlot(client)
 if slot == 10 then
  takeWeapon(client,11)
  setElementHealth(client,100)
 end
end)