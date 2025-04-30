local WindUI = loadstring(game:HttpGet("https://tree-hub.vercel.app/api/UI/WindUI"))()

local Window = WindUI:CreateWindow({
    Title = "Moonlight Hub",
    Icon = "door-open",
    Author = "Dig to Earth's Core",
    Folder = "CloudHub",
    Size = UDim2.fromOffset(400, 360),
    Transparent = true,
    Theme = "Dark",
    UserEnabled = true,
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
    Title = "Open Moonlight-Hub",
    Icon = "monitor",
    CornerRadius = UDim.new(0,10),
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
    TeleportTab = Window:Tab({ Title = "Teleport", Icon = "mouse-pointer-2", Desc = "Contains interactive buttons for various actions." }),
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

Tabs.MainTab:Section({ Title = "OP Features" })

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

Tabs.MainTab:Section({ Title = "Farm" })

local AutoDig = LocalPlayer.AutoDig
AutoDig.Value = false

Tabs.MainTab:Toggle({
    Title = "Legit Farm",
    Default = true,
    Callback = function(state) 
        pcall(function()
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

local worldPos = {
    ["World 1"] = Vector3.new(15, -400, 0),
    ["World 2"] = Vector3.new(42, -400, -1048),
    ["World 3"] = Vector3.new(21, -400, -2004),
    ["World 4"] = Vector3.new(-6, -400, -3010),
    ["World 5"] = Vector3.new(-1, -400, -4000),
    ["World 6"] = Vector3.new(0, -400, -5000),
    ["World 7"] = Vector3.new(0, -400, -6000),
    ["World 8"] = Vector3.new(0, -400, -7000),
    ["World 9"] = Vector3.new(0, -400, -8000),
    ["World 10"] = Vector3.new(0, -400, -9000),
}

for i = 1, 10 do
    local worldName = "World " .. i
    local position = worldPos[worldName]

    Tabs.TeleportTab:Button({
        Title = worldName,
        Callback = function()
            pcall(function()
                local remotes = ReplicatedStorage:FindFirstChild("Remotes")
                if remotes and remotes:FindFirstChild("WorldTeleportEvent") then
                    remotes.WorldTeleportEvent:FireServer(i)

                    local character = LocalPlayer.Character
                    local hrp = character and character:FindFirstChild("HumanoidRootPart")
                    if hrp and position then
                        hrp.CFrame = CFrame.new(position + Vector3.new(0, 1550, 0)) 
                    end
                end
            end)
        end
    })
end



Tabs.PetsTab:CreateInput({
   Title = "Triple Dominus ( 50X )",
   Default = "0",
   Placeholder = "Amount",
   Callback = function(Text)
        pcall(function()
        for amount = 1, Text do task.wait()
            if ReplicatedStorage:FindFirstChild("Remotes") then
                local remotes = ReplicatedStorage.Remotes
                if remotes:FindFirstChild("SpinPrizeEvent") then
                    local spinPrizeevent = remotes.SpinPrizeEvent
                    spinPrizeevent:FireServer(4)
                end
            end
        end

        end)
   end
})

Tabs.PetsTab:CreateInput({
   Title = "Diamond Cosmic Alien ( 180X )",
   Default = "0",
   Placeholder = "Amount",
   Callback = function(Text)
        pcall(function()
        for amount = 1, Text do task.wait()
            if ReplicatedStorage:FindFirstChild("Remotes") then
                local remotes = ReplicatedStorage.Remotes
                if remotes:FindFirstChild("PetCageEvent") then
                    local PetCageevent = remotes.PetCageEvent
                    PetCageevent:FireServer("Diamond Cosmic Alien")
                end
            end
        end

        end)
   end
})

Tabs.PetsTab:CreateInput({
   Title = "Void Angel ( 100X )",
   Default = "0",
   Placeholder = "Amount",
   Callback = function(Text)
        pcall(function()
        for amount = 1, Text do task.wait()
            if ReplicatedStorage:FindFirstChild("Remotes") then
                local remotes = ReplicatedStorage.Remotes
                if remotes:FindFirstChild("PetCageEvent") then
                    local PetCageevent = remotes.PetCageEvent
                    PetCageevent:FireServer("Void Angel")
                end
            end
        end

        end)
   end
})

local HttpService = game:GetService("HttpService")

local folderPath = "WindUI"
makefolder(folderPath)

local function SaveFile(fileName, data)
    local filePath = folderPath .. "/" .. fileName .. ".json"
    local jsonData = HttpService:JSONEncode(data)
    writefile(filePath, jsonData)
end

local function LoadFile(fileName)
    local filePath = folderPath .. "/" .. fileName .. ".json"
    if isfile(filePath) then
        local jsonData = readfile(filePath)
        return HttpService:JSONDecode(jsonData)
    end
end

local function ListFiles()
    local files = {}
    for _, file in ipairs(listfiles(folderPath)) do
        local fileName = file:match("([^/]+)%.json$")
        if fileName then
            table.insert(files, fileName)
        end
    end
    return files
end

Tabs.WindowTab:Section({ Title = "Window" })

local themeValues = {}
for name, _ in pairs(WindUI:GetThemes()) do
    table.insert(themeValues, name)
end

local themeDropdown = Tabs.WindowTab:Dropdown({
    Title = "Select Theme",
    Multi = false,
    AllowNone = false,
    Value = nil,
    Values = themeValues,
    Callback = function(theme)
        pcall(function()
        WindUI:SetTheme(theme) end)
    end
})
themeDropdown:Select(WindUI:GetCurrentTheme())

local ToggleTransparency = Tabs.WindowTab:Toggle({
    Title = "Toggle Window Transparency",
    Callback = function(e)
        pcall(function()
        Window:ToggleTransparency(e) end)
    end,
    Value = WindUI:GetTransparency()
})

Tabs.WindowTab:Section({ Title = "Save" })

local fileNameInput = ""
Tabs.WindowTab:Input({
    Title = "Write File Name",
    PlaceholderText = "Enter file name",
    Callback = function(text)
        pcall(function()
        fileNameInput = text end)
    end
})

Tabs.WindowTab:Button({
    Title = "Save File",
    Callback = function()
        pcall(function()
        if fileNameInput ~= "" then
            SaveFile(fileNameInput, { Transparent = WindUI:GetTransparency(), Theme = WindUI:GetCurrentTheme() })
        end end)
    end
})

Tabs.WindowTab:Section({ Title = "Load" })

local filesDropdown
local files = ListFiles()

filesDropdown = Tabs.WindowTab:Dropdown({
    Title = "Select File",
    Multi = false,
    AllowNone = true,
    Values = files,
    Callback = function(selectedFile)
        pcall(function()
        fileNameInput = selectedFile end)
    end
})

Tabs.WindowTab:Button({
    Title = "Load File",
    Callback = function()
    pcall(function()
        if fileNameInput ~= "" then
            local data = LoadFile(fileNameInput)
            if data then
                WindUI:Notify({
                    Title = "File Loaded",
                    Content = "Loaded data: " .. HttpService:JSONEncode(data),
                    Duration = 5,
                })
                if data.Transparent then 
                    Window:ToggleTransparency(data.Transparent)
                    ToggleTransparency:SetValue(data.Transparent)
                end
                if data.Theme then WindUI:SetTheme(data.Theme) end
            end
        end end)
    end
})

Tabs.WindowTab:Button({
    Title = "Overwrite File",
    Callback = function()
    pcall(function()
        if fileNameInput ~= "" then
            SaveFile(fileNameInput, { Transparent = WindUI:GetTransparency(), Theme = WindUI:GetCurrentTheme() })
        end end)
    end
})

Tabs.WindowTab:Button({
    Title = "Refresh List",
    Callback = function()
        pcall(function()
        filesDropdown:Refresh(ListFiles()) end)
    end
})

local currentThemeName = WindUI:GetCurrentTheme()
local themes = WindUI:GetThemes()

local ThemeAccent = themes[currentThemeName].Accent
local ThemeOutline = themes[currentThemeName].Outline
local ThemeText = themes[currentThemeName].Text
local ThemePlaceholderText = themes[currentThemeName].PlaceholderText

function updateTheme()
    WindUI:AddTheme({
        Name = currentThemeName,
        Accent = ThemeAccent,
        Outline = ThemeOutline,
        Text = ThemeText,
        PlaceholderText = ThemePlaceholderText
    })
    WindUI:SetTheme(currentThemeName)
end

Tabs.CreateThemeTab:Input({
    Title = "Theme Name",
    Value = currentThemeName,
    Callback = function(name)
        pcall(function()
        currentThemeName = name end)
    end
})

Tabs.CreateThemeTab:Colorpicker({
    Title = "Background Color",
    Default = Color3.fromHex(ThemeAccent),
    Callback = function(color)
        pcall(function()
        ThemeAccent = color:ToHex() end)
    end
})

Tabs.CreateThemeTab:Colorpicker({
    Title = "Outline Color",
    Default = Color3.fromHex(ThemeOutline),
    Callback = function(color)
        pcall(function()
        ThemeOutline = color:ToHex() end)
    end
})

Tabs.CreateThemeTab:Colorpicker({
    Title = "Text Color",
    Default = Color3.fromHex(ThemeText),
    Callback = function(color)
        pcall(function()
        ThemeText = color:ToHex() end)
    end
})

Tabs.CreateThemeTab:Colorpicker({
    Title = "Placeholder Text Color",
    Default = Color3.fromHex(ThemePlaceholderText),
    Callback = function(color)
        pcall(function()
        ThemePlaceholderText = color:ToHex() end)
    end
})

Tabs.CreateThemeTab:Button({
    Title = "Update Theme",
    Callback = function()
        pcall(function()
        updateTheme() end)
    end
})
