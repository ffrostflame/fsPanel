local debugGui = require(script.debugGui)

local ui = {}

local plr = game.Players.LocalPlayer

function ui.init()
    -- Create UI
    local screenGui = debugGui()
    screenGui.Parent = plr:WaitForChild("PlayerGui")
end

return ui