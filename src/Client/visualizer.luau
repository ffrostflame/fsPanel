local Fusion = require(script.Parent.Parent.Parent.Fusion)
local logging = require(script.Parent.Parent.logging)

local Value = Fusion.Value
local Observer = Fusion.Observer

local visualizer = {}

local enabled = Value(false)
local instances = {}

function visualizer.init()
	Observer(enabled):onChange(function()
		if enabled:get() then
			logging.print("enabled visualizer")
		else
			logging.print("disabled visualizer")
			visualizer._clearAll()
		end
	end)
end

function visualizer.makeStyle(color: Color3, transparency: number)
	return {
		color = color,
		transparency = transparency
	}
end

function visualizer.drawRay()
	if not enabled then
		return
	end
end

function visualizer.drawSphere()
	if not enabled then
		return
	end
end

function visualizer.drawText()
	if not enabled then
		return
	end
end

function visualizer.drawShapecast()
	if not enabled then
		return
	end
end

function visualizer.drawLine()
	if not enabled then
		return
	end
end

function visualizer.drawPoint()
	if not enabled then
		return
	end
end

function visualizer.drawCube()
	if not enabled then
		return
	end
end

function visualizer._clearAll()
	for _, inst: Instance in instances do
		
	end
end

function visualizer._getValue()
	return enabled
end

return visualizer