local all_sprites   = require('all_sprites')
local Vector        = require('vector')

local map = {}

local TypeInstance = {
    enemy = "assets/ennemi",
    sheep = "assets/mouton",
    fence = "assets/cage",
    button = "assets/bouton"
}

local function FileExists(filename)
    local f = io.open(filename, "rb")
    if f then f:close() end
    return f ~= nil
end

local function LinesFrom(filename)
    if not FileExists(filename) then return {} end
    local lines = {}
    for line in io.lines(filename) do
        lines[#lines + 1] = line
    end
    return lines
end

local function ScanDir(directory)
    local i, t, popen = 0, {}, io.popen
    local pfile = popen('ls -a "'..directory..'"')

    for filename in pfile:lines() do
        i = i + 1
        t[i] = filename
    end
    pfile:close()
    return t
end

map.ParseMap = function(filename, num)
    if not FileExists(filename) then return end
    local lines = LinesFrom(filename)

    for _, l in pairs(lines) do
        local words = string.split(l, " ")
        if #words <= 0 then goto continue end

        if words[1] == "hoppy-says" then
            table.remove(words, 1)
            _G.map.hoppyQuote = table.concat(words, ' ')
            goto continue
        end

        if words[1] == "player" then
            _G.player.pos = Vector.new(tonumber(words[2]), tonumber(words[3]))
            if words[4] ~= _G.player.color then
                _G.player.changeColor()
            end
        end

        if TypeInstance[words[1]] == nil then goto continue end

        table.insert(_G.map.list[num], all_sprites:Create(
            TypeInstance[words[1]],
            Vector.new(tonumber(words[2]), tonumber(words[3])),
            .25,
            0,
            words[4]
        ))
        ::continue::
    end
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
        local num = tonumber(mapName:sub(1, -5))
        if num == nil then goto continue end
        _G.map.list[num] = {}
        --x map.ParseMap("maps/" .. mapName, num)
        ::continue::
    end
end

return map
