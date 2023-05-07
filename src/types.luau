type serverConfig = {

}

type clientConfig = {

}

export type fsPanel = {
	Client: {
		init: (config: clientConfig) -> (),
	},
	Server: {
		init: (config: serverConfig) -> (),
		isPlayerAuthorized: () -> boolean
	}
}

return nil