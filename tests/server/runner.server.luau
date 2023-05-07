local ReplicatedStorage = game:GetService("ReplicatedStorage")
local fsPanel = require(ReplicatedStorage.Packages.fsPanel)

fsPanel.Server.init(function()
	return true
end, {
	testAction = function(plr)
		print(`Hello { plr.Name }`)
	end
}, {})