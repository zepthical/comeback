local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

local Version = "1.6.41"
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/download/" .. Version .. "/main.lua"))()

local Window = WindUI:CreateWindow({
    Title = "Eternal Tower of Hell",
    Icon = "bird", -- lucide icon. optional
    Author = "very special scripts", -- optional
})

Window:SetBackgroundImage("rbxassetid://81992215231772")

Window:EditOpenButton({
    Title = "Open UI",
    Icon = "monitor",
    CornerRadius = UDim.new(0,16),
    StrokeThickness = 2,
    Color = ColorSequence.new( -- gradient
        Color3.fromHex("FF0F7B"), 
        Color3.fromHex("F89B29")
    ),
    OnlyMobile = false,
    Enabled = true,
    Draggable = true,
})

local MainTab = Window:Tab({
    Title = "Main",
    Icon = "info", -- optional
    Locked = false,
})

--[[local TeleportTab = Window:Tab({
    Title = "Teleport",
    Icon = "bird", -- optional
    Locked = false,
})]]

--[[local MiscTab = Window:Tab({
    Title = "Miscellaneous",
    Icon = "swords", -- optional
    Locked = false,
})]]

local STInput = MainTab:Input({
    Title = "Select Tower",
    Desc = "Select Tower to beat",
    Value = "ToAST",
    InputIcon = "bird",
    Type = "Input",
    Placeholder = "Tower acronym here",
    Callback = function(input) 
         currentInput = input
    end
})

local TInput = MainTab:Input({
    Title = "Select Time",
    Desc = "Select Time to beat",
    Value = "0",
    InputIcon = "bird",
    Type = "Input",
    Placeholder = "Leave blank for faster",
    Callback = function(input) 
         timeInput = tonumber(input) or 0
         if string.find(input, "inf") then
            timeInput = math.huge
         end
    end
})

local BButton = MainTab:Button({
    Title = "Beat Selected Tower",
    Desc = "Beat Selected Tower",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/zepthical/script/refs/heads/main/etoh/jtohautowin.lua", true))()(currentInput, timeInput)
    end
})

local BATButton = MainTab:Button({
    Title = "Beat All Towers [ NON-SC ]",
    Desc = "Beat All Towers Except SoulCrushing",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/zepthical/script/refs/heads/main/etoh/jtohautowin.lua", true))()(nil, timeInput)
    end
})
