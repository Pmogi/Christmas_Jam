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

InventoryGUI.w = 30
InventoryGUI.h = 30
InventoryGUI.alpha = 1

local drawItems = false


-- Uses suite to draw the GUI and update the position of the expanding GUI
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
            local x = 5
            local y = 71

            local horizontalCount = 0
            local inventory = Inventory.getInventory()
            
            for key, item in ipairs(inventory) do
                
                if horizontalCount == 1 then
                    x = 69
                    
                elseif horizontalCount == 2 then
                    x = x + 64

                else
                    horizontalCount = 0
                    x = 5
                    y = y + 64
                end

                GUI(item.id, x, y)
                
                horizontalCount = horizontalCount + 1
                
                
            end
    end

end


function InventoryGUI.draw()
    -- active item box
    love.graphics.rectangle("fill", 10, 10, 74, 74)
    if  (Inventory.getActiveItem()) then
        love.graphics.draw(Assets.getAsset(Inventory.getActiveItem()), 10, 10)
    end

    if DRAW_TAB then
        love.graphics.setColor(0.5, 0.5, 0.5, InventoryGUI.alpha)
        love.graphics.rectangle("fill", 0, love.graphics.getHeight()/6, InventoryGUI.w , InventoryGUI.h)
        
        love.graphics.draw(Assets.getAsset("UI_backpack"), 0, love.graphics.getHeight()/6+2) -- draw backpack thing
        
        love.graphics.setColor(1, 1, 1)
    
    elseif EXPAND_MENU then
        love.graphics.setColor(0.5, 0.5, 0.5, InventoryGUI.alpha)
        love.graphics.rectangle("fill", 0, love.graphics.getHeight()/6, InventoryGUI.w, InventoryGUI.h)
        love.graphics.setColor(1, 1, 1, 1)

        -- once the menu expands draw the items in the inventory
        --if (drawItems) then
        
        --end
    end
    
    gui:draw()
    
end


-- Draws an image button with the given position and image
function GUI(item, x, y)
        if Inventory.checkInventory(item) then
                itemGlow = item .. "glow"
                if gui:ImageButton(Assets.getAsset(item), {hovered = Assets.getAsset(itemGlow)}, x,y).hit then
                        Assets.getAsset("Grab"):play()
                        Inventory.setActiveItem(item)
                end
        end
end 

function checkCursorPosition()
    local xPos = love.mouse.getX()
    local yPos = love.mouse.getY()

    if DRAW_TAB and xPos > 1 and xPos < 25 and yPos > love.graphics.getHeight()/6 and yPos < (love.graphics.getHeight()/6)+25 then
        DRAW_TAB = false
        EXPAND_MENU = true
        Timer.tween(0.25, InventoryGUI, {w = 200})
        Timer.tween(0.25, InventoryGUI, {h = 300})
        Timer.tween(0.25, InventoryGUI, {alpha = 0.5})
        Timer.after(0.25, function() drawItems = true end)

    -- check if mouse is within bounds of menu
    elseif EXPAND_MENU and not (xPos > 1 and xPos < 200 and yPos > love.graphics.getHeight()/6 and yPos < (love.graphics.getHeight()/6)+300) then
        DRAW_TAB = true
        EXPAND_MENU = false
        drawItems = false
        Timer.tween(0.25, InventoryGUI, {w = 32})
        Timer.tween(0.25, InventoryGUI, {h = 32})
        Timer.tween(0.25, InventoryGUI, {alpha = 1})
    end
end

return InventoryGUI
