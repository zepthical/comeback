local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Arcane Piece",
   Icon = 0,
   LoadingTitle = "Arcane Piece",
   LoadingSubtitle = "by Zepthical",
   Theme = "Default",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil,
      FileName = "AC-Piece"
   },
   Discord = {
      Enabled = false,
      Invite = "noinvitelink",
      RememberJoins = true
   },
   KeySystem = false
})

local MainTab = Window:CreateTab("Main", 4483362458)
local Section = MainTab:CreateSection("Farm")

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")

-- Remote calls
local function skillEquip(v)
    ReplicatedStorage.RemoteEvents.EquipSkillRE:FireServer("Equip", v)
end

local function sz()
    ReplicatedStorage.SungV2.SkillZ.EventZ:FireServer()
end

local function upg(type, amount)
    ReplicatedStorage.StatSystem.Points:FireServer(type, amount)
end

local function getlv()
    local data = player:FindFirstChild("Data")
    if data then
        local lv = data:FindFirstChild("Levels")
        if lv then
            return lv.Value
        end
    end
    return 0
end

local function getpoints()
    local data = player:FindFirstChild("Data")
    if data then
        local p = data:FindFirstChild("Points")
        if p then
            return p.Value
        end
    end
    return 0
end

-- Flags
_G.alv = false
_G.sv2 = true
_G.ug = true

-- TP loop
local teleporting = false

local function looptp(x, y, z)
    teleporting = true
    task.spawn(function()
        while _G.alv and teleporting do
            task.wait()
            hrp.CFrame = CFrame.new(x, y, z)
        end
    end)
end

local function autolv()
    task.spawn(function()
        while _G.alv and task.wait(1) do
            local lv = getlv()
            local points = getpoints()

            if _G.ug and points > 0 then
                upg("Sword", points)
            end

            if _G.sv2 then
                sz()
            end

            if lv <= 100 and not teleporting then
                looptp(-132, 22, 42)
            end
        end
    end)
end

MainTab:CreateToggle({
    Name = "Auto Farm Level",
    CurrentValue = false,
    Flag = "AutoFarmLevel",
    Callback = function(Value)
        _G.alv = Value
        if _G.alv then
            autolv()
        end
    end
})

Rayfield:LoadConfiguration()https://raw.githubusercontent.com/zepthical/comeback/refs/heads/main/ATP.luahttps://raw.githubusercontent.com/zepthical/comeback/refs/heads/main/ATP.lua
