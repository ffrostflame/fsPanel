local ReplicatedStorage = game:GetService("ReplicatedStorage")
local fsPanel = require(ReplicatedStorage.Packages.fsPanel)

print(fsPanel)

fsPanel.Client.init({
	toggleKeys = {
		Enum.KeyCode.X
	}
})
