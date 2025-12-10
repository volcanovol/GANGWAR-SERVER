local spamLimit = 3 -- the maximum number of messages a player can send in the spamTime period
local spamTime = 5 -- the time period (in seconds) during which the spamLimit applies
local spamCount = {} -- a table to store the number of messages each player has sent

function onPlayerChat(message, messageType)
    if messageType == 0 then -- check if it's a regular chat message
      cancelEvent()
        local playerID = source -- get the ID of the player who sent the message
        if not spamCount[playerID] then -- if the player doesn't have an entry in the spamCount table yet
            spamCount[playerID] = 1 -- add an entry with a count of 1
        else
            spamCount[playerID] = spamCount[playerID] + 1 -- increment the player's message count
        end
        if spamCount[playerID] > spamLimit then -- if the player has exceeded the spam limit
            cancelEvent() -- cancel the chat message event
            outputChatBox("أنت ترسل الكثير من الرسائل بسرعة كبيرة. يرجى الانتظار لبضع ثوانٍ قبل إرسال رسالة أخرى.", playerID, 255, 0, 0) -- inform the player that they are spamming
            setTimer(function() spamCount[playerID] = nil end, spamTime*1000, 1) -- reset the player's message count after the spamTime period has passed
        else -- if the player is not spamming
            local playerX, playerY, playerZ = getElementPosition(source) -- Get the position of the player who sent the message
            local chatRadius = 10 -- Set the chat radius to 10 meters
            local players = getElementsByType("player") -- Get a table of all players in the server
            for i, player in ipairs(players) do
                local targetX, targetY, targetZ = getElementPosition(player) -- Get the position of the current player in the loop
                local distance = getDistanceBetweenPoints3D(playerX, playerY, playerZ, targetX, targetY, targetZ) -- Calculate the distance between the two players
                if distance <= chatRadius then -- If the player is within the chat radius, send them the message
                    outputChatBox("#FFFFFF["..getPlayerName(source).."]: #FFD700"..message, player, 255, 255, 255, true) -- Send the message to the player in white color with the sender's name in gold color
                end
            end
        end
    end
end
addEventHandler("onPlayerChat", root, onPlayerChat)