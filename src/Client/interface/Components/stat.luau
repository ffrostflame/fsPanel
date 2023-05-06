local Fusion = require(script.Parent.Parent.Parent.Parent.Parent.Fusion)
local New = Fusion.New
local Children = Fusion.Children
local Computed = Fusion.Computed
-- local Observer = Fusion.Observer

local DataHandler = require(script.Parent.Parent.Parent.dataHandler)
local Style = require(script.Parent.Parent.Data.style)

local enums = require(script.Parent.Parent.Parent.Parent.enums)

return function(props)
	props.UnitName = props.UnitName or ""

	return New("TextLabel")({
		Name = props.Name,
		Text = props.Name,
		BackgroundTransparency = 1,
		TextSize = Style.Text.Sizes.Body,
		Size = UDim2.new(1, 0, 0, 16),
		TextColor3 = Style.Palettes.Default.Foreground,
		Font = Style.Text.Fonts.Default,
		TextXAlignment = Enum.TextXAlignment.Left,

		[Children] = {
			New("TextLabel")({
				Name = "Value",
				BackgroundTransparency = 1,
				TextSize = Style.Text.Sizes.Body,
				AnchorPoint = Vector2.new(1, 0),
				Position = UDim2.new(1, 0, 0, 0),
				Size = UDim2.new(0.25, 0, 1, 0),
				TextColor3 = Computed(function()
					local targetFunction
					if props.StatCategory == enums.Categories.ServerStats then
						targetFunction =
							DataHandler.TargetFunctions[enums.Categories.ServerStats][enums.ServerStatItems[props.Name]]
					else
						targetFunction = DataHandler.TargetFunctions[enums.Categories.GameStats]["custom"]
					end

					local goodness = targetFunction(props.StatValue:get())
					if goodness == -1 then
						return Color3.new(0.560784, 0.560784, 0.560784)
					end

					return Color3.fromHSV((120 / 359) * goodness, 1, 1)
				end),
				Font = Style.Text.Fonts.Default,
				TextXAlignment = Enum.TextXAlignment.Left,
				Text = Computed(function()
					return (tostring(props.StatValue:get()) .. props.UnitName) or "[Loading]"
				end),
			}),
		},
	})
end
