local auth = require(script.auth)
local serverStats = require(script.serverStats)

--[=[
	@class Server

	The server dictionary contains all the functions exported by the library that are specifically for the server instance.
]=]

--[=[
	@function init
	@within Server

	Initialization function. Starts the fsPanel server-sided process- determining which users are authorized, and which ones aren't.
	```lua
	local fsPanel = require(path.to.fsPanel)

	fsPanel.Server.init(function(plr)
		if plr:GetRankInGroup(1) > 200 then -- developer
			return true
		end
	end, {

	})

	```

	@param playerAuthFunction ((plr: Player) -> boolean)?
	@param debugActions { [string]: () -> () }
	@param replicatedValues: { [string]: any }
	@return void
]=]
return table.freeze({
	init = require(script.initializer),

	-- authorization
	isPlayedAuthorized = auth.isPlayerAuthorized,
	getAuthorizedPlayers = auth.getAuthorizedPlayers,
	setAuthorizedFunction = auth.setAuthorizationFunction,

	-- server stats
	getServerStats = serverStats.getServerStats,
})