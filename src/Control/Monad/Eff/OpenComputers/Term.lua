-- module Control.Monad.Eff.OpenComputers.Term

local exports = {}
local term = require("term")

exports.isAvailable = function()
   return term.isAvailable()
end

exports.getViewport = function()
    local width, height, xOffset, yOffset, relX, relY = term.getViewport()
    return {
        width = width,
        height = height,
        xOffset = xOffset,
        yOffset = yOffset,
        relX = relX,
        relY = relY
    }
end

exports.getGPU = function()
    return term.getGPU()
end

exports.getCursor = function()
    local x, y = term.getCursor()
    return {x = x, y = y}
end

exports.setCursor = function(x)
    return function(y)
        return function()
            term.setCursor(x,y)
            return {}
        end
    end
end

exports.isBlinking = function()
    return term.getCursorBlink()
end

exports.setBlinking = function(b)
    return function()
        term.setCursorBlink(b)
        return {}
    end
end

exports.clear = function()
    term.clear()
    return {}
end

exports.clearLine = function()
    term.clearLine()
    return {}
end

exports.read = function(dobreak)
    return function(wrap)
        return function(hintfun)
            return function(history)
                return function(passwdchar)
                    return function()
                        local hintfun_uc = function(txt, pos)
                            hintfun(txt)(pos)
                        end
                        history.dobreak = dobreak
                        history.hint = hintfun_uc
                        history.pwchat = passwdchar
                        history.nowrap = not wrap
                        return term.read(history)
                    end
                end
            end
        end
    end
end

exports.write = function(wrap)
    return function(text)
        return function()
            term.write(text, wrap)
            return {}
        end
    end
end

exports.screen = function()
    return term.screen()
end

exports.keyboard = function()
    return term.keyboard()
end

exports.stdin = function()
    return io.stdin
end

exports.stdout = function()
    return io.stdout
end

exports.stderr = function()
    return io.stderr
end

return exports
