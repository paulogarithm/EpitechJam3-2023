local input = require('./input')
local my = require('./my')
local timer = require('./timer')
local menu = require('./menu')
local all_timers = require('./all_timers')
local all_sprites = require('./all_sprites')
local Vector = require('./vector')
local map = require('./create_maps')

_G.scenes = {}
_G.scenes.Game = {
    sprites = {},
    color = {255, 255, 255},
    maps = {}
}
_G.scenes.Menu = {
    sprites = {},
    color = {0, 0, 0}
}

_G.scenes.GameOver = {
    sprites = {},
    color = {0, 0, 0}
}

love.load = function()
    all_sprites.septup()
    _G.direction = Vector.new(0, 0)
    _G.changeScene = function(name)
        _G.scene = name
        for key, value in pairs(_G.scenes) do
            if key ~= name then
                goto continue
            end
            love.graphics.setBackgroundColor(value.color[1], value.color[2], value.color[3])
            ::continue::
        end
    end
    map.Setup()
    _G.changeScene("Menu")
    menu.load()
    _G.player.color = "white"
    _G.gameOver = false
end

love.draw = function()
    if _G.scene == "Menu" then
        return menu.draw()
    end

    if _G.gameOver then
        return gameover.draw()
    end

    if _G.scene == "Game" then
        local playerColor = _G.player.color

        if playerColor == "white" then
            love.graphics.setColor(255, 255, 255)
        elseif playerColor == "black" then
            love.graphics.setColor(0, 0, 0)
        end

        love.graphics.draw(_G.player.image, _G.player.quad, _G.player.pos.x, _G.player.pos.y, _G.player.rotation,
            _G.player.scale)
    end

    love.graphics.setColor(255, 255, 255)

    for _, sprite in pairs(_G.scenes[_G.scene].sprites) do
        love.graphics.draw(sprite.image, sprite.quad, sprite.pos.x, sprite.pos.y, sprite.rotation, sprite.scale)
    end
end

love.update = function(dt)
    timer:Tick(dt)
    if _G.scene == "Game" then
        for _, s in pairs(_G.scenes[_G.scene].sprites) do
            if s.assets ~= "assets/ennemi" then goto continue end
            all_sprites:updateEnemy(s, _G.player, dt)
            ::continue::
        end
    end
    if _G.gameOver then
        _G.changeScene("Menu")
        _G.gameOver = false
    end
end
