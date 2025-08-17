local Players = game:GetService("Players")
local player = Players.LocalPlayer
local chr = player.Character or player.CharacterAdded:Wait()
local hrp = chr:WaitForChild("HumanoidRootPart")

-- Get the player's plot
local function getPlot()
    local maps = workspace:FindFirstChild("Maps")
    if not maps then return nil end

    local bases = maps:FindFirstChild("Bases")
    if not bases then return nil end

    for _, v in ipairs(bases:GetChildren()) do
        local owner = v:FindFirstChild("Owner")
        if owner and owner.Value == player.Name then
            return v
        end
    end
    return nil
end

-- Find the plot
local plot = getPlot()
if not plot then
    warn("No plot found for player")
    return
end

local crateFolder = plot:WaitForChild("Crate")

-- Return the first valid crate
local function getCrate()
    for _, v in ipairs(crateFolder:GetChildren()) do
        if v:FindFirstChild("InsideCrate") then
            return v
        end
    end
    return nil
end

-- Main loop
while _G.a do
    task.wait(0.1) -- small delay to avoid overloading
    
    local currentCrate = getCrate()
    if currentCrate then
        local inside = currentCrate:FindFirstChild("InsideCrate")
        if inside then
            local hit = inside:FindFirstChild("Hit")
            if hit then
                hit:FireServer(2000)
            end
        end
    end
end
