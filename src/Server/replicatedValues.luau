local Signal = require(script.Parent.Parent.Parent.Signal)
local logging = require(script.Parent.Parent.logging)

local replicatedValues = {}

local values = {}
local valueChanged = Signal.new()

function replicatedValues.init(definedValues: { [string]: any })
	for label, value in definedValues do
		local typeofLabel = typeof(label)
		logging.typecheck(typeofLabel == "string", typeofLabel, "string")

		values[label] = value
	end
end

function replicatedValues._onValueChanged(func: (label: string, newValue: any) -> ())
	valueChanged:Connect(func)
end

function replicatedValues._getAllValueData()
	return values
end

function replicatedValues.updateValue(valueName: string, newValue: any)
	local typeofValueName = typeof(valueName)
	logging.typecheck(typeofValueName == "string", typeofValueName, "string")

	values[valueName] = newValue
	valueChanged:Fire(valueName, newValue)
end

return replicatedValues