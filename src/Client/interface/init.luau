local UserInputService = game:GetService("UserInputService")

local debugGui = require(script.debugGui)

local ui = {}

local plr = game.Players.LocalPlayer

function ui.init(setupData, clientConfig)
	-- Create UI
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "DebugScreenGui"
	screenGui.DisplayOrder = 100
	screenGui.Enabled = false

	debugGui({ SetupData = setupData }).Parent = screenGui

	-- Track key presses to toggle UI
	local panelKeysDown = {}
	UserInputService.InputBegan:Connect(function(input, _)
		if input.UserInputType ~= Enum.UserInputType.Keyboard then
			return
		end
		if table.find(clientConfig.togglePanelKeys, input.KeyCode) == nil then
			return
		end

		panelKeysDown[input.KeyCode] = true

		-- Check if all keys are pressed
		for _, keyCode in clientConfig.togglePanelKeys do
			if not panelKeysDown[keyCode] then
				return
			end
		end

		-- Toggle UI
		screenGui.Enabled = not screenGui.Enabled
	end)

	UserInputService.InputEnded:Connect(function(input, _)
		if input.UserInputType ~= Enum.UserInputType.Keyboard then
			return
		end
		if table.find(clientConfig.togglePanelKeys, input.KeyCode) == nil then
			return
		end

		panelKeysDown[input.KeyCode] = nil
	end)

	screenGui.Parent = plr:WaitForChild("PlayerGui")
end

return ui
