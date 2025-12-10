
local screenW, screenH = guiGetScreenSize()
local x, y = (screenW/1366), (screenH/768)

checkBox1 = guiCreateCheckBox(x*519, y*389, x*17, y*18, "", false, false)
checkBox2 = guiCreateCheckBox(x*731, y*389, x*17, y*18, "", false, false)

guiSetVisible(checkBox1, false)
guiSetVisible(checkBox2, false)

guiSetAlpha(checkBox1, x*0)
guiSetAlpha(checkBox2, x*0)

userAlpha = x*150
passAlpha = x*150

alpha = 0
logo = 0
cor = {}

local dxfont0_font = dxCreateFont("gfx/font/font.ttf", x*13)
local dxfont1_font = dxCreateFont("gfx/font/font.ttf", x*10)
local dxfont2_font = dxCreateFont("gfx/font/font.ttf", x*18)


local fontScale = false

editBox = {}
editBox.__index = editBox
editBox.instances = {}

function onClientResourceStart()
    guiSetInputMode ( "no_binds" )
	local font_EditBox = dxCreateFont("gfx/font/font_EditBox.ttf", x*20)

	user = editBox.new()
	user:setPosition(x*519, y*274, x*332, y*35, "Usuário", false)
	user.color = {0,0,0,255}
	user.font = font_EditBox
	user.text = ""
	user.visible = true
	user.onInput = function()
		userAlpha = 255
	end
	user.onOutput = function()
		userAlpha = 150
	end

	pass = editBox.new()
	pass:setPosition(x*519, y*344, x*332, y*35, "Senha", false) 
	pass.color = {0,0,0,255}
	pass.font = font_EditBox
	pass.masked = true
	pass.visible = true
	pass.onInput = function()
		passAlpha = 255
	end
	pass.onOutput = function()
		passAlpha = 150
	end
     
	setTimer(function()
	end, 2500, 1)
	showChat(false)
	showCursor(true)
	guiSetVisible(checkBox1, true)
	guiSetVisible(checkBox2, true)
	addEventHandler("onClientRender", getRootElement(), crown)
	addEventHandler("onClientRender", getRootElement(), renderMensagesLogin)

	if not fontScale then fontScale = screenH/100 end

	local username, password = loadLoginFromXML()

	if not(username == "" or password == "") then
		guiCheckBoxSetSelected(checkBox1, true)
		user.text = tostring(username)
		pass.text = tostring(password)
	else
		guiCheckBoxSetSelected(checkBox1, false)
		user.text = tostring(username)
		pass.text = tostring(password)
	end
end
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), onClientResourceStart)

----------------------------------------------------------------------------------------------------------------------------------------------

