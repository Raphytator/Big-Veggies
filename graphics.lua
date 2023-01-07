--[[
███████╗██████╗ ██████╗ ██╗████████╗███████╗███████╗
██╔════╝██╔══██╗██╔══██╗██║╚══██╔══╝██╔════╝██╔════╝
███████╗██████╔╝██████╔╝██║   ██║   █████╗  ███████╗
╚════██║██╔═══╝ ██╔══██╗██║   ██║   ██╔══╝  ╚════██║
███████║██║     ██║  ██║██║   ██║   ███████╗███████║
╚══════╝╚═╝     ╚═╝  ╚═╝╚═╝   ╚═╝   ╚══════╝╚══════╝
                                                    
]]

function spriteDraw(pSprite)
    love.graphics.setColor(1,1,1,pSprite.alpha)
    love.graphics.draw(pSprite.img, pSprite.x, pSprite.y, 0, pSprite.sx, pSprite.sy, pSprite.ox, pSprite.oy)
    love.graphics.setColor(1,1,1,1)
end 

function creaSprite(image, x, y, sx, sy, ox, oy)
    local tab = {}

    tab.img = image    
    tab.x = x 
    tab.y = y 
    tab.w = image:getWidth()
    tab.h = image:getHeight()
    if sx ~= nil then tab.sx = sx else tab.sx = 1 end
    if sy ~= nil then tab.sy = sy else tab.sy = 1 end
    if ox ~= nil then tab.ox = ox else tab.ox = 0 end
    if oy ~= nil then tab.oy = oy else tab.oy = 0 end

    tab.alpha = 1 

    -- Fonctions
    tab.draw = spriteDraw
    
    return tab
end 

--[[
████████╗███████╗██╗  ██╗████████╗███████╗███████╗
╚══██╔══╝██╔════╝╚██╗██╔╝╚══██╔══╝██╔════╝██╔════╝
   ██║   █████╗   ╚███╔╝    ██║   █████╗  ███████╗
   ██║   ██╔══╝   ██╔██╗    ██║   ██╔══╝  ╚════██║
   ██║   ███████╗██╔╝ ██╗   ██║   ███████╗███████║
   ╚═╝   ╚══════╝╚═╝  ╚═╝   ╚═╝   ╚══════╝╚══════╝
                                                  
]]

function txtPrint(pTxt)

    if pTxt.ombrage then 
        love.graphics.setFont(pTxt.ombrageFont)
        love.graphics.setColor(pTxt.ombrageColor)
        love.graphics.print(pTxt.txt, pTxt.x + 1, pTxt.y + 1)
    end 

    love.graphics.setFont(pTxt.font)
    love.graphics.setColor(pTxt.color)
    
    if pTxt.supplcolor == nil then 
        if pTxt.align == nil then 
            love.graphics.print(pTxt.txt..pTxt.suppl, pTxt.x, pTxt.y)
        else 
            love.graphics.printf(pTxt.txt..pTxt.suppl, pTxt.x, pTxt.y, pTxt.limite, pTxt.align)
        end 
    else     
        if pTxt.align == nil then 
            love.graphics.print(pTxt.txt, pTxt.x, pTxt.y)
            love.graphics.setColor(pTxt.supplcolor)
            love.graphics.print(pTxt.suppl, pTxt.x + pTxt.font:getWidth(pTxt.txt), pTxt.y)
        else
            love.graphics.printf(pTxt.txt, pTxt.x, pTxt.y, pTxt.limite, pTxt.align)
            love.graphics.setColor(pTxt.supplcolor)
            love.graphics.printf(pTxt.suppl, pTxt.x + pTxt.font:getWidth(pTxt.txt), pTxt.y, pTxt.limite, pTxt.align)
        end
    end 
    
    love.graphics.setColor(1,1,1,1)

    if pTxt.souligne then 
        if pTxt.align == nil then 
            drawLine(pTxt.x, pTxt.y + pTxt.font:getHeight("W"), pTxt.x + pTxt.font:getWidth(pTxt.txt), pTxt.y + pTxt.font:getHeight("W"), pTxt.color, 1)
        else
            local w = pTxt.font:getWidth(pTxt.txt)
            local x
            if pTxt.align == "center" then 
                x = pTxt.x + (pTxt.limite - w) / 2
            end 
            local y = pTxt.y + pTxt.font:getHeight("W")
            drawLine(x, y, x + w, y, {0,0,0,1}, 1)
        end
    end 
end

function txtAddOmbrage(pTxt, pFont, pColor)
    pTxt.ombrage = true 
    pTxt.ombrageFont = pFont 
    pTxt.ombrageColor = pColor
end 

function creaTxt(text, font, x, y, c, limite, align)
    local tab = {}

    tab.txt = text

    tab.x = x
    tab.y = y
    tab.font = font
    tab.w = font:getWidth(text)
    tab.h = font:getHeight(text)
    tab.limite = limite
    tab.align = align
    tab.txtClean = ""
    tab.souligne = false
    tab.suppl = ""
    tab.supplcolor = nil
    tab.ombrage = false

    if c == nil then tab.color = {0,0,0,1}
    else tab.color = c end

    tab.print = txtPrint
    tab.addOmbrage = txtAddOmbrage
    
    return tab
end

function drawRectangle(pType, x, y, w, h, color)
    love.graphics.setColor(color)
    love.graphics.rectangle(pType, x, y, w, h)
    love.graphics.setColor(1,1,1,1)
end

function drawVoile()
    drawRectangle("fill", 0, 0, _ecran.w, _ecran.h, {0,0,0,0.3})
end
