local networked = require(script.networked)

--[=[
	@class Server

	The server dictionary contains all the functions exported by the library that are specifically for the server instance.
	
]=]
return {
	init = require(script.initializer),
	addDebugAction = nil,
}