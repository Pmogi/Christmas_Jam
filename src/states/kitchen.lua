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
    itemsInRoom["raisins"]    = true
    itemsInRoom["oats"]       = true
    itemsInRoom["cookbook"] =   true
    itemsInRoom["bowl"] =       true
end


function Kitchen:enter()
        Assets.getAsset("recordBGM"):pause()
    -- add sensor entities
    print(itemsInRoom["bowl"])
    
    World.addEntity(Sensor(230, 220 , 215, 160, 
        function()
            SpeechBox.startSpeech("It's beginning to look a lot like Christmas." )
            Assets.playAudioRandomPitch("GlassKnock", 0.9, 1.2)
            return true
        end
    ))

    -- Attic Door sensor
    World.addEntity(Sensor(200, 0, 300, 100, 
            function()
                if not roomState["atticDoor"] and Inventory.getActiveItem() == "hookicon" then
                    roomState["atticDoor"] = true
                    Assets.playAudio("AtticDoor")
                
                elseif not roomState["atticDoor"] then
                    -- play "hmmm" sound
                    Assets.playAudioRandomPitch("Hmm", 0.9, 1.1)
                    SpeechBox.startSpeech("I wonder if there's a way to get up there...", 1.5)
                else
                    -- DOOR SOUND
                    GameState.switch(Attic)
                end
                
            return true
        end))
    
    local addSugar = function()
            World.addEntity(Sensor(590, 223, 150, 150,
            function()    
                SpeechBox.startSpeech("You got a jar of sugar.", 0.75)
                -- grab sound
                Assets.playAudioRandomPitch("Grab", 0.9, 1.1)
                Inventory.addToInventory(Item("sugaricon", Assets.getAsset("sugaricon")))
                itemsInRoom["sugar"] = false
                return false
            end,
            Assets.getAsset("sugar"), true))
        end

    if roomState["cabinet"] and itemsInRoom["sugar"] then
            addSugar()
    end


    -- Cabinet and Sugar
    World.addEntity(Sensor(550, 200, 100, 100,
        function() 
            -- opening cabinet
            if not roomState["cabinet"] then
                roomState["cabinet"] = true
                -- play open sound
                Assets.playAudio("Cabinet")
                -- add sugar
                addSugar()
            end
        
            return false
        end),
        false, false)


    local addRaisins = function()
        World.addEntity(Sensor(930, 295 , 50, 50,
            function()    
                SpeechBox.startSpeech("You got a box of raisins, gross...", 1.2)
                -- grab sound
                Assets.playAudioRandomPitch("Grab", 0.9, 1.1)
                Inventory.addToInventory(Item("raisinsicon", Assets.getAsset("raisinsicon")))
                itemsInRoom["raisins"] = false
                return false
            end,
            Assets.getAsset("raisins"), true))
    end

    if roomState["fridge"] and itemsInRoom["raisins"] then
            addRaisins()
    end
    -- Fridge and thing inside it
    World.addEntity(Sensor(850, 300, 800, 100,
        function() 
            -- opening cabinet
            if not roomState["fridge"] then
                roomState["fridge"] = true
                -- play open sound
                Assets.playAudio("FridgeDoor")
                addRaisins()
            end
            return false
        end),
        false, false) 

    
    -- Add oats if not picked up by the player
    if itemsInRoom["oats"] then
        World.addEntity(Sensor(14,380,50,50,
            function()
                SpeechBox.startSpeech("You got some oats, mah-goats", 1)
                -- grab sound
                Assets.playAudioRandomPitch("Grab", 0.9, 1.1)
                Inventory.addToInventory(Item("oatsicon", Assets.getAsset("oatsicon")))
                itemsInRoom["oats"] = false
                return false
            end,Assets.getAsset("oats"), true))
    end

    if itemsInRoom["bowl"] then
    World.addEntity(Sensor(720,390,50,50,
        function()
                -- checks ingredients
                if Inventory.getActiveItem() == "oatsicon" then
                        Assets.playAudio("Grab")
                        SpeechBox.startSpeech("You threw some oats into the bowl.", 0.75)
                        Inventory.removeItem("oatsicon")
                        Inventory.removeItem("oatsiconglow")
                        Inventory.removeActiveItem()
                        ingredientsInBowl = ingredientsInBowl + 1
                        
                        if ingredientsInBowl == 4 then
                                SpeechBox.startSpeech("I got all the ingredients ready! Now it's time to put this in the oven!")
                        end
                        return true
                
                elseif Inventory.getActiveItem() == "sugaricon" then
                        Assets.playAudio("Grab")
                        SpeechBox.startSpeech("You threw some sugar into the bowl.", 0.75)
                        Inventory.removeItem("sugaricon")
                        Inventory.removeItem("sugariconglow")
                        Inventory.removeActiveItem()
                        ingredientsInBowl = ingredientsInBowl + 1

                        if ingredientsInBowl == 4 then
                                SpeechBox.startSpeech("I got all the ingredients ready! Now it's time to put this in the oven!")
                        end
                        return true
                
                elseif Inventory.getActiveItem() == "pruneicon" then
                        Assets.playAudio("Grab")
                        SpeechBox.startSpeech("You threw some prunes into the bowl.", 0.75)
                        Inventory.removeItem("pruneicon")
                        Inventory.removeItem("pruneiconglow")
                        Inventory.removeActiveItem()
                        ingredientsInBowl = ingredientsInBowl + 1

                        if ingredientsInBowl == 4 then
                                SpeechBox.startSpeech("I got all the ingredients ready! Now it's time to throw this in the oven!")
                        end
                        return true

                elseif Inventory.getActiveItem() == "raisinsicon" then
                        Assets.playAudio("Grab")
                        SpeechBox.startSpeech("You threw some raisins into the bowl.", 0.75)
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
                            SpeechBox.startSpeech("Looks like grandma started making raisin oatmeal and prune cookies but forgot to finish adding ingredients. I wonder if I can find the recipe somewhere...", 3)
                    end
            end
            return true
        end, Assets.getAsset("bowl"), true))
