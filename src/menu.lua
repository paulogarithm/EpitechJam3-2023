-- Menu state
local menu = {}

local clickSound
local startSound

menu.selectedOption = 1
menu.options = {"Start", "Options", "Exit"}
clickSound = love.audio.newSource("assets/click.mp3", "static")
startSound = love.audio.newSource("assets/start.mp3", "static")

function menu.update(dt)
  -- Update menu logic
end

function menu.draw()
  -- Draw menu graphics
  love.graphics.setBackgroundColor(0, 0, 0) -- Set background color to black
  love.graphics.setColor(255, 255, 255) -- Set text color to white
  love.graphics.setFont(love.graphics.newFont(32)) -- Set font and size

  -- Draw menu title
  local titleText = "Main Menu"
  local titleX = love.graphics.getWidth() / 2 - love.graphics.getFont():getWidth(titleText) / 2
  local titleY = 100
  love.graphics.print(titleText, titleX, titleY)

  -- Draw menu options
  local centerX = love.graphics.getWidth() / 2
  local centerY = love.graphics.getHeight() / 2
  local lineHeight = 60
  for i, option in ipairs(menu.options) do
    local optionY = centerY + (i - 1) * lineHeight
    if i == menu.selectedOption then
      love.graphics.setFont(love.graphics.newFont(24)) -- Set font and size for selected option
      love.graphics.printf("> " .. option, centerX - 150, optionY, 300, "center")
    else
      love.graphics.setFont(love.graphics.newFont(18)) -- Set font and size for non-selected options
      love.graphics.printf(option, centerX - 100, optionY, 200, "center")
    end
  end
end

function love.load()
  menu.load()
end

function love.keypressed(key)
  -- Handle keypress events
  menu.keypressed(key)
end

function menu.keypressed(key)
  if key == "up" or key == "z" then
    menu.selectedOption = menu.selectedOption - 1
    if menu.selectedOption < 1 then
      menu.selectedOption = #menu.options
    end
    love.audio.play(clickSound) -- Play click sound when changing the selected option
  elseif key == "down" or key == "s" then
    menu.selectedOption = menu.selectedOption + 1
    if menu.selectedOption > #menu.options then
      menu.selectedOption = 1
    end
    love.audio.play(clickSound) -- Play click sound when changing the selected option
  elseif key == "return" then
    if menu.selectedOption == 1 then
      love.audio.play(startSound) -- Play start sound when selecting the "Start" option
      -- Start the game
    elseif menu.selectedOption == 2 then
      -- Open options menu
    elseif menu.selectedOption == 3 then
      love.event.quit() -- Quit the game
    end
  end
end

return menu
