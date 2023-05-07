local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DebugLibraryUnnamed = require(ReplicatedStorage.Packages.DebugLibraryUnnamed)

DebugLibraryUnnamed.Server.init(function()
	return true
end, {}, {})