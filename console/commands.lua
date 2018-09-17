--[[ This file include a few exemple of commands that you can make with this console
     The full documentation can be found on the wiki:
     https://github.com/Quozul/lovcon/wiki ]]

return {
    lua = {
        requiredarguments = 0, -- no arguments are required
        execution = function(command)
            if command == "" then
                console.print("Please enter a valie lua script", 2)
                return false
            end
            loadstring(command)()
        end,
        usage = "lua [lua script]",
        description = "Execute a lua script"
    },

    print = {
        requiredarguments = 0, -- increasing this number let the console verify for arguments so they are required
        execution = function(command)
            local value = loadstring("return " .. command)()
            console.print(value)
        end,
        usage = "print [value|\"string\"]",
        description = "Prints a value from the game or a string"
    },

    test = {
        requiredarguments = 2, -- 2 make the "command" non required
        execution = function(command, args)
            if command ~= "" then
                console.print("Argument 1: " .. args[1] .. " Argument 2: " .. args[2] .. " Residue: " .. command)
            else
                console.print("Argument 1: " .. args[1] .. " Argument 2: " .. args[2])
            end
        end,
        usage = "test [arg1] [arg2] [string]",
        description = "Just a test command to demonstrate arguments"
    },

    loop = {
        arguments = 3,
        requiredarguments = 1,
        memory = true,
        execution = function(command, args, memory) -- "originalcommand" can be usefull in this case
            local action = args[1]
            local name = args[2]
            local time = tonumber(args[3])

            if action == "add" then -- loop add test 1 print("Hello world!")
                if not name or not time or not command then
                    return true -- returning true make the console display the usage for the command
                end
                console.print("Repeating command " .. name .. " every " .. time .. " seconds")

                console.addtomemory("loop", name, {
                    every = time,
                    time = 0,
                    command = loadstring(command),
                })
            elseif action == "rem" then -- loop rem test
                if args[2] == nil or args[2] == "" then
                    return true
                elseif not memory[args[2]] then
                    console.print("The command " .. args[2] .. " doesn't exists", 2)
                else
                    console.print("Command " .. args[2] .. " removed", 1)
                    console.remfrommemory("loop", name)
                end
            elseif action == "list" then
                local list = ""
                for name in pairs(memory) do
                    list = list .. name .. " "
                end
                
                if list ~= "" then
                    console.print("Repeated commands: " .. list)
                else
                    console.print("There are no commands being repeated", 1)
                end
            else
                return true
            end
        end,
        usage = "loop [add|rem|list] [name] [time] [lua script]",
        description = "Repeat a command every amount of time",
        update = function(dt, memory)
            for name, cmd in pairs(memory) do
                if cmd == nil then return end
                cmd.time = cmd.time + dt
                if cmd.time >= cmd.every then
                    cmd.command()
                    cmd.time = 0
                end
            end
        end,
    },

    exit = {
        requiredarguments = -1, -- disables the arguments check
        execution = function()
            love.event.quit()
        end,
        usage = "exit",
        description = "Close the game",
    },

    threadprint = {
        requiredarguments = 0,
        execution = function(command)
            local value = loadstring("return " .. command)()
            exemple_thread:start(value)
        end,
        usage = "threadprint [value|\"string\"]",
        description = "Prints a value from a thread"
    }
}