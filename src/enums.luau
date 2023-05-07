-- using this to save on network usage
return {
	PacketTypes = {
		update = "1",
		executeAction = "2",
		printToClient = "3",
	},
	Categories = {
		ServerStats = 1,
		GameStats = 2,
	},
	ServerStatItems = {
		DataReceiveKbps = 1,
		DataSendKbps = 2,
		HeartbeatTimeMs = 3,
		PhysicsStepTimeMs = 4,
		ServerFps = 5,
		TotalMemoryUsageMb = 6,
	},
}

--[[

A folder "fsPanelFolder" is created and placed into ReplicatedStorage
The remote "fsPanel_communicationRemote" is placed into this folder
The server will use this remote to send debug data to all authorized clients every 0.5s

The server sends one table with the following data:
{
	PacketType,
	{
		[enums.Categories.ServerStats] = {
			[enums.ServerStatItems.DataReceiveKbps],
			[enums.ServerStatItems.DataSendKbps],
			[enums.ServerStatItems.HeartbeatTimeMs],
			[enums.ServerStatItems.PhysicsStepTimeMs],
			[enums.ServerStatItems.ServerFps],
			[enums.ServerStatItems.TotalMemoryMb]
		},

		[enums.Categories.GameStats] = {}
	}
}

]]
