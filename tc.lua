--[[|||||||||<<< METHOD MADE BY ZEPTH >>>|||||||||--

    copyslot(slotNumber) will:
    1. Find Slot
    2. Check if slot is loaded
    3. Get "Obby" children
    4. Dump ALL properties
    5. Convert them into Instance.new code
    6. Copy to clipboard

--[[|||||||||<<< METHOD MADE BY ZEPTH >>>|||||||||]]--

local slots = workspace:WaitForChild("Slots")

-- helper: format Vector3, CFrame, Color3, etc.
local function formatValue(v)
    if typeof(v) == "string" then
        return '"' .. v .. '"'
    elseif typeof(v) == "Vector3" then
        return ("Vector3.new(%s,%s,%s)"):format(v.X, v.Y, v.Z)
    elseif typeof(v) == "CFrame" then
        return ("CFrame.new(%s)"):format(table.concat({v:GetComponents()}, ","))
    elseif typeof(v) == "Color3" then
        return ("Color3.new(%s,%s,%s)"):format(v.R, v.G, v.B)
    elseif typeof(v) == "EnumItem" then
        return tostring(v)
    elseif typeof(v) == "boolean" or typeof(v) == "number" then
        return tostring(v)
    else
        return "nil --[[ unsupported type: " .. typeof(v) .. " ]]"
    end
end

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
    local children = obby:GetChildren()
    local output = {}

    for _, inst in ipairs(children) do
        local lines = {}
        table.insert(lines, 'local obj = Instance.new("' .. inst.ClassName .. '")')

        -- use exploit API if available
        local props
        if getproperties then
            props = getproperties(inst)
        else
            -- fallback: manually collect common properties
            props = {}
            pcall(function()
                for _, prop in ipairs({
                    "Name","Parent","Archivable","Transparency","Anchored","CanCollide",
                    "Material","Reflectance","Size","Position","Orientation","Color",
                    "Shape","CFrame","BrickColor","TopSurface","BottomSurface"
                }) do
                    props[prop] = inst[prop]
                end
            end)
        end

        for prop, val in pairs(props) do
            if prop ~= "Parent" then -- we’ll handle parenting later
                local ok, str = pcall(function() return formatValue(val) end)
                if ok and str then
                    table.insert(lines, ("obj.%s = %s"):format(prop, str))
                end
            end
        end

        table.insert(lines, "obj.Parent = workspace") -- default parent
        table.insert(output, table.concat(lines, "\n"))
    end

    setclipboard(table.concat(output, "\n\n"))
    print("Copied Slot" .. num .. " Obby parts with ALL properties to clipboard.")
end

-- Usage:
-- copyslot(1)
