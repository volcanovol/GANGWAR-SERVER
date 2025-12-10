--/sfxBrowser.
setDevelopmentMode(true)
showCol(true)

local screenW, screenH = guiGetScreenSize()
local Sx, Sy = (screenW/1920), (screenH/1080)
local size = (Sx + Sy)

local invulnerable = false

addEventHandler("onClientPlayerSpawn", localPlayer,function ()
    invulnerable = true
    fadeCamera(false,0,0,0,0)
    setTimer(function() invulnerable = false end, 10000, 1)
    setTimer(function()fadeCamera(true,2,0,0,0)end,3500,1)
end)

addEventHandler("onClientPlayerDamage", localPlayer,function (attacker)
    if invulnerable == true then -- if the player is invulnerable, cancel the damage event
        cancelEvent()
    end
end)

addEvent("enableSpawnProtection", true)
addEventHandler("enableSpawnProtection", root, 
function (bool)
	for _,v in pairs( getElementsByType("player") ) do
		setElementCollidableWith(v, source, not bool)
	end
	setTimer(
		function()
			for _,v in pairs( getElementsByType("player") ) do
				setElementCollidableWith(v, localPlayer, bool)
			end
		end, 10000, 1
	)
end)



addEventHandler("onClientRender", root,
    function()
        dxDrawText("WWW.KEMGG.COM", screenW * 0.0078, screenH * 0.9625, screenW * 0.1016, screenH * 0.9861, tocolor(255, 254, 254, 100), size/1.5, "default-bold", "center", "center", false, false, false, false, false)
    end
)