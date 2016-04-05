--module Control.Monad.Eff.OpenComputers.Address

local component = require("component")

local exports = {}

exports.listImpl = function(filter)
	return function (exact)
		return function (nill)
			return function(cons)
				return function()
					local ret = nill
					for address, ct in component.list(filter, exact) do
						ret = cons({address=address, componentType=ct})(ret)
					end
					return ret
				end
			end
		end
	end
end

exports.componentType = function(address)
	return function()
		return component.type(address)
	end
end

exports.fromStringImpl = function(left)
    return function(right)
		return function(addr)
            return function(filter)
                if filter == "" then filter = nil end
				return function()
					address, err = component.get(addr, filter)
                    if address then
                        return right(address)
                    else
                        return left(err)
                    end
				end
			end
		end
	end
end

exports.isAvailable = function(ct)
	return function()
		return component.isAvailable(ct)
	end
end

return exports
