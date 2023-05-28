require('globals')
require('input')
require('my')
require('game_over')
require('key_pressed')
require('all_timers')


local hoppy = require('display_hoppy')
local timer = require('timer')
local menu = require('menu')
local all_sprites = require('all_sprites')
local map = require('create_maps')
local Vector = require('vector')
local photo = love.graphics.newImage("assets/hoppy.png")
local photo2 = love.graphics.newImage("assets/hoppy_2.png")

love.load = function()
    map.Setup()
    _G.changeScene("Menu")
    menu.load()
end

love.draw = function()
    
    if _G.currentScene == "Menu" then
        return menu.draw()
    end

    if _G.gameOver then
        return _G.scenes.GameOver:draw()
    end

    if _G.scenes.Game.color[1] == 0 and _G.scenes.Game.color[2] == 0 and _G.scenes.Game.color[3] == 0 then
        love.graphics.setColor(255, 255, 255)
    else
        love.graphics.setColor(0, 0, 0)
    end

    love.graphics.print("Timer: " .. _G.timer.value, 10, 10)

    love.graphics.setColor(255, 255, 255)

    for _, sprite in pairs(_G.scenes.Game.sprites) do
        love.graphics.draw(sprite.image, sprite.quad, sprite.pos.x, sprite.pos.y, sprite.rotation, sprite.scale)
    end

    if _G.map.hoppyQuote then
        hoppy.displayTextWithPhoto(_G.map.hoppyQuote, _G.scenes.Game.color[1] == 0 and photo2 or photo, 800, 600)
    end

    love.graphics.draw(
        _G.player.image, _G.player.quad, _G.player.pos.x, _G.player.pos.y, _G.player.rotation, _G.player.scale)
end

love.update = function(dt)
    timer:Tick(dt)
    if _G.currentScene == "Menu" then
        return menu.update(dt)
    end
    if _G.currentScene == "Game" then
        for _, s in pairs(_G.scenes.Game.sprites) do
            if s.asset == "assets/ennemi" then
                all_sprites:updateEnemy(s, _G.player, dt)
            elseif s.asset == "assets/mouton" then
                all_sprites:updateSheep(s, _G.player, dt)
            elseif s.asset == "assets/bouton" then
                all_sprites:UpdateButtonPress(s, _G.player)
            end
        end
        all_sprites:updatePlayer(dt)
    end
end
