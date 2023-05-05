local debugGui = require(script.debugGui)

local ui = {}

local plr = game.Players.LocalPlayer

function ui.init()
	-- Create UI
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "DebugScreenGui"
	screenGui.DisplayOrder = 100

	debugGui().Parent = screenGui

	screenGui.Parent = plr:WaitForChild("PlayerGui")
end

return ui
