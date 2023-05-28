local timer     = require('timer')

local all_timers = {}

all_timers.timers = {

    timer:Create("hello", 0.03, function()
        _G.player.pos.x = _G.player.pos.x + _G.direction.x * 2.5
        _G.player.pos.y = _G.player.pos.y + _G.direction.y * 2.5
    end),

    timer:Create("Countdown", 1, function()
        if not _G.timer.enabled then return end
        _G.timer.value = _G.timer.value - 1
        if _G.timer.value <= 0 then
            _G.timer.value = 0
            _G.changeScene("GameOver")
        end
    end)
}

return all_timers