function init()
    initVariables()
    initRootFunctions()
    initFonts()
    initScenes()
    initGame()
end 

function initVariables()
    _ecran = { w = 1280, h = 720 }
end 

function initRootFunctions()
    love.window.setMode(_ecran.w, _ecran.h)
    love.window.setTitle("Big Veggies - Ludum Dare 52 - By Raphytator - Januray 2023")
end 

function initFonts()
    _fonts = {}
    _fonts.titre = love.graphics.newFont("font/HVD_Comic_Serif_Pro.otf", 48)
    _fonts.texte = love.graphics.newFont("font/HVD_Comic_Serif_Pro.otf", 24)
end 

function initScenes()
    _scene = {}
    _scene.introduction = require("scene_introduction")
    _scene.game = require("scene_game")
end 

function initGame()
    _sceneActu = _scene.introduction
end 