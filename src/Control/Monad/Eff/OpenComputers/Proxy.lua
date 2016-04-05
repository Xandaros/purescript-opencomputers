-- module Control.Monad.Eff.OpenComputers.Proxy

local component = require("component")

local exports = {}

exports.fromAddress = function (addr)
	return function ()
		return component.proxy(addr)
	end
end

exports.toAddress = function(proxy)
	return function()
		return proxy.address
	end
end

exports.componentType = function(proxy)
	return function()
		return proxy.type
	end
end

exports.getPrimary = function(ct)
	return function()
		return component.getPrimary(ct)
	end
end

exports.setPrimary = function(addr)
	return function()
		component.setPrimary(component.type(addr), addr)
		return {}
	end
end

return exports
