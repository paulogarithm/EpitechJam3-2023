local Vector = require('./vector')
local menu   = require('./menu')

local keysPressed = {
    z = function ()
        return Vector.new(0, -1)
    end,
    s = function ()
        return Vector.new(0, 1)
    end,
    q = function ()
        return Vector.new(-1, 0)
    end,
    d = function ()
        return Vector.new(1, 0)
    end,
}

local checkMouvment = function (key, press)
    if not keysPressed[key] then return end
    if _G.scene ~= "Game" then return end

    local ret = keysPressed[key]()
    if not ret or not Vector.isVector(ret) then return true end
    _G.direction = press and Vector.add(_G.direction, ret) or Vector.sub(_G.direction, ret)
    return true
end

local checkMenu = function (key)
    if _G.scene ~= "Menu" then return true end
    if menu.keypressed(key) then return end
    return true
end

love.keypressed = function (key)
    if checkMouvment(key, true) then return end
    if not checkMenu(key) then return end
    print("test")
end

love.keyreleased = function (key)
    if checkMouvment(key, false) then return end
end

return {}