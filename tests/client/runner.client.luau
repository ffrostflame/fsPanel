local ReplicatedStorage = game:GetService("ReplicatedStorage")
local fsPanel = require(ReplicatedStorage.Packages.fsPanel)

fsPanel.Client.init({
	toggleKeys = {
		Enum.KeyCode.K
	},
})
