local map = {}

function FileExists(filename)
    local f = io.open(filename, "rb")
    if f then f:close() end
    return f ~= nil
end

function LinesFrom(filename)
    if not FileExists(filename) then return {} end
    local lines = {}
    for line in io.lines(filename) do 
        lines[#lines + 1] = line
    end
    return lines
end

local ParseMap = function (filename)
    local lines = LinesFrom(filename)
    for _, l in pairs(lines) do
        local words = string.split(l, " ")
        print(words)
    end
end

function map:Create()

end

map.Setup = function ()
    ParseMap("maps/map1.txt")
    --> table.insert(_G.scenes.Game.maps, map:Create(...))
end

return map
