local RunService = game:GetService("RunService")

local logging = require(script.logging)

local export = setmetatable({
	Client = if RunService:IsClient() then require(script.Client) else nil,
	Server = if RunService:IsServer() then require(script.Server) else nil,
}, {
	__index = function(_, index)
		print(RunService:IsClient())
		print(RunService:IsServer())
		print(index)
		if index == "Client" and RunService:IsServer() then
			logging.error("Attempted to access the client namespace from the server")
		elseif index == "Server" and RunService:IsClient() then
			logging.error("Attempted to access the server namespace from the client")
		end
		return nil
	end
})

print(export)
print(export.Client)
print(export.Server)

return