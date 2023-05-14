local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(script.Parent.Parent.Parent.Parent.Packages.Fusion)
local logging = require(script.Parent.Parent.logging)
local enums = require(script.Parent.Parent.enums)

local Value = Fusion.Value

local remote

local DataHandler = {}

DataHandler.TargetFunctions =
	{ -- Each target function returns a 0-1 value indicating how optimal the value is (0 = worst, 1 = best, -1 = not applicable/something went wrong)
		[enums.Categories.ServerStats] = {
			[enums.ServerStatItems.DataReceiveKbps] = function(_: string)
				return -1
			end,
			[enums.ServerStatItems.DataSendKbps] = function(_: string)
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

		[enums.Categories.GameStats] = {
			custom = function(text: string)
				local _ = tonumber(text)

				return -1
			end,
		},
	}

DataHandler.ServerStats = {
	[enums.ServerStatItems.DataReceiveKbps] = Value(0),
	[enums.ServerStatItems.DataSendKbps] = Value(0),
	[enums.ServerStatItems.HeartbeatTimeMs] = Value(0),
	[enums.ServerStatItems.PhysicsStepTimeMs] = Value(0),
	[enums.ServerStatItems.ServerFps] = Value(0),
	[enums.ServerStatItems.TotalMemoryUsageMb] = Value(0),
}

DataHandler.GameStats = {} -- The indexes for this are different; they're the names of the stats

function DataHandler.init(setupData)
	-- Set up game stats
	for statName, statData in setupData.replicatedValues do
		DataHandler.GameStats[statName] = Value(statData)
	end

	-- Updates
	remote = ReplicatedStorage.fsPanelFolder.fsPanel_communicationRemote

	remote.OnClientEvent:Connect(function(receivedData)
		local packetType = receivedData[1]
		if packetType == enums.PacketTypes.update then
			local newStats = receivedData[2]
			-- Update server stats
			for _, index in enums.ServerStatItems do
				local newValueData = newStats[enums.Categories.ServerStats][index]
				DataHandler.ServerStats[index]:set(newValueData)
			end

			-- Update game stats
			for statName, statData in newStats[enums.Categories.GameStats] do
				DataHandler.GameStats[statName]:set(statData)
			end
		elseif packetType == enums.PacketTypes.printToClient then
			local toPrint = receivedData[2]
			logging.print(toPrint)
		end
	end)
end

return DataHandler
