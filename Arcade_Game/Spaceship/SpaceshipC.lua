local screenW, screenH = guiGetScreenSize()
local Sx, Sy = (screenW/1920), (screenH/1080)
local size = (Sx + Sy)
local GameOn = false
local GameStat = "InGame"
local Music
local Frame = 0
local Score = 0
local LaserPower = 0
local YourBestScore = 0
local StarfieldX = 0
local scrollSpeed = 0.005

local spaceshipImage = "Spaceship/gfx/Spaceship01.png"
local BosterImage = "Spaceship/gfx/Boster01.png"

local spaceshipX = 0.1914
local spaceshipY = 0.4083
local spaceshipSize = {w = 0.0406, h = 0.0597}
local spaceshipSpeed = 0.01

local bulletImage = "Spaceship/gfx/Shot02.png"
local bulletSize = {w = 0.0258, h = 0.02295}
local bullets = {}

local enemyImage = "Spaceship/gfx/Enemy02.png"
local enemySize = {w = 0.025, h = 0.05}
local enemies = {}

local enemyImage2 = "Spaceship/gfx/EnemyB02.png"
local enemySize2 = {w = 0.025, h = 0.05}
local enemies2 = {}

local PAWImage = dxCreateTexture("Spaceship/gfx/paw01.png")
local PAWSize = {w = 0.025, h = 0.05}
local PAWs = {}

local ExploImage = "Spaceship/gfx/Explosion01.png"
local ExploSize = {w = 0.025, h = 0.05}
local Explos = {}


------------------------------------عند بداية اللعبة / The beginning of the game----------------------------------
addEvent("ArcadeSpaceshipStart", true)
addEventHandler("ArcadeSpaceshipStart", root,function (SpaceshipScore)
    GameStat = "menuGame"
    GameOn = true
    YourBestScore = SpaceshipScore
    Music = playSound("Spaceship/sound/Theme.mp3",true)
    setSoundVolume(Music,0.1)
    setElementFrozen(localPlayer,true)
end)


---------------------------------الفريمات / the frames-----------------------------------------------
function GameFrame()
  Frame = Frame + 1
  if Frame == 30 then
  Frame = 0
  end
end

-----------------------------------تشغيل اصوات اللعبة /Play the game sounds -------------------------------
function SoundPlayer(path,loop)
  local sound = playSound(path,loop)
  setSoundVolume(sound,0.2)
end

---------------------------------اضافة السكور / Add score---------------------------
function ScoreCountAdd(Amount)
  Score = Score + Amount
end


