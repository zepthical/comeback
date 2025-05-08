
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Create the Main Window for PolleserHub
local Window = Rayfield:CreateWindow({
   Name = "BABFT  | PolleserHub",
   Icon = 0,
   LoadingTitle = "BABFT | PolleserHub",
   LoadingSubtitle = "by Polleser",
   Theme = "Ocean",

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false,

   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil,
      FileName = "Polleser Hub"
   },

   Discord = {
      Enabled = true,
      Invite = "dmBzVaRrD3",
      RememberJoins = true
   },

   KeySystem = true,
   KeySettings = {
   Title = "Polleser Hub Key System",
   Subtitle = "Hello.",
   Note = "To get the Script's Key you need to join our Discord server the link is already copied.",
   FileName = "PolleserHub Key",
   SaveKey = true,
   GrabKeyFromSite = false,
   Key = {
      "BABFTKeyNdjdhanfiirhwjj",
      "TesterKey143",
      "YetAnotherKey67890",
      "MoreKeyLOL123"
   }
}
})

-- Create Tabs (equivalent to Pages in BooHub)
local TogglesTab = Window:CreateTab("Toggles", 4483362458) -- Using a default Roblox image ID
local ExtrasTab = Window:CreateTab("Extras", 4483362458)
local TeleportsTab = Window:CreateTab("Teleports", 4483362458)

-- Add Label to Toggles Tab
TogglesTab:CreateLabel("Made by Polleser", "rewind")

-- Toggles Tab: Infinite Jump
TogglesTab:CreateToggle({
    Name = "Infinite Jump",
    CurrentValue = false,
    Flag = "InfiniteJump",
    Callback = function(value)
        getgenv().inf = value
        pcall(function()
        spawn(function()
            while getgenv().inf do
                if not getgenv().inf then break end
                game:GetService("UserInputService").JumpRequest:Connect(function()
                    if getgenv().inf then
                        game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass('Humanoid'):ChangeState("Jumping")
                    end
                end)
                wait()
            end
        end) end)
    end
})

-- Toggles Tab: Auto Farm
TogglesTab:CreateToggle({
    Name = "Auto Farm",
    CurrentValue = false,
    Flag = "AutoFarm",
    Callback = function(value)
        local players = game:GetService("Players")
        local stages = workspace:WaitForChild("BoatStages"):WaitForChild("NormalStages")
        local penguin, gold = workspace:WaitForChild("ChangeCharacter"), workspace:WaitForChild("ClaimRiverResultsGold")
        local client = game.Players.LocalPlayer

        pcall(function()
        _G.Busy = value
        while _G.Busy do
            local bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.Velocity = Vector3.new(0, 0, 0)
            bodyVelocity.Parent = client.Character.HumanoidRootPart

            for i = 1, 9 do
                if not client.Character or not client.Character:FindFirstChild("Humanoid") then
                    repeat wait() until client.Character and client.Character:FindFirstChild("Humanoid")
                end

                client.Character.HumanoidRootPart.CFrame = stages["CaveStage"..i].DarknessPart.CFrame
                wait(0.1)

                if not _G.Busy then
                    client.Character.Humanoid.Health = 0
                    break
                end

                if i == 1 then
                    wait(6)
                else
                    wait(3)
                end

                gold:FireServer()
            end

            client.Character:Remove()
            repeat wait() until client.Character and client.Character:FindFirstChild("HumanoidRootPart")
        end end)
    end
})

-- Toggles Tab: Water GodMode
TogglesTab:CreateToggle({
    Name = "Water GodMode",
    CurrentValue = false,
    Flag = "WaterGodMode",
    Callback = function(value)
        getgenv().Water = value

        pcall(function()
        game:GetService('RunService').Stepped:Connect(function()
            pcall(function()
                if getgenv().Water and game.Players.LocalPlayer.Character:FindFirstChild("WaterDetector") then
                    game.Players.LocalPlayer.Character.WaterDetector:Destroy()
                end
            end)
        end) end)
    end
})

