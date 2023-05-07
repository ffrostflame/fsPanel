local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local enums = require(script.Parent.Parent.enums)
local serverStats = require(script.Parent.serverStats)
local auth = require(script.Parent.auth)
local debugActions = require(script.Parent.debugActions)

local network = {}

function network.init()
	local fsPanelFolder = Instance.new("Folder")
	fsPanelFolder.Name = "fsPanelFolder"
	fsPanelFolder.Parent = ReplicatedStorage

	local communicationRemote = Instance.new("RemoteEvent")
	communicationRemote.Name = "fsPanel_communicationRemote"
	communicationRemote.Parent = fsPanelFolder

	local getSetupInfo = Instance.new("RemoteFunction")
	getSetupInfo.Name = "fsPanel_getSetupInfo"
	getSetupInfo.Parent = fsPanelFolder

	getSetupInfo.OnServerInvoke = function(plr)
		return {
			isAuthorized = auth.isPlayerAuthorized(plr),
			debugActionNames = debugActions.getActionNames(),
			replicatedValues = {},
		}
	end

	communicationRemote.OnServerEvent:Connect(function(player, obj)
		if auth.isPlayerAuthorized(player) then
			if obj[1] == enums.PacketTypes.executeAction then
				debugActions.callDebugAction(player, obj[2])
			end
		end
	end)

	local lastSent = 0
	RunService.PostSimulation:Connect(function()
		debug.profilebegin("fsPanel_sendPerfStats")
		if (os.clock() - lastSent) >= 1 then
			lastSent = os.clock()

			local data = {
				[enums.Categories.ServerStats] = serverStats.getServerStats(),
				[enums.Categories.GameStats] = {},
			}

			for _, player in auth.getAuthorizedPlayers() do
				communicationRemote:FireClient(player, { enums.PacketTypes.update, data })
			end
		end
		debug.profileend()
	end)
end

function network.printToAllClients(string: string)
	
end

return network