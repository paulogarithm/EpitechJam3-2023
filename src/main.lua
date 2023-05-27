local input         = require('./input')
local my            = require('./my')
local timer         = require('./timer')
local menu          = require('./menu')
local all_timers    = require('./all_timers')
local all_sprites   = require('./all_sprites')
local scenechange   = require('./scenechange')

_G.scenes = {}
_G.scenes.Game = {sprites = {}}

love.load = function()
    
    all_sprites()
    _G.scene = "Menu"

    love.graphics.setBackgroundColor(255, 255, 255)
end

love.draw = function ()
    if _G.scene == "Menu" then
        return menu.draw()
    end
    for _, sprite in pairs(_G.scenes[_G.scene].sprites) do
        love.graphics.draw(sprite.image, sprite.quad, 100, 100)
    end
end

love.update = function (dt)
    timer:Tick(dt)
end
