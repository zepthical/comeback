--[[ Auto-Copy Slot Output in Clipboard Chunks ]]--

local slots = workspace:WaitForChild("Slots")

local function formatValue(v)
    local t = typeof(v)
    if t == "string" then
        return string.format("%q", v)
    elseif t == "Vector3" then
        return ("Vector3.new(%s,%s,%s)"):format(v.X, v.Y, v.Z)
    elseif t == "CFrame" then
        return ("CFrame.new(%s)"):format(table.concat({v:GetComponents()}, ","))
    elseif t == "Color3" then
        return ("Color3.new(%s,%s,%s)"):format(v.R, v.G, v.B)
    elseif t == "EnumItem" then
        return tostring(v)
    elseif t == "boolean" or t == "number" then
        return tostring(v)
    else
        return "nil"
    end
end

local function dumpInstance(inst)
    local lines = {}
    table.insert(lines, 'local ' .. inst.Name .. ' = Instance.new("' .. inst.ClassName .. '")')

    local props = {"Name","Anchored","CanCollide","Transparency","Size","CFrame","Color","Material","Reflectance","Orientation","Position","Rotation","Shape"}
    for _, prop in ipairs(props) do
        local ok, val = pcall(function() return inst[prop] end)
        if ok and val ~= nil then
            local str = formatValue(val)
            if str then
                table.insert(lines, ("%s.%s = %s"):format(inst.Name, prop, str))
            end
        end
    end

    table.insert(lines, inst.Name .. ".Parent = workspace")
    return table.concat(lines, "\n")
end

local function copyInChunks(str, chunkSize)
    chunkSize = chunkSize or 150000 -- safe chunk size for setclipboard
    local len = #str
    local i = 1
    local part = 1

    while i <= len do
        local chunk = str:sub(i, i + chunkSize - 1)
        setclipboard(chunk)
        print(("Copied part %d/%d to clipboard"):format(part, math.ceil(len/chunkSize)))
        task.wait(1) -- wait so you have time to paste before it gets overwritten
        i = i + chunkSize
        part = part + 1
    end
end

local function copySlot(slotNumber)
    local slot = slots:FindFirstChild("Slot"..slotNumber)
    if not slot then return warn("Slot not found!") end

    local ilva = slot.Utility:FindFirstChild("IsLoaded")
    if not ilva or not ilva.Value then return warn("Slot not loaded!") end

    local obby = slot:FindFirstChild("Obby")
    if not obby then return warn("No Obby found in slot") end

    local output = {}
    for _, child in ipairs(obby:GetChildren()) do
        table.insert(output, dumpInstance(child))
    end

    local finalCode = table.concat(output, "\n\n")
    copyInChunks(finalCode)
end

-- Example usage:
-- copySlot(1)
