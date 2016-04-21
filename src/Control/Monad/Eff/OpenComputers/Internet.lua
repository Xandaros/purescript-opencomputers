-- module Control.Monad.Eff.OpenComputers.Internet

local exports = {}

local component = require("component")

exports.isAvailable = function()
    return component.isAvailable("internet")
end

if component.isAvailable("internet") then
    local internet = require("internet")

    local itToList
    itToList = function(list)
        return function(defer)
            return function(empty)
                return function(cons)
                    return function(iter)
                        return list(defer(function()
                            local elem = iter()
                            if elem == nil then
                                return empty
                            else
                                local nxt = itToList(list)(defer)(empty)(cons)(iter)
                                return cons(elem, nxt)
                            end
                        end))
                    end
                end
            end
        end
    end

    exports.httpPOSTRawImpl = function(list)
        return function(defer)
            return function(empty)
                return function(cons)
                    return function(body)
                        return function(url)
                            return function()
                                local iter = internet.request(url, body)
                                return itToList(list)(defer)(empty)(cons)(iter)
                            end
                        end
                    end
                end
            end
        end
    end

    exports.httpPOSTRawImpl = function(list)
        return function(defer)
            return function(empty)
                return function(cons)
                    return function(body)
                        return function(url)
                            return function()
                                local data = {}
                                for i=1, #body do
                                    data[body[i].first] = body[i].second
                                end
                                local iter = internet.request(url, data)
                                return itToList(list)(defer)(empty)(cons)(iter)
                            end
                        end
                    end
                end
            end
        end
    end

    exports.httpGETImpl = function(list)
        return function(defer)
            return function(empty)
                return function(cons)
                    return function(url)
                        return function()
                            local iter = internet.request(url)
                            return itToList(list)(defer)(empty)(cons)(iter)
                        end
                    end
                end
            end
        end
    end

    exports.tcpOpen = function(addr)
        return function(port)
            return function()
                local ret = internet.socket(addr, port)
                ret.mode = "rwb"
                return ret
            end
        end
    end
end

return exports
