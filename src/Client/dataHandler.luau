local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(script.Parent.Parent.Parent.Parent.Packages.Fusion)
local Value = Fusion.Value

local enums = require(script.Parent.Parent.enums)

local remote

local DataHandler = {}

DataHandler.TargetFunctions =
	{ -- Each target function returns a 0-1 value indicating how optimal the value is (0 = worst, 1 = best, -1 = not applicable/something went wrong)
		[enums.Categories.ServerStats] = {
			[enums.ServerStatItems.DataReceiveKbps] = function(text: string)
				return -1
			end,
			[enums.ServerStatItems.DataSendKbps] = function(text: string)
				return -1
			end,
			[enums.ServerStatItems.HeartbeatTimeMs] = function(text: string)
				local number = tonumber(text)
				return math.clamp(1 - number / 10, 0, 1)
			end,
			[enums.ServerStatItems.PhysicsStepTimeMs] = function(text: string)
				local number = tonumber(text)
				return math.clamp(1 - number / 12, 0, 1)
			end,
			[enums.ServerStatItems.ServerFps] = function(text: string)
				local number = tonumber(text)
				return math.clamp(number / 50, 0, 1)
			end,
			[enums.ServerStatItems.TotalMemoryUsageMb] = function(text: string)
				local number = tonumber(text)

				local min, max = 3000, 4000
				return math.clamp(1 - ((number - min) / (max - min)), 0, 1)
			end,
		},
	}

DataHandler.ServerStats = {
	[enums.ServerStatItems.DataReceiveKbps] = Value(0), -- >?
	[enums.ServerStatItems.DataSendKbps] = Value(0), -- >?
	[enums.ServerStatItems.HeartbeatTimeMs] = Value(0), -- >10
	[enums.ServerStatItems.PhysicsStepTimeMs] = Value(0), -- >12
	[enums.ServerStatItems.ServerFps] = Value(0), -- <50
	[enums.ServerStatItems.TotalMemoryUsageMb] = Value(0), -- >4
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
			local newValueData = newStats[enums.Categories.ServerStats][index]
			DataHandler.ServerStats[index]:set(newValueData)
		end

		-- Add GameStats to this update function later
	end)
end

return DataHandler
