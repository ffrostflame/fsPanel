local Fusion = require(script.Parent.Parent.Parent.Parent.Parent.Fusion)
local New = Fusion.New

local Style = require(script.Parent.Parent.Data.style)

return function(props: {})
    props.Name = props.Name or "Stat"
    props.BackgroundTransparency = props.BackgroundTransparency or 1
    props.Size = props.Size or UDim2.new(1, 0, 0, 14)
    props.TextColor3 = props.TextColor3 or Style.Palettes.Default.Foreground
    props.Font = props.Font or Style.Text.Fonts.Bold

    return New("TextLabel", props)
end