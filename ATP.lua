local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "AT Piece",
   Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "AT Piece",
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

local MainTab = Window:CreateTab("Main", 4483362458) -- Title, Image

local Section = MainTab:CreateSection("Farm")

local ReplicatedStorage = game:GetService("ReplicatedStorage")

skillEquip = function(v)
    ReplicatedStorage.RemoteEvents.EquipSkillRE:FireServer("Equip", v)
end

local player = game.Players.LocalPlayer
local character = player.Character or player:WaitForChild("Character")
local hrp = character:FindFirstChild("HumanoidRootPart") or character:WaitForChild("HumanoidRootPart")

_G.ltp = false

local function looptp(x, y, z)
    while _G.ltp == true do task.wait()
        hrp.CFrame = CFrame.new(x,y,z)
    end
end

sz = function()
    ReplicatedStorage.SungV2.SkillZ.EventZ:FireServer()
end

local function getlv(level)
    local data = player:FindFirstChild("Data")
    if data then
        local lv = data:FindFirstChild("Levels")
        if lv then
            return level.Value
        end
    end
    return nil
end

upg = function(type, amount)
    ReplicatedStorage.StatSystem.Points:FireServer(type, amount)
end

local function getpoints(points)
    local data = player:FindFirstChild("Data")
    if data then
        local p = data:FindFirstChild("Points")
        if points then
            return points.Value
        end
    end
    return nil
end

local n = nil

([[autolevel]]):gsub(n, function(v) end)


local function autolv()
    pcall(function()
    local lv = getlv()
    local points = getpoints()

    -- upgrade

    while _G.ug do task.wait(1)
        upg("Sword", points)
    end

    -- upgrade
    -- sv2 z
    while _G.sv2 == true do task.wait(.4)
        sz()
    end

    -- sv2 z
    -- looptp
    if lv <= 100 then
        looptp(-132, 22, 42)
    end end)
end


([[autolevel]]):gsub(n, function(v) end)

_G.alv = false

local Toggle = MainTab:CreateToggle({
   Name = "Auto Farm Level",
   CurrentValue = false,
   Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
        _G.alv = Value

        autolv()
   end, 
})

Rayfield:LoadConfiguration()
