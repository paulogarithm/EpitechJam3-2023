local input         = require('./input')
local my            = require('./my')
local timer         = require('./timer')
local menu          = require('./menu')
local all_timers    = require('./all_timers')
local all_sprites   = require('./all_sprites')
local Vector        = require('./vector')

_G.scenes = {}
_G.scenes.Game = {sprites = {}, color = {255, 255, 255}}
_G.scenes.Menu = {sprites = {}, color = {0, 0, 0}}

love.load = function()
    all_sprites.septup()
    _G.direction = Vector.new(0, 0)
    _G.changeScene = function (name)
        _G.scene = name
        for key, value in pairs(_G.scenes) do
            if key ~= name then goto continue end
            love.graphics.setBackgroundColor(value.color[1], value.color[2], value.color[3])
            ::continue::
        end
    end
    _G.changeScene("Menu")
end

love.draw = function ()
    if _G.scene == "Menu" then
        return menu.draw()
    end
    if _G.scene == "Game" then
        love.graphics.draw(_G.player.image, _G.player.quad, _G.player.x, _G.player.y, _G.player.rotation, _G.player.scale)
    end
    for _, sprite in pairs(_G.scenes[_G.scene].sprites) do
        love.graphics.draw(sprite.image, sprite.quad, sprite.pos.x, sprite.pos.y, sprite.rotation, sprite.scale)
    end
end

love.update = function (dt)
    timer:Tick(dt)
end
