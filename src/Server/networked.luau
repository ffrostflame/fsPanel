local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")

local enums = require(script.Parent.Parent.enums)

local function floatToString(number: number, place: number?)
	local split = string.split(tostring(number), ".")
	local wholeNumber = split[1]
	if place == nil then
		return wholeNumber
	else
		return wholeNumber .. "." .. string.sub(split[2] or "", 1, place)
	end
end

local networked = {}

local authorizedPlayers = {}
local debugActions = {}
local customValues = {}

local function getServerStatsFormatted(serverFps: number)
	return {
		[enums.ServerStatItems.DataReceiveKbps] = floatToString(Stats.DataReceiveKbps, 3),
		[enums.ServerStatItems.DataSendKbps] = floatToString(Stats.DataSendKbps, 3),
		[enums.ServerStatItems.HeartbeatTimeMs] = floatToString(Stats.HeartbeatTimeMs * 1000, 3),
		[enums.ServerStatItems.PhysicsStepTimeMs] = floatToString(Stats.PhysicsStepTimeMs * 1000, 3),
		[enums.ServerStatItems.ServerFps] = floatToString(serverFps),
		[enums.ServerStatItems.TotalMemoryUsageMb] = floatToString(Stats:GetTotalMemoryUsageMb())
	}
end

local communicationRemote

function networked.init(playerAuthFunction: ((plr: Player) -> boolean)?, debugActions: { [string]: () -> () }, replicatedValues: { [string]: any })
	communicationRemote = ReplicatedStorage:FindFirstChild("DebugLibraryRemote") or Instance.new("RemoteEvent")
	communicationRemote.Name = "DebugLibraryRemote"
	communicationRemote.Parent = ReplicatedStorage

	local getSetupInfo = Instance.new("RemoteFunction")
	getSetupInfo.Name = "SetupInfoRemote"
	getSetupInfo.Parent = ReplicatedStorage

	getSetupInfo.OnServerInvoke = function(plr)
		return {
			isAuthorized = table.find(authorizedPlayers, plr) ~= nil,
			debugActionNames = {},
			replicatedValues = {},
		}
	end

	local function PlayerAdded(player)
		if playerAuthFunction ~= nil then
			if playerAuthFunction(player) then
				table.insert(authorizedPlayers, player)
			end
		else
			if (game.CreatorType == Enum.CreatorType.User and game.CreatorId == player.UserId) or RunService:IsStudio() then
				table.insert(authorizedPlayers, player)
			end
		end
	end

	for _, player in Players:GetPlayers() do
		PlayerAdded(player)
	end

	Players.PlayerAdded:Connect(PlayerAdded)

	local currentFps = 60
	RunService.Heartbeat:Connect(function(deltaTime)
		-- 1 / deltaTime is the reverse of 1 / 60
		currentFps = 1 / deltaTime
	end)

	communicationRemote.OnServerEvent:Connect(function(player, obj)
		if obj == nil then
			return
		end

		local isValidPacketType = enums.PacketTypes[obj[1]] ~= nil
		if not isValidPacketType or table.find(authorizedPlayers, player) ~= nil then
			return player:Kick("not authorized to execute debug actions")
		end

		if obj[1] == enums.PacketTypes.executeAction then
			debugActions[obj[2]](player)
		end
	end)

	local lastStream = 0
	RunService.PostSimulation:Connect(function()
		debug.profilebegin("DebugLibrary")
		if os.clock() - lastStream >= 1 then
			lastStream = os.clock()

			for _, plr in authorizedPlayers do
				local data = {
					[enums.Categories.ServerStats] = getServerStatsFormatted(currentFps),
					[enums.Categories.GameStats] = {},
				}

				communicationRemote:FireClient(plr, { enums.PacketTypes.update, data })
			end
		end
		debug.profileend()
	end)
end

function networked.updateReplicatedValue(name: string, val: any)
	customValues[name] = val
end

return networked