local victoire = {}

local sprites = {}
local txt = {}

function victoire.init()
    sprites.background = creaSprite(love.graphics.newImage("img/victory.png"), 0, 0)
    txt.victory = creaTxt("Victory !", _fonts.grosTitre, 540, 40)
    txt.victory.color = {1, 0.9, 0.2, 1}
    txt.quit = creaTxt("Thanks for playing, press F12 to quit.", _fonts.titre, 80, 620)
end 

function victoire.load()

end 

function victoire.update(dt)
    
end 

function victoire.draw()
    sprites.background:draw()
    txt.victory:print()
    txt.quit:print()
end 

return victoire