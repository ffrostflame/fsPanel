local networked = require(script.Parent.networked)

return function(playerAuthFunction: ((plr: Player) -> boolean)?, debugActions: { [string]: () -> () }, replicatedValues: { [string]: any })
	networked.init(playerAuthFunction, debugActions, replicatedValues)
end