function crown()
        dxDrawImage(screenW * 0.0000, screenH * 0.0000, screenW * 1.0000, screenH * 1.0000, ":data/image/Menu/Manu.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawImage(x*612, y*100, x*135, y*111, "gfx/img/logo.png",logo, 0, 0, tocolor(255, 255, 255, 255), false)

	   
	    


	cor[1] = tocolor(0, 0, 0, 110)
	cor[2] = tocolor(0, 0, 0, 110)
	cor[3] = tocolor(0, 0, 0, 110)

	if cursorPosition(x*462, y*422, x*151, y*52) then cor[1] = tocolor(255, 165, 0, 255) end
	if cursorPosition(x*613, y*422, x*151, y*52) then cor[2] = tocolor(255, 165, 0, 255) end
	if cursorPosition(x*764, y*422, x*148, y*52) then cor[3] = tocolor(255, 165, 0, 255) end
	
	    dxDrawRectangle(x*462, y*422, x*151, y*52, cor[1], false)
        dxDrawRectangle(x*613, y*422, x*151, y*52, cor[2], false)
        dxDrawRectangle(x*764, y*422, x*148, y*52, cor[3], false)
		
        dxDrawLine(x*462 - 1, y*224 - 1, x*462 - 1, y*474, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine(x*912, y*224 - 1, x*462 - 1, y*224 - 1, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine(x*462 - 1, y*474, x*912, y*474, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine(x*912,y*474, x*912, y*224 - 1, tocolor(0, 0, 0, 255), 1, false)
        dxDrawRectangle(x*462, y*224, x*450, y*250, tocolor(0, 0, 0, alpha), false)

        dxDrawLine(x*462 - 1, y*224 - 1, x*462 - 1, y*474, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine(x*912, y*224 - 1, x*462 - 1, y*224 - 1, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine(x*462 - 1, y*474, x*912, y*474, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine(x*912,y*474, x*912, y*224 - 1, tocolor(0, 0, 0, 255), 1, false)
        dxDrawRectangle(x*462, y*224, x*450, y*250, tocolor(0, 0, 0, 110), false)
        dxDrawImage(x*472, y*264, x*47, y*45, "gfx/img/user.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawImage(x*472, y*334, x*47, y*45, "gfx/img/pass.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawText("تسجيل دخول", x*504, y*436, x*586, y*464, tocolor(255, 255, 255, 255), 1.00, dxfont0_font, "left", "top", false, false, true, false, false)--Login
        dxDrawText("تخطي", x*643, y*436, x*725, y*464, tocolor(255, 255, 255, 255), 1.00, dxfont0_font, "left", "top", false, false, true, false, false)--Sign in without login
        dxDrawText("إنشاء حساب", x*794, y*436, x*876, y*464, tocolor(255, 255, 255, 255), 1.00, dxfont0_font, "left", "top", false, false, true, false, false)--Register

        dxDrawText("Lembrar Login", x*542, y*389, x*627, y*418, tocolor(255, 255, 255, 255), 1.00, dxfont0_font, "left", "top", false, false, false, false, false)--Remember login
        dxDrawText("Mostrar Senha", x*754, y*389, x*839, y*418, tocolor(255, 255, 255, 255), 1.00, dxfont0_font, "left", "top", false, false, false, false, false)--Show Password

		dxDrawEmptyRec(x*519, y*389, x*17, y*18, tocolor(255, 255, 255, 255), 1)
		dxDrawEmptyRec(x*731, y*389, x*17, y*18, tocolor(255, 255, 255, 255), 1)
	

	if guiCheckBoxGetSelected(checkBox1) == true then
		dxDrawImage(x*519, y*389, x*17, y*18, "gfx/img/confirm.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)--confirmed button
	else
	end

	if guiCheckBoxGetSelected(checkBox2) == true then
		pass.masked = false
		dxDrawImage(x*731, y*389, x*17, y*18, "gfx/img/confirm.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)--confirmed button
	else
		pass.masked = true


    end

	for k, self in pairs(editBox.instances) do
		if self.visible then
			local px, py, pw, ph = self:getPosition()
			local text = self.masked and string.gsub(self.text, ".", "•") or self.text
			local alignX = dxGetTextWidth(text, self.scale, self.font) <= pw and "left" or "right"
			dxDrawRectangle(px, py, pw, ph, tocolor(unpack(self.color)))
			dxDrawText(text, px + x*5, py, px - x*5 + pw, py + ph, tocolor(unpack(self.textColor)), self.scale, self.font, alignX, "center", true)
			if self.input and dxGetTextWidth(text, self.scale, self.font) <= pw then
				local lx = dxGetTextWidth(text, self.scale, self.font) + px + x*8
				local lx = dxGetTextWidth(text, self.scale, self.font) + px + x*8
				dxDrawLine(lx, py + y*10, lx, py + ph - y*10, tocolor(255, 255, 255, math.abs(math.sin(getTickCount() / 300))*200), 1)
			end
		end
	end

	if getKeyState("backspace") then
		for k, self in pairs(editBox.instances) do
			if self.visible and self.input then
				if not keyState then
					keyState = getTickCount() + 400
					self.text = string.sub(self.text, 1, string.len(self.text) - 1)
				elseif keyState and keyState < getTickCount() then
					keyState = getTickCount() + 100
					self.text = string.sub(self.text, 1, string.len(self.text) - 1)
				end
				return
			end
		end
		keyState = nil
	end
end

----------------------------------------------------------------------------------------------------------------------------------------------

function loginClick(botao, state)
	if botao == "left" and state == "down" then
		for k, self in pairs(editBox.instances) do
			if self.visible then
				if self.input then
					self.input = nil
					self.onOutput()
				end
				local x, y, w, h = self:getPosition()
				if cursorPosition(x, y, w, h) then
					self.input = true
					self.onInput()
				end
			end
		end
	elseif cursorPosition(x*462, y*422, x*151, y*52) then
		if guiCheckBoxGetSelected(checkBox1) == true then
			checksave = true
		else
			checksave = false
		end
		triggerServerEvent("login", getLocalPlayer(), user.text, pass.text, checksave)
	elseif cursorPosition(x*764, y*422, x*148, y*52) then
		triggerServerEvent("registrar", getLocalPlayer(), user.text, pass.text)	
	elseif cursorPosition(x*613, y*422, x*151, y*52) then
    	stopSound( sound )
		guiSetInputMode ( "allow_binds" )
	    removeEventHandler("onClientRender", getRootElement(), crown)
	    removeEventHandler("onClientRender", getRootElement(), renderMensagesLogin)
	    removeEventHandler("onClientClick", getRootElement(), loginClick)
	    removeEventHandler("onClientCharacter", getRootElement(), onClientCharacter)
	    showCursor(false)
		showChat(true)
    setTimer( startskin, 200, 1, source )

		
	end
end
addEventHandler("onClientClick", getRootElement(), loginClick)

----------------------------------------------------------------------------------------------------------------------------------------------

function cursorPosition(x, y, width, height)
	if (not isCursorShowing()) then
		return false
	end
	local sx, sy = guiGetScreenSize()
	local cx, cy = getCursorPosition()
	local cx, cy = (cx*sx), (cy*sy)
	if (cx >= x and cx <= x + width) and (cy >= y and cy <= y + height) then
		return true
	else
		return false
	end
end

----------------------------------------------------------------------------------------------------------------------------------------------

function onClientCharacter(character)
	if not isCursorShowing() then
		return
	end
	for k, self in pairs(editBox.instances) do
		if self.visible and self.input then
			if (string.len(self.text)) < self.maxLength then
				self.text = self.text..character
			end
		end
	end
end
addEventHandler("onClientCharacter", getRootElement(), onClientCharacter)

----------------------------------------------------------------------------------------------------------------------------------------------

function editBox.new()
	local self = setmetatable({}, editBox)
	self.text = ""
	self.maxLength = 30
	self.scale = y*0.8
	self.state = "normal"
	self.font = "sans"
	self.color = {255, 255, 255, 255}
	self.textColor = {255, 255, 255, 255}
	table.insert(editBox.instances, self)
	return self
end

function editBox:getPosition()
	return self.x, self.y, self.w, self.h
end

----------------------------------------------------------------------------------------------------------------------------------------------

function editBox:setPosition(x, y, w,h)
	self.x, self.y, self.w, self.h = x, y, w, h
	return true
end

----------------------------------------------------------------------------------------------------------------------------------------------

function dxDrawEmptyRec(absX, absY, sizeX, sizeY, color, ancho)
	dxDrawRectangle(absX, absY, sizeX, ancho, color)
	dxDrawRectangle(absX, absY + ancho, ancho, sizeY - ancho, color)
	dxDrawRectangle(absX + ancho, absY + sizeY - ancho, sizeX - ancho, ancho, color)
	dxDrawRectangle(absX + sizeX-ancho, absY + ancho, ancho, sizeY - ancho*2, color)
end

----------------------------------------------------------------------------------------------------------------------------------------------

function loadLoginFromXML()
	local xml_save_log_File = xmlLoadFile("gfx/xml/userdata.xml")
	if not xml_save_log_File then
		xml_save_log_File = xmlCreateFile("gfx/xml/userdata.xml", "login")
	end
	local usernameNode = xmlFindChild(xml_save_log_File, "username", 0)
	local passwordNode = xmlFindChild(xml_save_log_File, "password", 0)
	if usernameNode and passwordNode then
		return xmlNodeGetValue(usernameNode), xmlNodeGetValue(passwordNode)
	else
		return "", ""
	end
	xmlUnloadFile(xml_save_log_File)
end

----------------------------------------------------------------------------------------------------------------------------------------------

function saveLoginToXML(username, password)
	local xml_save_log_File = xmlLoadFile("gfx/xml/userdata.xml")
	if not xml_save_log_File then
		xml_save_log_File = xmlCreateFile("gfx/xml/userdata.xml", "login")
	end
	if (username ~= "") then
		local usernameNode = xmlFindChild(xml_save_log_File, "username", 0)
		if not usernameNode then
			usernameNode = xmlCreateChild(xml_save_log_File, "username")
		end
		xmlNodeSetValue(usernameNode, tostring(username))
	end
	if (password ~= "") then
		local passwordNode = xmlFindChild(xml_save_log_File, "password", 0)
		if not passwordNode then
			passwordNode = xmlCreateChild(xml_save_log_File, "password")
		end
		xmlNodeSetValue(passwordNode, tostring(password))
	end
	xmlSaveFile(xml_save_log_File)
	xmlUnloadFile(xml_save_log_File)
end
addEvent("saveLoginToXML", true)
addEventHandler("saveLoginToXML", getRootElement(), saveLoginToXML)

----------------------------------------------------------------------------------------------------------------------------------------------

function resetSaveXML()
	local xml_save_log_File = xmlLoadFile("gfx/xml/userdata.xml")
	if not xml_save_log_File then
		xml_save_log_File = xmlCreateFile("gfx/xml/userdata.xml", "login")
	end
	if (username ~= "") then
		local usernameNode = xmlFindChild(xml_save_log_File, "username", 0)
		if not usernameNode then
			usernameNode = xmlCreateChild(xml_save_log_File, "username")
		end
		xmlNodeSetValue(usernameNode, "")
	end
	if (password ~= "") then
		local passwordNode = xmlFindChild(xml_save_log_File, "password", 0)
		if not passwordNode then
			passwordNode = xmlCreateChild(xml_save_log_File, "password")
		end
		xmlNodeSetValue(passwordNode, "")
	end
	xmlSaveFile(xml_save_log_File)
	xmlUnloadFile(xml_save_log_File)
end
addEvent("resetSaveXML", true)
addEventHandler("resetSaveXML", getRootElement(), resetSaveXML)

----------------------------------------------------------------------------------------------------------------------------------------------

function removeLogin()
    stopSound( sound )

	user.visible = false
	pass.visible = false
	--setCameraTarget(localPlayer)
	guiSetVisible(checkBox1, false)
	guiSetVisible(checkBox2, false)
	removeEventHandler("onClientRender", getRootElement(), crown)
	removeEventHandler("onClientRender", getRootElement(), renderMensagesLogin)
	removeEventHandler("onClientClick", getRootElement(), loginClick)
	removeEventHandler("onClientCharacter", getRootElement(), onClientCharacter)	
	showCursor(false)
	showChat(true)
    guiSetInputMode ( "allow_binds" )

	
end
addEvent("removeLogin", true)
addEventHandler("removeLogin", getRootElement(), removeLogin)

----------------------------------------------------------------------------------------------------------------------------------------------

local fontMsg = dxCreateFont("gfx/font/font.ttf", x*18, true) or "default-bold"

mensages = {}
messagetick = 0

function servermessagesLogin(message, type)
	table.insert(mensages, {message, type or "confirm", getTickCount(), dxGetTextWidth(message, fontScale*0.08, fontMsg) + screenW*0.01, 0, 0, 0})
	messagetick = getTickCount()
end
addEvent("servermessagesLogin", true)
addEventHandler("servermessagesLogin", getRootElement(), servermessagesLogin)

----------------------------------------------------------------------------------------------------------------------------------------------

function renderMensagesLogin()
	local msgd = mensages
	if #msgd ~= 0 then
		local startY = screenH*0.5
		local i = 1
		repeat
			mData = msgd[i]
			local drawThis = true
			if i~= 1 then
				startY = startY + screenH*0.0425
			end
			if mData[5] == 0 and mData[6] == 0 then
				mData[5] = - mData[4] - screenW*0.015
				mData[6] = startY
				mData[7] = startY
			end
			local tick = getTickCount() - mData[3]
			local posX, posY, alpha
			if tick < 1000 then
				local progress = math.min(tick/1000,1)
				mData[5] = interpolateBetween(mData[5], 0, 0, 0, 0, 0, progress, "Linear")
			elseif tick >= 1000 and tick <= 7000 then
				mData[5] = 0
			elseif tick > 7000 then
				local progress = math.min((tick - 7000)/1000,1)
				mData[5] = interpolateBetween(mData[5], 0, 0, - mData[4] - mData[4] - screenW*0.015, 0, 0, progress, "Linear")
				if progress >= 1 then
					table.remove(msgd, i)
					drawThis = false
					messagetick = getTickCount()
				end
			end
			local globalTick = getTickCount() - messagetick
			if drawThis then
				mData[7] = startY
				mData[6] = interpolateBetween(mData[6], 0, 0, mData[7], 0, 0, math.min(globalTick/1000,1), "Linear")
				posX = mData[5]
				posY = mData[6]
				alpha = 255
				dxDrawRectangle(posX, posY, mData[4], screenH*0.04, tocolor(0, 0, 0, 100), true)
				local r, g, b = 255, 0, 0
				if mData[2] == "warning" then
					r, g, b = 255, 0, 0
				end
				dxDrawRectangle(posX + mData[4], posY, screenW*0.006, screenH*0.04, tocolor(r, g, b, alpha), true)
				dxDrawText(mData[1], posX, posY, posX + mData[4], posY + screenH*0.04, tocolor(255, 255, 255, alpha), fontScale*0.07, fontMsg, "center", "center", false, false, true, false, false)
			end
			i = i + 1
		until i > #msgd
		mensages = msgd
	end
end

----------------------------------------------------------------------------------------------------------------------------------------------

local alphaState = true

function alphaFunction()
	if alphaState == true then
		alpha = alpha + 2
	if alpha >= 110 then
		alphaState = false
	end
	end
	if alphaState == false then
		alpha = alpha - 2
	if alpha <= 0 then
		alphaState = true
		end
	end
end
addEventHandler("onClientRender", getRootElement(), alphaFunction)

----------------------------------------------------------------------------------------------------------------------------------------------

function apagarScript()
	if fileExists("client.lua") then
		fileDelete("client.lua")
	end
end
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), apagarScript)
addEventHandler("onClientPlayerQuit", getRootElement(), apagarScript)
addEventHandler("onClientPlayerJoin", getRootElement(), apagarScript)