local input     = require('./input')
local my        = require('./my')
local timer     = require('./timer')
local menu      = require('./menu')

local sprites = {}
local workdir = love.filesystem.getWorkingDirectory()

love.load = function()
    love.graphics.setBackgroundColor(255, 255, 255)

    timer:Create("hello", 1, function()
        print("hello")
    end)

    local sprite = {}
    sprite.image = love.graphics.newImage("assets/perso.png")
    sprite.quad = love.graphics.newQuad(0, 0, sprite.image:getWidth(), sprite.image:getHeight(), sprite.image:getDimensions())
    table.insert(sprites, sprite)
    menu = require("menu")
end

love.draw = function ()
    for _, sprite in pairs(sprites) do
        love.graphics.draw(sprite.image, sprite.quad, 100, 100)
    end
    menu.draw()
end

love.update = function (dt)
    timer:Tick(dt)
    menu.update(dt)
end
