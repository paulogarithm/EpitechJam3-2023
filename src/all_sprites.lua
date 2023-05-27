local timer     = require('./timer')

local all_sprites = function (scenes)
    
    local sprite = {}
    sprite.image = love.graphics.newImage("assets/perso.png")
    sprite.quad = love.graphics.newQuad(0, 0, sprite.image:getWidth(), sprite.image:getHeight(), sprite.image:getDimensions())
    table.insert(scenes.game.sprites, sprite)

    return scenes
end

return all_sprites