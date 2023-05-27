local timer     = require('./timer')

local all_timers = {}

all_timers.timers = {

    timer:Create("hello", 1, function()
        print("hello")
    end),

}

return all_timers