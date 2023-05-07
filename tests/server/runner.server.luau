local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DebugLibraryUnnamed = require(ReplicatedStorage.Packages.DebugLibraryUnnamed)

DebugLibraryUnnamed.Server.init(function()
	return true
end, {
	testAction = function(plr)
		print(`Hello { plr.Name }`)
	end
}, {})