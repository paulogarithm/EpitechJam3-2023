local timer = require('./timer')
local Vector = require('./vector')

local all_sprites = {}

function all_sprites:Create(image, pos, scale, rotation, color)
    local sprite = {}
    sprite.assets = image
    image = (color and color == "black") and (image .. "_2") or image
    print(color, image)
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
    _G.player = all_sprites:Create("assets/perso", Vector.new(100, 100), .3, 0, "white")
    _G.player.changeColor = function ()
        local image = "assets/perso"
        local newColor = _G.player.color == "white" and "black" or "white"
        _G.player.image = love.graphics.newImage(((newColor  == "black") and (image .. "_2") or image) .. ".png")
        _G.player.color = newColor
    end
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
        _G.gameOver = true
    end

    local screenWidth = love.graphics.getWidth()
    local screenHeight = love.graphics.getHeight()

    local enemyWidth = enemy.image:getWidth() * enemy.scale
    local enemyHeight = enemy.image:getHeight() * enemy.scale

    local minX = enemyWidth / 2 - 20
    local maxX = screenWidth - enemyWidth / 2
    local minY = enemyHeight / 2 - 20
    local maxY = screenHeight - enemyHeight / 2

    enemy.pos.x = math.max(minX, math.min(maxX, enemy.pos.x))
    enemy.pos.y = math.max(minY, math.min(maxY, enemy.pos.y))
end

local function indexOf(list, element)
    for i = 1, #list do
        if list[i] == element then
            return i
        end
    end
    return nil
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

    local screenWidth = love.graphics.getWidth()
    local screenHeight = love.graphics.getHeight()

    local sheepWidth = sheep.image:getWidth() * sheep.scale
    local sheepHeight = sheep.image:getHeight() * sheep.scale

    local minX = sheepWidth / 2
    local maxX = screenWidth - sheepWidth / 2 - 40
    local minY = sheepHeight / 2 - 10
    local maxY = screenHeight - sheepHeight / 2 - 40

    sheep.pos.x = math.max(minX, math.min(maxX, sheep.pos.x))
    sheep.pos.y = math.max(minY, math.min(maxY, sheep.pos.y))

    for i = #_G.scenes.Game.sprites, 1, -1 do
        local fence = _G.scenes.Game.sprites[i]
        if fence.assets == "assets/cage" and fence.color ~= sheep.color then
            local fenceWidth = fence.image:getWidth() * fence.scale
            local fenceHeight = fence.image:getHeight() * fence.scale

            local fenceMinX = fence.pos.x - fenceWidth / 2
            local fenceMaxX = fence.pos.x + fenceWidth / 2
            local fenceMinY = fence.pos.y - fenceHeight / 2
            local fenceMaxY = fence.pos.y + fenceHeight / 2

            if sheep.pos.x >= fenceMinX and sheep.pos.x <= fenceMaxX and sheep.pos.y >= fenceMinY and sheep.pos.y <= fenceMaxY then
                table.remove(_G.scenes.Game.sprites, indexOf(_G.scenes.Game.sprites, sheep))
                print("Sheep trapped in the cage")
                break
            end
        end
    end
end

function all_sprites:updatePlayer(dt)
    local speed = 100
    local screenWidth = love.graphics.getWidth()
    local screenHeight = love.graphics.getHeight()
    
    local playerWidth = _G.player.image:getWidth() * _G.player.scale
    local playerHeight = _G.player.image:getHeight() * _G.player.scale

    local minX = playerWidth / 2 - 20
    local maxX = screenWidth - playerWidth / 2
    local minY = playerHeight / 2 - 20
    local maxY = screenHeight - playerHeight / 2

    if love.keyboard.isDown("right") then
        _G.player.pos.x = _G.player.pos.x + speed * dt
    end

    _G.player.pos.x = math.max(minX, math.min(maxX, _G.player.pos.x))
    _G.player.pos.y = math.max(minY, math.min(maxY, _G.player.pos.y))
end

return all_sprites