----------------------------------خلفية متحركة / animated background---------------------------------------
function Starfield()
    StarfieldX = StarfieldX - scrollSpeed
    if StarfieldX < -1 then
        StarfieldX= 0
    end
    dxDrawImage(screenW * StarfieldX, screenH * 0.0000, screenW * 1.0000, screenH * 1.0000, "Spaceship/gfx/Starfield.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    dxDrawImage(screenW * StarfieldX + screenW, screenH * 0.0000, screenW * 1.0000, screenH * 1.0000, "Spaceship/gfx/Starfield.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
end

-------------------------------رسم المركبة الفضائية / Draw Spaceship------------------------------------------
function drawSpaceship()
  if (GameStat == "InGame") then
    dxDrawImage(screenW * spaceshipX, screenH * spaceshipY, screenW * spaceshipSize.w, screenH * spaceshipSize.h, spaceshipImage, 0, 0, 0, tocolor(255, 255, 255, 255), false)
    dxDrawImage(screenW * (spaceshipX - 0.018), screenH * spaceshipY, screenW * spaceshipSize.w, screenH * spaceshipSize.h, BosterImage, 0, 0, 0, tocolor(255, 255, 255, 255), false)
    if Frame >= 1 and Frame <= 7 then
        BosterImage = "Spaceship/gfx/Boster01.png"
    elseif Frame >= 7 and Frame <= 13 then
        BosterImage = "Spaceship/gfx/Boster02.png"
    elseif Frame >= 13 and Frame <= 19 then
        BosterImage = "Spaceship/gfx/Boster01.png"
    elseif Frame >= 19 and Frame <= 25 then
        BosterImage = "Spaceship/gfx/Boster02.png"
    end
  end
end

---------------------------------رسم الطلقة / Draw Bullets----------------------------------------------
function drawBullets()
    for i, bullet in ipairs(bullets) do
        dxDrawImage(screenW * (bullet.x + 0.05), screenH * (bullet.y + bullet.r), screenW * bulletSize.w, screenH * bulletSize.h, bulletImage, 0, 0, 0, tocolor(255, 255, 255, 255), false)
        bullet.x = bullet.x + 0.02 -- Move the bullet up
        if bullet.x > 0.85 then -- Remove the bullet if it goes off the screen
            table.remove(bullets, i)
        end
    end
end


----------------------------------رسم العدو / Draw Enemies -----------------------------------------
function drawEnemies()
  for i, enemy in ipairs(enemies) do
    if enemy.alive then
      dxDrawImage(screenW * enemy.x, screenH * enemy.y, screenW * enemySize.w, screenH * enemySize.h, enemyImage, 0, 0, 0, tocolor(255, 255, 255, 255), false)
      if Frame >= 1 and Frame <= 10 then
        enemyImage = "Spaceship/gfx/Enemy01.png"
      elseif Frame >= 10 and Frame <= 20 then
        enemyImage = "Spaceship/gfx/Enemy02.png"
      elseif Frame >= 20 and Frame <= 30 then
        enemyImage = "Spaceship/gfx/Enemy03.png"
      end
      enemy.x = enemy.x - 0.006 -- move enemy to the left
      if enemy.x < 0 then -- enemy has gone off screen
        table.remove(enemies, i) -- remove enemy from table
      end
    end
  end
end


function drawEnemies2()
  for i, enemy2 in ipairs(enemies2) do
    if enemy2.alive then
      dxDrawImage(screenW * enemy2.x, screenH * enemy2.y, screenW * enemySize2.w, screenH * enemySize2.h, enemyImage2, 0, 0, 0, tocolor(255, 255, 255, 255), false)
      if Frame >= 1 and Frame <= 10 then
        enemyImage2 = "Spaceship/gfx/EnemyB01.png"
      elseif Frame >= 10 and Frame <= 20 then
        enemyImage2 = "Spaceship/gfx/EnemyB02.png"
      elseif Frame >= 20 and Frame <= 30 then
        enemyImage2 = "Spaceship/gfx/EnemyB03.png"
      end
      enemy2.x = enemy2.x - 0.01 -- move enemy to the left
      if enemy2.x < 0 then -- enemy has gone off screen
        table.remove(enemies2, i) -- remove enemy from table
      end
    end
  end
end


------------------------------------رسم الطاقة /  Draw Power ------------------------------
function drawPAW()
  for i, PAW in ipairs(PAWs) do
    if PAW.alive then
      dxDrawImage(screenW * PAW.x, screenH * PAW.y, screenW * PAWSize.w, screenH * PAWSize.h, PAWImage, 0, 0, 0, tocolor(255, 255, 255, 255), false)
      PAW.x = PAW.x - 0.003 -- move enemy to the left
      if PAW.x < 0 then -- enemy has gone off screen
        table.remove(PAWs, i) -- remove enemy from table
      end
    end
  end
end


-------------------------------رسم الانفجار / Draw Explosions----------------------------------
function drawExplosions()
  for i, Explo in ipairs(Explos) do
      dxDrawImage(screenW * Explo.x, screenH * Explo.y, screenW * ExploSize.w, screenH * ExploSize.h, ExploImage, 0, 0, 0, tocolor(255, 255, 255, 255), false)
      if Frame >= 1 and Frame <= 10 then
        ExploImage = "Spaceship/gfx/Explosion01.png"
      elseif Frame >= 10 and Frame <= 20 then
        ExploImage = "Spaceship/gfx/Explosion02.png"
      elseif Frame >= 20 and Frame <= 30 then
        ExploImage = "Spaceship/gfx/Explosion03.png"
      end
    setTimer(function() table.remove(Explos, i) end, 200, 1)
  end
end



----------------------------------رسم لوحة السكور / Draw Scoreboard---------------------------------------
function drawScore()
  dxDrawText("CURRENT SCORE", screenW * 0.5789, screenH * 0.8014, screenW * 0.7844, screenH * 0.8431, tocolor(255, 255, 255, 255), 1.50, "default", "right", "center", false, false, false, false, false)
  dxDrawText(Score, screenW * 0.7922, screenH * 0.8014, screenW * 0.9273, screenH * 0.8431, tocolor(255, 255, 255, 255), 1.40, "default", "left", "center", false, false, false, false, false)
  
  dxDrawText("YOUR BEST SCORE", screenW * 0.5789, screenH * 0.8431, screenW * 0.7844, screenH * 0.8847, tocolor(255, 255, 255, 255), 1.50, "default", "right", "center", false, false, false, false, false)
  dxDrawText(YourBestScore, screenW * 0.7922, screenH * 0.8431, screenW * 0.9273, screenH * 0.8847, tocolor(255, 255, 255, 255), 1.50, "default", "left", "center", false, false, false, false, false)
end



---------------------------------رسم شاشة الخسارة ورسم شاشة البداية / Draw GAMEOVER screen and draw Menu screen -------------------------
function drawGAMEOVER()
  if GameStat == "GAME OVER" then
        dxDrawText("GAME OVER", (screenW * 0.3070) + 1, (screenH * 0.3361) + 1, (screenW * 0.6945) + 1, (screenH * 0.4528) + 1, tocolor(0, 0, 0, 255), size*2.5, dxfont0_Minecraft, "center", "center", false, false, false, false, false)
        dxDrawText("GAME OVER", screenW * 0.3070, screenH * 0.3361, screenW * 0.6945, screenH * 0.4528, tocolor(255, 0,0, 255), size*2.5, "bankgothic", "center", "center", false, false, false, false, false)
        
        dxDrawText("Your Score", screenW * 0.3070, screenH * 0.4528, screenW * 0.4805, screenH * 0.5167, tocolor(255, 255, 255, 255), size, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawText(Score, screenW * 0.5211, screenH * 0.4528, screenW * 0.6945, screenH * 0.5167, tocolor(255, 255, 255, 255), size, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawText("Press \"r\" to play again", screenW * 0.3070, screenH * 0.5306, screenW * 0.6945, screenH * 0.5958, tocolor(255, 255, 255, 255), size, "bankgothic", "center", "center", false, false, false, false, false)
  end
end

function drawMenuGame()
  if GameStat == "menuGame" then
    dxDrawImage(screenW * 0.4227, screenH * 0.1347, screenW * 0.1609, screenH * 0.2875, ":Arcade_Game/Spaceship/gfx/logo.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    dxDrawText("Earth protector", screenW * 0.3406, screenH * 0.4222, screenW * 0.6719, screenH * 0.4944, tocolor(255, 255, 255, 255), 1.00, "bankgothic", "center", "center", false, false, false, false, false)
    dxDrawText("Press \"space\" button to start", screenW * 0.2547, screenH * 0.5653, screenW * 0.7539, screenH * 0.6486, tocolor(255, 255, 255, 255), 1.00,"bankgothic", "center", "center", false, false, false, false, false)
  end
end



----------------------------------اضافة العدو الى اللعبة / Add the enemy to the game--------------------------
local EnemieSpawn = true
local SpawnLoc = {0.65,0.6,0.5,0.55,0.4,0.44,0.3,0.2,0.18}
function addEnemy()
  if EnemieSpawn then
    EnemieSpawn = false
    setTimer(function() EnemieSpawn = true end, 1000, 1)
    local enemy = {
      x = 1, -- start at the right edge of the screen
      y = SpawnLoc [ math.random ( #SpawnLoc ) ] ,
      alive = true
    }
  table.insert(enemies, enemy)
  end
end

local EnemieSpawn2 = true
local SpawnLoc2 = {0.65,0.6,0.5,0.55,0.4,0.44,0.3,0.2,0.18}
function addEnemy2()
  if EnemieSpawn2 then
    EnemieSpawn2 = false
    setTimer(function() EnemieSpawn2 = true end, 30000, 1)
    
    local enemy2 = {
      x = 1, -- start at the right edge of the screen
      y = SpawnLoc [ math.random ( #SpawnLoc ) ] ,
      alive = true
    }
  table.insert(enemies2, enemy2)
  SoundPlayer("Spaceship/sound/EnemyB.mp3",false)
  end
end

------------------------------وضع رمز الطاقة الى اللعبة / Add Power into the game-------------------------------
local PAWSpawn = true
local PAWLoc = {0.65,0.6,0.5,0.55,0.4,0.44,0.3,0.2,0.18}
function addPAW()
  if PAWSpawn then
    PAWSpawn = false
    setTimer(function() PAWSpawn = true end, 20000, 1)
    local PAW = {
      x = 1, -- start at the right edge of the screen
      y = PAWLoc [ math.random ( #PAWLoc ) ] ,
      alive = true
    }
  table.insert(PAWs, PAW)
  end
end
------------------------------- وضع الانفجار / Add Explosion effect--------------------------------
function addExplosions(x2,y2)
  local Explo = {x = x2,y = y2}
  table.insert(Explos, Explo)
end

----------------------------------التحقق من التصادم / Collision check--------------------------------
function checkCollisionsEnemy()
  for i, enemy in ipairs(enemies) do
    if enemy.alive then
      for j, bullet in ipairs(bullets) do
        if bullet.x >= enemy.x - enemySize.h and bullet.x <= enemy.x + enemySize.w
        and bullet.y >= enemy.y - enemySize.w and bullet.y <= enemy.y + enemySize.h then
          enemy.alive = false -- mark enemy as dead
          table.remove(bullets, j) -- remove bullet from table
          addExplosions(enemy.x ,enemy.y)
          SoundPlayer("Spaceship/sound/explosion2.mp3",false)
          ScoreCountAdd(100)
        end
      end
    end
  end
end

function checkCollisionsEnemy2()
  for i, enemy2 in ipairs(enemies2) do
    if enemy2.alive then
      for j, bullet in ipairs(bullets) do
        if bullet.x >= enemy2.x - enemySize2.h and bullet.x <= enemy2.x + enemySize2.w
        and bullet.y >= enemy2.y - enemySize2.w and bullet.y <= enemy2.y + enemySize2.h then
          enemy2.alive = false -- mark enemy as dead
          table.remove(bullets, j) -- remove bullet from table
          addExplosions(enemy2.x ,enemy2.y)
          SoundPlayer("Spaceship/sound/explosion2.mp3",false)
          ScoreCountAdd(200)
        end
      end
    end
  end
end

function checkCollisionsPAW()
  if (GameStat == "InGame") then
  for i, PAW in ipairs(PAWs) do
    if PAW.alive then
        if spaceshipX >= PAW.x - spaceshipSize.h and spaceshipX <= PAW.x + spaceshipSize.w
        and spaceshipY >= PAW.y - spaceshipSize.w and spaceshipY <= PAW.y + spaceshipSize.h then
          PAW.alive = false -- mark enemy as dead
          table.remove(PAWs, j) -- remove bullet from table
          SoundPlayer("Spaceship/sound/powerUp.mp3",false)
          LaserPower = 1
      end
    end
  end
  end
end

function checkCollisionsSpaceship()
  if (GameStat == "InGame") then
    for i, enemy in ipairs(enemies) do
      if enemy.alive then
          if spaceshipX >= enemy.x - spaceshipSize.h and spaceshipX <= enemy.x + spaceshipSize.w
          and spaceshipY >= enemy.y - spaceshipSize.w and spaceshipY <= enemy.y + spaceshipSize.h then
            enemy.alive = false -- mark enemy as dead
            addExplosions(spaceshipX ,spaceshipY)
            SoundPlayer("Spaceship/sound/explosion.mp3",false)
            GAME_OVER()
        end
      end
    end
  end
end




function checkCollisionsSpaceship2()
  if (GameStat == "InGame") then
    for i, enemy2 in ipairs(enemies2) do
      if enemy2.alive then
          if spaceshipX >= enemy2.x - spaceshipSize.h and spaceshipX <= enemy2.x + spaceshipSize.w
          and spaceshipY >= enemy2.y - spaceshipSize.w and spaceshipY <= enemy2.y + spaceshipSize.h then
            enemy2.alive = false -- mark enemy as dead
            addExplosions(spaceshipX ,spaceshipY)
            SoundPlayer("Spaceship/sound/explosion.mp3",false)
            GAME_OVER()
        end
      end
    end
  end
end

-----------------------------------عند الخروج من اللعبة / When you exit the game-----------------------------------
function ExitTheGame()
  if GameOn == true then
    GameStat = "menuGame"
    GameOn = false
    enemies = {}
    bullets = {}
    Frame = 0
    setElementFrozen(localPlayer,false)
    stopSound(Music)
    if Score > YourBestScore then
      triggerServerEvent("ArcadeSpaceshipSaveScore",localPlayer,Score)
      YourBestScore = Score
    end
    Score = 0
  end
end
--------------------------اذا اردت اللعب من جديد او لعب لعبة جديدة / If you want to play again or play a new game ------------------------------
function PlayAgain()
  if (GameOn == true) and ((GameStat == "menuGame") or (GameStat == "GAME OVER")) then
    GameStat = "InGame"
    enemies = {}
    bullets = {}
    Frame = 0
    Score = 0
    spaceshipImage = "Spaceship/gfx/Spaceship01.png"
    spaceshipX = 0.1914
    spaceshipY = 0.4083
    SoundPlayer("Spaceship/sound/start.mp3",false)
    stopSound(Music)
    Music = playSound("Spaceship/sound/Theme.mp3",true)
    setSoundVolume(Music,0.1)
  end
end

-------------------------------- اذا انفجرت المركبة و خسرت / If the Spaceship exploded and you lose ---------------------
function GAME_OVER()
  GameStat = "GAME OVER"
  spaceshipImage = ""
  Frame = 0
  stopSound(Music)
  Music = playSound("Spaceship/sound/GAME_OVER.mp3",false)
  setSoundVolume(Music,0.1)
  if Score > YourBestScore then
    triggerServerEvent("ArcadeSpaceshipSaveScore",localPlayer,Score)
    YourBestScore = Score
  end
end
-------------------------------أزرار اللاعب / player buttons------------------------------------------------
function PlayerKeyPress()
  if (GameStat == "InGame") then
  if (getKeyState("w")) and (spaceshipY > 0.12) then
    spaceshipY = spaceshipY - spaceshipSpeed
  elseif (getKeyState("s")) and (spaceshipY < 0.71) then
    spaceshipY = spaceshipY + spaceshipSpeed  
  elseif (getKeyState("a")) and (spaceshipX > 0.08)  then
    spaceshipX = spaceshipX - spaceshipSpeed
  elseif (getKeyState("d")) and (spaceshipX < 0.85) then
    spaceshipX = spaceshipX + spaceshipSpeed
  end
  end
end

local shootEnabled = true
function onClientKey(key, state)
  if (GameOn == true) then
    if (key == "space" or key == "mouse1") and (GameStat == "InGame") then -- Shoot when spacebar is pressed
        if shootEnabled then
            shootEnabled = false
            setTimer(function() shootEnabled = true end, 200, 1) -- Set a 1 second delay before enabling shooting again
            if LaserPower == 0 then
              table.insert(bullets, {x=spaceshipX, y=spaceshipY,r = 0.02})
            elseif LaserPower >= 1 then
              table.insert(bullets, {x=spaceshipX, y=spaceshipY,r = 0.02})
              table.insert(bullets, {x=spaceshipX, y=spaceshipY,r = 0})
            end
            SoundPlayer("Spaceship/sound/laserShoot.mp3",false)
        end
    elseif key == "f" then
      ExitTheGame()
    elseif key == "r" and GameStat == "GAME OVER" then
      PlayAgain()
    elseif key == "space" and GameStat == "menuGame" then
      PlayAgain()
    end
  end
end
addEventHandler("onClientKey", root, onClientKey)




-----------------------------------------------رسم الجرافيك كل فريم / Graphic drawing every frame----------------------------------------------------
addEventHandler("onClientRender", root,
    function()
      if GameOn == true then
        Starfield()
        drawSpaceship()
        PlayerKeyPress()
        GameFrame()
        drawBullets()
        drawEnemies()
        drawEnemies2()
        drawPAW()
        drawExplosions()
        addEnemy()
        addEnemy2()
        addPAW()
        checkCollisionsEnemy()
        checkCollisionsEnemy2()
        checkCollisionsSpaceship()
        checkCollisionsSpaceship2()
        checkCollisionsPAW()
        dxDrawImage(screenW * 0.0469, screenH * 0.7875, screenW * 0.9094, screenH * 0.1556, ":Timer/black.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawImage(screenW * 0.0000, screenH * 0.0000, screenW * 1.0000, screenH * 1.0000, "Spaceship/Screen_Spaceship.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        drawGAMEOVER()
        drawMenuGame()
        drawScore()
      end
    end
)
------------------------------------------------------------------------------------------------------

--[[  قديم
addEventHandler("onClientRender", root,
    function()
        dxDrawText("STAGE", screenW * 0.0922, screenH * 0.8014, screenW * 0.1492, screenH * 0.8389, tocolor(255, 255, 255, 255), 1.50, "default", "left", "center", false, false, false, false, false)
        dxDrawText("250", screenW * 0.1492, screenH * 0.8014, screenW * 0.2062, screenH * 0.8389, tocolor(255, 255, 255, 255), 1.50, "default", "left", "center", false, false, false, false, false)
        dxDrawText("PAWER ACT", screenW * 0.3883, screenH * 0.1222, screenW * 0.5945, screenH * 0.1625, tocolor(255, 255, 255, 255), 1.50, "default", "center", "center", false, false, false, false, false)
    end
)
--]]