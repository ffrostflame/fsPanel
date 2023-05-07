local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(script.Parent.Parent.Parent.Parent.Parent.Fusion)
local New = Fusion.New
local Children = Fusion.Children
-- local Computed = Fusion.Computed
-- local Observer = Fusion.Observer
local OnEvent = Fusion.OnEvent

-- local DataHandler = require(script.Parent.Parent.Parent.dataHandler)
local Style = require(script.Parent.Parent.Data.style)

local enums = require(script.Parent.Parent.Parent.Parent.enums)

local remote = ReplicatedStorage.fsPanelFolder.fsPanel_communicationRemote

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
			New("TextButton")({
				Name = "Button",
				Text = "Fire",
				TextWrapped = true,
				BackgroundTransparency = 0.4,
				BackgroundColor3 = Style.Palettes.Default.BackgroundLight,
				AutoButtonColor = true,
				BorderSizePixel = 1,
				BorderColor3 = Style.Palettes.Default.Border,
				TextColor3 = Style.Palettes.Default.Foreground,
				TextSize = Style.Text.Sizes.Body,
				Font = Style.Text.Fonts.Default,
				TextXAlignment = Enum.TextXAlignment.Center,
				AnchorPoint = Vector2.new(1, 0.5),
				Position = UDim2.new(1, 0, 0.5, 0),
				Size = UDim2.new(0.25, 0, 1, 0),

				[OnEvent("Activated")] = function()
					remote:FireServer({ enums.PacketTypes.executeAction, props.Name })
				end,
			}),
		},
	})
end
