local Players = game:GetService("Players")
local player = Players.LocalPlayer
local chr = player.Character or player.CharacterAdded:Wait()
local hrp = chr:WaitForChild("HumanoidRootPart")
local plrgui = player:WaitForChild("PlayerGui")
local poopUI = plrgui:WaitForChild("PoopUI")
local poopbar = poopUI:WaitForChild("PoopBar")
local poopArea = poopbar:WaitForChild("PoopArea")

while true do task.Wait()
    poopArea.Size = UDim2.new(4, 0, 1, 0)
end
