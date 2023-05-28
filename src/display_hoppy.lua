local hoppy = {}

hoppy.displayTextWithPhoto = function (text, photo, windowWidth, windowHeight)
    local bandHeight = 150
    local photoSize = 256

    local bandY = windowHeight - bandHeight

    local photoX = 0
    local textX = photoSize + 10 
    local textY = bandY + (bandHeight - love.graphics.getFont():getHeight()) / 2

    love.graphics.setColor(255, 255, 255)
    love.graphics.draw(photo, photoX, bandY, 0, photoSize / photo:getWidth(), photoSize / photo:getHeight())

    if _G.scenes.Game.color[1] == 0 then
        love.graphics.setColor(255, 255, 255)
    else
        love.graphics.setColor(0, 0, 0)
    end

    love.graphics.printf(text, textX, textY, windowWidth - textX)
    love.graphics.setColor(255, 255, 255)
end


return hoppy