-- module Data.OpenComputers.Path

local exports = {}

local filesystem = require("filesystem")

exports.canonicalPath = function(p)
    return filesystem.canonical(p)
end

exports.segments = function(p)
    return filesystem.segments(p)
end

exports.concat = function(ps)
    return filesystem.segments(unpack(ps))
end

exports.path = function(p)
    return filesystem.path(p)
end

exports.name = function(p)
    return filesystem.name(p)
end

return exports
