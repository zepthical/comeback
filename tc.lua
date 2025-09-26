-- [[ Debug Version ]] --

local slots = workspace:WaitForChild("Slots")

local function copyToClipboard(text)
    if setclipboard then
        setclipboard(text)
        print("[copyslot] Copied to clipboard with setclipboard")
    elseif toclipboard then
        toclipboard(text)
        print("[copyslot] Copied to clipboard with toclipboard")
    else
        warn("[copyslot] No clipboard function found")
    end
end

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
        return nil -- unsupported
    end
end

local function dumpInstance(inst)
    local lines = {}
    table.insert(lines, 'local obj = Instance.new("' .. inst.ClassName .. '")')

    local props = {}
    if getproperties then
        props = getproperties(inst)
    else
        -- fallback: common properties
        for _, prop in ipairs({
            "Name","Transparency","Anchored","CanCollide",
            "Material","Reflectance","Size","Position","Orientation",
            "Color","CFrame","BrickColor","TopSurface","BottomSurface"
        }) do
            local ok, val = pcall(function() return inst[prop] end)
            if ok then
                props[prop] = val
            end
        end
    end

    for prop, val in pairs(props) do
        if prop ~= "Parent" then
            local str = formatValue(val)
            if str then
                table.insert(lines, ("obj.%s = %s"):format(prop, str))
            else
                table.insert(lines, ("-- skipped %s (unsupported)"):format(prop))
            end
        end
    end

    table.insert(lines, "obj.Parent = workspace")
    return table.concat(lines, "\n")
end

local function copyslot(num)
    print("[copyslot] Starting for slot " .. num)

    local slot = slots:FindFirstChild("Slot" .. num)
    if not slot then
        warn("[copyslot] Slot" .. num .. " not found.")
        return
    end

    local ilva = slot:WaitForChild("Utility"):WaitForChild("IsLoaded")
    print("[copyslot] Slot found, IsLoaded =", ilva.Value)
    if ilva.Value ~= true then
        warn("[copyslot] Slot" .. num .. " is not loaded.")
        return
    end

    local obby = slot:FindFirstChild("Obby")
    if not obby then
        warn("[copyslot] No Obby folder found in Slot" .. num)
        return
    end

    local children = obby:GetChildren()
    print("[copyslot] Found " .. #children .. " children in Obby")

    local output = {}
    local function recurse(obj)
        table.insert(output, dumpInstance(obj))
        for _, child in ipairs(obj:GetChildren()) do
            recurse(child)
        end
    end

    for _, v in ipairs(children) do
        recurse(v)
    end

    if #output == 0 then
        warn("[copyslot] No objects were dumped!")
        return
    end

    local code = table.concat(output, "\n\n")
    copyToClipboard(code)
    print("[copyslot] Finished. Dumped " .. #output .. " objects.")
end

-- Usage:
-- copyslot(1)
