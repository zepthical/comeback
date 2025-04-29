local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Zepth | DTEC",
   Icon = 0, 
   LoadingTitle = "Dig to earth's core",
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
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local MainTab = Window:CreateTab("Main", 4483362458) -- Title, Image

MainTab:CreateSection("OP Features")

MainTab:CreateButton({
   Name = "Infinite Money",
   Callback = function()

        pcall(function()
        if ReplicatedStorage:FindFirstChild("Remotes") then
            local remotes = ReplicatedStorage.Remotes
            if remotes:FindFirstChild("AddRewardEvent") then
                local infevent = remotes.AddRewardEvent
                infevent:FireServer("Money", math.huge)
            end
        end

        end)
   end,
})

MainTab:CreateButton({
   Name = "Infinite Gems",
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
   end,
})

MainTab:CreateInput({
   Name = "Triple Dominus Pet",
   CurrentValue = "0",
   PlaceholderText = "Amount",
   RemoveTextAfterFocusLost = true,
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
   end,
})

MainTab:CreateSection("Farm")

MainTab:CreateToggle({
   Name = "Legit Farm",
   Callback = function(Value)
        pcall(function()
        if Value == true then
            if ReplicatedStorage:FindFirstChild("Remotes") then
                local remotes = ReplicatedStorage.Remotes
                if remotes:FindFirstChild("AutoDigEvent") then
                    local autodigevent = remotes.AutoDigEvent
                    autodigevent:FireServer()
                end
            end
            elseif Value == false then
                if ReplicatedStorage:FindFirstChild("Remotes") then
                local remotes = ReplicatedStorage.Remotes
                if remotes:FindFirstChild("AutoDigEvent") then
                    local autodigevent = remotes.AutoDigEvent
                    autodigevent:FireServer()
                end
            end
        end

        end)
   end,
})

