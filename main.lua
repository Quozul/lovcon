console = require "console"
local window_width, window_height = love.window.getMode()

local code = [[
console = require "console.thread"

local str = ...

console.print(str)
]]
exemple_thread = love.thread.newThread(code)

function love.load()
    console.print("Game loaded")
    console.print("Here is a fancy console")
    console.print("This console support multi-\nlines prints!! This is really cool!")
    console.print("Amazing shortcuts are available in this console: Pressing tab complete the command or just put a command, the right control key paste what's in your clipboard.")
    console.print("Console size and positioning: First of all, you can move the console around, grab the top of the window and try it! You can also stick the console at the top or bottom of the screen and you can resize it if you grab the bottom-right corner!")
    console.print("You can also print messages with a coloured time tag to identify them easely!")
    console.print("This is an information")
    console.print("This is a debug log", 1)
    console.print("This is an error", 2)
    console.print("When hovering 'time tag' at the left of the log, you can see where the log was called from.")
    console.print("The console also allow printing from a thread, read the doc to learn more!")
    console.print("Want to copy only this log? Click on it!")

    love.graphics.setBackgroundColor(.85, .85, .85)
end

local record_fps = false

local fps_show, fps_showcount = 0, 0
local fps_hidden, fps_hiddencount = 0, 0
local tick, tickRate = 0, 1

function love.update(dt)
    console.update(dt)

    tick = tick + dt

    if tick >= tickRate and record_fps then
        if console_show then
            if fps_showcount ~= 0 then
                fps_show = fps_show + love.timer.getFPS()
            else
                fps_show = love.timer.getFPS()
            end

            fps_showcount = fps_showcount + 1
        elseif not console_show then
            if fps_hiddencount ~= 0 then
                fps_hidden = fps_hidden + love.timer.getFPS()
            else
                fps_hidden = love.timer.getFPS()
            end

            fps_hiddencount = fps_hiddencount + 1
        end

        tick = 0
    end
end

function love.textinput(text)
    console.text(text)
end

function love.keypressed(key)
    if key == "f2" then record_fps = not record_fps end
    console.keypressed(key)
end

function love.wheelmoved(x, y)
    console.mousewheel(x, y)
end

function love.mousemoved(x, y, dx, dy)
    console.mousemoved(x, y, dx, dy)
end

function love.mousepressed(x, y, button)
    console.mousepressed(x, y, button)
end

function love.mousereleased(x, y, button)
    console.mousereleased(x, y)
end

function love.resize(width, height)
    window_width, window_height = width, height
    console.resize(width, height)
end

function love.mousefocus(focus)
    console.mousefocus(focus)
end

local text = [[Hey! I'm a text behind the console,
it seems like the console is transparent!
Press F1 to toggle the console,
press F2 to record your framerates.]]
local font = love.graphics.getFont()
function love.draw()
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.print(text, round(window_width / 2 - font:getWidth(text) / 2, 0), round(window_height / 2 - font:getHeight(text) / 2, 0))

    love.graphics.print("framerates shown:", 5, 5)
    love.graphics.print("framerates hidden:", 5, 15)
    love.graphics.print("difference:", 5, 25)
    love.graphics.print("current:", 5, 35)

    local fpsshow, fpshide = fps_show / fps_showcount, fps_hidden / fps_hiddencount
    love.graphics.print(round(fpsshow, 1), 150, 5)
    love.graphics.print(round(fpshide, 1), 150, 15)
    love.graphics.print(round((fpsshow - fpshide) / math.max(fpsshow, fpshide) * 100, 2) .. "%", 150, 25)
    love.graphics.print(love.timer.getFPS(), 150, 35)

    console.draw()
end