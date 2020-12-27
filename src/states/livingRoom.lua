-- Libaries
local Timer     = require("lib.timer")

-- Modules
local Assets = require("src/assets")
local Sensor = require("src.entities.sensor")
local SpeechBox = require("src.systems.speechbox")
local Item      = require("src.entities.item")
local Inventory    = require("src.systems.inventory")
local InventoryGUI = require("src.systems.inventoryGUI")
local World    = require("src.systems.world")
local Objective = require("src.systems.objective")
local DrawGrid = require("src.test.drawGrid") -- for drawing grid on screen to see where to place sensors


local LivingRoom = {}

local itemsInRoom = {}

function LivingRoom:init()
        itemsInRoom["denture"] = true
        itemsInRoom["hook"]    = true

end

function LivingRoom:enter()
        -- Go to kitchen
        World.addEntity(Sensor(515,233, 113,200, 
                            function()
                                    -- play door sound -- 
                                    GameState.switch(Kitchen)
                            end
        ))


        -- Go to kitchen
        World.addEntity(Sensor(213, 350, 100,100, 
                            function()
                                    -- hmm-- 
                                    SpeechBox.startSpeech('Near the photos it says, "My dear daughters, Lilly and Rose."')
                                    return true
                            end
        ))

        -- Go to bedroom
        World.addEntity(Sensor(822,232,100,200,
                            function()
                                    -- play door sound --
                                    GameState.switch(Bedroom)
                                    
                            end
        ))

        if itemsInRoom["denture"] then
                World.addEntity(Sensor(125, 245, 0, 0,
                        function()
                                -- grab sound
                                Inventory.addToInventory(Item("dentureicon", Assets.getAsset("dentureicon")))
                                SpeechBox.startSpeech("You obtained some false teeth.")
                                itemsInRoom["denture"] = false
                                return false
                        end
        , Assets.getAsset("denture"), true ))
        end

        
        if itemsInRoom["hook"] then
                World.addEntity(Sensor(868, 600, 0, 0,
                        function()
                                -- grab sound
                                Inventory.addToInventory(Item("hookicon", Assets.getAsset("hookicon")))
                                SpeechBox.startSpeech("You obtained a pole with a hook on the end")
                                itemsInRoom["hook"] = false
                                return false
                        end
        , Assets.getAsset("hook"), true ))
        end
end

function LivingRoom:update(dt)
    InventoryGUI.update(dt)
    SpeechBox.update(dt)
    World.update(dt)
end

function LivingRoom:draw()
        love.graphics.draw(Assets.getAsset("livingRoomBG"))
        
        DrawGrid.drawGrid()
        InventoryGUI.draw()
        World.draw() -- draw entities    
        SpeechBox.draw()
        --camera:detach()
end

function LivingRoom:leave()
        World.clearEntities()
end


return LivingRoom
