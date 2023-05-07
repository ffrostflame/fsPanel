local ReplicatedStorage = game:GetService("ReplicatedStorage")
ReplicatedStorage:WaitForChild("fsPanelFolder")

return {
	init = require(script.initializer)({
		togglePanelKeys = {
			Enum.KeyCode.LeftAlt,
			Enum.KeyCode.F5,
		},
	}),
}
