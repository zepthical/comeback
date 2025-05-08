local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Moonlight Hub",
   Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "Be a Italian Brainrot",
   LoadingSubtitle = "by Moonlight",
   Theme = "Default", -- Check https://docs.sirius.menu/rayfield/configuration/themes

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface

   ConfigurationSaving = {
      Enabled = true,
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

local MainTab = Window:CreateTab("Main", 4483362458) -- Title, Image

_G.big = true

_G.fast = true

_G.walkspeed = 40 -- set it like 30-50 but more doesn't matter

_G.method = {
    speed = 0,
    size = 5, -- 5 Is best
}

local function collect()
    local args = {
        [1] = {
            [1] = workspace.Pellets:FindFirstChild(_G.method.size),
            [2] = workspace.Pellets:FindFirstChild(_G.method.size-1),
            [3] = workspace.Pellets:FindFirstChild(_G.method.size-2),
            [4] = workspace.Pellets:FindFirstChild(_G.method.size-3),
            [5] = workspace.Pellets:FindFirstChild(_G.method.size-4),
        }
    }

game:GetService("ReplicatedStorage").SpawnPellet:FireServer(unpack(args))

end

local Toggle = MainTab:CreateToggle({
   Name = "Auto Bigger",
   CurrentValue = false,
   Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
        pcall(function()
            _G.big = Value
            while _G.big do task.wait(_G.method.speed)
                collect()
            end
        end)
   end,
})

local Input = MainTab:CreateInput({
   Name = "WalkSpeed",
   CurrentValue = "",
   PlaceholderText = "30-1000",
   RemoveTextAfterFocusLost = false,
   Flag = "Input1",
   Callback = function(Text)
        pcall(function()
            _G.walkspeed = Text;while _G.fast do task.wait();game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = _G.walkspeed end end)
   end,
})

local Button = MainTab:CreateButton({
   Name = "Unlock VIP Zone",
   Callback = function()
        pcall(function()
        for q, vip in pairs(workspace:GetChildren()) do
            if vip.Name:lower():find("VIP") then
                vip.Wall:Destroy()
                vip.VIP:Destroy()
            end
        end

        end)
   end,
})

_G.bigs = false

local Toggle = MainTab:CreateToggle({
   Name = "Big Scope",
   CurrentValue = false,
   Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
        pcall(function()
            _G.bigs = Value
            while _G.bigs do task.wait()
                local char = game.Players.LocalPlayer.Character
                local scope = char:FindFirstChild("Scope") or char:WaitForChild("Scope")
                scope.Size = Vector3.new(150, 0, 150)
            end
        end)
   end,
})
