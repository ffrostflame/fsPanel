local ReplicatedStorage = game:GetService("ReplicatedStorage")
ReplicatedStorage:WaitForChild("fsPanelFolder")

return table.freeze({
	init = require(script.initializer),
})
