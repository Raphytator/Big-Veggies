local game = {}

local sprites = {}
local tomate = {}
local img = {}
local quad = {}
local txt = {}
local btn = {}
local pompeUp, argent, timerHarvest, etat, timerHarvestMax, nbTomates, timerWorker
local timerHarvestBase = 30
local goal = 250000
local lvlPerk = {}
local imgPetiteTomate

function game.init()
    sprites.background = creaSprite(love.graphics.newImage("img/background.png"), 0, 0)

    --< GROW >------------------------------------------------

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

    local txtMultiplicator = "Multiplicator"
    txt.multiplicator = creaTxt(txtMultiplicator, _fonts.texte, _ecran.w - _fonts.texte:getWidth(txtMultiplicator) - 15, 15)
    imgPetiteTomate = love.graphics.newImage("img/petiteTomate.png")

    txt.music = creaTxt("F5 : Music on/off", _fonts.texte, 5, _ecran.h - _fonts.texte:getHeight("W"))

    --< SHOP >------------------------------------------------

    local imgPanelWood = love.graphics.newImage("img/panelWood.png")
    sprites.panelWood = creaSprite(imgPanelWood, (_ecran.w - imgPanelWood:getWidth()) / 2, (_ecran.h - imgPanelWood:getHeight()) / 2)

    txt.argentGagne = creaTxt("Earned money : +$", _fonts.titre2, sprites.panelWood.x + 60, sprites.panelWood.y + 25)
    txt.argentActuel = creaTxt("Actual money : $", _fonts.titre2, sprites.panelWood.x + 80, txt.argentGagne.y + txt.argentGagne.font:getHeight("W") + 5)
    txt.objectif = creaTxt("Goal : $"..parseNumber(goal), _fonts.titre2, sprites.panelWood.x + 100, txt.argentActuel.y + txt.argentActuel.font:getHeight("W") + 5)

    local imgBtnPerk = love.graphics.newImage("img/buttonPerk.png")
    local imgBtnPerkHover = love.graphics.newImage("img/buttonPerkHover.png")
    local tier = sprites.panelWood.img:getWidth() / 3
    btn.perk = {}
    btn.perk[1] = creaBtn("perk", sprites.panelWood.x + 120, sprites.panelWood.y + 185, imgBtnPerk, imgBtnPerkHover, "Pump")
    btn.perk[2] = creaBtn("perk", sprites.panelWood.x + 350 , btn.perk[1].y, imgBtnPerk, imgBtnPerkHover, "Time")
    btn.perk[3] = creaBtn("perk", sprites.panelWood.x + 580 , btn.perk[1].y, imgBtnPerk, imgBtnPerkHover, "Worker")

    local imgBtn = love.graphics.newImage("img/button.png")
    local imgBtnHover = love.graphics.newImage("img/buttonHover.png")
    btn.continuer = creaBtn("img", (_ecran.w - imgBtn:getWidth()) / 2, sprites.panelWood.y + sprites.panelWood.img:getHeight() - imgBtn:getHeight() - 25, imgBtn, imgBtnHover, "Continue")

    txt.perk = {}
    txt.perk[1] = creaTxt("Increase power of the pump", _fonts.texte, 0, btn.perk[1].y + btn.perk[1].img:getHeight() + 12, {0,0,0,1}, _ecran.w, "center")
    txt.perk[2] = creaTxt("Increase time before harvesting", _fonts.texte, 0, btn.perk[1].y + btn.perk[1].img:getHeight() + 12, {0,0,0,1}, _ecran.w, "center")
    txt.perk[3] = creaTxt("Auto-pump each 5 seconds", _fonts.texte, 0, btn.perk[1].y + btn.perk[1].img:getHeight() + 12, {0,0,0,1}, _ecran.w, "center")

end 

function game.load()
    game.demarre()
end 

function game.update(dt)

    if etat == "grow" then 

        timerHarvest = timerHarvest + dt

        if lvlPerk[3] > 0 then 
            timerWorker = timerWorker + dt 
            if timerWorker >= 5 then 
                timerWorker = 0
                for i=1, lvlPerk[3] do 
                    game.pump()
                end
            end 
        end 

        local wQuad = img.barreReceptacle:getWidth() / 100 * (timerHarvest / timerHarvestMax * 100)
        quad.barreReceptacle = love.graphics.newQuad(0, 0, wQuad, img.barreReceptacle:getHeight(), img.barreReceptacle:getWidth(), img.barreReceptacle:getHeight())
        
        tomate.value = (tomate.size - 1) * 5
        txt.tomateValue.txt = "$"..parseNumber(tomate.value)

        if timerHarvest >= timerHarvestMax then 
            game.harvest()
        end

        if love.mouse.isDown(1) and not _clic then 
            _clic = true
            game.pump()
        end 
    elseif etat == "shop" then  

        if argent >= btn.perk[1].value then btn.perk[1]:update(game.amlPerk, {1}) end
        if argent >= btn.perk[2].value then btn.perk[2]:update(game.amlPerk, {2}) end
        if argent >= btn.perk[3].value then btn.perk[3]:update(game.amlPerk, {3}) end

        btn.continuer:update(game.returnGame)
    end 
