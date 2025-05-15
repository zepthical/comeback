local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Anime Power Simulator 0.5",
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

attack = function()
    RemoteEvent:FireServer("attack")
end

spinchamp = function(amount, world)
    RemoteEvent:FireServer("rollChampion", amount, world)
end

getquest = function(world)
    RemoteEvent:FireServer("setQuest", world)
end

_G.at = false

local Toggle1 = Main:CreateToggle({
   Name = "Auto Attack",
   CurrentValue = false,
   Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
        _G.at = Value
        
        pcall(function()
        while _G.at do task.wait(0.2)
            attack()
        end end)
   end,
})

local mob = nil

MobDropdown = Main:CreateDropdown({
    Name = "Select Mob",
    Options = {}, -- Will be updated dynamically
    CurrentOption = "",
    MultipleOptions = false,
    Flag = "MobDropdown",
    Callback = function(selectedMob)
        mob = selectedMob
        print("Selected mob:", mob)
    end,
})

local spawners = workspace:FindFirstChild("spawners")
if not spawners then
    warn("No 'spawners' folder found in Workspace.")
    return
end

-- Utility function to get spawner (world) names
local function getSpawnerNames()
    local names = {}
    for _, child in ipairs(spawners:GetChildren()) do
        table.insert(names, child.Name)
    end
    return names
end

-- Forward declare the MobDropdown so we can access it later
local MobDropdown

local WorldDropdown = Main:CreateDropdown({
    Name = "Select World",
    Options = getSpawnerNames(),
    CurrentOption = "shinobi world",
    MultipleOptions = false,
    Flag = "WorldDropdown",
    Callback = function(selectedWorld)
        local selectedFolder = spawners:FindFirstChild(selectedWorld)
        if not selectedFolder then
            warn("World folder not found:", selectedWorld)
            return
        end

        -- Get visible mobs
        local mobNames = {}
        for _, mob in ipairs(selectedFolder:GetChildren()) do
            if mob:IsA("BasePart") and mob.Transparency == 0 then
                table.insert(mobNames, mob.Name)
            end
        end

        -- Update the MobDropdown
        if MobDropdown then
            MobDropdown:Refresh(mobNames)
            MobDropdown:Set(mobNames[1] or "")
        end
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
            local trash = nil
        else
            Rayfield:Notify({
                Title = "Auto Kill Mob",
                Content = "You have to enable Auto attack first!",
                Duration = 1,
                Image = 4483362458,
            })
        end
        
        end)
   end,
})

Rayfield:LoadConfiguration()
