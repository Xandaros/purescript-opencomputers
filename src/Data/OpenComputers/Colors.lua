-- module Data.OpenComputers.Colors

local exports = {}

exports.intToHex = function(i)
    return string.format("%.2X", i)
end

exports.hexToInt = function(radix)
    return function(s)
        return tonumber(s, radix)
    end
end

return exports
