local hoppy = {}

hoppy.displayTextWithPhoto = function (text, photo, windowWidth, windowHeight)
    local bandHeight = 150-- Height of the band at the bottom
    local photoSize = 256 -- Size of the photo (assuming it's square)

    -- Calculate the position and dimensions of the band
    local bandY = windowHeight - bandHeight
    local bandWidth = windowWidth

    -- Calculate the position of the photo and the text within the band
    local photoX = 0
    local textX = photoSize + 10 -- Spacing between the photo and text
    local textY = bandY + (bandHeight - love.graphics.getFont():getHeight()) / 2

    -- Draw the photo
    love.graphics.setColor(255, 255, 255) -- White color for the photo
    love.graphics.draw(photo, photoX, bandY, 0, photoSize / photo:getWidth(), photoSize / photo:getHeight())

    -- Draw the text
    if _G.scenes.Game.color[1] == 0 then
        love.graphics.setColor(255, 255, 255) -- White color for the text
    else
        love.graphics.setColor(0, 0, 0) -- Black color for the text
    end
    love.graphics.print(text, textX, textY)
    love.graphics.setColor(255, 255, 255)
end
return hoppy