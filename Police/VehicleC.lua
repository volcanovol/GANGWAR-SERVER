local rental = false
local vehicleOrder = 1
local vehicleSelect = ""

local vehicleList = {523,596,598,599,427,490,528,601} 


local vehiclePrice = {
    [523]={Name = "HPV1000",Price = 1000, level = 1},
    [596]={Name = "Police LS",Price = 2000, level = 2},
    [598]={Name = "Police LV",Price = 2000, level = 2},
    [599]={Name = "Police Ranger",Price = 3000, level = 3},
    [427]={Name = "Enforcer",Price = 4000, level = 4},
    [490]={Name = "FBI Rancher	",Price = 5000, level = 5},
    [528]={Name = "FBI Truck	",Price = 6000, level = 6},
    [601]={Name = "S.W.A.T",Price = 7000, level = 7}
}

local displayVehicle = createVehicle(596,1543,-1667.4,6.1,0,0,238)
setElementDimension(displayVehicle,20)

addEvent("policeVehicleStart", true)
addEventHandler("policeVehicleStart", localPlayer,function()
    setElementDimension(localPlayer,20)
    toggleAllControls(false)
    showChat (false) 
    rental = true
    setCameraMatrix(1544.5,-1673.5,7.5,1543,-1667.4,6.0,0,90)
    exports ["info_Text"]:TutoText("استخدم عجلة الفأرة أو زر يمين ويسار للتبديل / لكل سيارة سعر ومستوى خاص بها",0)
end)



function NextVehicle()
    if rental and vehicleOrder < #vehicleList then
        vehicleOrder = vehicleOrder + 1
        local vehicleListId = vehicleList[vehicleOrder]
        local Name = vehiclePrice[vehicleListId].Name
        local Price = vehiclePrice[vehicleListId].Price
        local level = vehiclePrice[vehicleListId].level
        setElementModel(displayVehicle, vehicleListId)
        exports["info_Text"]:InfoText(""..Name.." / Price "..Price.." /  Police level "..level.."", 10000)
        playSFX("genrl", 53, 0, false)
    end
end
bindKey("d", "down", NextVehicle)
bindKey("mouse_wheel_down", "down", NextVehicle)

function PreviousVehicle()
    if rental and vehicleOrder > 1 then
        vehicleOrder = vehicleOrder - 1
        local vehicleListId = vehicleList[vehicleOrder]
        local Name = vehiclePrice[vehicleListId].Name
        local Price = vehiclePrice[vehicleListId].Price
        local level = vehiclePrice[vehicleListId].level
        setElementModel(displayVehicle, vehicleListId)
        exports["info_Text"]:InfoText(""..Name.." / Price "..Price.." /  Police level "..level.."", 10000)
        playSFX("genrl", 53, 0, false)
    end
end

bindKey("a", "down", PreviousVehicle)
bindKey("mouse_wheel_up", "down", PreviousVehicle)

bindKey("space", "down",function()
  if rental then
    local vehicleListId = vehicleList[vehicleOrder]
    local Price = vehiclePrice[vehicleListId].Price
    rental = false
    vehicleOrder = 1
    toggleAllControls(true)
    showChat (true) 
    setCameraTarget(localPlayer,localPlayer)
    setElementDimension(localPlayer,0)
    triggerServerEvent("policeVehicleBuy",localPlayer,Price,vehicleListId)
    playSFX("genrl", 53, 6, false)
    exports ["info_Text"]:TutoText("",10)
  end
end)


bindKey("f", "down",function()
  if rental then
    rental = false
    vehicleOrder = 1
    toggleAllControls(true)
    showChat (true) 
    setCameraTarget(localPlayer,localPlayer)
    setElementDimension(localPlayer,0)
    exports ["info_Text"]:TutoText("",10)
  end
  end)