# Lovcon
Lovcon is a fully-featured in-game console which you can use and edit it as your desires. You can find the full documentation on the [wiki](https://github.com/Quozul/lovcon/wiki).  
The console comes with some images and cursor, as for the cursors, you can disable them in the [config file](https://github.com/Quozul/lovcon/wiki/Config-file).

**Please note that the console is very resource heavy when opened, weak systems may lag with it!**

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

## Basic usage
```LUA
local console = require "console" -- require the console

--[[ note that if you want to print messages using a command
     such as the "print" command included in the exemple, 
     you'll have to require the console in a global variable ]]

function love.load()
    console.registercallbacks() -- register all required callbacks for the console

    --[[ if you wish to use a gamestate library such as hump.gamestate
         you should execute this function after the one from the library
         otherwise the console will not display in a correct way.
         in an other hand, you can call each console's callbacks manually ]]

    console.print("Super cool message!") -- prints a message
end
```

### Print from thread
```LUA
local console = require "console"

-- initialize the thread code
local code = [[
-- require the thread version of the console
local console = require "console.thread"

local str = ... -- get the argument

console.print(str) -- prints a message to the console
]]

thread = love.thread.newThread(code)

function love.load()
    console.registercallbacks()

    thread:start("An other cool message!") -- starts the threads with an argument
end
```