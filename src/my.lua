local function convertArgs(arg)
    if type(arg) == 'table' then
        local ret = "{\n"
        for key, value in pairs(arg) do
            ret = ret .. "  " .. tostring(key) .. " = " .. tostring(value) ..",\n"
        end
        ret = ret .. "}"
        return ret
    end
    return tostring(arg)
end

_G.print = function (...)
    local args = {...}
    local format = {}

    for i, arg in ipairs(args) do
        format[i] = convertArgs(arg)
    end
    local formattedText = table.concat(format, "\n")
    io.write(formattedText .. "\n")
end

_G.table.seek = function (table, callback)
    for key, val in table do
        if callback(key, val) == true then
            return key
        end
    end
    return nil
end
