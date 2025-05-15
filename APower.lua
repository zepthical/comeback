local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Anime Power Simulator",
   Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "Anime Power Simulator",
   LoadingSubtitle = "by Zepthical",
   Theme = "Default", -- Check https://docs.sirius.menu/rayfield/configuration/themes

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface

   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil, -- Create a custom folder for your hub/game
      FileName = "Anime-Power"
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

local Main = Window:CreateTab("Main", 4483362458) -- Title, Image

local Section = Main:CreateSection("Farm")

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local shared = ReplicatedStorage:FindFirstChild("Shared")

local events = shared:FindFirstChild("events")

local RemoteEvent = events:FindFirstChild("RemoteEvent")

_G.at = false

local Toggle1 = Main:CreateToggle({
   Name = "Auto Attack",
   CurrentValue = false,
   Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
        _G.at = Value
        
        pcall(function()
        while _G.at do task.wait(0.2)
            RemoteEvent:FireServer("attack")
        end end)
   end,
})

local spawners = workspace:FindFirstChild("spawners")
if not spawners then
    warn("Spawners folder not found in Workspace")
    return
end

-- Collect names of all the spawner folders/objects
local function getSpawnerNames()
    local names = {}
    for _, spawner in pairs(spawners:GetChildren()) do
        table.insert(names, spawner.Name)
    end
    return names
end

-- Create dropdown with spawner names
local Dropdown = Main:CreateDropdown({
    Name = "Select World",
    Options = getSpawnerNames(),
    CurrentOption = "shinobi world",
    MultipleOptions = false,
    Flag = "Dropdown1",
    Callback = function(selected)
        print("Selected world:", selected)
    end,
})


-- Assuming 'worlds' is a folder or model containing mobs
local function getVisibleMobs(world)
    local mobNames = {}
    for _, mob in pairs(world:GetChildren()) do
        if mob:IsA("BasePart") and mob.Transparency == 0 then
            table.insert(mobNames, mob.Name)
        end
    end
    return mobNames
end

-- Example: select a specific world folder from spawners
local selectedWorld = workspace.spawners:FindFirstChild("shinobi world") -- Or use the one selected from the world dropdown

if not selectedWorld then
    warn("Selected world not found")
    return
end

-- Get mob names
local mobNames = getVisibleMobs(selectedWorld)

-- Setup dropdown for mobs
local mob
local Dropdown = Main:CreateDropdown({
    Name = "Select Mob",
    Options = mobNames,
    CurrentOption = mobNames[1] or "",
    MultipleOptions = false,
    Flag = "Dropdown2", -- Unique flag
    Callback = function(selected)
        mob = selected
        print("Selected mob:", mob)
    end,
})


looptp = function(x, y, z)
    local character = game.Players.LocalPlayer.Character
    local hrp = character:FindFirstChild("HumanoidRootPart") or character:WaitForChild("HumanoidRootPart")

    while _G.tp do task.wait()
        hrp.CFrame = CFrame.new(x, y, z)
    end
end

looptpMob = function()
    local character = game.Players.LocalPlayer.Character
    local hrp = character:FindFirstChild("HumanoidRootPart") or character:WaitForChild("HumanoidRootPart")

    while _G.tp do task.wait()
        hrp.CFrame = CFrame.new(mob.CFrame)
    end
end

local Toggle2 = Main:CreateToggle({
   Name = "Auto Kill Mob",
   CurrentValue = false,
   Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)

        pcall(function()
        looptpMob()

        if _G.at == true then
            while _G.at do task.wait()
                RemoteEvent:FireServer("attack")
            end
        else
            Rayfield:Notify({
                Title = "Auto Kill Mob",
                Content = "You have to enable Auto attack first!",
                Duration = 0.5,
                Image = 4483362458,
            })
        end
        
        end)
   end,
})

Rayfield:LoadConfiguration()
