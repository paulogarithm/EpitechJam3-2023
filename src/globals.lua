local Vector = require('vector')
local all_sprites = require('all_sprites')
local create_maps = require('create_maps')

-- Defines

_G.map = {
    current = 0,
    list = {}
}

_G.currentScene = nil

_G.scenes = {
    Game = {
        sprites = {},
        color = { 255, 255, 255 },
    },
    Menu = {
        sprites = {},
        color = { 0, 0, 0 },
    }
}

_G.player = all_sprites:Create("assets/perso", Vector.new(100, 100), .3, 0, "white")
_G.player.changeColor = function()
    local image = "assets/perso"
    local newColor = _G.player.color == "white" and "black" or "white"
    _G.player.image = love.graphics.newImage(((newColor == "black") and (image .. "_2") or image) .. ".png")
    _G.player.color = newColor
end

_G.direction = Vector.new(0, 0)

_G.gameOver = false

_G.counter = 0

-- Functions

function _G.map:GetNumberOf(stuff)
    local counter = 0

    if type(stuff) ~= "string" then
        return
    end
    if not _G.scenes.Game.maps[_G.map.current] then
        return
    end
    for _, s in pairs(_G.scenes.Game.maps[_G.map.current].sprites) do
        if s.asset == "assets/" .. stuff then
            counter = counter + 1
        end
    end
    return counter
end

function _G.changeScene(name)
    _G.currentScene = name
    for key, value in pairs(_G.scenes) do
        if key ~= name then
            goto continue
        end
        love.graphics.setBackgroundColor(value.color[1], value.color[2], value.color[3])
        ::continue::
    end
end

function _G.map.CallMap(mapNum)
    _G.map.current = mapNum
    _G.scenes.Game.sprites = {}
    create_maps.Setup()
    _G.scenes.Game.sprites = _G.map.list[mapNum]
end
