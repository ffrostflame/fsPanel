local ReplicatedStorage = game:GetService("ReplicatedStorage")

return function(clientConfig)
	local remote = ReplicatedStorage:WaitForChild("fsPanelFolder").fsPanel_getSetupInfo

	local setupData = remote:InvokeServer()
	if not setupData.isAuthorized then
		return
	end

	print(setupData)
	require(script.Parent.dataHandler).init(setupData)
	require(script.Parent.interface).init(setupData, clientConfig)
end
