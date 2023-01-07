function chgScene(pNewScene)
    _sceneActu = pNewScene 

    if _sceneActu.initializedScene == nil then 
        _sceneActu.initializedScene = true 
        _sceneActu.init()
    end 

    if _sceneActu.load ~= nil then 
        _sceneActu.load()
    end 
end 

function parseNumber(pValue)
    local strValue = tostring(pValue)
    local str = ""
    local tab = {}
    for w in strValue:gmatch("%d") do 
        table.insert(tab, w)
    end
    local n=0
    for i=#tab, 1, -1 do 
        n = n + 1
        str = tab[i]..str 
        if n == 3 and i > 1 then 
            n = 0
            str = "."..str
        end 
    end 

    return str
end 