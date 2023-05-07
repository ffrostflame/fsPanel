local ReplicatedStorage = game:GetService("ReplicatedStorage")
local fsPanel = require(ReplicatedStorage.Packages.fsPanel)

fsPanel.Server.init({
	debugActions = {
		testAction = function(player)
			print(`Hello { player.Name }`)
		end
	},
	playerAuthFunction = function()
		return true
	end
})