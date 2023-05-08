local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local logging = require(script.Parent.Parent.logging)

local auth = {}

local authorizedPlayers = {}
local playerAuthFunction

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

function auth.init()
	Players.PlayerAdded:Connect(function(player)
		PlayerAdded(player)
	end)

	Players.PlayerRemoving:Connect(function(player)
		local index = table.find(authorizedPlayers, player)
		if index ~= nil then
			table.remove(authorizedPlayers, index)
		end
	end)
end

function auth._getAuthorizedPlayers(): { Player }
	return authorizedPlayers
end

function auth.isPlayerAuthorized(player: Player)
	local typeofPlayer = typeof(player)
	logging.typecheck(typeofPlayer == "Instance", typeofPlayer, "Instance")

	return table.find(authorizedPlayers, player) ~= nil
end

function auth.setAuthorizationFunction(authFunc: (Player) -> boolean)
	local typeofAuthFunc = typeof(authFunc)
	logging.typecheck(typeofAuthFunc == "function", typeofAuthFunc, "function")

	playerAuthFunction = authFunc
end

return auth