local worlds = {
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

local selectedWorldPosition = worlds["World 1"]

MainTab:CreateDropdown({
    Name = "World Select (Blatant Farm)",
    Options = {"World 1", "World 2", "World 3", "World 4", "World 5", "World 6", "World 7", "World 8", "World 9", "World 10"},
    CurrentOption = {"World 1"},
    Callback = function(option)
        pcall(function()
            -- Ensure option is a string (it should be)
            selectedWorldPosition = worlds[option]
        end)
    end,
})

MainTab:CreateToggle({
    Name = "Blatant Farm",
    Callback = function(enabled)
        pcall(function()
            task.spawn(function()
                while enabled do
                    if selectedWorldPosition then
                        local character = LocalPlayer.Character
                        local hrp = character and character:FindFirstChild("HumanoidRootPart")
                        if hrp then
                            hrp.CFrame = CFrame.new(selectedWorldPosition)
                        end
                    end
                    task.wait()
                end
            end)
        end)
    end,
})

--[[MainTab:CreateDivider()

local function getUniquePetNames()
    local petsFolder = LocalPlayer:FindFirstChild("Pets")
    local uniqueNames = {}
    local nameSet = {}

    if petsFolder then
        for _, pet in ipairs(petsFolder:GetChildren()) do
            if pet:IsA("Instance") and not nameSet[pet.Name] then
                table.insert(uniqueNames, pet.Name)
                nameSet[pet.Name] = true
            end
        end
    end

    return uniqueNames
end

-- Create dropdown
local goldPet = MainTab:CreateDropdown({
    Name = "Make Golden(Only if you have 5 pets of what you want)",
    Options = getUniquePetNames(),
    CurrentOption = {},
    Callback = function(selected)
        pcall(function()
            print(selected.Name)
        end)
    end,
})

MainTab:CreateButton({
   Name = "Golden pet",
   Callback = function()
        pcall(function()
            local petsRemotes = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes")
            if petsRemotes and petsRemotes:FindFirstChild("GoldPetCraftEvent") then
                petsRemotes.GoldPetCraftEvent:FireServer(goldPet.Callback.selected, 100)
            end
        end)
   end,
})

local diamondPet = MainTab:CreateDropdown({
    Name = "Make Diamond(Only if you have 5 pets of what you want)",
    Options = getUniquePetNames(),
    CurrentOption = {},
    Callback = function(selected)
        pcall(function()
            local petsRemotes = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes")
            if petsRemotes and petsRemotes:FindFirstChild("DiamondPetCraftEvent") then
                petsRemotes.GoldPetCraftEvent:FireServer(selected.Name, 100)
            end
        end)
    end,
})

MainTab:CreateButton({
   Name = "Refesh Pets",
   Callback = function()
        goldPet:Refresh(getUniquePetNames())
        diamondPet:Refresh(getUniquePetNames())
   end,
}) ]]

local TeleportTab = Window:CreateTab("Teleport", 4483362458)

TeleportTab:CreateSection("Worlds")


TeleportTab:CreateButton({
    Name = "World 1",
    Callback = function()
        pcall(function()
            local remotes = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes")
            if remotes and remotes:FindFirstChild("WorldTeleportEvent") then
                remotes.WorldTeleportEvent:FireServer(1)
                local character = LocalPlayer.Character
                local hrp = character and character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    hrp.CFrame = CFrame.new(100, 1000, 0)
                end
            end
        end)
    end,
})

TeleportTab:CreateButton({
    Name = "World 2",
    Callback = function()
        pcall(function()
            local remotes = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes")
            if remotes and remotes:FindFirstChild("WorldTeleportEvent") then
                remotes.WorldTeleportEvent:FireServer(2)
                local character = LocalPlayer.Character
                local hrp = character and character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    hrp.CFrame = CFrame.new(100, 1000, -1000)
                end
            end
        end)
    end,
})

TeleportTab:CreateButton({
    Name = "World 3",
    Callback = function()
        pcall(function()
            local remotes = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes")
            if remotes and remotes:FindFirstChild("WorldTeleportEvent") then
                remotes.WorldTeleportEvent:FireServer(3)
                local character = LocalPlayer.Character
                local hrp = character and character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    hrp.CFrame = CFrame.new(100, 1000, -2000)
                end
            end
        end)
    end,
})

TeleportTab:CreateButton({
    Name = "World 4",
    Callback = function()
        pcall(function()
            local remotes = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes")
            if remotes and remotes:FindFirstChild("WorldTeleportEvent") then
                remotes.WorldTeleportEvent:FireServer(4)
                local character = LocalPlayer.Character
                local hrp = character and character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    hrp.CFrame = CFrame.new(100, 1000, -3000)
                end
            end
        end)
    end,
})

TeleportTab:CreateButton({
    Name = "World 5",
    Callback = function()
        pcall(function()
            local remotes = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes")
            if remotes and remotes:FindFirstChild("WorldTeleportEvent") then
                remotes.WorldTeleportEvent:FireServer(5)
                local character = LocalPlayer.Character
                local hrp = character and character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    hrp.CFrame = CFrame.new(100, 1000, -4000)
                end
            end
        end)
    end,
})

TeleportTab:CreateButton({
    Name = "World 6",
    Callback = function()
        pcall(function()
            local remotes = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes")
            if remotes and remotes:FindFirstChild("WorldTeleportEvent") then
                remotes.WorldTeleportEvent:FireServer(6)
                local character = LocalPlayer.Character
                local hrp = character and character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    hrp.CFrame = CFrame.new(100, 1000, -5000)
                end
            end
        end)
    end,
})

TeleportTab:CreateButton({
    Name = "World 7",
    Callback = function()
        pcall(function()
            local remotes = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes")
            if remotes and remotes:FindFirstChild("WorldTeleportEvent") then
                remotes.WorldTeleportEvent:FireServer(7)
                local character = LocalPlayer.Character
                local hrp = character and character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    hrp.CFrame = CFrame.new(100, 1000, -6000)
                end
            end
        end)
    end,
})

TeleportTab:CreateButton({
    Name = "World 8",
    Callback = function()
        pcall(function()
            local remotes = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes")
            if remotes and remotes:FindFirstChild("WorldTeleportEvent") then
                remotes.WorldTeleportEvent:FireServer(8)
                local character = LocalPlayer.Character
                local hrp = character and character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    hrp.CFrame = CFrame.new(100, 1000, -7000)
                end
            end
        end)
    end,
})

TeleportTab:CreateButton({
    Name = "World 9",
    Callback = function()
        pcall(function()
            local remotes = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes")
            if remotes and remotes:FindFirstChild("WorldTeleportEvent") then
                remotes.WorldTeleportEvent:FireServer(9)
                local character = LocalPlayer.Character
                local hrp = character and character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    hrp.CFrame = CFrame.new(100, 1000, -8000)
                end
            end
        end)
    end,
})

TeleportTab:CreateButton({
    Name = "World 10",
    Callback = function()
        pcall(function()
            local remotes = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes")
            if remotes and remotes:FindFirstChild("WorldTeleportEvent") then
                remotes.WorldTeleportEvent:FireServer(10)
                local character = LocalPlayer.Character
                local hrp = character and character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    hrp.CFrame = CFrame.new(100, 1000, -9000)
                end
            end
        end)
    end,
})
