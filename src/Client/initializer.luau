local ReplicatedStorage = game:GetService("ReplicatedStorage")

return function()
	local remote = ReplicatedStorage:WaitForChild("SetupInfoRemote")

	local authorized = remote:InvokeServer()
	if not authorized then
		return
	end

	require(script.Parent.interface).init()
	require(script.Parent.dataHandler).init()
end
