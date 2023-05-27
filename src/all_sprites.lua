local timer     = require('./timer')
local Vector    = require('./vector')

local all_sprites = {}

function all_sprites:Create(image, pos, scale, rotation)
    local sprite = {}
    sprite.image = image
    sprite.quad = love.graphics.newQuad(
        0, 0, sprite.image:getWidth(), sprite.image:getHeight(), sprite.image:getDimensions()
    )
    sprite.x = pos.x
    sprite.y = pos.y
    sprite.scale = scale
    sprite.rotation = rotation
    return sprite
end

all_sprites.septup = function ()
    
    _G.player = all_sprites:Create(
        love.graphics.newImage("assets/perso.png"),
        Vector.new(100, 100),
        .3,
        0
    )

    --> table.insert(_G.scenes.Game.sprites, all_sprites:Create(image, pos (Vector.new), scale, rotation))

    return _G.scenes
end

return all_sprites