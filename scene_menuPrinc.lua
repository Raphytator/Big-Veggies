local menuPrinc = {}

local sprites = {}
local txt = {}

function menuPrinc.init()
    sprites.fond = creaSprite(love.graphics.newImage("img/mainMenu.png"), 0, 0)
    txt.demarrage = creaTxt("Click to start", _fonts.titre, 240, 450)
end 

function menuPrinc.load()

end 

function menuPrinc.update(dt)
    if love.mouse.isDown(1) and not _clic then 
        _clic = true
        chgScene(_scene.introduction)
    end 
end 

function menuPrinc.draw()
    sprites.fond:draw()
    txt.demarrage:print()
end 

return menuPrinc