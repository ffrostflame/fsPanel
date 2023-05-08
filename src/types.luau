type serverConfig = {
	playerAuthFunction: ((player: Player) -> boolean)?,
	debugActions: { [string]: (player: Player) -> () }?,
	replicatedValues: { [string]: any }?
}

type clientConfig = {
	toggleKeys: { [number]: Enum.KeyCode }
}

type serverStats = {
	DataReceiveKbps: number,
	DataSendKbps: number,
	HeartbeatTimeMs: number,
	PhysicsStepTimeMs: number,
	ServerFps: number,
	TotalMemoryUsageMb: number,
}

export type fsPanel = {
	Client: {
		init: (config: clientConfig) -> (),
	},
	Server: {
		init: (config: serverConfig) -> (),

		isPlayerAuthorized: () -> boolean,
		getAuthorizedPlayers: () -> { Players },

		getServerStats: () -> {},

		printToAllClients: (string: string) -> (),

		updateValue: (valueName: string, newValue: any) -> (),
	}
}

return nil