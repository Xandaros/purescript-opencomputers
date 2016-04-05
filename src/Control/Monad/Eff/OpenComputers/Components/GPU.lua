-- module Control.Monad.Eff.OpenComputers.Components.GPU
local GPU = {}

local component = require("component")

GPU.bindImpl = function(left)
	return function(right)
		return function(gpu)
			return function(screen)
				return function()
					nofail, msg = gpu.bind(screen)
					if nofail then
						return right({})
					else
						return left(msg)
					end
				end
			end
		end
	end
end

GPU.getScreen = function(gpu)
	return function()
		return gpu.getScreen()
	end
end

GPU.getBackgroundColorImpl = function(gpu)
    return function()
        num, bool = gpu.getBackground()
        return {color = num, pallette = bool}
	end
end

GPU.setBackgroundColorImpl = function(gpu)
    return function(col)
        return function()
            gpu.setBackground(col.color, col.palette)
            return {}
        end
    end
end

GPU.getForegroundColorImpl = function(gpu)
    return function()
        col, pal = gpu.getForeground()
        return {color = col, pallette = pal}
    end
end

GPU.setForegroundColorImpl = function(gpu)
    return function(col)
        return function()
            gpu.setForeground(col.color, col.palette)
            return {}
        end
    end
end

GPU.getPaletteColorImpl = function(gpu)
    return function(idx)
        return function()
            return gpu.getPaletteColor(idx)
        end
    end
end

GPU.setPaletteColorImpl = function(gpu)
    return function(idx)
        return function(col)
            return function()
                gpu.setPaletteColor(idx, col)
                return {}
            end
        end
    end
end

GPU.maxDepth = function(gpu)
    return function()
        return gpu.maxDepth()
    end
end

GPU.getDepth = function(gpu)
    return function()
        return gpu.getDepth()
    end
end

GPU.setDepth = function(gpu)
    return function(depth)
        return function()
            return gpu.setDepth(depth)
        end
    end
end

GPU.maxResolution = function(gpu)
    return function()
        w,h = gpu.maxResolution()
        return {width=w, height=h}
    end
end

GPU.getResolution = function(gpu)
    return function()
        w,h = gpu.getResolution()
        return {width=w, height=h}
    end
end

GPU.setResolution = function(gpu)
    return function(res)
        return function()
            return gpu.setResolution(res.width, res.height)
        end
    end
end

GPU.getImpl = function(gpu)
    return function(x)
        return function(y)
            return function()
                local char, fore, back, pfore, pback = gpu.get(x,y)
                local retFore = pfore and {color=pfore, palette=true} or {color=fore, palette=false}
                local retBack = pback and {color=pback, palette=true} or {color=back, palette=false}
                return {char=char, backgroundColor=retBack, foregroundColor=retFore}
            end
        end
    end
end

GPU.write = function(gpu)
    return function(vertical)
        return function(x)
            return function(y)
                return function(str)
                    return function()
                        return gpu.set(x,y,str,vertical)
                    end
                end
            end
        end
    end
end

GPU.copy = function(gpu)
    return function(x)
        return function(y)
            return function(w)
                return function(h)
                    return function(dx)
                        return function(dy)
                            return function()
                                return gpu.copy(x,y,w,h,dx,dy)
                            end
                        end
                    end
                end
            end
        end
    end
end

GPU.fill = function(gpu)
	return  function(x)
		return function(y)
			return function(w)
				return function(h)
					return function(c)
						return function()
							gpu.fill(x,y,w,h,c)
							return {}
						end
					end
				end
			end
		end
	end
end

return GPU
