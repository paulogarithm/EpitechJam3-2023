-- Menu state
local menu = {}

local clickSound
local startSound

menu.selectedOption = 1
menu.options = {"Start", "Options", "Exit"}
clickSound = love.audio.newSource("assets/click.mp3", "stream")
startSound = love.audio.newSource("assets/start.mp3", "stream")

menu.currentState = "main"
menu.optionsMenu = {"Sound", "Video", "Back"}

function menu.draw()
    love.graphics.setBackgroundColor(0, 0, 0)
    love.graphics.setColor(255, 255, 255)
    love.graphics.setFont(love.graphics.newFont(32))

    local titleText = "HoppyJam"
    local titleX = love.graphics.getWidth() / 2 - love.graphics.getFont():getWidth(titleText) / 2
    local titleY = 100
    love.graphics.print(titleText, titleX, titleY)

    if menu.currentState == "main" then
        local centerX = love.graphics.getWidth() / 2
        local centerY = love.graphics.getHeight() / 2
        local lineHeight = 60
        for i, option in ipairs(menu.options) do
            local optionY = centerY + (i - 1) * lineHeight
            if i == menu.selectedOption then
                love.graphics.setFont(love.graphics.newFont(24))
                love.graphics.printf("> " .. option, centerX - 150, optionY, 300, "center")
            else
                love.graphics.setFont(love.graphics.newFont(18))
                love.graphics.printf(option, centerX - 100, optionY, 200, "center")
            end
        end
    elseif menu.currentState == "options" then
        -- Draw options menu
        local centerX = love.graphics.getWidth() / 2
        local centerY = love.graphics.getHeight() / 2
        local lineHeight = 60
        for i, option in ipairs(menu.optionsMenu) do
            local optionY = centerY + (i - 1) * lineHeight
            if i == menu.selectedOption then
                love.graphics.setFont(love.graphics.newFont(24))
                love.graphics.printf("> " .. option, centerX - 150, optionY, 300, "center")
            else
                love.graphics.setFont(love.graphics.newFont(18))
                love.graphics.printf(option, centerX - 100, optionY, 200, "center")
            end
        end
    end
end

function menu.load()
    menu.selectedOption = 1
    menu.currentState = "main"
end

function menu.keypressed(key)
    if menu.currentState == "main" then
        if key == "up" or key == "z" then
            menu.selectedOption = menu.selectedOption - 1
            if menu.selectedOption < 1 then
                menu.selectedOption = #menu.options
            end
            love.audio.play(clickSound)
        elseif key == "down" or key == "s" then
            menu.selectedOption = menu.selectedOption + 1
            if menu.selectedOption > #menu.options then
                menu.selectedOption = 1
            end
            love.audio.play(clickSound)
        elseif key == "return" then
            love.audio.play(startSound)
            if menu.selectedOption == 1 then
                _G.scene = "Game"
            elseif menu.selectedOption == 2 then
                menu.currentState = "options"
                menu.selectedOption = 1
            elseif menu.selectedOption == 3 then
                love.audio.play(startSound)
                love.event.quit()
            end
        end
    elseif menu.currentState == "options" then
        if key == "up" or key == "z" then
            menu.selectedOption = menu.selectedOption - 1
            if menu.selectedOption < 1 then
                menu.selectedOption = #menu.optionsMenu
            end
            love.audio.play(clickSound)
        elseif key == "down" or key == "s" then
            menu.selectedOption = menu.selectedOption + 1
            if menu.selectedOption > #menu.optionsMenu then
                menu.selectedOption = 1
            end
            love.audio.play(clickSound)
        elseif key == "return" then
            if menu.selectedOption == 1 then
                -- Handle sound options
            elseif menu.selectedOption == 2 then
                -- Handle graphics options
            elseif menu.selectedOption == 3 then
                menu.currentState = "main"
                menu.selectedOption = 2
            end
        end
    end
end

return menu
