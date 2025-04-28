local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Zepth | Fisch",
   Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "Hate is making me",
   LoadingSubtitle = "insane",
   Theme = "Default", -- Check https://docs.sirius.menu/rayfield/configuration/themes

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
      RememberJoins = true -- Set this to false to make them join the discord every time they load it up
   },

   KeySystem = false,
   KeySettings = {
      Title = "Untitled",
      Subtitle = "Key System",
      Note = "No method of obtaining the key is provided", -- Use this to tell the user how to get a key
      FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
      SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"nil"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
   }
})

-- _G --

_G.AutoEquipRod = false
_G.AutoCast = false
_G.AutoShake = false
_G.AutoReel = false

--------

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Char = LocalPlayer.Character
local Humanoid = Char.Humanoid
local VirtualInputManager = game:GetService("VirtualInputManager")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GuiService = game:GetService("GuiService")
local Backpack = LocalPlayer:FindFirstChild("Backpack")

local MainTab = Window:CreateTab("Main", 4483362458)

local ConfigsSection = MainTab:CreateSection("Configs")

equipitem = function(v)
if LocalPlayer.Backpack:FindFirstChild(v) then
    local a = LocalPlayer.Backpack:FindFirstChild(v)
        Humanoid:EquipTool(a)
    end
end

local function findRod()
    for _, v in pairs(LocalPlayer.Backpack:GetChildren()) do
        if v:IsA("Tool") and v.Name:lower():find("rod") then
            return v
        end
    end
    return nil
end

local AutoEquip = MainTab:CreateToggle({
   Name = "Auto Equip Rod",
   Flags = "Hate",
   Callback = function(v)
       _G.AutoEquipRod = v

        spawn(function()
            while _G.AutoEquipRod do
                if _G.AutoEquipRod then
                    pcall(function()
                        for i,v in pairs(LocalPlayer.Backpack:GetChildren()) do
                           if v:IsA ("Tool") and v.Name:lower():find("rod") then
                              equipitem(v.Name)
                        end
                     end
                  end)
               end
               task.wait()
            end
        end)
   end,
})

local Divider1 = MainTab:CreateDivider()

MainTab:CreateToggle({
   Name = "Auto Cast",
   Callback = function(v)
      _G.AutoCast = v
      spawn(function()
         while _G.AutoCast do
            task.wait(0.1)
            local Rod = Char:FindFirstChildOfClass("Tool")
            if Rod and Rod:FindFirstChild("events") then
               local castEvent = Rod.events:FindFirstChild("cast")
               if castEvent then
                  castEvent:FireServer(100, 1)
               end
            end
         end
      end)
   end
})

local function shake ()
      local PlayerGUI = LocalPlayer:FindFirstChild("PlayerGui")
      if PlayerGUI then
      local shakeUI = PlayerGUI:FindFirstChild("shakeui")
      if shakeUI and shakeUI.Enabled then
         local safezone = shakeUI:FindFirstChild("safezone")
         if safezone then
            local button = safezone:FindFirstChild("button")
            if button and button:IsA("ImageButton") and button.Visible then
               GuiService.SelectedObject = button
               VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
               VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Return, false, game)
            end
         end
      end
   end
end

local function findRod()
    for _, v in ipairs(LocalPlayer.Backpack:GetChildren()) do
        if v:IsA("Tool") and v:FindFirstChild("events") then
            return v
        end
    end
end

-- Helper: Reset
local function Reset()
    local Rod = findRod()
    if Rod and Rod:FindFirstChild("events") and Rod.events:FindFirstChild("reset") then
        task.wait(0.1)
        Rod.events.reset:FireServer()
        task.wait(0.1)
        local Equip = ReplicatedStorage.packages.Net:FindFirstChild("RE/Backpack/Equip")
        if Equip then
            Equip:FireServer(Rod)
            task.wait(0.1)
            Equip:FireServer(Rod)
        end
    else
        warn("Rod or reset event not found!")
    end
end

-- Auto Shake
local AutoShakeToggle = MainTab:CreateToggle({
    Name = "Auto Shake",
    CurrentValue = false,
    Callback = function(Value)
        _G.AutoShake = Value
        task.spawn(function()
            while _G.AutoShake do
                task.wait()
                shake()
                shake()
                shake()
                shake()
            end
        end)
    end,
})

-- Auto Reel
local AutoReelToggle = MainTab:CreateToggle({
    Name = "Auto Reel",
    CurrentValue = false,
    Callback = function(Value)
        _G.AutoReel = Value
        task.spawn(function()
            while _G.AutoReel do
                task.wait(0.1)
                local Rod = findRod()
                if Rod and Rod:FindFirstChild("values") and Rod.values:FindFirstChild("bite") and Rod.values.bite.Value then
                    local reelGui = LocalPlayer.PlayerGui:FindFirstChild("reel")
                    local reelfinishedEvent = ReplicatedStorage:FindFirstChild("events") and ReplicatedStorage.events:FindFirstChild("reelfinished")

                    if reelGui and reelGui:FindFirstChild("bar") and reelGui.bar:FindFirstChild("playerbar") and reelfinishedEvent then
                        local playerbar = reelGui.bar.playerbar

                        -- Start reeling while the fish is still biting
                        while _G.AutoReel and Rod.values.bite.Value do
                            playerbar.Size = UDim2.new(1, 0, 1, 0)
                            task.wait(0.5)
                            reelfinishedEvent:FireServer(100, true)
                            task.wait(0.5)
                        end

                        -- After bite ends
                        task.wait(0.5)
                        Reset()
                    end
                end
            end
        end)
    end,
})


-- Optionally: Turn ON by default
task.spawn(function()
    task.wait(0.5) -- Wait Rayfield to fully load
    AutoShakeToggle:Set(true)
    AutoReelToggle:Set(true)
end)
