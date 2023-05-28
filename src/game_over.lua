_G.scenes.GameOver = {
    sprites = {},
    color = {0, 0, 0}
}

function _G.scenes.GameOver:update(dt)
    -- Update code for the GameOver scene (if needed)
end

function _G.scenes.GameOver:draw()
    -- Set font properties for the "GAME OVER" text
    local bigFont = love.graphics.newFont(72)
    love.graphics.setFont(bigFont)
    love.graphics.setColor(255, 255, 255) -- White color

    -- Draw the "GAME OVER" text at the center of the screen
    local gameOverText = "GAME OVER"
    local gameOverTextWidth = bigFont:getWidth(gameOverText)
    local gameOverTextHeight = bigFont:getHeight()
    local screenWidth = love.graphics.getWidth()
    local screenHeight = love.graphics.getHeight()
    local gameOverTextX = (screenWidth - gameOverTextWidth) / 2
    local gameOverTextY = (screenHeight - gameOverTextHeight) / 2 - 50
    love.graphics.print(gameOverText, gameOverTextX, gameOverTextY)

    -- Set font properties for the smaller text
    local smallFont = love.graphics.newFont(24)
    love.graphics.setFont(smallFont)

    -- Draw the smaller text below the "GAME OVER" text
    local smallText = "An enemy touched Bob. Bob is dead."
    local smallTextWidth = smallFont:getWidth(smallText)
    local smallTextHeight = smallFont:getHeight()
    local smallTextX = (screenWidth - smallTextWidth) / 2
    local smallTextY = gameOverTextY + gameOverTextHeight + 50
    love.graphics.print(smallText, smallTextX, smallTextY)

    -- Draw the button
    local buttonWidth = 200
    local buttonHeight = 50
    local buttonX = (screenWidth - buttonWidth) / 2
    local buttonY = smallTextY + smallTextHeight + 50

    love.graphics.setColor(255, 255, 255) -- White color for the button
    love.graphics.rectangle("fill", buttonX, buttonY, buttonWidth, buttonHeight)

    -- Set font properties for the button text
    local buttonText = "Menu"
    local buttonTextWidth = smallFont:getWidth(buttonText)
    local buttonTextHeight = smallFont:getHeight()
    local buttonTextX = buttonX + (buttonWidth - buttonTextWidth) / 2
    local buttonTextY = buttonY + (buttonHeight - buttonTextHeight) / 2

    love.graphics.setColor(0, 0, 0) -- Black color for the button text
    love.graphics.print(buttonText, buttonTextX, buttonTextY)
end

function _G.scenes.GameOver:mousepressed(x, y, button)
    -- Check if the mouse click is within the button bounds
    local buttonWidth = 200
    local buttonHeight = 50
    local buttonX = (love.graphics.getWidth() - buttonWidth) / 2
    local buttonY = (love.graphics.getHeight() - buttonHeight) / 2 + buttonHeight * 3
    if (x >= buttonX and x <= buttonX + buttonWidth) and (y >= buttonY and y <= buttonY + buttonHeight) then
        _G.changeScene("Menu")
    end
end
