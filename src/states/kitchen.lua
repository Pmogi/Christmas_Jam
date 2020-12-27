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

local ingredientsInBowl = 0

function Kitchen:init()
    -- set initial state from Kitchen to world
    self.background = Assets.getAsset("kitchenBG")
    
    roomState["atticDoor"] = false
    roomState["cabinet"]   = false
    roomState["fridge"]    = false

    itemsInRoom["sugar"]      = true
    itemsInRoom["raisins"]     = true
    itemsInRoom["oats"]       = true
    itemsInRoom["cookbook"] = true
    itemsInRoom["bowl"] = true
end


function Kitchen:enter()
    -- add sensor entities
    
    World.addEntity(Sensor(230, 220 , 215, 160, 
        function()
            SpeechBox.startSpeech("It's beginning to look a lot like Christmas." )
            Assets.getAsset("Touch"):play()
            return true
        end
    ))

    -- Attic Door sensor
    World.addEntity(Sensor(200, 0, 300, 100, 
            function()
                if not roomState["atticDoor"] and Inventory.getActiveItem() == "hookicon" then
                    roomState["atticDoor"] = true
                
                elseif not roomState["atticDoor"] then
                    -- play "hmmm" sound
                    SpeechBox.startSpeech("I wonder if there's a way to get up there...")
                else
                    -- DOOR SOUND
                    
                    GameState.switch(Attic)
                end
                
            return true
        end))
    
    -- Cabinet and Sugar
    World.addEntity(Sensor(550, 200, 100, 100,
        function() 
            -- opening cabinet
            if not roomState["cabinet"] then
                roomState["cabinet"] = true
                -- play open sound
                Assets.getAsset("Cabinet"):play()
                -- add sugar
                World.addEntity(Sensor(610, 210, 150, 150,
                    function()    
                        SpeechBox.startSpeech("You got a jar of sugar.")
                        -- grab sound
                        Inventory.addToInventory(Item("sugaricon", Assets.getAsset("sugaricon")))
                        itemsInRoom["sugar"] = false
                        return false
                    end,
                Assets.getAsset("sugar"), true))
            end
        
            return false
        end),
        false, false)
    
    -- Fridge and thing inside it
    World.addEntity(Sensor(850, 300, 800, 100,
        function() 
            -- opening cabinet
            if not roomState["fridge"] then
                roomState["fridge"] = true
                -- play open sound

                -- add sugar
                World.addEntity(Sensor(930, 290 , 50, 50,
                    function()    
                        SpeechBox.startSpeech("You got a box of raisins, gross...")
                        -- grab sound
                        Inventory.addToInventory(Item("raisinsicon", Assets.getAsset("raisinsicon")))
                        itemsInRoom["raisins"] = false
                        return false
                    end,
                Assets.getAsset("raisins"), true))
            end
            return false
        end),
        false, false)

    
    -- Add oats if not picked up by the player
    if itemsInRoom["oats"] then
        World.addEntity(Sensor(14,380,50,50,
            function()
                SpeechBox.startSpeech("You got some oats Mah-goats")
                -- grab sound
                Inventory.addToInventory(Item("oatsicon", Assets.getAsset("oatsicon")))
                itemsInRoom["oats"] = false
                return false
            end,Assets.getAsset("oats"), true))
    end


    World.addEntity(Sensor(720,390,50,50,
        function()
                -- checks ingredients
                if Inventory.getActiveItem() == "oatsicon" then
                        SpeechBox.startSpeech("You threw some oats into the bowl.")
                        Inventory.removeItem("oatsicon")
                        Inventory.removeItem("oatsiconglow")
                        Inventory.removeActiveItem()
                        ingredientsInBowl = ingredientsInBowl + 1
                        
                        if ingredientsInBowl == 4 then
                                SpeechBox.startSpeech("I got all the ingredients ready! Now it's time to put this in the oven!")
                        end
                        return true
                
                elseif Inventory.getActiveItem() == "sugaricon" then
                        SpeechBox.startSpeech("You threw some sugar into the bowl.")
                        Inventory.removeItem("sugaricon")
                        Inventory.removeItem("sugariconglow")
                        Inventory.removeActiveItem()
                        ingredientsInBowl = ingredientsInBowl + 1

                        if ingredientsInBowl == 4 then
                                SpeechBox.startSpeech("I got all the ingredients ready! Now it's time to put this in the oven!")
                        end
                        return true
                
                elseif Inventory.getActiveItem() == "pruneicon" then
                        SpeechBox.startSpeech("You threw some prunes into the bowl.")
                        Inventory.removeItem("pruneicon")
                        Inventory.removeItem("pruneiconglow")
                        Inventory.removeActiveItem()
                        ingredientsInBowl = ingredientsInBowl + 1

                        if ingredientsInBowl == 4 then
                                SpeechBox.startSpeech("I got all the ingredients ready! Now it's time to throw this in the oven!")
                        end
                        return true

                elseif Inventory.getActiveItem() == "raisinsicon" then
                        SpeechBox.startSpeech("You threw some raisins into the bowl.")
                        Inventory.removeItem("raisinsicon")
                        Inventory.removeItem("raisinsiconglow")
                        Inventory.removeActiveItem()
                        ingredientsInBowl = ingredientsInBowl + 1
                        if ingredientsInBowl == 4 then
                                SpeechBox.startSpeech("I got all the ingredients ready! Now it's time to throw this in the oven!")
                        end
                        return true

                elseif Inventory.isActiveItem() then
                        SpeechBox.startSpeech("No, I don't think that's in the recipe...")
                
                else
                -- Checks to see if all ingredients are in the bowl.

                    if ingredientsInBowl == 4 then
                            SpeechBox.startSpeech("You got a bowl of raisin oatmeal and prune batter")
                            Inventory.addToInventory(Item("bowlicon", Assets.getAsset("bowlicon")))
                            itemsInRoom["bowl"] = false
                            return false
                    
                    elseif ingredientsInBowl > 0 and ingredientsInBowl < 4 then
                            SpeechBox.startSpeech("I've got some of the ingredients in the bowl, but I just need to put in the rest before baking.")
                    
                    else
                            SpeechBox.startSpeech("Looks like grandma started making raisin oatmeal and prune cookies but forgot to finish adding ingredients. I wonder if I can find the recipe somewhere...")
                    end
            end
            return true
        end, Assets.getAsset("bowl"), true))

    World.addEntity(Sensor(540,440,200,150,
        function()
                if Inventory.getActiveItem() == "bowlicon" then
                        SpeechBox.startSpeech("You put the cookie batter onto a baking pan and place it in the oven.")
                        SpeechBox.startSpeech("doot...dee...doot dooot....")
                        SpeechBox.startSpeech("ski doobie doobie doo de bap bap...")
                        -- finish noise 
                        SpeechBox.startSpeech("Cookies are done!")
                        Inventory.addToInventory(Item("cookiesicon", Assets.getAsset("cookiesicon")))
                        Inventory.removeActiveItem()
                        Inventory.removeItem("bowlicon")
                        Inventory.removeItem("bowliconglow")
                        SpeechBox.startSpeech("You got a tray of fresh hot cookies")
                else
                        SpeechBox.startSpeech("it's a stove.")
                end
                return true
        end
                        ))
    -- Go to recipe page
    World.addEntity(Sensor(150, 425, 0, 0,
        function()
            -- Go to Recipe page
            GameState.switch(Recipe) 
            return true
        end, Assets.getAsset("cookbook"), true))
    
    -- Go to living room
    World.addEntity(Sensor(371, 680, 200,200,
                        function()
                                -- play door sound --
                                GameState.switch(LivingRoom)
                        end))
    
     

    -- Go to backyard
    World.addEntity(Sensor(1095,249,220,400,
        function()
            --play door sound--
            GameState.switch(Backyard)
        end))
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

    -- Draw base on room state
    if not roomState["atticDoor"] then
        love.graphics.draw(Assets.getAsset("kitchenAtticDoor1"), 200, 0)
    else
        love.graphics.draw(Assets.getAsset("kitchenAtticDoor2"), 200, 0)
    end

    if not roomState["cabinet"] then
        love.graphics.draw(Assets.getAsset("kitchencabinet1"), 450, 175)
    else
        love.graphics.draw(Assets.getAsset("kitchencabinet2"), 450, 175)
    end

    if not roomState["fridge"] then
        love.graphics.draw(Assets.getAsset("kitchenFridge1"), 825, 200)
    else
        love.graphics.draw(Assets.getAsset("kitchenFridge2"), 825, 200)
    end

    InventoryGUI.draw()
    World.draw() -- draw entities    
    SpeechBox.draw()
    camera:detach()

    DrawGrid.drawGrid()

end

return Kitchen
