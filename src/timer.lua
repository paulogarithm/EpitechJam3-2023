local TM = {}

TM.timers = {}

function TM:Create(name, time, fun)
    local timer = {}

    timer.fun = fun
    timer.name = name
    timer.interval = time
    timer.clock = 0
    table.insert(TM.timers, timer)
    return timer
end

function TM:Destroy(name)
    table.remove(TM.timers, table.seek(TM.timers, function (_, val)
        if val == name then return true end
    end))
end

function TM:Tick(dt)
    for _, t in pairs(TM.timers) do
        t.clock = t.clock + dt
        if t.clock < t.interval then goto continue end
        t.fun()
        t.clock = t.clock - t.interval
        ::continue::
    end
end

return TM