-- Toggles Tab: Auto Common Chest
TogglesTab:CreateToggle({
    Name = "Auto Common Chest",
    CurrentValue = false,
    Flag = "AutoCommonChest",
    Callback = function(value)
        getgenv().Number = 1
        getgenv().Common = value

        pcall(function()
        game:GetService('RunService').Stepped:Connect(function()
            if getgenv().Common then
                workspace.ItemBoughtFromShop:InvokeServer("Common Chest", getgenv().Number)
            end
        end) end)
    end
})

-- Toggles Tab: Auto Uncommon Chest
TogglesTab:CreateToggle({
    Name = "Auto Uncommon Chest",
    CurrentValue = false,
    Flag = "AutoUncommonChest",
    Callback = function(value)
        getgenv().UnCommon = value
        getgenv().Number = 1

        pcall(function()
        game:GetService('RunService').Stepped:Connect(function()
            if getgenv().UnCommon then
                workspace.ItemBoughtFromShop:InvokeServer("Uncommon Chest", getgenv().Number)
            end
        end) end)
    end
})

-- Toggles Tab: Auto Rare Chest
TogglesTab:CreateToggle({
    Name = "Auto Rare Chest",
    CurrentValue = false,
    Flag = "AutoRareChest",
    Callback = function(value)
        getgenv().Rare = value
        getgenv().Number = 1
        
        pcall(function()
        game:GetService('RunService').Stepped:Connect(function()
            if getgenv().Rare then
                workspace.ItemBoughtFromShop:InvokeServer("Rare Chest", getgenv().Number)
            end
        end) end)
    end
})

-- Toggles Tab: Auto Epic Chest
TogglesTab:CreateToggle({
    Name = "Auto Epic Chest",
    CurrentValue = false,
    Flag = "AutoEpicChest",
    Callback = function(value)
        getgenv().Epic = value
        getgenv().Number = 1

        pcall(function()
        game:GetService('RunService').Stepped:Connect(function()
            if getgenv().Epic then
                workspace.ItemBoughtFromShop:InvokeServer("Epic Chest", getgenv().Number)
            end
        end) end)
    end
})

-- Toggles Tab: Auto Legendary Chest
TogglesTab:CreateToggle({
    Name = "Auto Legendary Chest",
    CurrentValue = false,
    Flag = "AutoLegendaryChest",
    Callback = function(value)
        getgenv().Legendary = value
        getgenv().Number = 1

        pcall(function()
        game:GetService('RunService').Stepped:Connect(function()
            if getgenv().Legendary then
                workspace.ItemBoughtFromShop:InvokeServer("Legendary Chest", getgenv().Number)
            end
        end) end)
    end
})

-- Toggles Tab: Get a ton of some Blocks (patched)
TogglesTab:CreateToggle({
    Name = "Get a ton of some Blocks (patched)",
    CurrentValue = false,
    Flag = "GetBlocks",
    Callback = function(value)
        _G.RUN = value

        pcall(function()
        spawn(function()
            coroutine.wrap(function()
                while _G.RUN do
                    wait()
                    coroutine.wrap(function()
                        while _G.RUN do
                            wait()
                            workspace.ItemBoughtFromShop:InvokeServer("Winter Chest", math.floor(game:GetService("Players").LocalPlayer.Data.Gold.Value / 100))
                        end
                    end)()
                end
            end)()
        end) end)
    end
})

-- Extras Tab: Fly Button
ExtrasTab:CreateButton({
    Name = "Fly",
    Callback = function()
        local FlyingKey = Enum.KeyCode.B
        loadstring(game:HttpGet('https://raw.githubusercontent.com/zachisfunny/Fly-Script/main/Script'))()
    end
})

