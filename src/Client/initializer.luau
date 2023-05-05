local ReplicatedStorage = game:GetService("ReplicatedStorage")

return function()
	local remote = ReplicatedStorage:WaitForChild("SetupInfoRemote")

	local setupData = remote:InvokeServer()
	if not setupData.isAuthorized then
		return
	end

	require(script.Parent.interface).init(setupData)
	require(script.Parent.dataHandler).init(setupData)
end
