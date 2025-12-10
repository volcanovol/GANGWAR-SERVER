
local WeaponTruckPosition = {} 





function SpawnTrucks(VehiclePosition,BlipID,VehicleModel,VehicleID,R,G,B,BotList) --- سبون الشاحنات
    local i = math.random( 1, #VehiclePosition )
    local Vehicle = createVehicle(VehicleModel,VehiclePosition[i][1],VehiclePosition[i][2],VehiclePosition[i][3],0,0,VehiclePosition[i][4],"WeaponTruck",false,1,1)
    if R ~= nil then
      setVehicleColor(Vehicle,R,G,B)
    end
    setElementID(Vehicle,VehicleID)
    local Blip = createBlip(VehiclePosition[i][1],VehiclePosition[i][2],VehiclePosition[i][3],BlipID,0,0,0,0,0,0,350)
    AttachToVehicle(Blip,Vehicle,0,0,0)
    BotGuards(Vehicle,BotList)
end


SpawnTrucks(WeaponTruckPosition,51,455,"WeaponTruck",97,94,62,1)
SpawnTrucks(MoneyTruckPosition,52,428,"MoneyTruck",nil,nil,nil,2)
SpawnTrucks(DrugTruckPosition,25,414,"DrugTruck",nil,nil,nil,3)


function DeleteAndSpawnVehicle(source) ---- ريسبون المركبة ثم حذفها
  local ID = getElementID(source)
  if ID == "WeaponTruck" then
    SpawnTrucks(WeaponTruckPosition,51,455,"WeaponTruck",97,94,62,1)
  elseif ID == "MoneyTruck" then
    SpawnTrucks(MoneyTruckPosition,52,428,"MoneyTruck",nil,nil,nil,2)
  elseif ID == "DrugTruck" then
    SpawnTrucks(DrugTruckPosition,25,414,"DrugTruck",nil,nil,nil,3)
  end
  destroyElement(source)
end


addEventHandler("onVehicleExplode",resourceRoot,function () -- عند انفجار المركبة احذفها و اصنع جديدة
 DeleteAndSpawnVehicle(source)
end)

addEventHandler ("onVehicleEnter",resourceRoot,function (thePlayer, seat, jacked) ----- ارشادات اللاعب
 triggerClientEvent("InfoText",thePlayer,"انقل الحمولة إلى موقع تسليم المسروقات - العلم الأحمر الخاص بعصابتك.",10000)
end)