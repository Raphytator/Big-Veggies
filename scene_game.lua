local game = {}

local sprites = {}
local tomate = {}
local img = {}
local quad = {}
local txt = {}
local pompeUp, forcePompe, argent, timerHarvest, etat, timerHarvestMax

function game.init()
    sprites.background = creaSprite(love.graphics.newImage("img/background.png"), 0, 0)
    local imgTomate = love.graphics.newImage("img/tomate.png")
    sprites.tomate = creaSprite(imgTomate, 910, 660, 1, 1, imgTomate:getWidth() / 2, imgTomate:getHeight())

    sprites.pompeUp = creaSprite(love.graphics.newImage("img/pompe_up.png"), 120, 175)
    sprites.pompeDown = creaSprite(love.graphics.newImage("img/pompe_down.png"), 120, 175)

    local xReceptacle = 20
    local yReceptacle = 50
    sprites.fondReceptacle = creaSprite(love.graphics.newImage("img/fond_receptacle.png"), xReceptacle, yReceptacle)
    sprites.receptacle = creaSprite(love.graphics.newImage("img/receptacle.png"), xReceptacle, yReceptacle)

    img.barreReceptacle = love.graphics.newImage("img/barre_receptacle.png")
    game.initQuadReceptacle()

    txt.timeHarvest = creaTxt("Time before harvesting", _fonts.texte, 70, 15)
    txt.tomateValue = creaTxt("", _fonts.titre, 20, _ecran.h - _fonts.titre:getHeight("W") - 5, {0,0,0,1}, _ecran.w - 40, "right")
end 

function game.load()
    game.demarre()
end 

function game.update(dt)

    if etat == "grow" then 

        timerHarvest = timerHarvest + dt

        local wQuad = img.barreReceptacle:getWidth() / 100 * (timerHarvest / timerHarvestMax * 100)
        quad.barreReceptacle = love.graphics.newQuad(0, 0, wQuad, img.barreReceptacle:getHeight(), img.barreReceptacle:getWidth(), img.barreReceptacle:getHeight())
        
        tomate.value = (tomate.size - 1) * 5
        txt.tomateValue.txt = "$"..parseNumber(tomate.value)

        if timerHarvest >= timerHarvestMax then 
            game.harvest()
        end

        if love.mouse.isDown(1) and not _clic then 
            _clic = true
            pompeUp = not pompeUp
            tomate.size = tomate.size + forcePompe
            if sprites.tomate.sx < 1 then 
                sprites.tomate.sx = sprites.tomate.sx + (.001 * forcePompe)
                sprites.tomate.sy = sprites.tomate.sy + (.001 * forcePompe)
            else 
                sprites.tomate.sx = 1 
                sprites.tomate.sy = 1 
            end 
        end 
    elseif etat == "shop" then  

    end 
end 

function game.draw()
    sprites.background:draw()

    if pompeUp then sprites.pompeUp:draw()
    else sprites.pompeDown:draw() end

    txt.timeHarvest:print()
    sprites.fondReceptacle:draw()
    love.graphics.draw(img.barreReceptacle, quad.barreReceptacle, sprites.fondReceptacle.x, sprites.fondReceptacle.y)
    sprites.receptacle:draw()

    sprites.tomate:draw()
    txt.tomateValue:print()

    if etat == "shop" then  
        drawVoile()

    end 
end 

function game.keypressed(key)

end

function game.demarre()
    forcePompe = 1
    argent = 0
    timerHarvestMax = 30
    game.returnGame()
end 

function game.newTomate()
    tomate.size = 1
    tomate.value = 1
    sprites.tomate.sx = 0.05
    sprites.tomate.sy = 0.05
end 

function game.harvest()

    etat = "shop"
end 

function game.returnGame()
    pompeUp = true
    game.initQuadReceptacle()
    timerHarvest = 0
    game.newTomate()
    etat = "grow"
end 

function game.initQuadReceptacle()
    quad.barreReceptacle = love.graphics.newQuad(0, 0, 0, img.barreReceptacle:getHeight(), img.barreReceptacle:getWidth(), img.barreReceptacle:getHeight())
end 

return game