-- module Control.Monad.Eff.OpenComputers.Stream

local exports = {}

exports.readImpl = function(left)
    return function(right)
        return function(stream)
            return function(n)
                return function()
                    local val, msg = stream:read(n)
                    if val then
                        return right(val)
                    else
                        if msg then
                            return left(msg)
                        else
                            return left("end of file")
                        end
                    end
                end
            end
        end
    end
end

exports.writeImpl = function(left)
    return function(right)
        return function(stream)
            return function(str)
                return function()
                    local suc, msg = stream:write(str)
                    if suc then
                        return right({})
                    else
                        return left(msg)
                    end
                end
            end
        end
    end
end

exports.close = function(stream)
    return function()
        stream:close()
        return {}
    end
end

exports.seekImpl = function(left)
    return function(right)
        return function(stream)
            return function(whence)
                return function(offset)
                    return function()
                        local n, msg = stream:seek(whence, offset)
                        if n then
                            return right(n)
                        else
                            return left(msg)
                        end
                    end
                end
            end
        end
    end
end

return export
