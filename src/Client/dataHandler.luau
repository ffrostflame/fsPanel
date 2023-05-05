local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(script.Parent.Parent.Parent.Parent.Packages.Fusion)
local Value = Fusion.Value

local enums = require(script.Parent.Parent.enums)

local remote

local DataHandler = {}

DataHandler.ServerStats = {
	[enums.ServerStatItems.DataReceiveKbps] = Value(0),
	[enums.ServerStatItems.DataSendKbps] = Value(0),
	[enums.ServerStatItems.HeartbeatTimeMs] = Value(0),
	[enums.ServerStatItems.PhysicsStepTimeMs] = Value(0),
	[enums.ServerStatItems.ServerFps] = Value(0),
	[enums.ServerStatItems.TotalMemoryUsageMb] = Value(0),
}

function DataHandler.init()
	remote = ReplicatedStorage:WaitForChild("DebugLibraryRemote")

	remote.OnClientEvent:Connect(function(receivedPerfData)
		local packetType = receivedPerfData[1]
		if packetType ~= enums.PacketTypes.update then
			return
		end

		local newStats = receivedPerfData[2]
		for _, index in enums.ServerStatItems do
			local newValueData = newStats.ServerStatItems[index]
			DataHandler.ServerStats[index]:set(newValueData)
		end

		-- Add GameStats to this update function later
	end)
end

return DataHandler
