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
local Workspace = game:GetService("Workspace")

local MainTab = Window:CreateTab("Main", 4483362458) -- Title, Image

MainTab:CreateSection("OP Features")

MainTab:CreateButton({
   Name = "Infinite Cash",
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

MainTab:CreateSection("Farm")

MainTab:CreateToggle({
   Name = "Legit Farm",
   Callback = function(Value)
        pcall(function()
        if LocalPlayer:FindFirstChild("AutoDig") and LocalPlayer.AutoDig.Value == false then
            local AutoDig = LocalPlayer.AutoDig

        if AutoDig.Value == true then
            AutoDig.Value = false

        elseif AutoDig.Value == false then
            AutoDig.Value = true
        end

        end

        end)
   end,
})

--[[local function GetCurrentWorldValue()
    local currentWorld = LocalPlayer:FindFirstChild("CurrentWorld")
    return currentWorld and currentWorld.Value or nil
end]]

local selectedWorldName = "World1"
local isFarming = false -- track toggle state

MainTab:CreateDropdown({
    Name = "World Select (Blatant Farm)",
    Options = {"World1", "World2", "World3", "World4", "World5", "World6", "World7", "World8", "World9", "World10"},
    CurrentOption = {"World1"},
    Callback = function(option)
        if typeof(option) == "table" then
            selectedWorldName = option[1]
        else
            selectedWorldName = option
        end
    end,
})

MainTab:CreateToggle({
    Name = "Blatant Farm",
    Callback = function(enabled)
        isFarming = enabled -- update toggle state
        if enabled then
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
                    task.wait(0.1)
                end
            end)
        end
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

    TeleportTab:CreateButton({
        Name = worldName,
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
        end,
    })
end

local PetsTab = Window:CreateTab("Pets", 4483362458)

PetsTab:CreateSection("OP Pets")

PetsTab:CreateInput({
   Name = "Triple Dominus ( 50X )",
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

PetsTab:CreateInput({
   Name = "Diamond Cosmic Alien[Best] ( 180X )",
   CurrentValue = "0",
   PlaceholderText = "Amount",
   RemoveTextAfterFocusLost = true,
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
   end,
})

PetsTab:CreateInput({
   Name = "Void Angel ( 100X )",
   CurrentValue = "0",
   PlaceholderText = "Amount",
   RemoveTextAfterFocusLost = true,
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
   end,
})




local SettingsTab = Window:CreateTab("Settings", 4483362458)

SettingsTab:CreateSection("FPS")

SettingsTab:CreateToggle({
   Name = "FPS Boost(Irreversible) -- not mine",
   Callback = function(Value)
        pcall(function()
            _G.Ignore = {}
            _G.Settings = {
                Players = {
                    ["Ignore Me"] = true,
                    ["Ignore Others"] = true,
                    ["Ignore Tools"] = true
                },
                Meshes = {
                    NoMesh = false,
                    NoTexture = false,
                    Destroy = false
                },
                Images = {
                    Invisible = true,
                    Destroy = false
                },
                Explosions = {
                    Smaller = true,
                    Invisible = false, -- Not for PVP games
                    Destroy = false -- Not for PVP games
                },
                Particles = {
                    Invisible = true,
                    Destroy = false
                },
                TextLabels = {
                    LowerQuality = true,
                    Invisible = false,
                    Destroy = false
                },
                MeshParts = {
                    LowerQuality = true,
                    Invisible = false,
                    NoTexture = false,
                    NoMesh = false,
                    Destroy = false
                },
                Other = {
                    ["FPS Cap"] = 23239, -- true to uncap
                    ["No Camera Effects"] = true,
                    ["No Clothes"] = true,
                    ["Low Water Graphics"] = true,
                    ["No Shadows"] = true,
                    ["Low Rendering"] = true,
                    ["Low Quality Parts"] = true,
                    ["Low Quality Models"] = true,
                    ["Reset Materials"] = true,
                }
            }
            loadstring(game:HttpGet("https://raw.githubusercontent.com/CasperFlyModz/discord.gg-rips/main/FPSBooster.lua"))()

        end)
   end,
})
SettingsTab:CreateButton({
   Name = "Destroy UI",
   Callback = function()
        pcall(function()
            Rayfield:Destroy()
        end)
   end,
})
