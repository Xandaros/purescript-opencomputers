-- module Control.Monad.Eff.OpenComputers.Filesystem

local exports = {}

local filesystem = require("filesystem")

exports.isAutorunEnabled = function()
    return filesystem.isAutorunEnabled()
end

exports.setAutorunEnabled = function(en)
    return function()
        filesystem.setAutorunEnabled(en)
        return {}
    end
end

exports.proxy = function(lbl)
    return function()
        return filesystem.proxy(lbl)
    end
end

exports.mountImpl = function(left)
    return function(right)
        return function(fs)
            return function(path)
                return function()
                    local suc, msg = filesystem.mount(fs, path)
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

exports.mountsImpl = function(tuple)
    return function()
        local ret = {}
        for proxy, path in filesystem.mounts() do
            ret[#ret+1] = tuple(proxy)(path)
        end
        return ret
    end
end

exports.umount = function(fs)
    return function()
        return filesystem.umount(fs)
    end
end

exports.umountPath = function(path)
    return function()
        return filesystem.umount(path)
    end
end

exports.isLink = function(path)
    return function()
        local ret = filesystem.isLink(path)
        return ret
    end
end

exports.getLinkImpl = function(nothing)
    return function(just)
        return function(path)
            return function()
                local suc, link = filesystem.isLink(path)
                if suc then
                    return just(link)
                else
                    return nothing
                end
            end
        end
    end
end

exports.linkImpl = function(left)
    return function(right)
        return function(target)
            return function(linkpath)
                return function()
                    local suc, msg = filesystem.link(target, linkpath)
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

exports.getImpl = function(left)
    return function(right)
        return function(tuple)
            return function(path)
                return function()
                    local proxy, path = filesystem.get(path)
                    if not proxy then
                        return left(path) -- path is the error message in this case
                    else
                        return right(tuple(proxy)(path))
                    end
                end
            end
        end
    end
end

exports.exists = function(path)
    return function()
        return filesystem.exists(path)
    end
end

exports.size = function(path)
    return function()
        return filesystem.size(path)
    end
end

exports.isDirectory = function(path)
    return function()
        return filesystem.isDirectory(path)
    end
end

exports.lastModified = function(path)
    return function()
        return filesystem.lastModified(path)
    end
end

exports.listImpl = function(left)
    return function(right)
        return function(path)
            return function()
                local iter, msg = filesystem.list(path)
                if not iter then
                    return left(msg)
                else
                    local ret = {}
                    for entry in iter do
                        ret[#ret+1] = entry
                    end
                    return right(ret)
                end
            end
        end
    end
end

exports.makeDirectoryImpl = function(left)
    return function(right)
        return function(path)
            return function()
                local suc, msg = filesystem.makeDirectory(path)
                if suc then
                    return right({})
                else
                    return left(msg)
                end
            end
        end
    end
end

exports.removeImpl = function(left)
    return function(right)
        return function(path)
            return function()
                local suc, msg = filesystem.remove(path)
                if suc then
                    return right({})
                else
                    return left(msg)
                end
            end
        end
    end
end

exports.renameImpl = function(left)
    return function(right)
        return function(oldName)
            return function(newName)
                return function()
                    local suc, msg = filesystem.rename(oldName, newName)
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

exports.copyImpl = function(left)
    return function(right)
        return function(from)
            return function(to)
                return function()
                    local suc, msg = filesystem.copy(from, to)
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

exports.openImpl = function(left)
    return function(right)
        return function(mode)
            return function(path)
                return function()
                    local ret, msg = filesystem.open(path, mode)
                    if ret then
                        ret.mode = mode
                        return right(ret)
                    else
                        return left(msg)
                    end
                end
            end
        end
    end
end

return exports
