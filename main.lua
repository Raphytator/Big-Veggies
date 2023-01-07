io.stdout:setvbuf("no")

require("init")
require("graphics")
require("functions")

function love.load()
    init()
end 

function love.update(dt)
    _sceneActu.update(dt)

    if not love.mouse.isDown(1) then 
        _clic = false
    end 
end 

function love.draw()
    _sceneActu.draw()
end 

function love.keypressed(key)
    if _sceneActu.keypressed ~= nil then _sceneActu.keypressed(key) end
    if key == "f12" then 
        love.event.quit()
    end
end 