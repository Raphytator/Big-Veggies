io.stdout:setvbuf("no")

require("init")
require("graphics")

function love.load()
    init()
end 

function love.update(dt)
    _sceneActu.update(dt)
end 

function love.draw()
    _sceneActu.draw()
end 

function love.keypressed(key)
    _sceneActu.keypressed(key)
    if key == "f12" then 
        love.event.quit()
    end
end 