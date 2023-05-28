local timer     = require('timer')

local all_timers = {}

all_timers.timers = {

    timer:Create("hello", 0.03, function()
        _G.player.pos.x = _G.player.pos.x + _G.direction.x * 2.5
        _G.player.pos.y = _G.player.pos.y + _G.direction.y * 2.5
    end),

}

return all_timers