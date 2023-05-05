local Fusion = require(script.Parent.Parent.Parent.Parent.Fusion)
local New = Fusion.New
local Children = Fusion.Children
local Value = Fusion.Value

local components = script.Parent.Components
local Stat = require(components.stat)

local DataHandler = require(script.Parent.Parent.dataHandler)
local Style = require(script.Parent.Data.style)

local enums = require(script.Parent.Parent.Parent.enums)

return function()
	return New("Frame")({
		Name = "DebugGui",
		BackgroundTransparency = 0.4,
		BorderSizePixel = 1,
		BackgroundColor3 = Style.Palettes.Default.BackgroundDark,
		BorderColor3 = Style.Palettes.Default.Border,
		Size = UDim2.new(0, 800, 0, 400),

		[Children] = {
			New("TextLabel")({
				Name = "Title",
				Text = "Debug Panel",
				TextSize = Style.Text.Sizes.Body,
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 0, 30),
				TextColor3 = Style.Palettes.Default.Foreground,
				Font = Style.Text.Fonts.Bold,
				TextXAlignment = Enum.TextXAlignment.Center,
			}),

			New("Frame")({
				Name = "ServerStats",
				BackgroundTransparency = 0.4,
				BorderSizePixel = 1,
				BackgroundColor3 = Style.Palettes.Default.BackgroundDark,
				BorderColor3 = Style.Palettes.Default.Border,
				AnchorPoint = Vector2.new(0, 1),
				Position = UDim2.new(0, 0, 1, 0),
				Size = UDim2.new(0.333, 0, 1, -30),

				[Children] = {
					New("TextLabel")({
						Name = "Title",
						Text = "Server Stats",
						TextSize = Style.Text.Sizes.Body,
						BackgroundTransparency = 1,
						Size = UDim2.new(1, 0, 0, 30),
						TextColor3 = Style.Palettes.Default.Foreground,
						Font = Style.Text.Fonts.Bold,
						TextXAlignment = Enum.TextXAlignment.Center,
					}),

					New("Frame")({
						Name = "InnerFrame",
						BackgroundTransparency = 0.4,
						BorderSizePixel = 1,
						BackgroundColor3 = Style.Palettes.Default.BackgroundDark,
						BorderColor3 = Style.Palettes.Default.Border,
						AnchorPoint = Vector2.new(0.5, 1),
						Position = UDim2.new(0.5, 0, 1, -5),
						Size = UDim2.new(1, -10, 1, -35),

						[Children] = {
							New("UIListLayout")({
								Padding = UDim.new(0, 1),
								SortOrder = Enum.SortOrder.LayoutOrder,
							}),

							New("Frame")({
								Name = "Kbps",
								BackgroundTransparency = 0.4,
								BorderSizePixel = 1,
								BackgroundColor3 = Style.Palettes.Default.BackgroundDark,
								BorderColor3 = Style.Palettes.Default.Border,
								AutomaticSize = Enum.AutomaticSize.Y,
								Size = UDim2.new(1, 0, 0, 0),
								LayoutOrder = 1,

								[Children] = {
									New("UIListLayout")({
										Padding = UDim.new(0, 0),
										SortOrder = Enum.SortOrder.LayoutOrder,
									}),

									Stat({
										Name = "DataReceiveKbps",
										StatCategory = enums.Categories.ServerStats,
										StatValue = DataHandler.ServerStats[enums.ServerStatItems.DataReceiveKbps],
									}),

									Stat({
										Name = "DataSendKbps",
										StatCategory = enums.Categories.ServerStats,
										StatValue = DataHandler.ServerStats[enums.ServerStatItems.DataSendKbps],
									}),
								},
							}),

							New("Frame")({
								Name = "Ms",
								BackgroundTransparency = 0.4,
								BorderSizePixel = 1,
								BackgroundColor3 = Style.Palettes.Default.BackgroundDark,
								BorderColor3 = Style.Palettes.Default.Border,
								AutomaticSize = Enum.AutomaticSize.Y,
								Size = UDim2.new(1, 0, 0, 0),
								LayoutOrder = 2,

								[Children] = {
									New("UIListLayout")({
										Padding = UDim.new(0, 0),
										SortOrder = Enum.SortOrder.LayoutOrder,
									}),

									Stat({
										Name = "HeartbeatTimeMs",
										StatCategory = enums.Categories.ServerStats,
										StatValue = DataHandler.ServerStats[enums.ServerStatItems.HeartbeatTimeMs],
									}),

									Stat({
										Name = "PhysicsStepTimeMs",
										StatCategory = enums.Categories.ServerStats,
										StatValue = DataHandler.ServerStats[enums.ServerStatItems.PhysicsStepTimeMs],
									}),
								},
							}),

							New("Frame")({
								Name = "Mb",
								BackgroundTransparency = 0.4,
								BorderSizePixel = 1,
								BackgroundColor3 = Style.Palettes.Default.BackgroundDark,
								BorderColor3 = Style.Palettes.Default.Border,
								AutomaticSize = Enum.AutomaticSize.Y,
								Size = UDim2.new(1, 0, 0, 0),
								LayoutOrder = 3,

								[Children] = {
									New("UIListLayout")({
										Padding = UDim.new(0, 0),
										SortOrder = Enum.SortOrder.LayoutOrder,
									}),

									Stat({
										Name = "TotalMemoryUsageMb",
										StatCategory = enums.Categories.ServerStats,
										StatValue = DataHandler.ServerStats[enums.ServerStatItems.TotalMemoryUsageMb],
									}),
								},
							}),

							New("Frame")({
								Name = "FPS",
								BackgroundTransparency = 0.4,
								BorderSizePixel = 1,
								BackgroundColor3 = Style.Palettes.Default.BackgroundDark,
								BorderColor3 = Style.Palettes.Default.Border,
								AutomaticSize = Enum.AutomaticSize.Y,
								Size = UDim2.new(1, 0, 0, 0),
								LayoutOrder = 4,

								[Children] = {
									New("UIListLayout")({
										Padding = UDim.new(0, 0),
										SortOrder = Enum.SortOrder.LayoutOrder,
									}),

									Stat({
										Name = "Server FPS",
										StatCategory = enums.Categories.ServerStats,
										StatValue = DataHandler.ServerStats[enums.ServerStatItems.ServerFps],
									}),
								},
							}),
						},
					}),
				},
			}),

			New("Frame")({
				Name = "GameStats",
				BackgroundTransparency = 0.4,
				BorderSizePixel = 1,
				BackgroundColor3 = Style.Palettes.Default.BackgroundDark,
				BorderColor3 = Style.Palettes.Default.Border,
				AnchorPoint = Vector2.new(0.5, 1),
				Position = UDim2.new(0.5, 0, 1, 0),
				Size = UDim2.new(0.333, 0, 1, -30),
			}),

			New("Frame")({
				Name = "Functions",
				BackgroundTransparency = 0.4,
				BorderSizePixel = 1,
				BackgroundColor3 = Style.Palettes.Default.BackgroundLight,
				BorderColor3 = Style.Palettes.Default.Border,
				AnchorPoint = Vector2.new(1, 1),
				Position = UDim2.new(1, 0, 1, 0),
				Size = UDim2.new(0.333, 0, 1, -30),
			}),
		},
	})
end
