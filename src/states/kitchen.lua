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


local Kitchen = {}

local roomState = {}

local itemsInRoom  = {}

function Kitchen:init()
-- set initial state from Kitchen to world
    self.background = Assets.getAsset("kitchenBG")
    
    roomState["atticDoor"] = false
    roomState["cabinet"]   = false
    roomState["fridge"]    = false

    roomState["sugar"]      = true
    roomState["rasins"]     = true
    roomState["oats"]       = true

end


function Kitchen:enter()
    -- add sensor entities
    
    World.addEntity(Sensor(200, 200 , 300, 200, 
        function()
            SpeechBox.startSpeech("It's beginning to look a lot like Christmas." )
            Assets.getAsset("Touch"):play()
        return true
    end))

    -- Attic Door sensor
    World.addEntity(Sensor(200, 0, 300, 100, 
            function()
                if not roomState["atticDoor"] and Inventory.getActiveItem() == "Hook" then
                    roomState["atticDoor"] = true
                else if not roomState["atticDoor"] then
                    -- play "hmmm" sound
                    SpeechBox.startSpeech("I wonder if there's a way to get up there...")
                else
                    --change gameState to attic room
                    
                end
                
                return true
            end
                ))
    
    -- Cabinet and Sugar
    World.addEntity(Sensor(500, 200, 800, 100,
                    function() 
                        -- opening cabinet
                        if not roomState["cabinet"] then
                            roomState["cabinet"] = true
                            -- play open sound

                            -- add sugar
                            World.addEntity(Sensor(643, 210, 150, 150,
                                function()    
                                    SpeechBox.startSpeech("You got a jar of sugar.")
                                    -- grab sound
                                    --Inventory.addToInventory(Item("Sugar", Assets.getAsset("Sugar")))
                                    itemsInRoom["sugar"] = false
                                    return false
                                end,
                            Assets.getAsset("Sugar"), true))
                        end
                    
                    return false
                    end ),
                    false, false)
    


    -- Go to living room


    -- Go to backyard
    

end

function Kitchen:update(dt)
    InventoryGUI.update(dt)
    SpeechBox.update(dt)
    World.update(dt)
end

function Kitchen:leave()
    -- Clear entities from the world on leaving room gamestate
    World.clearEntities()
end

function Kitchen:draw()
    camera:attach()
    love.graphics.draw(self.background, 0 , 0)

    -- Draw states
    if not roomState["atticDoor"] then
        love.graphics.draw(Assets.getAsset("kitchenAtticDoor1"), 200, 0)
    else
        love.graphics.draw(Assets.getAsset("kitchenAtticDoor2"), 200, 0)
    end

    if not roomState["cabinet"] then
        love.graphics.draw(Assets.getAsset("kitchencabinet1"), 500, 175)
    else
        love.graphics.draw(Assets.getAsset("kitchencabinet2"), 500, 175)
    end




    InventoryGUI.draw()
    World.draw() -- draw entities    
    SpeechBox.draw()
    camera:detach()

    DrawGrid.drawGrid()
end


return Kitchen
