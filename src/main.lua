local input         = require('./input')
local my            = require('./my')
local timer         = require('./timer')
local menu          = require('./menu')
local all_timers    = require('./all_timers')
local all_sprites   = require('./all_sprites')
local scenechange   = require('./scenechange')

_G.scenes = {}
_G.scenes.Game = {sprites = {}, color = {255, 255, 255}}
_G.scenes.Menu = {sprites = {}, color = {0, 0, 0}}

love.load = function()
    
    all_sprites()

    _G.changeScene = function (name)
        _G.scene = name
        for key, value in pairs(_G.scenes) do
            print(key)
            if key ~= name then goto continue end
            love.graphics.setBackgroundColor(value.color[1], value.color[2], value.color[3])
            print(value.color)
            ::continue::
        end
    end

    _G.changeScene("Menu")
    menu.load()
end

love.draw = function ()
    if _G.scene == "Menu" then
        return menu.draw()
    end
    for _, sprite in pairs(_G.scenes[_G.scene].sprites) do
        love.graphics.draw(sprite.image, sprite.quad, 100, 100, 0, .5)
    end
end

love.update = function (dt)
    timer:Tick(dt)
end
