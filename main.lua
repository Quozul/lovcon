console = require "console"
local window_width, window_height = love.window.getMode()

-- creates a thread for an exemple
local code = [[
console = require "console.thread"

local str = ...

console.print(str)
]]
exemple_thread = love.thread.newThread(code)

function love.load()
    console.registercallbacks() -- register callbacks
    
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

-- loag a cursor you want
local arrow = love.mouse.newCursor( love.image.newImageData("data/console/arrow.png"), 0, 0 )
function love.update(dt)
    if not console.hasfocus() then
        love.mouse.setCursor(arrow) -- sets your own cursor if the console isn't shown
    end

    -- everything bellow is just a small code that count the average framerates
    -- used to know the impact of the console over your performaces
    tick = tick + dt

    if tick >= tickRate and record_fps then -- the framerates are recorded every seconds
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

function love.keypressed(key)
    -- toggles the record fps mode
    if key == "f2" then record_fps = not record_fps end
end

local text = [[Hey! I'm a text behind the console,
it seems like the console is transparent!
Press F1 to toggle the console,
press F2 to record your framerates.]]
local font = love.graphics.getFont()
function love.draw()
    -- prints a text behind the console
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.print(text, math.round(window_width / 2 - font:getWidth(text) / 2, 0), math.round(window_height / 2 - font:getHeight(text) / 2, 0))

    -- prints your average fps
    if record_fps or (fps_showcount + fps_hiddencount) ~= 0 then
        -- the average fps will be hidden if no value is set
        love.graphics.print("Framerates shown:", 5, 20)
        love.graphics.print("Framerates hidden:", 5, 35)
        love.graphics.print("Difference:", 5, 50)

        local fpsshow, fpshide = fps_show / fps_showcount, fps_hidden / fps_hiddencount
        love.graphics.print(math.round(fpsshow, 1), 150, 20)
        love.graphics.print(math.round(fpshide, 1), 150, 35)
        love.graphics.print(math.round((fpsshow - fpshide) / math.max(fpsshow, fpshide) * 100, 2) .. "%", 150, 50)
    end

    love.graphics.print("Current framerates:", 5, 5)
    love.graphics.print(love.timer.getFPS(), 150, 5)
end