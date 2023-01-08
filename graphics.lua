--[[
██████╗  ██████╗ ██╗   ██╗████████╗ ██████╗ ███╗   ██╗███████╗
██╔══██╗██╔═══██╗██║   ██║╚══██╔══╝██╔═══██╗████╗  ██║██╔════╝
██████╔╝██║   ██║██║   ██║   ██║   ██║   ██║██╔██╗ ██║███████╗
██╔══██╗██║   ██║██║   ██║   ██║   ██║   ██║██║╚██╗██║╚════██║
██████╔╝╚██████╔╝╚██████╔╝   ██║   ╚██████╔╝██║ ╚████║███████║
╚═════╝  ╚═════╝  ╚═════╝    ╚═╝    ╚═════╝ ╚═╝  ╚═══╝╚══════╝
                                                              
]]

function btnDraw(pBtn)
    local color
    --if pBtn.type == "img" then    
        if pBtn.pressed then
            pBtn.img = pBtn.imgDefault
            color = {.4,.4,.4,1}
        elseif pBtn.hover then
            pBtn.img = pBtn.imgHover
            if pBtn.hoverColor == nil then 
                color = {1,1,0,1}
            else 
                color = pBtn.hoverColor
            end
        else
            pBtn.img = pBtn.imgDefault
            color = {.8,.8,.8,1}

            if not pBtn.disable then 
                color = {0,0,0,1}
            else 
                color = {.4, .4, .4, 1}
            end
        end

        love.graphics.draw(pBtn.img, pBtn.x, pBtn.y, pBtn.r, pBtn.sx, pBtn.sy, pBtn.ox, pBtn.oy)
        if pBtn.txt ~= nil then
            love.graphics.setColor(color)
            love.graphics.setFont(pBtn.font)
            love.graphics.printf(pBtn.txt, pBtn.x, pBtn.y + pBtn.txtY, pBtn.img:getWidth(), "center")
            love.graphics.setColor(1,1,1,1)
        end 

        if pBtn.type == "perk" then 
            
            love.graphics.setColor(color)
            love.graphics.setFont(pBtn.font)
            love.graphics.printf("lvl : "..pBtn.lvl, pBtn.x, pBtn.y + 60, pBtn.img:getWidth(), "center")
            love.graphics.setFont(_fonts.texte)            
            love.graphics.printf("$"..parseNumber(pBtn.value), pBtn.x, pBtn.y + 130, pBtn.img:getWidth(), "center")
            love.graphics.setColor(1,1,1,1)
        end

    --end
end

function btnUpdate(pBtn, pEvent, pVar, pClic)               
    if love.mouse.getX() >= pBtn.x - pBtn.ox and
        love.mouse.getX() <= (pBtn.x - pBtn.ox + pBtn.w) and
        love.mouse.getY() >= pBtn.y - pBtn.oy and
        love.mouse.getY() <= (pBtn.y - pBtn.oy + pBtn.h) then
                    
        pBtn.hover = true
    else
        pBtn.hover = false
        pBtn.pressed = false
    end

    local wichClic
    if pClic ~= nil then 
        wichClic = pClic
    else 
        wichClic = 1
    end 

    if pBtn.hover and love.mouse.isDown(wichClic) and not _clic and not pBtn.disable and
        pBtn.pressed == false and pBtn.oldButtonState == false then
        pBtn.pressed = true
        pBtn.hover = false
        _clic = true
        
        -- if pBtn.son ~= nil then
        --     pBtn.son:stop()
        --     pBtn.son:play()
        -- end
        
        if pEvent ~= nil then 
            if pVar ~= nil then 
                pEvent(pVar[1], pVar[2], pVar[3], pVar[4])
            else 
                pEvent()
            end
        end
    else
        if pBtn.pressed and not love.mouse.isDown(wichClic) then pBtn.pressed = false end    
    end
    pBtn.oldButtonState = love.mouse.isDown(wichClic)
end

function creaBtn(pType, x, y, ...) 

    local tab = {}
    tab.x = x
    tab.y = y  
    tab.type = pType
    tab.hover = false
    tab.pressed = false
    tab.disable = false
    tab.oldButtonState = false
    tab.r = 0
    tab.sx = 1
    tab.sy = 1
    tab.ox = 0
    tab.oy = 0   
    tab.disable = false

    local args = {...}

    tab.imgDefault = args[1]
    tab.imgHover = args[2]
    tab.img = tab.imgDefault
    tab.w = tab.imgDefault:getWidth()
    tab.h = tab.imgDefault:getHeight()
    tab.txt = args[3] or nil
    tab.font = _fonts.btn
    
    if pType == "img" then
        tab.txtY = (tab.img:getHeight() - tab.font:getHeight("W")) / 2
    elseif pType == "perk" then
        tab.txtY = 5
        tab.lvl = 1
        tab.value = 0
    end
    
    -- Fonctions
    tab.draw = btnDraw 
    tab.update = btnUpdate          

    return tab
end

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
