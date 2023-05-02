local Fusion = require(script.Parent.Parent.Parent.Parent.Parent.Fusion)
local New = Fusion.New
local Children = Fusion.Children
local Computed = Fusion.Computed

local Style = require(script.Parent.Parent.Data.style)

return function(props)
	props.UnitName = props.UnitName or ""

	return New("TextLabel")({
		Name = props.Name or "Stat",
		Text = props.Name or "Stat",
		BackgroundTransparency = 1,
		TextSize = Style.Text.Sizes.Body,
		Size = UDim2.new(1, 0, 0, 16),
		TextColor3 = Style.Palettes.Default.Foreground,
		Font = Style.Text.Fonts.Bold,
		TextXAlignment = Enum.TextXAlignment.Left,

		[Children] = {
			New("TextLabel")({
				Name = "Value",
				BackgroundTransparency = 1,
				TextSize = Style.Text.Sizes.Body,
				Size = UDim2.new(1, 0, 1, 0),
				TextColor3 = Style.Palettes.Default.Foreground,
				Font = Style.Text.Fonts.Default,
				TextXAlignment = Enum.TextXAlignment.Right,
				Text = Computed(function()
					return tostring(props.StatValue:get()) .. props.UnitName
				end),
			}),
		},
	})
end
