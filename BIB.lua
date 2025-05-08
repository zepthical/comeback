_G.big = true

_G.fast = true

_G.walkspeed = 40 -- set it like 30-50 but more doesn't matter

_G.method = {
    speed = 0,
    size = 5, -- 5 Is best
}

local function bigger()
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

while _G.big do task.wait(_G.method.speed)
    bigger()
end

while _G.fast do task.wait();game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = _G.walkspeed end
