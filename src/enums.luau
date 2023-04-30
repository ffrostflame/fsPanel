-- using this to save on network usage
return {
	PacketTypes = {
		update = '1',
		connected = '2',
		setup = '3',
		executeAction = '4',
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
		TotalMemoryTime = 6,
	}
}