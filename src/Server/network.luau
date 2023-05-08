local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local logging = require(script.Parent.Parent.logging)
local enums = require(script.Parent.Parent.enums)
local serverStats = require(script.Parent.serverStats)
local auth = require(script.Parent.auth)
local debugActions = require(script.Parent.debugActions)
local replicatedValues = require(script.Parent.replicatedValues)

local network = {}

local communicationRemote = (nil) :: RemoteEvent

function network.init()
	-- Instance management
	local fsPanelFolder = Instance.new("Folder")
	fsPanelFolder.Name = "fsPanelFolder"
	fsPanelFolder.Parent = ReplicatedStorage

	communicationRemote = Instance.new("RemoteEvent")
	communicationRemote.Name = "fsPanel_communicationRemote"
	communicationRemote.Parent = fsPanelFolder

	local getSetupInfo = Instance.new("RemoteFunction")
	getSetupInfo.Name = "fsPanel_getSetupInfo"
	getSetupInfo.Parent = fsPanelFolder

	-- Setup info
	getSetupInfo.OnServerInvoke = function(player: Player)
		local isAuthorized = auth.isPlayerAuthorized(player)

		if isAuthorized then
			logging.print(`authorized player { player.Name }:{ player.UserId } has joined the game`)
		end

		return {
			isAuthorized = auth.isPlayerAuthorized(player),
			debugActionNames = debugActions._getActionNames(),
			replicatedValues = replicatedValues._getAllValueData(),
		}
	end

	-- Debug actions
	communicationRemote.OnServerEvent:Connect(function(player, obj)
		if auth.isPlayerAuthorized(player) then
			if obj[1] == enums.PacketTypes.executeAction then
				debugActions._callDebugAction(player, obj[2])
			end
		end
	end)

	local valuesToUpdate = {}
	replicatedValues._onValueChanged(function(label, newValue)
		valuesToUpdate[label] = newValue
	end)

	-- Performance stats
	local lastSent = 0
	RunService.PostSimulation:Connect(function()
		debug.profilebegin("fsPanel_sendPerfStats")
		if (os.clock() - lastSent) >= 1 then
			lastSent = os.clock()

			local data = {
				[enums.Categories.ServerStats] = serverStats._getServerStatsArray(),
				[enums.Categories.GameStats] = valuesToUpdate,
			}

			table.clear(valuesToUpdate)

			for _, player in auth._getAuthorizedPlayers() do
				communicationRemote:FireClient(player, { enums.PacketTypes.update, data })
			end
		end
		debug.profileend()
	end)
end

function network.printToAllClients(string: string)
	communicationRemote:FireAllClients({ enums.PacketTypes.printToClient, string })
end

return network