--[[|||||||||<<< METHOD MADE BY ZEPTH >>>|||||||||--

    copyslot(slotNumber) will:
    1. Find Slot
    2. Check if slot is loaded
    3. Get "Obby" children
    4. Dump ALL properties
    5. Convert them into Instance.new code
    6. Copy to clipboard

--[[|||||||||<<< METHOD MADE BY ZEPTH >>>|||||||||]]--

-- [[ Copy Slot Objects to Clipboard ]] --

local slots = workspace:WaitForChild("Slots")

-- clipboard helper
local function copyToClipboard(text)
    if setclipboard then
        setclipboard(text)
    elseif toclipboard then
        toclipboard(text)
    else
        warn("No clipboard function found (setclipboard/toclipboard).")
    end
end

-- format values
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
        return "nil --[[ unsupported: " .. t .. " ]]"
    end
end

-- dump one instance
local function dumpInstance(inst)
    local lines = {}
    table.insert(lines, 'local obj = Instance.new("' .. inst.ClassName .. '")')

    local props = {}
    if getproperties then
        props = getproperties(inst)
    else
        -- manual fallback properties
        pcall(function()
            for _, prop in ipairs({
                "Name","Archivable","Transparency","Anchored","CanCollide",
                "Material","Reflectance","Size","Position","Orientation",
                "Color","CFrame","BrickColor","TopSurface","BottomSurface"
            }) do
                local ok, val = pcall(function() return inst[prop] end)
                if ok then
                    props[prop] = val
                end
            end
        end)
    end

    for prop, val in pairs(props) do
        if prop ~= "Parent" then
            local ok, str = pcall(function() return formatValue(val) end)
            if ok and str then
                table.insert(lines, ("obj.%s = %s"):format(prop, str))
            end
        end
    end

    table.insert(lines, "obj.Parent = workspace")
    return table.concat(lines, "\n")
end

-- main function
local function copyslot(num)
    local slot = slots:FindFirstChild("Slot" .. num)
    if not slot then
        warn("Slot" .. num .. " not found.")
        return
    end

    local ilva = slot:WaitForChild("Utility"):WaitForChild("IsLoaded")
    if ilva.Value ~= true then
        warn("Slot" .. num .. " is not loaded.")
        return
    end

    local obby = slot:WaitForChild("Obby")
    local output = {}

    local function recurse(obj)
        table.insert(output, dumpInstance(obj))
        for _, child in ipairs(obj:GetChildren()) do
            recurse(child)
        end
    end

    for _, v in ipairs(obby:GetChildren()) do
        recurse(v)
    end

    local code = table.concat(output, "\n\n")
    copyToClipboard(code)
    print("Copied Slot" .. num .. " Obby objects to clipboard (" .. #output .. " items).")
end

-- Example usage:
-- copyslot(1)
