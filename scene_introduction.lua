local intro = {}

local sprites = {}
local txt = {}

local etatIntro

function intro.init()
    local introImg = {}
    introImg[1] = love.graphics.newImage("img/intro_1.png")
    introImg[2] = love.graphics.newImage("img/intro_2.png")
    introImg[3] = love.graphics.newImage("img/intro_3.png")

    sprites.intro = {}
    sprites.intro[1] = creaSprite(introImg[1], 0, 0)
    sprites.intro[2] = creaSprite(introImg[2], 0, 0)
    sprites.intro[3] = creaSprite(introImg[1], 0, 0)
    sprites.intro[4] = creaSprite(introImg[3], 0, 0)
    sprites.intro[5] = creaSprite(introImg[1], 0, 0)
    sprites.intro[6] = creaSprite(introImg[2], 0, 0)
    
    local txt1 = "Honney, we need to buy a new car !"
    local txt2 = "How much do we need ?"
    local txt3 = "Around $250.000."
    local txt4 = "Hum..... ok honney, i will sell some veggies, but that will take time."
    local txt5 = "I need it quickly !!"
    local txt6 = "I should try something different to increase the value of veggies."
        
    txt.intro = {}
    txt.intro[1] = creaTxt(txt1, _fonts.titre, 500, 80, {0,0,0,1}, 750, "left")
    txt.intro[2] = creaTxt(txt2, _fonts.titre, 50, 80, {0,0,0,1}, 750, "left")
    txt.intro[3] = creaTxt(txt3, _fonts.titre, 500, 80, {0,0,0,1}, 750, "left")
    txt.intro[4] = creaTxt(txt4, _fonts.titre, 50, 80, {0,0,0,1}, 750, "left")
    txt.intro[5] = creaTxt(txt5, _fonts.titre, 500, 80, {0,0,0,1}, 750, "left")
    txt.intro[6] = creaTxt(txt6, _fonts.titre, 50, 80, {0,0,0,1}, 750, "left")

    txt.continue = creaTxt("Click to continue", _fonts.titre, 0, 620, {0,0,0,1}, _ecran.w, "center")
end 

function intro.load()
    etatIntro = 1
end 

function intro.update(dt)
    local etatFinal = 6
    if love.mouse.isDown(1) and not _clic then 
        _clic = true
        if etatIntro < etatFinal then 
            etatIntro = etatIntro + 1
        else 
            chgScene(_scene.game)
        end 
    end 
end 

function intro.draw()
    sprites.intro[etatIntro]:draw()
    txt.intro[etatIntro]:print()
    txt.continue:print()
end 

return intro