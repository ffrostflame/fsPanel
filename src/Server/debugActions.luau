local debugActions = {}

local actionDictionary = {}
local actionNames = {}

function debugActions.init(actions)
	for action, label in actions do
		table.insert(actionNames, label)
		actionDictionary[label] = action
	end
end

function debugActions._getActionNames()
	return actionNames
end

function debugActions._callDebugAction(player: Player, action: string)
	actionDictionary[action](player)
end

return debugActions