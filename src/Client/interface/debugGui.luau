local UserInputService = game:GetService("UserInputService")

local Fusion = require(script.Parent.Parent.Parent.Parent.Fusion)
local New = Fusion.New
local Children = Fusion.Children
local OnEvent = Fusion.OnEvent
local Value = Fusion.Value
local Ref = Fusion.Ref
local Computed = Fusion.Computed

local components = script.Parent.Components
local Stat = require(components.stat)
local DebugActionButton = require(components.debugActionButton)

local DataHandler = require(script.Parent.Parent.dataHandler)
local Visualizer = require(Script.Parent.Visualizer)
local Style = require(script.Parent.Data.style)

local enums = require(script.Parent.Parent.Parent.enums)

return function(props)
	local setupData = props.SetupData
	local visualizerEnabledValue = Visualizer._getValue()

	-- Window dragging
	local frameRef = Value()

	local dragging = false

	local dragConnection
	local function startDragging()
		if dragging then
			return
		end
		dragging = true

		local lastMousePosition = UserInputService:GetMouseLocation()
		dragConnection = UserInputService.InputChanged:Connect(function(input, _)
			if input.UserInputType ~= Enum.UserInputType.MouseMovement then
				return
			end

			local newMousePosition = UserInputService:GetMouseLocation()
			local difference = newMousePosition - lastMousePosition

			local frame: Frame = frameRef:get()
			frame.Position = UDim2.new(
				frame.Position.X.Scale,
				frame.Position.X.Offset + difference.X,
				frame.Position.Y.Scale,
				frame.Position.Y.Offset + difference.Y
			)

			lastMousePosition = newMousePosition
		end)
	end

	UserInputService.InputEnded:Connect(function(input, _)
		-- When user stops dragging the window
		if input.UserInputType ~= Enum.UserInputType.MouseButton1 then
			return
		end
		if not dragging then
			return
		end
		dragging = false
		dragConnection:Disconnect()
	end)

	-- Game stats
	local gameStatInnerFrameRef = Value()

	local gameStatInnerFrameChildren = {
		New("UIListLayout")({
			Padding = UDim.new(0, 1),
			SortOrder = Enum.SortOrder.Name,
		}),
	}

	for statName, _ in setupData.replicatedValues do
		table.insert(
			gameStatInnerFrameChildren,
			Stat({
				Name = statName,
				StatCategory = enums.Categories.GameStats,
				StatValue = DataHandler.GameStats[statName],
			})
		)
	end

	-- Debug actions
	local actionInnerFrameChildren = {
		New("UIListLayout")({
			Padding = UDim.new(0, 1),
			SortOrder = Enum.SortOrder.LayoutOrder,
		}),
	}

	for _, actionName in setupData.debugActionNames do
		--[[
			New("Frame")({
				Name = "Category",
				BackgroundTransparency = 0.4,
				BorderSizePixel = 1,
				BackgroundColor3 = Style.Palettes.Default.BackgroundDark,
				BorderColor3 = Style.Palettes.Default.Border,
				AutomaticSize = Enum.AutomaticSize.Y,
				Size = UDim2.new(1, 0, 0, 0),
				LayoutOrder = 1,
			})
		]]
		table.insert(
			actionInnerFrameChildren,
			DebugActionButton({
				Name = actionName,
			})
		)
	end

	return New("Frame")({
		Name = "DebugGui",
		BackgroundTransparency = 0.4,
		BorderSizePixel = 1,
		BackgroundColor3 = Style.Palettes.Default.BackgroundDark,
		BorderColor3 = Style.Palettes.Default.Border,
		Size = UDim2.new(0, 800, 0, 400),
		[Ref] = frameRef,

		[Children] = {
			New("TextButton")({
				Name = "Title",
				Text = "Debug Panel",
				TextSize = Style.Text.Sizes.Body,
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 0, 30),
				TextColor3 = Style.Palettes.Default.Foreground,
				Font = Style.Text.Fonts.Bold,
				TextXAlignment = Enum.TextXAlignment.Center,

				[OnEvent("MouseButton1Down")] = startDragging,
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

					New("ScrollingFrame")({
						Name = "InnerFrame",
						BackgroundTransparency = 0.4,
						BorderSizePixel = 1,
						BackgroundColor3 = Style.Palettes.Default.BackgroundDark,
						BorderColor3 = Style.Palettes.Default.Border,
						AnchorPoint = Vector2.new(0.5, 1),
						Position = UDim2.new(0.5, 0, 1, -5),
						Size = UDim2.new(1, -10, 1, -35),
						AutomaticCanvasSize = Enum.AutomaticSize.Y,

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
										Name = "ServerFps",
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

				[Children] = {
					New("ScrollingFrame")({
						Name = "InnerFrame",
						BackgroundTransparency = 0.4,
						BorderSizePixel = 1,
						BackgroundColor3 = Style.Palettes.Default.BackgroundDark,
						BorderColor3 = Style.Palettes.Default.Border,
						AnchorPoint = Vector2.new(0.5, 1),
						Position = UDim2.new(0.5, 0, 1, -5),
						Size = UDim2.new(1, -10, 1, -35),
						AutomaticCanvasSize = Enum.AutomaticSize.Y,
						[Ref] = gameStatInnerFrameRef,

						[Children] = gameStatInnerFrameChildren,
					}),
				},
			}),

			New("Frame")({
				Name = "Actions",
				BackgroundTransparency = 0.4,
				BorderSizePixel = 1,
				BackgroundColor3 = Style.Palettes.Default.BackgroundLight,
				BorderColor3 = Style.Palettes.Default.Border,
				AnchorPoint = Vector2.new(1, 0),
				Position = UDim2.new(1, 0, 0, 30),
				Size = UDim2.new(0.333, 0, 0.8, -30),

				[Children] = {
					New("TextLabel")({
						Name = "Title",
						Text = "Actions",
						TextSize = Style.Text.Sizes.Body,
						BackgroundTransparency = 1,
						Size = UDim2.new(1, 0, 0, 30),
						TextColor3 = Style.Palettes.Default.Foreground,
						Font = Style.Text.Fonts.Bold,
						TextXAlignment = Enum.TextXAlignment.Center,
					}),

					--[[
					New("TextBox")({
						Name = "Data",
						PlaceholderText = "arg1, arg2, arg3...",
						TextSize = Style.Text.Sizes.Body,
						BackgroundTransparency = 0.4,
						BorderSizePixel = 1,
						BackgroundColor3 = Style.Palettes.Default.BackgroundTextBox,
						BorderColor3 = Style.Palettes.Default.Border,
						TextColor3 = Style.Palettes.Default.Foreground,
						AnchorPoint = Vector2.new(0.5, 0),
						Position = UDim2.new(0.5, 0, 0, 30),
						Size = UDim2.new(1, -10, 0, 32),
						TextXAlignment = Enum.TextXAlignment.Left,
						TextYAlignment = Enum.TextYAlignment.Top,

						Font = Style.Text.Fonts.Default,
						LayoutOrder = 0,

						Visible = false,
					}),
					]]

					New("ScrollingFrame")({
						Name = "InnerFrame",
						BackgroundTransparency = 0.4,
						BorderSizePixel = 1,
						BackgroundColor3 = Style.Palettes.Default.BackgroundDark,
						BorderColor3 = Style.Palettes.Default.Border,
						AnchorPoint = Vector2.new(0.5, 1),
						Position = UDim2.new(0.5, 0, 1, -5),
						Size = UDim2.new(1, -10, 1, -35),
						AutomaticCanvasSize = Enum.AutomaticSize.Y,

						[Children] = actionInnerFrameChildren,
					}),
				},
			}),

			New("Frame")({
				Name = "Misc",
				BackgroundTransparency = 0.4,
				BorderSizePixel = 1,
				BackgroundColor3 = Style.Palettes.Default.BackgroundLight,
				BorderColor3 = Style.Palettes.Default.Border,
				AnchorPoint = Vector2.new(1, 1),
				Position = UDim2.new(1, 0, 1, 0),
				Size = UDim2.new(0.333, 0, 0.2, 0),

				[Children] = {
					New("TextLabel")({
						Name = "Visualizers",
						Text = "Visualizers",
						BackgroundTransparency = 1,
						TextSize = Style.Text.Sizes.Body,
						Size = UDim2.new(1, 0, 0, 16),
						TextColor3 = Style.Palettes.Default.Foreground,
						Font = Style.Text.Fonts.Default,
						TextXAlignment = Enum.TextXAlignment.Left,

						[Children] = {
							New("TextButton")({
								Name = "Button",
								Text = Computed(function()
									return visualizerEnabledValue:get() and "ON" or "OFF"
								end),
								TextWrapped = true,
								BackgroundTransparency = Computed(function()
									return visualizerEnabledValue:get() and 0.8 or 0.4
								end),
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
									visualizerEnabledValue:set(not visualizerEnabledValue:get())
								end,
							}),
						},
					}),
				},
			}),
		},
	})
end
