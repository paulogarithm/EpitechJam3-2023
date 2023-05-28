require('globals')
require('input')
require('my')
require('game_over')
require('key_pressed')
require('all_timers')

local timer = require('timer')
local menu = require('menu')
local all_sprites = require('all_sprites')
local map = require('create_maps')
local Vector = require('vector')

local countdownTimer

love.load = function()
    map.Setup()
    _G.changeScene("Menu")
    menu.load()

    countdownTimer = timer:Create("Countdown", 1, function()
        _G.timerValue = _G.timerValue - 1
        if _G.timerValue <= 0 then
            _G.timerValue = 0
            _G.changeScene("GameOver")
        end
    end)

    _G.timerValue = 180
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

    love.graphics.print("Timer: " .. _G.timerValue, 10, 10)

    love.graphics.setColor(255, 255, 255)

    love.graphics.draw(
        _G.player.image, _G.player.quad, _G.player.pos.x, _G.player.pos.y, _G.player.rotation, _G.player.scale)

    for _, sprite in pairs(_G.scenes.Game.sprites) do
        love.graphics.draw(sprite.image, sprite.quad, sprite.pos.x, sprite.pos.y, sprite.rotation, sprite.scale)
    end
end

love.update = function(dt)
    timer:Tick(dt)
    if _G.currentScene == "Menu" then
        return menu.update(dt)
    end
    if _G.currentScene == "Game" then
        for _, s in pairs(_G.scenes.Game.sprites) do
            if s.asset ~= "assets/ennemi" then goto continue end
            all_sprites:updateEnemy(s, _G.player, dt)
            ::continue::
        end
        for _, sh in pairs(_G.scenes.Game.sprites) do
            if sh.asset ~= "assets/mouton" then goto continue end
            all_sprites:updateSheep(sh, _G.player, dt)
            ::continue::
        end
        all_sprites:updatePlayer(dt)
    end
    if _G.gameOver then
        _G.direction = Vector.new(0, 0)
        _G.changeScene("GameOver")
    end
end
