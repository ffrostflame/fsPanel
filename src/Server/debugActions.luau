local debugActions = {}

local actionDictionary = {}
local actionNames = {}

function debugActions.init(actions)
	for action, label in actions do
		table.insert(actionNames, label)
		actionDictionary[label] = action
	end
end

function debugActions.getActionNames()
	return actionNames
end

function debugActions.callDebugAction(player: Player, action: string)
	actionDictionary[action](player)
end

return debugActions