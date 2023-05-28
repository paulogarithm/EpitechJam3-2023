require('globals')
require('input')
require('my')
require('game_over')
require('key_pressed')
require('all_timers')

local timer = require('timer')
local menu = require('menu')
local all_sprites = require('all_sprites')
local Vector = require('vector')
local map = require('create_maps')

local currentMap = 1

love.load = function()
    map.Setup()
    _G.changeScene("Menu")
    menu.load()
end

love.draw = function()
    if _G.scene == "Menu" then
        return menu.draw()
    end

    if _G.gameOver then
        return _G.scenes.GameOver:draw()
    end

    love.graphics.draw(
        _G.player.image, _G.player.quad, _G.player.pos.x, _G.player.pos.y, _G.player.rotation, _G.player.scale)

    love.graphics.setColor(255, 255, 255)

    for _, sprite in pairs(_G.scenes.Game.maps[currentMap].sprites) do
        love.graphics.draw(sprite.image, sprite.quad, sprite.pos.x, sprite.pos.y, sprite.rotation, sprite.scale)
    end
end

love.update = function(dt)
    timer:Tick(dt)
    if _G.scene == "Menu" then
        return menu.update(dt)
    end
    if _G.scene == "Game" then
        for _, s in pairs(_G.scenes.Game.maps[currentMap].sprites) do
            if s.assets ~= "assets/ennemi" then goto continue end
            all_sprites:updateEnemy(s, _G.player, dt)
            ::continue::
        end
        for _, sh in pairs(_G.scenes.Game.maps[currentMap].sprites) do
            if sh.assets ~= "assets/mouton" then goto continue end
            all_sprites:updateSheep(sh, _G.player, dt)
            ::continue::
        end
        all_sprites:updatePlayer(dt)
    end
    if _G.gameOver then
        _G.changeScene("GameOver")
    end
end
