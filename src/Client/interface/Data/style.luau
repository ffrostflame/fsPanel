local style = {}

style.Palettes = {
    Default = {
        BackgroundLight = Color3.fromRGB(100, 100, 100),
        BackgroundDark = Color3.fromRGB(50, 50, 50),
        Border = Color3.fromRGB(20, 20, 20),
        Accent = Color3.new(1, 0.776470, 0.160784),
        Foreground = Color3.new(1, 1, 1),
    }
}

style.Text = {
    Fonts = {
        Default = Enum.Font.SourceSans,
        Italic = Enum.Font.SourceSansItalic,
        Bold = Enum.Font.SourceSansBold,
        Semibold = Enum.Font.SourceSansSemibold,
    },

    Body = {
        TextSize = 14,
    }
}

return style