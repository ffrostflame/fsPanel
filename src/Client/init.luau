local ReplicatedStorage = game:GetService("ReplicatedStorage")
ReplicatedStorage:WaitForChild("DebugLibraryRemote")

return {
	init = require(script.initializer),
}
