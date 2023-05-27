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

    table.insert(_G.scenes.Game.sprites, all_sprites:Create("assets/ennemi.png", Vector.new(50, 300), .25, 0))

    return _G.scenes
end

function all_sprites:updateEnemy(enemy, player, dt)
    local direction = Vector.sub(player.pos, enemy.pos)
    direction = Vector.normalize(direction)
    local speed = 75

    enemy.pos = Vector.add(enemy.pos, Vector.mul(direction, speed * dt))

    local distance = Vector.length(Vector.sub(player.pos, enemy.pos))
    local collisionThreshold = 10 -- Adjust the collision threshold as needed
    if distance <= collisionThreshold then
        print("Enemy touched the player!")
        -- Add your desired actions here when the enemy touches the player
    end
end

return all_sprites