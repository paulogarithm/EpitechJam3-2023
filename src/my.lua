local function convertArgs(arg)
    if type(arg) == 'table' then
        local ret = "{\n"
        for key, value in pairs(arg) do
            ret = ret .. "  " .. tostring(key) .. " = " .. tostring(value) ..",\n"
        end
        ret = ret .. "}\n"
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
    io.write(formattedText)
end