-- Extras Tab: Vehicle Fly Button
ExtrasTab:CreateButton({
    Name = "Vehicle Fly",
    Callback = function()
        local FlyKey = Enum.KeyCode.V
        local SpeedKey = Enum.KeyCode.LeftControl
        local SpeedKeyMultiplier = 3
        local FlightSpeed = 256
        local FlightAcceleration = 4
        local TurnSpeed = 16

        local UserInputService = game:GetService("UserInputService")
        local StarterGui = game:GetService("StarterGui")
        local RunService = game:GetService("RunService")
        local Players = game:GetService("Players")
        local User = Players.LocalPlayer
        local Camera = workspace.CurrentCamera
        local UserCharacter = nil
        local UserRootPart = nil
        local Connection = nil

        
        pcall(function()
        workspace.Changed:Connect(function()
            Camera = workspace.CurrentCamera
        end)

        local setCharacter = function(c)
            UserCharacter = c
            UserRootPart = c:WaitForChild("HumanoidRootPart")
        end

        User.CharacterAdded:Connect(setCharacter)
        if User.Character then
            setCharacter(User.Character)
        end

        local CurrentVelocity = Vector3.new(0, 0, 0)
        local Flight = function(delta)
            local BaseVelocity = Vector3.new(0, 0, 0)
            if not UserInputService:GetFocusedTextBox() then
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                    BaseVelocity = BaseVelocity + (Camera.CFrame.LookVector * FlightSpeed)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                    BaseVelocity = BaseVelocity - (Camera.CFrame.RightVector * FlightSpeed)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                    BaseVelocity = BaseVelocity - (Camera.CFrame.LookVector * FlightSpeed)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                    BaseVelocity = BaseVelocity + (Camera.CFrame.RightVector * FlightSpeed)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                    BaseVelocity = BaseVelocity + (Camera.CFrame.UpVector * FlightSpeed)
                end
                if UserInputService:IsKeyDown(SpeedKey) then
                    BaseVelocity = BaseVelocity * SpeedKeyMultiplier
                end
            end
            if UserRootPart then
                local car = UserRootPart:GetRootPart()
                if car.Anchored then return end
                if not isnetworkowner(car) then return end
                CurrentVelocity = CurrentVelocity:Lerp(
                    BaseVelocity,
                    math.clamp(delta * FlightAcceleration, 0, 1)
                )
                car.Velocity = CurrentVelocity + Vector3.new(0, 2, 0)
                if car ~= UserRootPart then
                    car.RotVelocity = Vector3.new(0, 0, 0)
                    car.CFrame = car.CFrame:Lerp(CFrame.lookAt(
                        car.Position,
                        car.Position + CurrentVelocity + Camera.CFrame.LookVector
                    ), math.clamp(delta * TurnSpeed, 0, 1))
                end
            end
        end

        UserInputService.InputBegan:Connect(function(userInput, gameProcessed)
            if gameProcessed then return end
            if userInput.KeyCode == FlyKey then
                if Connection then
                    StarterGui:SetCore("SendNotification", {
                        Title = "Polleser's Car Fly",
                        Text = "Flight disabled"
                    })
                    Connection:Disconnect()
                    Connection = nil
                else
                    StarterGui:SetCore("SendNotification", {
                        Title = "Polleser's Car Fly",
                        Text = "Flight enabled"
                    })
                    CurrentVelocity = UserRootPart.Velocity
                    Connection = RunService.Heartbeat:Connect(Flight)
                end
            end
        end) end)

        StarterGui:SetCore("SendNotification", {
            Title = "Polleser's Car Fly",
            Text = "Loaded successfully, Press V to toggle"
        })
    end
})

-- Extras Tab: HipHeight Input
ExtrasTab:CreateInput({
    Name = "HipHeight, Numbers Only",
    PlaceholderText = "Enter number",
    NumbersOnly = true,
    Flag = "HipHeight",
    Callback = function(value)
        pcall(function()
        game.Players.LocalPlayer.Character.Humanoid.HipHeight = tonumber(value) end)
    end 
})

-- Extras Tab: Walkspeed Input
ExtrasTab:CreateInput({
    Name = "Walkspeed, Numbers Only",
    PlaceholderText = "Enter number",
    NumbersOnly = true,
    Flag = "Walkspeed",
    Callback = function(value)
        pcall(function()
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = tonumber(value) end)
    end
})

