local input         = require('./input')
local my            = require('./my')
local timer         = require('./timer')
local menu          = require('./menu')
local all_timers    = require('./all_timers')
local all_sprites   = require('./all_sprites')

local scenes = {}
scenes.menu = {name = "menu", sprites = {}}
scenes.game = {name = "game", sprites = {}}

love.load = function()
    
    scenes = all_sprites(scenes)
    _G.scene = scenes.menu
    --] _G.scene = scenes.game

    love.graphics.setBackgroundColor(255, 255, 255)
end

love.draw = function ()
    if _G.scene.name == "menu" then
        return menu.draw()
    end
    for _, sprite in pairs(_G.scene.sprites) do
        love.graphics.draw(sprite.image, sprite.quad, 100, 100)
    end
end

love.update = function (dt)
    timer:Tick(dt)
    menu.update(dt)
end
