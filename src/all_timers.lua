local timer     = require('./timer')

local all_timers = {}

all_timers.timers = {

    timer:Create("hello", 0, function()
        _G.player.x = _G.player.x + _G.direction.x * 1.75
        _G.player.y = _G.player.y + _G.direction.y * 1.75
    end),

}

return all_timers