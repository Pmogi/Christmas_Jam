local SpeechBox = require("src.systems.speechbox")

Inventory = {}

-- hashtable inventory
-- used for holding item objects

local inv = {}


-- Used when using an item on something
local activeItemID = nil

function Inventory.setActiveItem(id)
    if (Inventory.checkInventory(id)) then
        activeItemID = id
        SpeechBox.startSpeech("You are holding the " .. id .. ".")
    end
end

function Inventory.resetActiveItem()
    SpeechBox.startSpeech("You put away the " .. activeItemID .. ".")
    activeItemID = nil
end

function Inventory.getActiveItem()
    return activeItemID
end

function Inventory.expendActiveItem(id)
    Inventory.removeItem(id)
end

-- Add item to inv
function Inventory.addToInventory(item)
    table.insert(inv, item)
end

function Inventory.getInventory()
        local copy = {}
        for key, value in pairs(inv) do
                copy[key] = value
        end
        return copy
end

-- Check if item is within inv by id.
-- If in inv, then return true and it's positive, else false
function Inventory.checkInventory(id)
    for i, item in ipairs(inv) do 
        if item.id == id then
            return true, i
        end 
    end
    return false
end


-- remove item in inv based on id, first call checkInventory method to see if within inv
function Inventory.removeItem(id)
    contains, itemEntry = Inventory.checkInventory(id)
    
    if contains then
        table.remove(inv , itemEntry )
        return true
    else
        return false
    end
end

return Inventory
