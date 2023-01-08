io.stdout:setvbuf("no")

require("init")
require("graphics")
require("functions")

function love.load()
    init()
end 

function love.update(dt)

    if _enableMusic then if not _music.theme:isPlaying() then _music.theme:play() end end
    _sceneActu.update(dt)

    if not love.mouse.isDown(1) then 
        _clic = false
    end 
end 

function love.draw()
    _sceneActu.draw()
end 

function love.keypressed(key)
    if key == "f5" then 
        _enableMusic = not _enableMusic
        if not _enableMusic then _music.theme:stop() end
    elseif key == "f12" then 
        love.event.quit()
    end
end 