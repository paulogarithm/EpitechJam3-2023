-- Menu state
local menu = {}

local clickSound
local startSound
local menuSong

menu.selectedOption = 1
menu.options = {"Start", "Options", "Exit"}
clickSound = love.audio.newSource("assets/click.mp3", "stream")
startSound = love.audio.newSource("assets/start.mp3", "stream")
menuSong = love.audio.newSource("assets/menu_song.mp3", "stream")

menu.currentState = "main"
menu.optionsMenu = {"Sound", "Video", "Back"}
menu.soundOptionsMenu = {"Sound On", "Sound Off", "Back"}
menu.videoOptionsMenu = {"Light Mode", "Dark Mode", "Back"}

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
    elseif menu.currentState == "soundOptions" then
        local centerX = love.graphics.getWidth() / 2
        local centerY = love.graphics.getHeight() / 2
        local lineHeight = 60
        for i, option in ipairs(menu.soundOptionsMenu) do
            local optionY = centerY + (i - 1) * lineHeight
            if i == menu.selectedOption then
                love.graphics.setFont(love.graphics.newFont(24))
                love.graphics.printf("> " .. option, centerX - 150, optionY, 300, "center")
            else
                love.graphics.setFont(love.graphics.newFont(18))
                love.graphics.printf(option, centerX - 100, optionY, 200, "center")
            end
        end
    elseif menu.currentState == "videoOptions" then
        local centerX = love.graphics.getWidth() / 2
        local centerY = love.graphics.getHeight() / 2
        local lineHeight = 60
        for i, option in ipairs(menu.videoOptionsMenu) do
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
    menuSong:setLooping(true)
    menuSong:play()
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
                _G.changeScene("Game")
                menuSong:stop()
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
                menu.currentState = "soundOptions"
                menu.selectedOption = 1
            elseif menu.selectedOption == 2 then
                menu.currentState = "videoOptions"
                menu.selectedOption = 1
            elseif menu.selectedOption == 3 then
                menu.currentState = "main"
                menu.selectedOption = 2
            end
        end
    elseif menu.currentState == "soundOptions" then
        if key == "up" or key == "z" then
            menu.selectedOption = menu.selectedOption - 1
            if menu.selectedOption < 1 then
                menu.selectedOption = #menu.soundOptionsMenu
            end
            love.audio.play(clickSound)
        elseif key == "down" or key == "s" then
            menu.selectedOption = menu.selectedOption + 1
            if menu.selectedOption > #menu.soundOptionsMenu then
                menu.selectedOption = 1
            end
            love.audio.play(clickSound)
        elseif key == "return" then
            if menu.selectedOption == 1 then
                clickSound:setVolume(1)
                startSound:setVolume(1)
                menuSong:play()
                menuSong:setVolume(1)
            elseif menu.selectedOption == 2 then
                clickSound:setVolume(0)
                startSound:setVolume(0)
                menuSong:pause()
                menuSong:setVolume(0)
            elseif menu.selectedOption == 3 then
                menu.currentState = "options"
                menu.selectedOption = 1
            end
        end
    elseif menu.currentState == "videoOptions" then
        if key == "up" or key == "z" then
            menu.selectedOption = menu.selectedOption - 1
            if menu.selectedOption < 1 then
                menu.selectedOption = #menu.videoOptionsMenu
            end
            love.audio.play(clickSound)
        elseif key == "down" or key == "s" then
            menu.selectedOption = menu.selectedOption + 1
            if menu.selectedOption > #menu.videoOptionsMenu then
                menu.selectedOption = 1
            end
            love.audio.play(clickSound)
        elseif key == "return" then
            if menu.selectedOption == 1 then
                love.graphics.setBackgroundColor(255, 255, 255)
            elseif menu.selectedOption == 2 then
                love.graphics.setBackgroundColor(0, 0, 0)
            elseif menu.selectedOption == 3 then
                menu.currentState = "options"
                menu.selectedOption = 2
            end
        end
    end
end

function menu.update(dt)
    -- Update menu logic here
end

function menu.stop()
    menuSong:stop()
end

return menu
