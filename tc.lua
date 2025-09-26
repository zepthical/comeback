-- [[ Print Slot Objects as Code ]] --

local slots = workspace:WaitForChild("Slots")

-- helper: format values
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
        return nil
    end
end

-- turn an instance into code
local function dumpInstance(inst)
    local lines = {}
    table.insert(lines, 'local obj = Instance.new("' .. inst.ClassName .. '")')

    local properties = {
        "Name","Transparency","Anchored","CanCollide","Material",
        "Reflectance","Size","Position","Orientation","Color",
        "CFrame","BrickColor","TopSurface","BottomSurface"
    }

    for _, prop in ipairs(properties) do
        local ok, val = pcall(function() return inst[prop] end)
        if ok and val ~= nil then
            local str = formatValue(val)
            if str then
                table.insert(lines, ("obj.%s = %s"):format(prop, str))
            end
        end
    end

    table.insert(lines, "obj.Parent = workspace")
    return table.concat(lines, "\n")
end

-- main function
local function copyslot(num)
    print("[copyslot] Checking Slot" .. num)

    local slot = slots:FindFirstChild("Slot" .. num)
    if not slot then
        warn("[copyslot] Slot" .. num .. " not found.")
        return
    end

    local ilva = slot:WaitForChild("Utility"):WaitForChild("IsLoaded")
    if ilva.Value ~= true then
        warn("[copyslot] Slot" .. num .. " is not loaded.")
        return
    end

    local obby = slot:FindFirstChild("Obby")
    if not obby then
        warn("[copyslot] Slot" .. num .. " has no Obby folder.")
        return
    end

    local function recurse(obj)
        print(dumpInstance(obj))
        for _, child in ipairs(obj:GetChildren()) do
            recurse(child)
        end
    end

    for _, v in ipairs(obby:GetChildren()) do
        recurse(v)
    end

    print("[copyslot] Done.")
end

-- Example:
-- copyslot(1)
