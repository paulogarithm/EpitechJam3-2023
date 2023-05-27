local Vector = require('./vector')
local menu   = require('./menu')

local direction = Vector.new(0, 0)

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

    local ret = keysPressed[key]()
    if not ret or not Vector.isVector(ret) then return true end

    direction = press and Vector.add(direction, ret) or Vector.sub(direction, ret)
    print(direction)
    return true
end

local checkMenu = function (key)
    menu.keypressed(key)
end

love.keypressed = function (key)
    if checkMouvment(key, true) then return end
    if checkMenu(key) then return end
end

love.keyreleased = function (key)
    if checkMouvment(key, false) then return end
end

return {}