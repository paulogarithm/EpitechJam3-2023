local all_sprites   = require('all_sprites')
local Vector        = require('vector')

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

local TypeInstance = {
    enemy = "assets/ennemi",
    sheep = "assets/mouton",
    fence = "assets/cage",
}

local ParseMap = function(filename, num)
    local lines = LinesFrom(filename)

    for _, l in pairs(lines) do
        local words = string.split(l, " ")
        if #words <= 0 then goto continue end
        if TypeInstance[words[1]] == nil then goto continue end
        
        table.insert(_G.scenes.Game.maps[num].sprites, all_sprites:Create(
            TypeInstance[words[1]],
            Vector.new(tonumber(words[2]), tonumber(words[3])),
            .25,
            0,
            words[4]
        ))
        ::continue::
    end
end

function ScanDir(directory)
    local i, t, popen = 0, {}, io.popen
    local pfile = popen('ls -a "'..directory..'"')

    for filename in pfile:lines() do
        i = i + 1
        t[i] = filename
    end
    pfile:close()
    return t
end

map.Setup = function ()
    local files = ScanDir("maps")
    local realFiles = {}

    for _, value in pairs(files) do
        if string.starts(value, ".") then goto continue end
        if string.sub(value, -4) ~= ".txt" then goto continue end
        if not tonumber(value:sub(1, -5)) then goto continue end
        table.insert(realFiles, value)
        ::continue::
    end
    for _, mapName in pairs(realFiles) do
        _G.scenes.Game.maps[tonumber(mapName:sub(1, -5))] = {}
        _G.scenes.Game.maps[tonumber(mapName:sub(1, -5))].sprites = {}
        ParseMap("maps/" .. mapName, tonumber(mapName:sub(1, -5)))
    end
end

return map
