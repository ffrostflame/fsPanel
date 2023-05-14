local Fusion = require(script.Parent.Parent.Parent.Fusion)
local logging = require(script.Parent.Parent.logging)

local Value = Fusion.Value
local Observer = Fusion.Observer

local visualizer = {}

local enabled = Value(false)
local instances = {}
local presetInstances = {}

function visualizer.init()
	local wireSphere = Instance.new("Part")
	wireSphere.Name = "wireSphere"
	wireSphere.Shape = Enum.PartType.Ball
	wireSphere.BottomSurface = Enum.SurfaceType.Smooth
	wireSphere.Size = Vector3.new(4, 4, 4)
	wireSphere.TopSurface = Enum.SurfaceType.Smooth
	wireSphere.Transparency = 1

	local cylinderAdornmentA = Instance.new("CylinderHandleAdornment")
	cylinderAdornmentA.Name = "CylinderHandleAdornment"
	cylinderAdornmentA.Height = 0.1
	cylinderAdornmentA.InnerRadius = 2
	cylinderAdornmentA.Radius = 1.98
	cylinderAdornmentA.AlwaysOnTop = true
	cylinderAdornmentA.Color3 = Color3.fromRGB(0, 255, 0)
	cylinderAdornmentA.Adornee = wireSphere
	cylinderAdornmentA.Parent = wireSphere

	local cylinderAdornmentB = cylinderAdornmentA:Clone()
	cylinderAdornmentB.CFrame = cylinderAdornmentA.CFrame * CFrame.fromOrientation(0, math.rad(90), 0)
	cylinderAdornmentB.Adornee = wireSphere
	cylinderAdornmentB.Parent = wireSphere

	local cylinderAdornmentC = cylinderAdornmentA:Clone()
	cylinderAdornmentC.CFrame = cylinderAdornmentB.CFrame * CFrame.fromOrientation(0, 0, math.rad(90))
	cylinderAdornmentC.Adornee = wireSphere
	cylinderAdornmentC.Parent = wireSphere

	local cylinderAdornmentD = cylinderAdornmentA:Clone()
	cylinderAdornmentD.CFrame = cylinderAdornmentB.CFrame * CFrame.fromOrientation(math.rad(90), 0, 0)
	cylinderAdornmentD.Adornee = wireSphere
	cylinderAdornmentD.Parent = wireSphere

	local wireCube = Instance.new("Part")
	wireCube.Name = "wireCube"
	wireCube.BottomSurface = Enum.SurfaceType.Smooth
	wireCube.Size = Vector3.new(2, 2, 2)
	wireCube.TopSurface = Enum.SurfaceType.Smooth
	wireCube.Transparency = 1

	local selectionBox = Instance.new("SelectionBox")
	selectionBox.Name = "SelectionBox"
	selectionBox.LineThickness = 0.01
	selectionBox.Parent = wireCube

	local arrow = Instance.new("ConeHandleAdornment")
	arrow.Name = "arrow"
	arrow.AlwaysOnTop = true

	local line = Instance.new("CylinderHandleAdornment")
	line.Name = "line"
	line.Height = 15
	line.Radius = 0.1
	line.AlwaysOnTop = true
	line.Parent = arrow

	local point = Instance.new("SphereHandleAdornment")
	point.Name = "point"
	point.Radius = 0.3
	point.AlwaysOnTop = true

	local wireShapecast = Instance.new("Part")
	wireShapecast.Name = "wireShapecast"
	wireShapecast.Shape = Enum.PartType.Cylinder
	wireShapecast.BottomSurface = Enum.SurfaceType.Smooth
	wireShapecast.CFrame = CFrame.new(-26, 12.5, -58, 0, 1, 0, -1, 0, 0, 0, 0, 1)
	wireShapecast.Rotation = Vector3.new(0, 0, -90)
	wireShapecast.Size = Vector3.new(11, 4, 4)
	wireShapecast.TopSurface = Enum.SurfaceType.Smooth
	wireShapecast.Transparency = 1

	local shapecastLineA = Instance.new("CylinderHandleAdornment")
	shapecastLineA.Name = "CylinderHandleAdornment"
	shapecastLineA.Height = 11
	shapecastLineA.InnerRadius = 0.01
	shapecastLineA.Radius = 0.03
	shapecastLineA.AlwaysOnTop = true
	shapecastLineA.CFrame = CFrame.new(0, 0, 0, -4.37113883e-08, 0, 1, 0, 1, 0, -1, 0, -4.37113883e-08)
	shapecastLineA.SizeRelativeOffset = Vector3.new(0, 0, -1)
	shapecastLineA.Color3 = Color3.fromRGB(0, 255, 0)
	shapecastLineA.Parent = wireShapecast

	local shapecastLineB = Instance.new("CylinderHandleAdornment")
	shapecastLineB.Name = "CylinderHandleAdornment"
	shapecastLineB.Height = 11
	shapecastLineB.InnerRadius = 0.01
	shapecastLineB.Radius = 0.03
	shapecastLineB.AlwaysOnTop = true
	shapecastLineB.CFrame = CFrame.new(0, 0, 0, -4.37113883e-08, 0, 1, 0, 1, 0, -1, 0, -4.37113883e-08)
	shapecastLineB.SizeRelativeOffset = Vector3.new(0, 0, 1)
	shapecastLineB.Color3 = Color3.fromRGB(0, 255, 0)
	shapecastLineB.Parent = wireShapecast

	local shapecastLineC = Instance.new("CylinderHandleAdornment")
	shapecastLineC.Name = "CylinderHandleAdornment"
	shapecastLineC.Height = 11
	shapecastLineC.InnerRadius = 0.01
	shapecastLineC.Radius = 0.03
	shapecastLineC.AlwaysOnTop = true
	shapecastLineC.CFrame = CFrame.new(0, 0, 0, -4.37113883e-08, 0, 1, 0, 1, 0, -1, 0, -4.37113883e-08)
	shapecastLineC.SizeRelativeOffset = Vector3.new(0, -1, 0)
	shapecastLineC.Color3 = Color3.fromRGB(0, 255, 0)
	shapecastLineC.Parent = wireShapecast

	local shapecastLineD = Instance.new("CylinderHandleAdornment")
	shapecastLineD.Name = "CylinderHandleAdornment"
	shapecastLineD.Height = 11
	shapecastLineD.InnerRadius = 0.01
	shapecastLineD.Radius = 0.03
	shapecastLineD.AlwaysOnTop = true
	shapecastLineD.CFrame = CFrame.new(0, 0, 0, -4.37113883e-08, 0, 1, 0, 1, 0, -1, 0, -4.37113883e-08)
	shapecastLineD.SizeRelativeOffset = Vector3.new(0, 1, 0)
	shapecastLineD.Color3 = Color3.fromRGB(0, 255, 0)
	shapecastLineD.Parent = wireShapecast

	presetInstances.arrow = arrow
	presetInstances.wireSphere = wireSphere
	presetInstances.wireCube = wireCube
	presetInstances.point = point
	presetInstances.wireShapecast = wireShapecast

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
		transparency = transparency,
	}
end

function visualizer.drawRay()
	if not enabled then
		return
	end
end

function visualizer.drawWireSphere()
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

function visualizer.drawPoint(_: Vector3)
	if not enabled then
		return
	end
end

function visualizer.drawWireCube()
	if not enabled then
		return
	end
end

function visualizer._clearAll()
	for _, _: Instance in instances do
	end
end

function visualizer._getValue()
	return enabled
end

return visualizer
