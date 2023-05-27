local timer     = require('./timer')

local all_sprites = function ()
    
    local sprite = {}
    sprite.image = love.graphics.newImage("assets/perso.png")
    sprite.quad = love.graphics.newQuad(
        0, 0, sprite.image:getWidth(), sprite.image:getHeight(), sprite.image:getDimensions()
    )
    table.insert(_G.scenes.Game.sprites, sprite)

    return _G.scenes
end

return all_sprites