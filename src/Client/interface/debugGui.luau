local Fusion = require(script.Parent.Parent.Parent.Parent.Parent.Fusion)
local New = Fusion.New
local Children = Fusion.Children
local Value = Fusion.Value

local Style = require(script.Parent.Parent.Data.style)

local components = script.Components
local Stat = require(components.stat)

return function()
    New "ScreenGui" {
        Name = "DebugGui",

        [Children] = {
            New "Frame" {
                Name = "ServerStats",
                BackgroundTransparency = 0.4,
                BorderSizePixel = 1,
                BackgroundColor3 = Style.Palettes.Default.BackgroundDark,
                BorderColor3 = Style.Palettes.Default.Border,
                Size = UDim2.new(0.333, 0, 1, 0)
            },

            New "Frame" {
                Name = "GameStats",
                BackgroundTransparency = 0.4,
                BorderSizePixel = 1,
                BackgroundColor3 = Style.Palettes.Default.BackgroundDark,
                BorderColor3 = Style.Palettes.Default.Border,
                AnchorPoint = Vector2.new(0.5, 0),
                Position = UDim2.new(0.5, 0, 0, 0),
                Size = UDim2.new(0.333, 0, 1, 0),

                [Children] = {
                    New "UIListLayout" {
                        Padding = Vector2.new(0, 0)
                    },

                    Stat {
                        Name = "Test",
                        StatValue = Value(100)
                    }
                }
            },

            New "Frame" {
                Name = "Functions",
                BackgroundTransparency = 0.4,
                BorderSizePixel = 1,
                BackgroundColor3 = Style.Palettes.Default.BackgroundLight,
                BorderColor3 = Style.Palettes.Default.Border,
                AnchorPoint = Vector2.new(1, 0),
                Position = UDim2.new(1, 0, 0, 0),
                Size = UDim2.new(0.333, 0, 1, 0)
            }
        }
    }
end