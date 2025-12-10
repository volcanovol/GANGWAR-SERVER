

local RadarArea = createRadarArea(-3000, -3000, 6000, 6000, 0, 0, 255, 0)
local isBlue = true
setRadarAreaFlashing(RadarArea, true)
addEventHandler("onClientRender", root,
    function()
        if getPlayerWantedLevel(localPlayer) > 0 then
            if isBlue then
                setRadarAreaColor(RadarArea, 255, 0, 0, 80)
                setTimer(function() isBlue = false end,600,1)
            else
                setRadarAreaColor(RadarArea, 0, 0, 255, 80)
                setTimer(function() isBlue = true end,600,1)
            end
        else
            setRadarAreaColor(RadarArea, 0, 0, 255, 0)
           -- setRadarAreaFlashing(RadarArea, false)
        end
    end
)



