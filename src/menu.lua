local menu = {}
menu.selectedOption = 1
menu.options = {"Start", "Options", "Exit"}

function menu.update(dt)
  -- Update menu logic
end

function menu.draw()
  -- Draw menu graphics
  love.graphics.setBackgroundColor(0, 0, 0) -- Set background color to black
  love.graphics.setColor(255, 255, 255) -- Set text color to white
  love.graphics.setFont(love.graphics.newFont(24)) -- Set font and size

  -- Draw menu options
  local centerX = love.graphics.getWidth() / 2
  local centerY = love.graphics.getHeight() / 2
  local lineHeight = 30
  for i, option in ipairs(menu.options) do
    local optionY = centerY + (i - 1) * lineHeight
    if i == menu.selectedOption then
      love.graphics.printf("> " .. option, centerX - 100, optionY, 200, "center")
    else
      love.graphics.printf(option, centerX - 100, optionY, 200, "center")
    end
  end
end

function menu.keypressed(key)
  -- Handle keypress events
  print(menu.selectedOption)
  if key == "up" then
    menu.selectedOption = menu.selectedOption - 1
    if menu.selectedOption < 1 then
      menu.selectedOption = #menu.options
    end
  elseif key == "down" then
    menu.selectedOption = menu.selectedOption + 1
    if menu.selectedOption > #menu.options then
      menu.selectedOption = 1
    end
  elseif key == "return" then
    if menu.selectedOption == 1 then
      -- Start the game
    elseif menu.selectedOption == 2 then
      -- Open options menu
    elseif menu.selectedOption == 3 then
      love.event.quit() -- Quit the game
    end
  end
end

return menu
