local RunService = game:GetService("RunService")

local network = require(script.Parent.network)
local serverStats = require(script.Parent.serverStats)
local auth = require(script.Parent.auth)
local debugActions = require(script.Parent.debugActions)

type serverConfig = {
	playerAuthFunction: ((player: Player) -> boolean)?,
	debugActions: { [string]: (player: Player) -> () }?,
	replicatedValues: { [string]: any }?,
}

return function(serverConfig: serverConfig)
	assert(RunService:IsServer(), "wrong context")

	-- debug actions
	debugActions.init(serverConfig.debugActions)

	-- server perf stats
	serverStats.init()

	-- authorization
	auth.init()
	auth.setAuthorizationFunction(serverConfig.playerAuthFunction)

	-- networked
	network.init()
end