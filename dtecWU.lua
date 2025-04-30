local WindUI = loadstring(game:HttpGet("https://tree-hub.vercel.app/api/UI/WindUI"))()

local Window = WindUI:CreateWindow({
    Title = "Moonlight Hub",
    Icon = "door-open",
    Author = "Example UI",
    Folder = "CloudHub",
    Size = UDim2.fromOffset(400, 360),
    Transparent = true,
    Theme = "Dark",
    UserEnabled = false,
    SideBarWidth = 200,
    --Background = "rbxassetid://13511292247", -- rbxassetid only
    HasOutline = true,
    -- remove it below if you don't want to use the key system in your script.
    KeySystem = { 
        Key = { "1234", "5678" },
        Note = "Example Key System. \n\nThe Key is '1234' or '5678",
        -- Thumbnail = {
        --     Image = "rbxassetid://18220445082", -- rbxassetid only
        --     Title = "Thumbnail"
        -- },
        URL = "https://github.com/Footagesus/WindUI", -- remove this if the key is not obtained from the link.
        SaveKey = true, -- optional
    },
})

Window:EditOpenButton({
    Title = "Open Example UI",
    Icon = "monitor",
    CornerRadius = UDim.new(0,16),
    StrokeThickness = 2,
    Color = ColorSequence.new( -- gradient
        Color3.fromHex("FF0F7B"), 
        Color3.fromHex("F89B29")
    ),
    --Enabled = false,
    Draggable = true,
})

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local Tabs = {
    MainTab = Window:Tab({ Title = "Main", Icon = "type" }),
    TeleportnTab = Window:Tab({ Title = "Teleport", Icon = "mouse-pointer-2", Desc = "Contains interactive buttons for various actions." }),
    PetsTab = Window:Tab({ Title = "Pets", Icon = "code", Desc = "Displays and manages code snippets." }),
    SettingsrTab = Window:Tab({ Title = "Settings", Icon = "paintbrush", Desc = "Choose and customize colors easily." }),
    --[[NotificationTab = Window:Tab({ Title = "Notification", Icon = "bell", Desc = "Configure and view notifications." }),
    ToggleTab = Window:Tab({ Title = "Toggle", Icon = "toggle-left", Desc = "Switch settings on and off." }),
    SliderTab = Window:Tab({ Title = "Slider", Icon = "sliders-horizontal", Desc = "Adjust values smoothly with sliders." }),
    InputTab = Window:Tab({ Title = "Input", Icon = "keyboard", Desc = "Accept text and numerical input." }),
    DropdownTab = Window:Tab({ Title = "Dropdown", Icon = "chevrons-up-down", Desc = "Select from multiple options." }),]]
    b = Window:Divider(),
    WindowTab = Window:Tab({ Title = "Window and File Configuration", Icon = "settings", Desc = "Manage window settings and file configurations." }),
    CreateThemeTab = Window:Tab({ Title = "Create Theme", Icon = "palette", Desc = "Design and apply custom themes." }),
}

Window:SelectTab(1)

Tabs.MainTab:Button({
    Title = "Infinite Cash",
    Desc = "Please only click one time",
    Callback = function()
        pcall(function()
            if ReplicatedStorage:FindFirstChild("Remotes") then
                local remotes = ReplicatedStorage.Remotes
                if remotes:FindFirstChild("AddRewardEvent") then
                    local infevent = remotes.AddRewardEvent
                    infevent:FireServer("Cash", math.huge)
                end
            end
        end)
    end
})

Tabs.MainTab:Button({
    Title = "Infinite Gems",
    Desc = "Please only click one time",
    Callback = function()
        pcall(function()
            if ReplicatedStorage:FindFirstChild("Remotes") then
                local remotes = ReplicatedStorage.Remotes
                if remotes:FindFirstChild("AddRewardEvent") then
                    local infevent = remotes.AddRewardEvent
                    infevent:FireServer("Gems", math.huge)
                end
            end
        end)
    end
})

Tabs.MainTab:Paragraph({
    Title = "Farm",
    Desc = "Farm Wins",
    Image = "bird",
    --Color = "Red"
    Buttons = {
    }
})

Tabs.MainTab:Toggle({
    Title = "Legit Farm",
    Default = false,
    Callback = function(state) 
        pcall(function()
            local AutoDig = LocalPlayer.AutoDig
            AutoDig.Value = state
            if AutoDig.Value == true then
                AutoDig.Value = false
            elseif AutoDig.Value == false then
                AutoDig.Value = true
            end
        end)
    end
})

local selectedWorldName = "World1"
local isFarming = false

Tabs.MainTab:Dropdown({
    Title = "World Select (Blatant Farm)",
    Values = {"World1", "World2", "World3", "World4", "World5", "World6", "World7", "World8", "World9", "World10"},
    Value = "Option 1",
    Callback = function(option) 
        if typeof(option) == "table" then
            selectedWorldName = option[1]
        else
            selectedWorldName = option
        end
    end
})

Tabs.MainTab:Toggle({
    Title = "Blatant Farm",
    Default = false,
    Callback = function(state) 
        isFarming = state -- update toggle state
        if state then
            task.spawn(function()
                while isFarming do
                    pcall(function()
                        local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                        local hrp = char:FindFirstChild("HumanoidRootPart")
                        local world = Workspace:FindFirstChild(selectedWorldName)
                        local winPart = world and world:FindFirstChild("WinPart")

                        if hrp and winPart then
                            hrp.CFrame = winPart.CFrame + Vector3.new(0, 12.5, 0)
                        end
                    end)
                    task.wait(0.05)
                end
            end)
        end
    end
})
