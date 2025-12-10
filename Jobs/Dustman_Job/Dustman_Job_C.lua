
addEvent("Garbage_has_been_collected", true)
addEventHandler("Garbage_has_been_collected",localPlayer,function()
    playSFX("genrl", 52, 18, false)
    local stock = getElementData(localPlayer,"Dustman_stock")
    if stock < 5 then
      exports ["info_Text"]:InfoText("تم جمع القمامة اذهب الى الموقع التالي",10000)
    else
      exports ["info_Text"]:InfoText("لقد جمعت الكثير من القمامة، اذهب لتفريغها في المكب",10000)
    end
end)

addEvent("Garbage_was_dumped", true)
addEventHandler("Garbage_was_dumped",localPlayer,function()
    exports ["info_Text"]:InfoText("تم تفريغ القمامة، شاحنتك الآن فارغة، يمكنك الآن الذهاب لجمع المزيد.",10000)
    playSFX("genrl", 52, 18, false)
end)

