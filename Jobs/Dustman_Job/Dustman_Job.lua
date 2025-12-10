local GarbageLocs = {}

-- استرداد جميع الأشياء من نوع الـobject
local Allobjects = getElementsByType("object")
for i, v in ipairs(Allobjects) do
  local id = getElementModel(v)
  
  -- إذا كان العنصر هو نفايات، حفظ موقعه ثم تدميره
  if id == 1344 then
    local x, y, z = getElementPosition(v)
    local xr, yr, zr = getElementRotation(v)
    table.insert(GarbageLocs, {x, y, z, zr, "Dustman_Job"})
    destroyElement(v)
  end
end

--createJobsClothes(2191.7,-1970.4,13.6,0,0,260)

-- إنشاء النفايات الجديدة
function createGarbage(player, Col)
  local loc = GarbageLocs[math.random(#GarbageLocs)]
  local object = createObject(1344, loc[1], loc[2], loc[3], 0, 0, loc[4])
  setElementID(object, loc[5])
  setElementFrozen(object, true)
  MikeBlipFor(object, player, 2)
  setElementParent(object, Col)
end


function MakeGarbageDump(player)
    local Marker = createMarker(2183.8, -1994.4, 12.5, "cylinder", 5, 255, 0, 0, 100, resourceRoot)
    setElementID(Marker, "Dustman_Job")
    local Col = getElementData(player, "Dustman_Col")
    setElementParent(Marker, Col)
    setElementVisibleTo(Marker, player, true)
    MikeBlipFor(Marker, player, 2)
end


-- إنهاء المهمة
function End_Dustman_Job(player)
  if isElement(player) then
    setElementData(player, "Mission", 0)
    destroyElement(getElementData(player, "Dustman_Col"))
  end
end

-- بدء المهمة
addEvent("Start_Dustman_Job", true)
addEventHandler("Start_Dustman_Job", getRootElement(), function ()
  local source = source
  if getElementData(source, "Mission") == 0 then
    setElementData(source, "Mission", 1)
    setElementData(source, "Dustman_stock", 0)
    local vehicle = getPedOccupiedVehicle(source)
    local x, y, z = getElementPosition(vehicle)
    local col = createColSphere(x, y, z, 2)
    attachElements(col, vehicle, 0, -4, 0)
    setElementData(source, "Dustman_Col", col)
    setElementData(col, "Get_Col_Dustman", source)
    createGarbage(source, col)
  end
end)

-- تدمير النفايات المجمعة وإنشاء نفايات جديدة
addEventHandler("onColShapeHit", resourceRoot, function(hitElement)
    if getElementType(hitElement) == "object" and getElementID(hitElement) == "Dustman_Job" and getElementParent(hitElement) == source then
        local player = getElementData(source, "Get_Col_Dustman")
        local stock = getElementData(player, "Dustman_stock")
        triggerClientEvent(player,"Garbage_has_been_collected", player)
        destroyElement(hitElement)
        if stock < 0 then
            stock = stock + 1
            setElementData(player, "Dustman_stock", stock)
            setTimer(createGarbage, 2000, 1, player, source)
        else
            MakeGarbageDump(player)
        end
    elseif getElementType(hitElement) == "marker" and getElementID(hitElement) == "Dustman_Job" and getElementParent(hitElement) == source then
        local player = getElementData(source, "Get_Col_Dustman")
        setElementData(player, "Dustman_stock", 0)
        createGarbage(player, source)
        triggerClientEvent(player,"Garbage_was_dumped", player)
        local x, y, z = getElementPosition(hitElement)
        local object = createObject(851, x, y, z + 0.5, 0, 0, 0, true)
        setObjectScale(object, 2.3)
        setTimer(function() destroyElement(object) end, 10000, 1)
        destroyElement(hitElement)
    end
end)

