local Players = game:GetService("Players")
local player = Players.LocalPlayer
local chr = player.Character or player.CharacterAdded:Wait()
local hrp = chr:WaitForChild("HumanoidRootPart")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local playerDataFolder = player:WaitForChild("PlayerData")
local normalUpgrade = playerDataFolder:WaitForChild("Upgrades")
local rebirthUpgrade = playerDataFolder:WaitForChild("RebirthUpgrades")


local function getpos()
    return hrp.CFrame
end

local function NUpg(val, upg)
    local amount = val -- value
    local upgrade = upg -- Boost Duration, Boost Speed, Damage, Flashtime Speed, Health, Speed

    normalUpgrade:WaitForChild(upg).Value = amount
end

local function RUpg(val, upg)
    local amount = val -- Value
    local upgrade = upg -- Boost Duration, Boost Speed, Damage, Flashtime Speed, Health, Speed

    rebirthUpgrade:WaitForChild(upg).Value = amount
end

_twTIME = true

function getTWtime()
    while _twTIME do task.Wait(0.1)
        return playerDataFolder:WaitForChild("TimeUntilTimeWraith").Value
    end
end

local function tp(pos)
    local posi = pos
    
    hrp.CFrame = CFrame.new(posi)
end

_deliv = false
_defeat = true
_defuse = false

local function findQuest()
    if workspace:FindFirstChild("DeliveryGuy") or workspace:FindFirstChild("Debris").NPC then
        return workspace:FindFirstChild("DeliveryGuy")
    elseif workspace:FindFirstChild("NPCs"):FindFirstChild("Normal") then
        return workspace:FindFirstChild("NPCs"):FindFirstChild("Normal")
    elseif workspace:FindFirstChild("Debris"):FindFirstChild("Patient") then
        return workspace:FindFirstChild("Debris"):FindFirstChild("Patient")
    end
end

local currentQuest

_getQUest = true

while _getQUest do task.wait(0.1)
    local currentQuest = findQuest()
end


local function def()
    while _defeat do task.wait(0.1)
        for i, v in ipairs(workspace:FindFirstChild("NPCs"):GetChildren()) do
            if v.Name == "Normal" then
                if v:FindFirstChild("HumanoidRootPart") then
                    hrp.CFrame = v.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
                    task.wait(0.5)
                end
            end
        end
    end
end


local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Flashpoint",
   Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "Flashpoint",
   LoadingSubtitle = "by zph",
   ShowText = "Rayfield", -- for mobile users to unhide rayfield, change if you'd like
   Theme = "Default", -- Check https://docs.sirius.menu/rayfield/configuration/themes

   ToggleUIKeybind = "K", -- The keybind to toggle the UI visibility (string like "K" or Enum.KeyCode)

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface

   ConfigurationSaving = {
      Enabled = false,
      FolderName = nil, -- Create a custom folder for your hub/game
      FileName = "Big Hub"
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

local StatsTab = Window:CreateTab("Stats", "rewind")

local Section = StatsTab:CreateSection("Upgrade")

local Input = StatsTab:CreateInput({
   Name = "Stamina",
   CurrentValue = "",
   PlaceholderText = "Value",
   RemoveTextAfterFocusLost = false,
   Flag = "Input1",
   Callback = function(Text)
        pcall(function()
            NUpg(Text, "Boost Duration")
        end)
   end,
})

local Input = StatsTab:CreateInput({
   Name = "Boost Speed",
   CurrentValue = "",
   PlaceholderText = "Value",
   RemoveTextAfterFocusLost = false,
   Flag = "Input1",
   Callback = function(Text)
        pcall(function()
            NUpg(Text, "Boost Speed")
        end)
   end,
})

local Input = StatsTab:CreateInput({
   Name = "Damage",
   CurrentValue = "",
   PlaceholderText = "Value",
   RemoveTextAfterFocusLost = false,
   Flag = "Input1",
   Callback = function(Text)
        pcall(function()
            NUpg(Text, "Damage")
        end)
   end,
})

local Input = StatsTab:CreateInput({
   Name = "Flashtime Speed",
   CurrentValue = "",
   PlaceholderText = "Value",
   RemoveTextAfterFocusLost = false,
   Flag = "Input1",
   Callback = function(Text)
        pcall(function()
            NUpg(Text, "Flashtime Speed")
        end)
   end,
})

local Input = StatsTab:CreateInput({
   Name = "Health",
   CurrentValue = "",
   PlaceholderText = "Value",
   RemoveTextAfterFocusLost = false,
   Flag = "Input1",
   Callback = function(Text)
        pcall(function()
            NUpg(Text, "Health")
        end)
   end,
})

local Input = StatsTab:CreateInput({
   Name = "Speed",
   CurrentValue = "",
   PlaceholderText = "Value",
   RemoveTextAfterFocusLost = false,
   Flag = "Input1",
   Callback = function(Text)
        pcall(function()
            NUpg(Text, "Speed")
        end)
   end,
})

local Section = StatsTab:CreateSection("Rebirth Upgrade")

local Input = StatsTab:CreateInput({
   Name = "Stamina",
   CurrentValue = "",
   PlaceholderText = "Value",
   RemoveTextAfterFocusLost = false,
   Flag = "Input1", 
   Callback = function(Text)
        pcall(function()
            RUpg(Text, "Boost Duration")
        end)
   end,
})

local Input = StatsTab:CreateInput({
   Name = "Boost Speed",
   CurrentValue = "",
   PlaceholderText = "Value",
   RemoveTextAfterFocusLost = false,
   Flag = "Input1",
   Callback = function(Text)
        pcall(function()
            RUpg(Text, "Boost Speed")
        end)
   end,
})

local Input = StatsTab:CreateInput({
   Name = "Damage",
   CurrentValue = "",
   PlaceholderText = "Value",
   RemoveTextAfterFocusLost = false,
   Flag = "Input1",
   Callback = function(Text)
        pcall(function()
            RUpg(Text, "Damage")
        end)
   end,
})

local Input = StatsTab:CreateInput({
   Name = "Flashtime Speed",
   CurrentValue = "",
   PlaceholderText = "Value",
   RemoveTextAfterFocusLost = false,
   Flag = "Input1",
   Callback = function(Text)
        pcall(function()
            RUpg(Text, "Flashtime Speed")
        end)
   end,
})

local Input = StatsTab:CreateInput({
   Name = "Health",
   CurrentValue = "",
   PlaceholderText = "Value",
   RemoveTextAfterFocusLost = false,
   Flag = "Input1",
   Callback = function(Text)
        pcall(function()
            RUpg(Text, "Health")
        end)
   end,
})

local Input = StatsTab:CreateInput({
   Name = "Speed",
   CurrentValue = "",
   PlaceholderText = "Value",
   RemoveTextAfterFocusLost = false,
   Flag = "Input1",
   Callback = function(Text)
        pcall(function()
            RUpg(Text, "Speed")
        end)
   end,
})
