local timer     = require('./timer')
local Vector    = require('./vector')

local all_sprites = {}

function all_sprites:Create(image, pos, scale, rotation)
    local sprite = {}
    sprite.image = love.graphics.newImage(image)
    sprite.quad = love.graphics.newQuad(
        0, 0, sprite.image:getWidth(), sprite.image:getHeight(), sprite.image:getDimensions()
    )
    sprite.pos = pos or Vector.new(0, 0)
    sprite.scale = scale or 1
    sprite.rotation = rotation or 0
    return sprite
end

all_sprites.septup = function ()
    
    _G.player = all_sprites:Create("assets/perso.png", Vector.new(100, 100), .3, 0)

    --> table.insert(_G.scenes.Game.sprites, all_sprites:Create(image, pos (Vector.new), scale, rotation))

    return _G.scenes
end

return all_sprites