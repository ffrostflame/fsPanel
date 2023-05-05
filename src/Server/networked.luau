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
		return wholeNumber .. "." .. string.sub(split[2], 1, place)
	end
end

local networked = {}

local authorizedPlayers = {}
local debugActions = {}
local hasStarted = false
local customValues = {}
local currentServerStats = {}

local function updateServerStats(serverFps)
	currentServerStats = {
		[enums.ServerStatItems.DataReceiveKbps] = Stats.DataReceiveKbps,
		[enums.ServerStatItems.DataSendKbps] = Stats.DataSendKbps,
		[enums.ServerStatItems.HeartbeatTimeMs] = Stats.HeartbeatTimeMs,
		[enums.ServerStatItems.PhysicsStepTimeMs] = Stats.PhysicsStepTimeMs,
		[enums.ServerStatItems.ServerFps] = serverFps,
		[enums.ServerStatItems.TotalMemoryUsageMb] = Stats:GetTotalMemoryUsageMb()
	}
end

local function getServerStatsFormatted(serverFps: number)
	updateServerStats(serverFps)
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

function networked.init(playerAuthFunction: ((plr: Player) -> boolean)?)
	-- error handling
	hasStarted = true

	communicationRemote = Instance.new("RemoteEvent")
	communicationRemote.Name = "DebugLibraryRemote"
	communicationRemote.Parent = ReplicatedStorage

	local getSetupInfo = Instance.new("RemoteFunction")
	getSetupInfo.Name = "SetupInfoRemote"
	getSetupInfo.Parent = ReplicatedStorage

	getSetupInfo.OnServerInvoke = function(plr)
		return table.find(authorizedPlayers, plr) ~= nil
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
		if isValidPacketType then
			local isAuthorized = table.find(authorizedPlayers, player) ~= nil
			if isAuthorized then
				-- find the debug action, then execute it with the the first parameter being the player calling
				debugActions[obj[2]](player)
			else
				player:Kick("not authorized to execute debug actions")
			end
		end
	end)

	local lastStream = 0
	RunService.PostSimulation:Connect(function()
		debug.profilebegin("DebugLibrary")
		if os.clock() - lastStream >= 1 then
			lastStream = os.clock()

			for _, plr in authorizedPlayers do
				local data = {
					[enums.Categories.ServerStats] = getServerStats(currentFps),
					[enums.Categories.GameStats] = {},
				}

				communicationRemote:FireClient(plr, { enums.PacketTypes.update, data })
			end
		end
		debug.profileend()
	end)
end

function networked.makeReplicatedValue(name: string, val: any)
	customValues[name] = val
end

function networked.addDebugAction(name: string, func: (callingPlr: Player) -> () | nil)
	assert(hasStarted, "Library has not started yet! run .init()")
	assert(typeof(name) == "string", "name is not string")
	assert(typeof(func) == "function", "func is not function")

	debugActions[name] = func
end

return networked