-- Extras Tab: JumpPower Input
ExtrasTab:CreateInput({
    Name = "JumpPower, Numbers Only",
    PlaceholderText = "Enter number",
    NumbersOnly = true,
    Flag = "JumpPower",
    Callback = function(value)
        pcall(function()
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = tonumber(value) end)
    end
})

-- Extras Tab: Morph Buttons
ExtrasTab:CreateButton({
    Name = "Fox Morph",
    Callback = function()
        pcall(function()
        workspace.ChangeCharacter:FireServer("FoxCharacter") end)
    end
})

ExtrasTab:CreateButton({
    Name = "Penguin Morph",
    Callback = function()
        pcall(function()
        workspace.ChangeCharacter:FireServer("PenguinCharacter") end)
    end
})

ExtrasTab:CreateButton({
    Name = "Chicken Morph",
    Callback = function()
        pcall(function()
        workspace.ChangeCharacter:FireServer("ChickenCharacter") end)
    end
})

-- Extras Tab: Infinite Yield Button
ExtrasTab:CreateButton({
    Name = "Infinite Yield",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
    end
})

-- Extras Tab: Anti-AFK Button–
ExtrasTab:CreateButton({
    Name = "Anti-AFK",
    Callback = function()
        wait(3)
        pcall(function()
        local VirtualUser = game:GetService('VirtualUser')
        game:GetService('Players').LocalPlayer.Idled:Connect(function()
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
        end) end)
    end
})

-- Extras Tab: Anti-LAG Button
ExtrasTab:CreateButton({
    Name = "Anti-LAG",
    Callback = function()
    pcall(function()
        for _, v in pairs(game:GetService("Workspace"):GetDescendants()) do
            if v:IsA("BasePart") and not v.Parent:FindFirstChild("Humanoid") then
                v.Material = Enum.Material.SmoothPlastic
                if v:IsA("Texture") then
                    v:Destroy()
                end
            end
        end end)
    end
})

-- Teleports Tab: Teleport Buttons
TeleportsTab:CreateButton({
    Name = "Teleport To Blue",
    Callback = function()
    pcall(function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace")["Really blueZone"].CFrame * CFrame.new(0, 5, 0)
    end) end
})

TeleportsTab:CreateButton({
    Name = "Teleport To Black",
    Callback = function()
    pcall(function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").BlackZone.CFrame * CFrame.new(0, 5, 0)
    end) end
})

TeleportsTab:CreateButton({
    Name = "Teleport To Magenta",
    Callback = function()
    pcall(function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").MagentaZone.CFrame * CFrame.new(0, 5, 0)
    end) end
})

TeleportsTab:CreateButton({
    Name = "Teleport To Red",
    Callback = function()
    pcall(function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(221.12088, -9.89999676, -64.0851135, 0.0238732975, -3.54099043e-08, -0.999714971, 3.27503464e-08, 1, -3.46379174e-08, 0.999714971, -3.19140909e-08, 0.0238732975)
    end) end
})

TeleportsTab:CreateButton({
    Name = "Teleport To Yellow",
    Callback = function()
    pcall(function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace")["New YellerZone"].CFrame * CFrame.new(0, 5, 0)
    end) end
})

TeleportsTab:CreateButton({
    Name = "Teleport To Green",
    Callback = function()
        pcall(function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").CamoZone.CFrame * CFrame.new(0, 5, 0)
    end) end
})

TeleportsTab:CreateButton({
    Name = "Teleport To White",
    Callback = function()
        pcall(function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").WhiteZone.CFrame * CFrame.new(0, 5, 0)
    end) end
})

TeleportsTab:CreateButton({
    Name = "Teleport To Void",
    Callback = function()
        pcall(function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(math.huge, math.huge, math.huge)
    end) end
})

TeleportsTab:CreateButton({
    Name = "Rejoin",
    Callback = function()
        pcall(function()
        game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer)
    end) end
})

TeleportsTab:CreateButton({
    Name = "Server Hop",
    Callback = function()
        pcall(function()
        game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer)
    end) end
})

-- Load Configuration
Rayfield:LoadConfiguration()
