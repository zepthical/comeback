local Players = game:GetService("Players")
local player = Players.LocalPlayer
local chr = player.Character or player.CharacterAdded:Wait()
local hrp = chr:WaitForChild("HumanoidRootPart")

function getPlot()
    if workspace:FindFirstChild("Maps") then
        if workspace.Maps:FindFirstChild("Bases") then
            for i, v in pairs(workspace.Maps.Bases:GetChildren()) do
                if v:FindFirstChild("Owner") and v.Owner.Value == player.Name then
                    return v
                end
            end
        end
    end
end

local plot = getPlot()
local crate = plot:WaitForChild("Crate")

local function getCrate()
    for i, v in pairs(crate:GetChildren()) do
        return v
    end
end

while _G.a do task.wait()
    local currentCrate = getCrate()
    if currentCrate:WaitForChild("InsideCrate") then
        currentCrate.InsideCrate:WaitForChild("Hit"):FireServer(2000)
    end
end