end 

function game.draw()
    sprites.background:draw()

    txt.music:print()

    --< Multiplicator >--------------------------------------------
    txt.multiplicator:print()
    local xTomate = _ecran.w - imgPetiteTomate:getWidth() - 10
    for i=1, nbTomates do 
        love.graphics.draw(imgPetiteTomate, xTomate, txt.multiplicator.y + txt.multiplicator.font:getHeight("W") + 5)
        xTomate = xTomate - imgPetiteTomate:getWidth() - 10
    end

    --< Pump >--------------------------------------------
    if pompeUp then sprites.pompeUp:draw()
    else sprites.pompeDown:draw() end

    --< Timer >--------------------------------------------
    txt.timeHarvest:print()
    sprites.fondReceptacle:draw()
    love.graphics.draw(img.barreReceptacle, quad.barreReceptacle, sprites.fondReceptacle.x, sprites.fondReceptacle.y)
    sprites.receptacle:draw()

    --< Tomato >--------------------------------------------
    sprites.tomate:draw()
    txt.tomateValue:print()

    --< Shop >--------------------------------------------
    if etat == "shop" then  
        drawVoile()
        sprites.panelWood:draw()
        txt.argentGagne:print()
        txt.argentActuel:print()
        txt.objectif:print()
        btn.continuer:draw()

        for k, v in pairs(btn.perk) do 
            v:draw()
        end 

        if btn.perk[1].hover then txt.perk[1]:print() end
        if btn.perk[2].hover then txt.perk[2]:print() end
        if btn.perk[3].hover then txt.perk[3]:print() end
    end 
end 

function game.demarre()
    lvlPerk = {1, 1, 0}
    argent = 0
    timerHarvestMax = timerHarvestBase
    game.returnGame()
end 

function game.newTomate()
    tomate.size = 1
    tomate.value = 1
    sprites.tomate.sx = 0.05
    sprites.tomate.sy = 0.05
end 

function game.pump()
    pompeUp = not pompeUp
    tomate.size = tomate.size + lvlPerk[1]
    if sprites.tomate.sx < 1 then 
        sprites.tomate.sx = sprites.tomate.sx + (.001 * lvlPerk[1])
        sprites.tomate.sy = sprites.tomate.sy + (.001 * lvlPerk[1])
    else 
        nbTomates = nbTomates + 1
        sprites.tomate.sx = 0.05
        sprites.tomate.sy = 0.05
    end 
end

function game.harvest()
    txt.argentGagne.suppl = parseNumber(tomate.value).." x"..nbTomates
    argent = argent + tomate.value * nbTomates
    txt.argentActuel.suppl = parseNumber(argent)

    if argent >= goal then 
        chgScene(_scene.victoire)
    else
        game.checkBtnPerk()
        etat = "shop"
    end
end 

function game.checkBtnPerk()
    btn.perk[1].lvl = lvlPerk[1]
    btn.perk[2].lvl = lvlPerk[2]
    btn.perk[3].lvl = lvlPerk[3]

    btn.perk[1].value = lvlPerk[1] * math.ceil(600 * 1.8)
    btn.perk[2].value = lvlPerk[2] * math.ceil(850 * 1.8)
    btn.perk[3].value = (lvlPerk[3] + 1) * math.ceil(200 * 1.8)

    if argent < btn.perk[1].value then btn.perk[1].disable = true else btn.perk[1].disable = false end
    if argent < btn.perk[2].value then btn.perk[2].disable = true else btn.perk[2].disable = false end
    if argent < btn.perk[3].value then btn.perk[3].disable = true else btn.perk[3].disable = false end
end

function game.returnGame()
    pompeUp = true
    game.initQuadReceptacle()
    timerHarvest = 0
    timerWorker = 0
    nbTomates = 1
    game.newTomate()
    etat = "grow"
end 

function game.initQuadReceptacle()
    quad.barreReceptacle = love.graphics.newQuad(0, 0, 0, img.barreReceptacle:getHeight(), img.barreReceptacle:getWidth(), img.barreReceptacle:getHeight())
end 

function game.amlPerk(pPerk)
    argent = argent - btn.perk[pPerk].value
    txt.argentActuel.suppl = parseNumber(argent)
    lvlPerk[pPerk] = lvlPerk[pPerk] + 1
    timerHarvestMax = timerHarvestBase + (lvlPerk[2] - 1) * 2
    game.checkBtnPerk()
end 

return game