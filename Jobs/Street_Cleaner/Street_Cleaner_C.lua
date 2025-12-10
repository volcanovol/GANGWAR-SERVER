
addEvent("Street_Been_Cleaned", true)
addEventHandler("Street_Been_Cleaned",localPlayer,function()
    playSFX("genrl", 52, 18, false)
    exports ["info_Text"]:InfoText("تم تنظيف الشارع اذهب الى العلامة الثالية",10000)
end)
