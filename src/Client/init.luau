local ReplicatedStorage = game:GetService("ReplicatedStorage")
ReplicatedStorage:WaitForChild("fsPanel_communicationRemote")

return {
	init = require(script.initializer)({
		togglePanelKeys = {
			Enum.KeyCode.LeftAlt,
			Enum.KeyCode.F5,
		},
	}),
}
