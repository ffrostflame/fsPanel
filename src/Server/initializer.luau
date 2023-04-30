local networked = require(script.Parent.networked)

return function(playerAuthFunction: ((plr: Player) -> boolean)?)
	networked.init(playerAuthFunction)
end