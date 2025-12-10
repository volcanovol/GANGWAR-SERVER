
function login(username, password, checksave)
	if not (username == "") then
		if not (password == "") then
			local account = getAccount(username, password)
			if (account ~= false) then
				displayServerMessageLogin(source, "Logado com sucesso", "confirm")
				logIn(source, account, password)
				triggerClientEvent(source, "removeLogin", getRootElement())
        triggerClientEvent("startskinS", source)
				if checksave == true then
					triggerClientEvent(source, "saveLoginToXML", getRootElement(), username, password)
				else
					triggerClientEvent(source, "resetSaveXML", getRootElement(), username, password)
				end
			else
				displayServerMessageLogin(source, "اسم المستخدم أو كلمة المرور غير صحيحة", "تحذير")--Incorrect username or password
			end
		else
			displayServerMessageLogin(source, "اكتب كلمة المرور الخاصة بك", "تحذير")---type your password
		end
	else
		displayServerMessageLogin(source, "أدخل اسم المستخدم الخاص بك", "تحذير")--type username
	end
end
addEvent("login", true)
addEventHandler("login", getRootElement(), login)

function registrar(username, password)
	if not (username == "") then
		if not (password == "") then
			local account = getAccount(username, password)
			if (account == false) then
				local accountAdded = addAccount(tostring(username), tostring(password))
				if (accountAdded) then
					displayServerMessageLogin(source, "Login: "..username.."  |  Senha: "..password.."", "confirm")
				else
					displayServerMessageLogin(source, "خطأ حاول مجددا", "تحذير")--Error, please try again
				end
			else
				displayServerMessageLogin(source, "اسم مستخدم مستعمل", "حذير")--This username already exists
			end
		else
			displayServerMessageLogin(source, "أدخل كلمة السر", "حذير")--type your password
		end
	else
		displayServerMessageLogin(source, "ادخل اسم المستخدم", "حذير")--type username
	end
end
addEvent("registrar", true)
addEventHandler("registrar", getRootElement(), registrar)

function displayServerMessageLogin(source, message, type)
	triggerClientEvent(source, "servermessagesLogin", getRootElement(), message, type)
end