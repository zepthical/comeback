local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local chr = player.Character

function getMoney()
    local money = player:WaitForChild("leaderstats"):WaitForChild("Money")

    return money.Value
end

function getStreak()
    local str = player:WaitForChild("leaderstats"):WaitForChild("🔥")

    return str.Value
end

function getBiggest()
    local biggest = player:WaitForChild("leaderstats"):WaitForChild("BiggestPoop")

    return biggest.Value
end

local function sellhand()
    ReplicatedStorage:WaitForChild("PoopResponseChosen"):FireServer("1. [I want to sell THIS.]")
end

local function loopsellhand(state)
    local running = state

    while running do task.wait(2.5)
        ReplicatedStorage:WaitForChild("PoopResponseChosen"):FireServer("1. [I want to sell THIS.]")
    end
end

local function sellinv()
    ReplicatedStorage:WaitForChild("PoopResponseChosen"):FireServer("2. [I want to sell my inventory.]")
end

local function loopsellinv(state)
    local running = state

    while running do task.wait(0.5)
        ReplicatedStorage:WaitForChild("PoopResponseChosen"):FireServer("2. [I want to sell my inventory.]")
    end
end

local function loopcharge(state)
    local running = state

    while running do task.wait(0.5)
        ReplicatedStorage:WaitForChild("PoopChargeStart"):FireServer()
    end
end

local function loopPoop(state)
    local running = state

    while running do task.wait(0.5)
        ReplicatedStorage:WaitForChild("PoopEvent"):FireServer(1)
    end
end

local mstate = false

local function moneychanger(Amount)
    local running = mstate

    local money = Amount

    local ml = player:WaitForChild("leaderstats"):WaitForChild("Money")

    while running do task.wait(0.01)
        ml.Value = Amount
        player:WaitForChild("PlayerGui"):WaitForChild("Money/LevelUI"):WaitForChild("LevelDisplayUI"):WaitForChild("MoneyLabel").Text = "$".. Amount
    end
end

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "very special scripts",
   Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "very special scripts",
   LoadingSubtitle = game.Name,
   ShowText = "UI", -- for mobile users to unhide rayfield, change if you'd like
   Theme = "Default", -- Check https://docs.sirius.menu/rayfield/configuration/themes

   ToggleUIKeybind = "K", -- The keybind to toggle the UI visibility (string like "K" or Enum.KeyCode)

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface

   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil, -- Create a custom folder for your hub/game
      FileName = "vss"
   },

   Discord = {
      Enabled = false, -- Prompt the user to join your Discord server if their executor supports it
      Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ ABCD would be ABCD
      RememberJoins = false -- Set this to false to make them join the discord every time they load it up
   },

   KeySystem = false, -- Set this to true to use our key system
   KeySettings = {
      Title = "Untitled",
      Subtitle = "Key System",
      Note = "No method of obtaining the key is provided", -- Use this to tell the user how to get a key
      FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
      SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"Hello"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
   }
})

local MainTab = Window:CreateTab("Main", 4483362458)
local VisualTab = Window:CreateTab("Visual", 4483362458)
--local PlayerTab = Window:CreateTab("Player", 4483362458)
--local SettingTab = Window:CreateTab("Settings", 4483362458)

local MainSection = MainTab:CreateSection("Auto")

local Toggle1 = MainTab:CreateToggle({
   Name = "Auto Charge",
   CurrentValue = false,
   Flag = "Toggle1",
   Callback = function(Value)
        loopcharge(Value)
   end,
})

local Toggle2 = MainTab:CreateToggle({
   Name = "Auto Poop",
   CurrentValue = false,
   Flag = "Toggle2",
   Callback = function(Value)
        loopPoop(Value)
   end,
})

local Divider1 = MainTab:CreateDivider()

local Toggle3 = MainTab:CreateToggle({
   Name = "Auto Sell Hand",
   CurrentValue = false,
   Flag = "Toggle3",
   Callback = function(Value)
        loopsellhand(Value)
   end,
})

local Toggle4 = MainTab:CreateToggle({
   Name = "Auto Sell Inventory",
   CurrentValue = false,
   Flag = "Toggle4",
   Callback = function(Value)
        loopsellinv(Value)
   end,
})

local Section2 = VisualTab:CreateSection("Changer")

local Input1 = VisualTab:CreateInput({
   Name = "Money Changer",
   CurrentValue = "",
   PlaceholderText = "Amount",
   RemoveTextAfterFocusLost = false,
   Flag = "Input1",
   Callback = function(Text)
        moneychanger(Text)
   end,
})

local Toggle5 = VisualTab:CreateToggle({
   Name = "On/Off Money Changer",
   CurrentValue = false,
   Flag = "Toggle5",
   Callback = function(Value)
        mstate = Value
   end,
})

Rayfield:LoadConfiguration()
