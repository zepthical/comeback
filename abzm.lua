--// LocalScript

local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

local itemsFolder = workspace:WaitForChild("Spawned Items")

-- Function for the teleport grab sequence
local function grabItem(targetPos)
    local abovePos = targetPos + Vector3.new(0, -1, 0)  -- above item
    local belowPos = targetPos + Vector3.new(0, -10, 0) -- under item

    -- 1. Teleport under the item
    hrp.CFrame = CFrame.new(belowPos)

    -- 2. Anchor
    hrp.Anchored = true
    task.wait()

    -- 3. Unanchor
    

    -- 4. Teleport above item
    hrp.CFrame = CFrame.new(abovePos)
    task.wait(0.5)
    hrp.Anchored = false
  
    -- 5. Small delay before next
    task.wait(0.5)
end

-- Loop through items
for _, item in ipairs(itemsFolder:GetChildren()) do
    if item.Name ~= "Arrow" and item.Name ~= "Rokakaka" then
        if item:IsA("BasePart") then
            grabItem(item.Position)
        elseif item:IsA("Model") and item.PrimaryPart then
            grabItem(item.PrimaryPart.Position)
        end
    end
end
