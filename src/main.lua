local input     = require('./input')
local my        = require('./my')
local timer     = require('./timer')

love.load = function()
    love.graphics.setBackgroundColor(255, 255, 255)

    timer:Create("hello", .5, function ()
        print("hello")
    end)
end

love.draw = function ()
    
end

love.update = function (dt)
    timer:Tick(dt)
end
