-- module Control.Monad.Eff.OpenComputers.Computer

local exports = {}

local computer = require("computer")
local component = require("component")

exports.address = function()
    return computer.address()
end

exports.tmpAddress = function()
    return computer.tmpAddress()
end

exports.freeMemory = function()
    return computer.freeMemory()
end

exports.totalMemory = function()
    return computer.totalMemory()
end

exports.energy = function()
    return computer.energy()
end

exports.maxEnergy = function()
    return computer.maxEnergy()
end

exports.isRobot = function()
    return component.isAvailable("robot")
end

exports.uptime = function()
    return computer.uptime()
end

exports.shutdown = function()
    computer.shutdown(false)
    return {} -- Yeah, right
end

exports.reboot = function()
    computer.shutdown(true)
    return {} -- see above
end

exports.bootAddress = function()
    return computer.getBootAddress()
end

exports.setBootAddressImpl = function(addr)
    if addr == "" then addr = nil end
    return function()
        computer.setBootAddress(addr)
        return {}
    end
end

exports.runlevelImpl = function(left)
    return function(right)
        return function()
            local rl = computer.runlevel()
            if type(rl) == "string" then
                return left(rl)
            elseif type(rl) == "number" then
                return right(rl)
            else
                error("Runtime error: Unexpected runlevel type '" .. type(rl) .."'")
            end
        end
    end
end

exports.users = function()
    return {computer.users()}
end

exports.addUserImpl = function(left)
    return function(right)
        return function(player)
            return function()
                local suc, msg = computer.addUser(player)
                if suc then
                    return right({})
                else
                    return left(msg)
                end
            end
        end
    end
end

exports.removeUser = function(player)
    return function()
        return computer.removeUser(player)
    end
end

return exports
