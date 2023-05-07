local network = require(script.Parent.network)
local serverStats = require(script.Parent.serverStats)
local auth = require(script.Parent.auth)
local debugActions = require(script.Parent.debugActions)

type serverConfig = {
	playerAuthFunction: ((plr: Player) -> boolean)?,
	debugActions: { [string]: () -> () }?,
	replicatedValues: { [string]: any }?,
}

return function(serverConfig: serverConfig)
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