_G.scenes.GameOver = {
    sprites = {},
    color = {0, 0, 0}
}

function _G.scenes.GameOver:update(dt)
end

function _G.scenes.GameOver:draw()
    local bigFont = love.graphics.newFont(72)
    love.graphics.setFont(bigFont)
    love.graphics.setColor(255, 255, 255)

    local gameOverText = "GAME OVER"
    local gameOverTextWidth = bigFont:getWidth(gameOverText)
    local gameOverTextHeight = bigFont:getHeight()
    local screenWidth = love.graphics.getWidth()
    local screenHeight = love.graphics.getHeight()
    local gameOverTextX = (screenWidth - gameOverTextWidth) / 2
    local gameOverTextY = (screenHeight - gameOverTextHeight) / 2 - 50
    love.graphics.print(gameOverText, gameOverTextX, gameOverTextY)

    local smallFont = love.graphics.newFont(24)
    love.graphics.setFont(smallFont)

    local smallText = "An enemy touched Bob. Bob is dead."
    local smallTextWidth = smallFont:getWidth(smallText)
    local smallTextHeight = smallFont:getHeight()
    local smallTextX = (screenWidth - smallTextWidth) / 2
    local smallTextY = gameOverTextY + gameOverTextHeight + 50
    love.graphics.print(smallText, smallTextX, smallTextY)

    local buttonWidth = 200
    local buttonHeight = 50
    local buttonX = (screenWidth - buttonWidth) / 2
    local buttonY = smallTextY + smallTextHeight + 50

    love.graphics.setColor(255, 255, 255)
    love.graphics.rectangle("fill", buttonX, buttonY, buttonWidth, buttonHeight)

    local buttonText = "Menu"
    local buttonTextWidth = smallFont:getWidth(buttonText)
    local buttonTextHeight = smallFont:getHeight()
    local buttonTextX = buttonX + (buttonWidth - buttonTextWidth) / 2
    local buttonTextY = buttonY + (buttonHeight - buttonTextHeight) / 2

    love.graphics.setColor(0, 0, 0)
    love.graphics.print(buttonText, buttonTextX, buttonTextY)
end

function _G.scenes.GameOver:mousepressed(x, y, button)
    local buttonWidth = 200
    local buttonHeight = 50
    local buttonX = (love.graphics.getWidth() - buttonWidth) / 2
    local buttonY = (love.graphics.getHeight() - buttonHeight) / 2 + buttonHeight * 3
    if (x >= buttonX and x <= buttonX + buttonWidth) and (y >= buttonY and y <= buttonY + buttonHeight) then
        _G.changeScene("Menu")
        _G.gameOver = false
    end
end
