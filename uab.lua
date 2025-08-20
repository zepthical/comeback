_G.a = true

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local chr = player.Character or player.CharacterAdded:Wait()
local hrp = chr:WaitForChild("HumanoidRootPart")

-- Get the player's plot (retry until found)
local function getPlot()
    local maps = workspace:WaitForChild("Map")
    local bases = maps:WaitForChild("Bases")

    while true do
        for _, v in ipairs(bases:GetChildren()) do
            local owner = v:FindFirstChild("Owner")
            if owner and owner.Value then
                -- Check if it's a Player object or just a name string
                if owner.Value == player or owner.Value == player.Name then
                    return v
                end
            end
        end
        task.wait(1) -- retry every second until plot is found
    end
end

local plot = getPlot()
print("found plot ", plot.Name)

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
    task.wait(0.1)
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
