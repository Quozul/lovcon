# Lovcon
Lovcon is a fully-featured in-game console which you can use and edit it as your desires. You can find the full documentation on the [📖 wiki](https://github.com/Quozul/lovcon/wiki).  
The console comes with some images and cursor, as for the cursors, you can disable them in the [📖 config file](https://github.com/Quozul/lovcon/wiki/Config-file).  
You can find an exemple on the [💾 releases page](https://github.com/Quozul/lovcon/releases).

⚠️ **Please note that the console can be very resource heavy when opened, weak systems may lag with it!**

<img src="https://i.imgur.com/1VMfoM2.png" title="Lovcon" alt="Lovcon image"/>

## Features
* Command execution (*you can customize the commands*)
* Configurable log history limits
* Traceback and time *so you can know where and when the print was executed*
* This console supports multi-line printing
* Print messages from threads *see bellow*
* *Smooth* scrolling
* Coloured tags *to identify the commands easily*
* Move the console around, resize it and magnetize it on the edges of the window
* Command completions and suggestions
* Powerful text input

## Basic usage
```LUA
local console = require "console" -- Require the console

--[[ Note that if you want to print messages using a command
     such as the "print" command included in the exemple, 
     you'll have to require the console in a global variable. ]]

function love.load()
    console.registercallbacks() -- Register all required callbacks for the console

    --[[ If you wish to use a gamestate library such as hump.gamestate
         you should execute this function after the one from the library
         otherwise the console will not display in a correct way.
         In an other hand, you can call each console's callbacks manually. ]]

    console.print("Super cool message!") -- Prints a message
end
```

### Print from a thread
```LUA
local console = require "console"

-- Initialize the thread code
local code = [[
-- Require the thread version of the console,
-- this version only contain the console.print() function.
local console = require "console.thread"

local str = ... -- Get the argument

console.print(str) -- Prints a message to the console
]]

thread = love.thread.newThread(code)

function love.load()
    console.registercallbacks()

    thread:start("An other cool message!")
    --[[ Starts the thread with an argument which will be used to print a message.
         The console automatically create a channel that will be used for that,
         the channel is called "console_channel". ]]
end
```