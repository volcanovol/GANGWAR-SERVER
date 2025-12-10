local DrugDealerId = {28, 29, 30}
local DrugDealerLoc = {}
local DrugDealerNumber = 5

local AllPeds = getElementsByType("ped", resourceRoot)
for i, v in pairs(AllPeds) do
  local x, y, z = getElementPosition(v)
  local xr,yr,zr = getElementRotation(v)
  local id = getElementModel(v)
  destroyElement(v)
  table.insert(DrugDealerLoc, {x, y, z, zr, "DrugDealer"})
end


function SpawnDrugDealer()
    local Id = DrugDealerId[math.random(#DrugDealerId)]
    local coordIndex = math.random(#DrugDealerLoc)
    local newCoord = DrugDealerLoc[coordIndex]
    
    local useLoc = {x = newCoord[1], y = newCoord[2], z = newCoord[3], zr = newCoord[4]}
    local Ped = createPed(Id, newCoord[1], newCoord[2], newCoord[3], newCoord[4])
    setElementData(Ped, "DrugDealerLoc", toJSON(useLoc))
    setElementID(Ped, newCoord[5])
    giveWeapon(Ped, 22, 16, true)
    setElementFrozen(Ped, true)
    setPedAnimation(Ped, "dealer", "dealer_idle_01", -1, true, false, false, true)
    
    table.remove(DrugDealerLoc, coordIndex) -- remove used location
end


for i = 1, DrugDealerNumber do
    SpawnDrugDealer()
end


function PedWasted()
  local x, y, z = getElementPosition(source)
  exports["Drop_Loot"]:MakeMoney(x, y, z, 5, 100)
  setTimer(destroyElement, 30000, 1, source)
  setTimer(SpawnDrugDealer, 30000, 1)
  local myTableData = fromJSON(getElementData(source, "DrugDealerLoc"))
  table.insert(DrugDealerLoc, {myTableData.x, myTableData.y, myTableData.z, myTableData.r, "DrugDealer"})
end
addEventHandler("onPedWasted", resourceRoot, PedWasted)
