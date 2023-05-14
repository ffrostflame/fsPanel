local RunService = game:GetService("RunService")

local network = require(script.Parent.network)
local serverStats = require(script.Parent.serverStats)
local auth = require(script.Parent.auth)
local debugActions = require(script.Parent.debugActions)
local replicatedValue = require(script.Parent.replicatedValues)
local logging = require(script.Parent.Parent.logging)

type serverConfig = {
	playerAuthFunction: ((player: Player) -> boolean)?,
	debugActions: { [string]: (player: Player) -> () }?,
	replicatedValues: { [string]: any }?,
}

return function(serverConfig: serverConfig)
	assert(RunService:IsServer(), "wrong context")

	-- typechecking
	local typeofConfig = typeof(serverConfig)
	logging.typecheck(typeofConfig == "table", typeofConfig, "table")

	local typeofAuthFunction = typeof(serverConfig.playerAuthFunction or function() end)
	logging.typecheck(typeofAuthFunction == "function", typeofAuthFunction, "function")

	for label, func in (serverConfig.debugActions or {}) do
		local typeofLabel = typeof(label)
		logging.typecheck(typeofLabel == "string", typeofLabel, "string")

		local typeofFunc = typeof(func)
		logging.typecheck(typeofFunc == "function", typeofFunc, "function")
	end

	for label in (serverConfig.replicatedValues or {}) do
		local typeofLabel = typeof(label)
		logging.typecheck(typeofLabel == "string", typeofLabel, "string")
	end

	-- debug actions
	debugActions.init(serverConfig.debugActions or {})

	-- replicated values
	replicatedValue.init(serverConfig.replicatedValues or {})

	-- server perf stats
	serverStats.init()

	-- authorization
	auth.init()
	auth.setAuthorizationFunction(serverConfig.playerAuthFunction)

	-- networked
	network.init()
end
