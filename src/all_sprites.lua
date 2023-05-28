local timer     = require('./timer')
local Vector    = require('./vector')

local all_sprites = {}

function all_sprites:Create(image, pos, scale, rotation, color)
    local sprite = {}
    sprite.assets = image
    image = (color and color == "white") and (image .. "_2") or image
    sprite.image = love.graphics.newImage(image .. ".png")
    sprite.quad = love.graphics.newQuad(
        0, 0, sprite.image:getWidth(), sprite.image:getHeight(), sprite.image:getDimensions()
    )
    sprite.pos = pos or Vector.new(0, 0)
    sprite.scale = scale or 1
    sprite.rotation = rotation or 0
    sprite.color = color or "white"
    return sprite
end

all_sprites.septup = function ()
    
    _G.player = all_sprites:Create("assets/perso", Vector.new(100, 100), .3, 0)

    table.insert(_G.scenes.Game.sprites, all_sprites:Create("assets/ennemi", Vector.new(50, 300), .25, 0, "black"))
    table.insert(_G.scenes.Game.sprites, all_sprites:Create("assets/ennemi", Vector.new(50, 300), .25, 0, "white"))

    table.insert(_G.scenes.Game.sprites, all_sprites:Create("assets/mouton", Vector.new(50, 300), .25, 0, "black"))
    table.insert(_G.scenes.Game.sprites, all_sprites:Create("assets/mouton", Vector.new(50, 300), .25, 0, "white"))
    return _G.scenes
end

function all_sprites:updateEnemy(enemy, player, dt)
    if _G.player.color == enemy.color then return end
    local direction = Vector.sub(player.pos, enemy.pos)
    direction = Vector.normalize(direction)
    local speed = 75

    enemy.pos = Vector.add(enemy.pos, Vector.mul(direction, speed * dt))

    local distance = Vector.length(Vector.sub(player.pos, enemy.pos))
    local collisionThreshold = 10
    if distance <= collisionThreshold then
        print("Enemy touched the player!")
        _G.gameOver= true
    end
end

function all_sprites:updateSheep(sheep, player, dt)
    if _G.player.color == sheep.color then return end
    local direction = Vector.sub(sheep.pos, player.pos)
    local distance = Vector.length(direction)
    local threshold = 100
    local speed = 50

    if distance <= threshold then
        direction = Vector.normalize(direction)
        sheep.pos = Vector.add(sheep.pos, Vector.mul(direction, speed * dt))
    end
end

return all_sprites
