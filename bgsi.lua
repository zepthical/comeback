local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Zepth | BGSI",
   Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "Bubble Gum Simulator Infinite Script",
   LoadingSubtitle = "by Zepth",
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

local Players = game.Players
local player = Players.LocalPlayer
local char = player.Character
local rstorage = game.GetService("ReplicatedStorage")
local hrp = char:FindFirstChild("HumanoidRootPart") or char:WaitForChild("HumanoidRootPart")

local MainTab = Window:CreateTab("Main", 4483362458) -- Title, Image

local ConfigsSection = MainTab:CreateSection("Configs")

_G.blow = false

local autoblow = MainTab:CreateToggle({
   Name = "Auto Blow Bubble",
   Callback = function(Value)
        _G.blow = Value

        if _G.blow == true then wait(1) end
        spawn(function()
        while _G.blow do task.wait()
            pcall(function()
            if rstorage:FindFirstChild("Shared") and rstorage.Shared:FindFirstChild("Framework") then
                local framework = rstorage.Shared.Framework
                if framework:FindFirstChild("Network") then
                    local network = framework.Network
                    if network:FindFirstChild("Remote") then
                        local blowR = network.Remote
                        if _G.blow == true then
                            blowR:FireServer("BlowBubble")
                        end
                    end
                end
            end

            end)
        end
        task.wait()
        end)
   end,
})

_G.sell = false

local AutoSell = MainTab:CreateToggle({
   Name = "Auto Sell",
   Callback = function(Value)
        _G.sell = Value

        if _G.sell == true then wait(1) end
        spawn(function()
        while _G.sell do task.wait()
            pcall(function()
            if rstorage:FindFirstChild("Shared") and rstorage.Shared:FindFirstChild("Framework") then
                local framework = rstorage.Shared.Framework
                if framework:FindFirstChild("Network") then
                    local network = framework.Network
                    if network:FindFirstChild("Remote") then
                        local sellR = network.Remote
                        if _G.sell == true then
                            sellR:FireServer("SellBubble")
                        end
                    end
                end
            end
            
            end)
        end
        task.wait()
        end)
   end,
})

_G.collect = false

local AUtoCollect = MainTab:CreateToggle({
   Name = "Auto Collect",
   Callback = function(Value)
        _G.collect = Value

        if _G.collect == true then wait(1) end
        spawn(function()
        while _G.collect do task.wait()
            pcall(function()
            local render = game.Workspace:FindFirstChild("Rendered")
            if render then
                for i, v in pairs(render:GetChildren()) do
                    if v.Name == "Chunker" then
                        for model, coin in pairs(v:GetChildren()) do
                            if coin:IsA("Model") and coin:FindFirstChild("coin") then
                                for _, portable in ipairs(coin:GetChildren()) do
                                    if portable:IsA("Model") and portable:FindFirstChild("coin") then
                                        local tp = portable.coin
                                        hrp.CFrame = tp.CFrame * CFrame.new(0, 1, 0)
                                        
                                    end
                                end
                            end
                        end
                    end
                end
            end
            end)
        end
        task.wait()
        end)
   end,
})

