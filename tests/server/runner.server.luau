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
	end,
	replicatedValues = {
		testValue = 5
	}
})

task.spawn(function()
	while true do
		fsPanel.Server.updateValue("testValue", math.random(1,6))
		task.wait(1)
	end
end)