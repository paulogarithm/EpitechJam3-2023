local Vector = require('./vector')
local menu = require('./menu')

local keysPressed = {
    z = function()
        return Vector.new(0, -1)
    end,
    s = function()
        return Vector.new(0, 1)
    end,
    q = function()
        return Vector.new(-1, 0)
    end,
    d = function()
        return Vector.new(1, 0)
    end
}

local checkMouvment = function(key, press)
    if not keysPressed[key] then
        return
    end
    if _G.scene ~= "Game" then
        return
    end

    local ret = keysPressed[key]()
    if not ret or not Vector.isVector(ret) then
        return true
    end
    _G.direction = press and Vector.add(_G.direction, ret) or Vector.sub(_G.direction, ret)
    return true
end

local checkMenu = function(key)
    if _G.scene ~= "Menu" then
        return true
    end
    if menu.keypressed(key) then
        return
    end
    return true
end

local CheckShapeShift = function(key)
    if _G.scene ~= "Game" then
        return
    end
    if key ~= "r" then
        return
    end
    _G.player.changeColor()
    return true
end

local CheckBackgroud = function(key)
    if _G.scene ~= "Game" then
        return
    end
    if key ~= "i" then
        return
    end
    if _G.scenes.Game.color[1] == 0 and _G.scenes.Game.color[2] == 0 and _G.scenes.Game.color[3] == 0 then
        _G.scenes.Game.color = {255, 255, 255}
    else
        _G.scenes.Game.color = {0, 0, 0}
    end
    _G.changeScene("Game")
end


love.keypressed = function(key)
    if checkMouvment(key, true) then return end
    if not checkMenu(key) then return end
    if CheckShapeShift(key) then return end
    if not CheckBackgroud(key) then return end
end

love.keyreleased = function(key)
    if checkMouvment(key, false) then return end
end

return {}
