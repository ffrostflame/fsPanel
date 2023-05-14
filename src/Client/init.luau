local ReplicatedStorage = game:GetService("ReplicatedStorage")
ReplicatedStorage:WaitForChild("fsPanelFolder")

--[=[
	@class Client

	The root namespace for all the exposed client functions in fsPanel.
]=]

--[=[
	@type clientConfig {
		toggleKeys: {
			[number]: Enum.KeyCode
		}
	}
	@within Client

	Configuration for `fsPanel.Server.init()`
	Example:
	```lua
	local clientConfiguration = {
		toggleKeys = {
			Enum.KeyCode.F2
		}
	}
	```
]=]

--[=[
	@function init
	@within Client
	
	Initialization function. Starts & creates the fsPanel client-sided UI- determining which users are authorized, and which ones aren't.
	```lua
	local fsPanel = require(path.to.fsPanel)

	fsPanel.Client.init({
		toggleKeys = { Enum.KeyCode.F1 }
	})
	```

	@param clientConfig clientConfig
	@return void
]=]

return table.freeze({
	init = require(script.initializer),
})
