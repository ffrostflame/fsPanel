local RunService = game:GetService("RunService")

local logging = require(script.logging)

setmetatable({
	Client = if RunService:IsClient() then require(script.Client) else nil,
	Server = if RunService:IsServer() then require(script.Server) else nil,
}, {
	__index = function(_, index)
		if index == "Client" and RunService:IsServer() then
			logging.error("Attempted to access the client namespace from the server")
		elseif index == "Server" and RunService:IsClient() then
			logging.error("Attempted to access the server namespace from the client")
		end
	end
})

return table.freeze({
	Client = if RunService:IsClient() then Client else nil,
	Server = Server,
})