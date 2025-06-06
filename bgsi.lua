local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "Zepth | BGSI",
    Icon = 0,
    LoadingTitle = "Bubble Gum Simulator Infinite Script",
    LoadingSubtitle = "by Zepth",
    Theme = "Default",
    DisableRayfieldPrompts = false,
    DisableBuildWarnings = false,

    ConfigurationSaving = {
        Enabled = false,
        FolderName = nil,
        FileName = "Big Hub"
    },

    Discord = {
        Enabled = false,
        Invite = "noinvitelink",
        RememberJoins = true
    },

    KeySystem = false,
    KeySettings = {
        Title = "Untitled",
        Subtitle = "Key System",
        Note = "No method of obtaining the key is provided",
        FileName = "Key",
        SaveKey = true,
        GrabKeyFromSite = false,
        Key = {"Hello"}
    }
})

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local rstorage = game:GetService("ReplicatedStorage")
local workspace = game:GetService("Workspace")

local function getHRP()
    local character = player.Character or player.CharacterAdded:Wait()
    return character:WaitForChild("HumanoidRootPart")
end

local MainTab = Window:CreateTab("Main", 4483362458)

local ConfigsSection = MainTab:CreateSection("Configs")

-- Auto Blow
_G.blow = false

MainTab:CreateToggle({
    Name = "Auto Blow Bubble",
    CurrentValue = false,
    Callback = function(Value)
        _G.blow = Value
        task.spawn(function()
            while _G.blow do
                task.wait()
                pcall(function()
                    local framework = rstorage:FindFirstChild("Shared") and rstorage.Shared:FindFirstChild("Framework")
                    if framework then
                        local remote = framework:FindFirstChild("Network") and framework.Network:FindFirstChild("Remote")
                        if remote then
                            if remote:FindFirstChild("Event") then
                                remote.Event:FireServer("BlowBubble")
                            end
                        end
                    end
                end)
            end
        end)
    end,
})

-- Auto Sell
_G.sell = false

MainTab:CreateToggle({
    Name = "Auto Sell",
    CurrentValue = false,
    Callback = function(Value)
        _G.sell = Value
        task.spawn(function()
            while _G.sell do
                task.wait()
                pcall(function()
                    local framework = rstorage:FindFirstChild("Shared") and rstorage.Shared:FindFirstChild("Framework")
                    if framework then
                        local remote = framework:FindFirstChild("Network") and framework.Network:FindFirstChild("Remote")
                        if remote then
                            if remote:FindFirstChild("Event") then
                                remote.Event:FireServer("SellBubble")
                            end
                        end
                    end
                end)
            end
        end)
    end,
})

-- Auto Collect
_G.collect = false

MainTab:CreateToggle({
    Name = "Auto Collect",
    CurrentValue = false,
    Callback = function(Value)
        _G.collect = Value
        task.spawn(function()
            while _G.collect do
                task.wait()
                pcall(function()
                    local render = workspace:FindFirstChild("Rendered")
                    if render then
                        for _, chunker in pairs(render:GetDescendants()) do
                            if chunker.Name == "Chunker" then
                                for _, model in pairs(chunker:GetDescendants()) do
                                    if model:IsA("Model") and model:FindFirstChild("coin") then
                                        local remotes = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes")
                                        if remotes then
                                            local pickupfol = remotes:FindFirstChild("Pickups")
                                            if pickupfol then
                                                local collectR = pickupfol:FindFirstChild("CollectPickup")
                                                if collectR then
                                                collectR:FireServer(model.Name); end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end)
            end
        end)
    end,
})