end

    World.addEntity(Sensor(540,440,200,150,
        function()
                if Inventory.getActiveItem() == "bowlicon" then
                        SpeechBox.startSpeech("You put the cookie batter onto a baking pan and place it in the oven.", 2)
                        SpeechBox.startSpeech("doot...dee...doot dooot....", 2)
                        SpeechBox.startSpeech("ski doobie doobie doo de bap bap...", 2)
                        -- finish noise 
                        SpeechBox.startSpeech("Cookies are done!", 1)
                        Inventory.addToInventory(Item("cookiesicon", Assets.getAsset("cookiesicon")))
                        Inventory.removeActiveItem()
                        Inventory.removeItem("bowlicon")
                        Inventory.removeItem("bowliconglow")
                        SpeechBox.startSpeech("You got a tray of fresh hot cookies", 0.75)
                else
                        SpeechBox.startSpeech("It's matilda the ol' oven.", 1)
                end
                return true
        end
                        ))
    -- Go to recipe page
    World.addEntity(Sensor(110, 420, 0, 0,
        function()
            -- Go to Recipe page
            GameState.switch(Recipe) 
            return true
        end, Assets.getAsset("cookbook"), true))
    
    -- Go to living room
    World.addEntity(Sensor(570, 650, 200,200,
                        function()
                                -- play door sound --
                                
                                Assets.playAudio("Cabinet")
                                GameState.switch(LivingRoom)
                        end, Assets.getAsset("arrow"), true))
    
     

    -- Go to backyard
    World.addEntity(Sensor(1095,249,220,400,
        function()
            --play door sound--
            
            Assets.playAudio("Cabinet")
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
    love.graphics.draw(self.background, 0 , 0)

    -- Draw base on room state
    if not roomState["atticDoor"] then
        love.graphics.draw(Assets.getAsset("kitchenAtticDoor1"), 200, 0)
    else
        love.graphics.draw(Assets.getAsset("kitchenAtticDoor2"), 200, 0)
    end

    
    if not roomState["fridge"] then
        love.graphics.draw(Assets.getAsset("kitchenFridge1"), 815, 204)
    else
        love.graphics.draw(Assets.getAsset("kitchenFridge2"), 815, 204)
    end
    if not roomState["cabinet"] then
        love.graphics.draw(Assets.getAsset("kitchencabinet1"), 450, 178)
    else
        love.graphics.draw(Assets.getAsset("kitchencabinet2"), 450, 178)
    end
    
    InventoryGUI.draw()
    World.draw() -- draw entities    
    SpeechBox.draw()

    -- DrawGrid.drawGrid()

end

return Kitchen
