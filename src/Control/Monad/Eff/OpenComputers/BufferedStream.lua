-- module Control.Monad.Eff.OpenComputers.BufferedStream

local exports = {}

local buffer = require("buffer")

exports.fromStream = function(stream)
    return buffer.new(stream.mode, stream)
end

exports.close = function(stream)
    return function()
        stream:close()
    end
end

exports.flushImpl = function(left)
    return function(right)
        return function(stream)
            return function()
                local suc, msg = stream:flush()
                if suc then
                    return right({})
                else
                    return left(msg)
                end
            end
        end
    end
end

exports.readImpl = function(left)
    return function(right)
        return function(stream)
            return function(n)
                return function()
                    local ret, msg = stream:read(n)
                    if ret then
                        return right(ret)
                    else
                        return left(msg)
                    end
                end
            end
        end
    end
end

exports.readLineImpl = function(left)
    return function(right)
        return function(stream)
            return function()
                local ret, msg = stream:read("l")
                if ret then
                    return right(ret)
                else
                    return left(msg)
                end
            end
        end
    end
end

exports.readAllImpl = function(left)
    return function(right)
        return function(stream)
            return function()
                local ret, msg = stream:read("a")
                if ret then
                    return right(ret)
                else
                    return left(msg)
                end
            end
        end
    end
end

exports.seekImpl = function(left)
    return function(right)
        return function(stream)
            return function(whence)
                return function(offset)
                    return function()
                        local ret, msg = stream:seek(whence, offset)
                        if ret then
                            return right(ret)
                        else
                            return left(msg)
                        end
                    end
                end
            end
        end
    end
end

exports.setBufferModeImpl = function(stream)
    return function(bm)
        return function()
            stream.bufferMode = bm
            return {}
        end
    end
end

exports.getBufferModeImpl = function(stream)
    return function()
        return stream.bufferMode
    end
end

exports.setBufferSize = function(stream)
    return function(size)
        return function()
            stream.bufferSize = size
        end
    end
end

exports.getBufferSize = function(stream)
    return function()
        return stream.bufferSize
    end
end

exports.writeImpl = function(left)
    return function(right)
        return function(stream)
            return function(data)
                return function()
                    local ret, msg = stream:write(data)
                    if ret then
                        return right({})
                    else
                        return left(msg)
                    end
                end
            end
        end
    end
end

exports.error = error

return exports
