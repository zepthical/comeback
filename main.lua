local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Rayfield Example Window",
   Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "Hate is making me",
   LoadingSubtitle = "insane",
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

   KeySystem = false,
   KeySettings = {
      Title = "Untitled",
      Subtitle = "Key System",
      Note = "No method of obtaining the key is provided", -- Use this to tell the user how to get a key
      FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
      SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"nil"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
   }
})

-- _G --

_G.AutoEquipRod = false
_G.AutoCast = false

--------

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Char = LocalPlayer.Character
local Humanoid = Char.Humanoid
local VirtualInputManager = game:GetService("VirtualInputManager")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GuiService = game:GetService("GuiService")
local Backpack = LocalPlayer:FindFirstChild("Backpack")

local rod = function()
   task.wait(0.1)
   for i, v in pairs(Backpack:GetChildren()) do
         if v.Name:lower():find("rod") then
         rod = v
      end
   end
end

local MainTab = Window:CreateTab("Main", 4483362458)

local ConfigsSection = Tab:CreateSection("Configs")

equipitem = function(v)
if LocalPlayer.Backpack:FindFirstChild(v) then
    local a = LocalPlayer.Backpack:FindFirstChild(v)
        Humanoid:EquipTool(a)
    end
end

local AutoEquip = MainTab:CreateToggle({
   Name = "Auto Equip Rod",
   CurrentValue = _G.AutoEquipRod,
   Flag = "Hate",
   Callback = function(Value)
       _G.AutoEquipRod = Value

       pcall(function()
           while _G.AutoEuipRod do
              for i, v in pairs(Backpack:GetChildren()) do
                 if v.Name:lower():find("rod") then
                    equipitem(v)
                 end
              end
              task.wait(0.4)
           end
       end)
   end,
})

local Divider1 = MainTab:CreateDivider()

local AutoCast = MainTab:CreateToggle({
   Name = "Auto Cast",
   CurrentValue = _G.AutoCast,
   Flag = "Everyone",
   Callback = function(Value)
       _G.AutoCast = Value

       pcall(function()
           while _G.AutoCast do task.wait()
              if rod:FindFirstChild("values") and rod.values:FindFirstChild("casted") then
                 local casted = rod.values.casted.Value
                 if casted == false then
                    rod.events.cast:FireServer(100,1)
                 end
              end
           end
       end)
   end,
})
