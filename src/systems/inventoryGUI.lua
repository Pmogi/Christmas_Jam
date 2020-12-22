local Suit      = require("lib.suit")
local Timer     = require("lib.timer")

local Assets    = require("src.assets")
local Inventory = require("src.systems.inventory")

-- FSM for GUI showing items in inventory

local selectedItem = nil

local EXPAND_MENU = false
local DRAW_TAB = true

local gui = Suit.new()

local InventoryGUI = {}

InventoryGUI.w = 25
InventoryGUI.h = 25
InventoryGUI.alpha = 1

local drawItems = false

function InventoryGUI.update(dt) 
    -- check for activity on the inventory GUI
    checkCursorPosition()
    
    -- for the player to remove the active item
    if (Inventory.getActiveItem()) then
        if gui:Button("Unequip Item", 84, 10, 100, 50).hit then -- CHANGE, scale x,y by the window 
            
            -- reset active item to nil
            Inventory.resetActiveItem()
            Assets.getAsset("Grab"):play()
        end
    end
    
    -- for inventory gui drawing
    if (drawItems) then
        GUI()
    end

end

function InventoryGUI.draw()
    -- active item box
    love.graphics.rectangle("fill", 10, 10, 74, 74) -- CHANGE needs to be based on the on the window size
    if  (Inventory.getActiveItem()) then
        love.graphics.draw(Assets.getAsset(Inventory.getActiveItem()), 10, 10)
    end


    if DRAW_TAB then
        love.graphics.setColor(0.5, 0.5, 0.5, InventoryGUI.alpha)
        love.graphics.rectangle("fill", 0, love.graphics.getHeight()/8, InventoryGUI.w , InventoryGUI.h)
        love.graphics.setColor(1, 1, 1)
    
    elseif EXPAND_MENU then
        love.graphics.setColor(0.5, 0.5, 0.5, InventoryGUI.alpha)
        love.graphics.rectangle("fill", 0, love.graphics.getHeight()/8, InventoryGUI.w, InventoryGUI.h)
        love.graphics.setColor(1, 1, 1, 1)

        -- once the menu expands draw the items in the inventory
        --if (drawItems) then
        
        --end
    end
    
    gui:draw()
    
end


-- Maybe not hardcode this and have a stack of items
function GUI()
    if Inventory.checkInventory("Eraser") then
         if gui:ImageButton(Assets.getAsset("Eraser"), { hovered = Assets.getAsset("EraserGlow")  }, 10, 96).hit then 
            Assets.getAsset("Grab"):play()
            Inventory.setActiveItem("Eraser")
         end
    end
    
    if Inventory.checkInventory("Duck") then    
        if gui:ImageButton(Assets.getAsset("Duck"), { hovered = Assets.getAsset("DuckGlow")  }, 10, 170).hit then 
            Assets.getAsset("Grab"):play()
            Inventory.setActiveItem("Duck")
        end
    end

    if Inventory.checkInventory("Glue") then    
        if gui:ImageButton(Assets.getAsset("Glue"), { hovered = Assets.getAsset("GlueGlow")  }, 10, 244).hit then 
            Assets.getAsset("Grab"):play()
            Inventory.setActiveItem("Glue")
        end
    end

    if Inventory.checkInventory("Blanket") then    
        if gui:ImageButton(Assets.getAsset("Blanket"), { hovered = Assets.getAsset("BlanketGlow")  }, 10, 318).hit then 
            Assets.getAsset("Grab"):play()
            Inventory.setActiveItem("Blanket")
        end
    end

    if Inventory.checkInventory("Scissors") then    
        if gui:ImageButton(Assets.getAsset("Scissors"), { hovered = Assets.getAsset("ScissorsGlow")  }, 96, 96).hit then 
            Assets.getAsset("Grab"):play()
            Inventory.setActiveItem("Scissors")
        end
    end

    if Inventory.checkInventory("Mustache") then    
        if gui:ImageButton(Assets.getAsset("Mustache"), { hovered = Assets.getAsset("MustacheGlow")  }, 96, 244).hit then 
            Assets.getAsset("Grab"):play()
            Inventory.setActiveItem("Mustache")
        end
    end

    
    if Inventory.checkInventory("HelpBook") then    
        if gui:ImageButton(Assets.getAsset("HelpBook"), { hovered = Assets.getAsset("HelpBookGlow")  }, 96, 318).hit then 
            Assets.getAsset("Grab"):play()
            Inventory.setActiveItem("HelpBook")
        end
    end

end


function checkCursorPosition()
    local xPos = love.mouse.getX()
    local yPos = love.mouse.getY()

    if DRAW_TAB and xPos > 0 and xPos < 25 and yPos > love.graphics.getHeight()/8 and yPos < (love.graphics.getHeight()/8)+25 then
        DRAW_TAB = false
        EXPAND_MENU = true
        Timer.tween(0.25, InventoryGUI, {w = 200})
        Timer.tween(0.25, InventoryGUI, {h = 300})
        Timer.tween(0.25, InventoryGUI, {alpha = 0.5})
        Timer.after(0.25, function() drawItems = true end)

    -- check if mouse is within bounds of menu
    elseif EXPAND_MENU and not (xPos > 0 and xPos < 200 and yPos > love.graphics.getHeight()/8 and yPos < (love.graphics.getHeight()/8)+300) then
        DRAW_TAB = true
        EXPAND_MENU = false
        drawItems = false
        Timer.tween(0.25, InventoryGUI, {w = 25})
        Timer.tween(0.25, InventoryGUI, {h = 25})
        Timer.tween(0.25, InventoryGUI, {alpha = 1})
    end
end

return InventoryGUI