
addEvent("Pizza_was_delivered", true)
addEventHandler("Pizza_was_delivered",localPlayer,function()
    
    local x,y,z = getElementPosition(localPlayer)
    local pizza = createObject (1582, x,y,z,0,0,0,true)
    setTimer(function() destroyElement(pizza) end, 10000, 1)
    attachElements(pizza,localPlayer,0,1,-1)
    detachElements(pizza,localPlayer)
    setPedAnimation(localPlayer,"carry" ,"putdwn" , -1, false, false, false, true,100)
    setTimer(setPedAnimation,1000,1,localPlayer,nil ,nil , -1, false, false, false, true,100)
    local stock = getElementData(localPlayer,"Pizza_stock")
    playSFX("genrl", 52, 18, false)
    if stock > 0 then
      exports ["info_Text"]:InfoText(" تم توصيل الطرد باقي فقط "..stock.."علبة ",10000)
    else
      exports ["info_Text"]:InfoText("اذهب الى مطعم البيتزا للتزود بالمزيد",10000)
    end
    
end)



addEvent("Get_Stock_Pizza", true)
addEventHandler("Get_Stock_Pizza",localPlayer,function()
    
    setPedAnimation(localPlayer,"carry" ,"liftup" , -1, false, false, false, true,100)
    setTimer(setPedAnimation,1500,1,localPlayer,nil ,nil , -1, false, false, false, true,100)
    exports ["info_Text"]:InfoText("حصلت على 5 صناديق بيتزا، اذهب لتوزيعها",10000)
    playSFX("genrl", 52, 18, false)
    
end)

