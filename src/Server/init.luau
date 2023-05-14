local auth = require(script.auth)
local serverStats = require(script.serverStats)
local replicatedValues = require(script.replicatedValues)

--[=[
	@class Server

	The server namespace contains all the functions exported by the library that are specifically for the server instance.
]=]

--[=[
	@type serverConfig {
		playerAuthFunction: ((player: Player) -> boolean)?,
		debugActions: { [string]: (player: Player) -> () }?,
		replicatedValues: { [string]: any }?
	}
	@within Server

	Configuration for `fsPanel.Server.init()`
	Example:
	```lua
	local configurationForServer = {

		debugActions = {
			testAction = function(player)
				print(`Hello { player.Name }`)
			end
		},

		playerAuthFunction = function()
			return true
		end,

		replicatedValues = {
			testValue = 5
		}

	}
	```
]=]

--[=[
	@type serverStats {
		DataReceiveKbps: number,
		DataSendKbps: number,
		HeartbeatTimeMs: number,
		PhysicsStepTimeMs: number,
		ServerFps: number,
		TotalMemoryUsageMb: number,
	}
	@within Server
]=]

--[=[
	@function init
	@within Server

	Initialization function. Starts the fsPanel server-sided process- determining which users are authorized, and which ones aren't.
	```lua
	local fsPanel = require(path.to.fsPanel)

	fsPanel.Server.init({
		playerAuthFunction = function(plr)
			if plr.Name == "AdminDevPerson" then
				return true
			end
		end,

		-- etc.
	})
	```

	@param serverConfig serverConfig
	@return void
]=]

--[=[
	@function isPlayerAuthorized
	@within Server

	Gets whether or not a specific player is authorized to see the debug panel.
	```lua
	local Players = game.Players:GetPlayers()

	local randomPlayer = Players[math.random(1, #Players)]

	local isRandomPlayerAuthorized = fsPanel.Server.isPlayerAuthorized(randomPlayer)

	print(isRandomPlayerAuthorized) -- "true" or "false"
	```

	@return boolean
]=]

--[=[
	@function getServerStats
	@within Server

	Retrieves the server stats without any formatting in raw numbers.
	```lua
	local fsPanel = require(path.to.fsPanel)

	while task.wait(1) do
		local currentServerStats = fsPanel.Server.getServerStats()

		if currentServerStats.ServerFps < 30 then
			print("The server is lagging!")
		else
			print("The server is fine.")
		end
	end
	```

	@return serverStats
]=]

--[=[
	@function updateValue
	@within Server

	Updates an already-created replicated value (created in `fsPanel.Server.init()`) to a new value. This new value can be
	any replictable data type.
	```lua
	local fsPanel = require(path.to.fsPanel)

	fsPanel.Server.updateValue("valueName", 50) -- sets valueName to 50
	```

	@return serverStats
]=]
return table.freeze({
	init = require(script.initializer),

	-- authorization
	isPlayerAuthorized = auth.isPlayerAuthorized,
	setAuthorizedFunction = auth.setAuthorizationFunction,

	-- server stats
	getServerStats = serverStats.getServerStats,

	updateValue = replicatedValues.updateValue,
})
