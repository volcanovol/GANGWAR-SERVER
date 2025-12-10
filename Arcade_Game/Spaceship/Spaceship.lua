

addEvent("ArcadeSpaceshipSaveScore", true)
addEventHandler("ArcadeSpaceshipSaveScore", getRootElement(),function (SpaceshipScore)
    local account = getPlayerAccount(source)
    setAccountData(account, "SpaceshipScore", SpaceshipScore)
end)