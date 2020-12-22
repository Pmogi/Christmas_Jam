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

-- local DrawGrid = require("src.test.drawGrid") -- for drawing grid on screen to see where to place sensors
local Objective = require("src.systems.objective")

local Basement = {}

local itemsInRoom = {}

local basementState = {}

function Basement:init() 
    itemsInRoom["Mustache"] = true
    itemsInRoom["Glue"]     = true
    
    basementState.billCovered = false
    basementState.billX = 250
    basementState.billY = 295

    -- Timer nonsense to make Bill float
    Timer.every(1, 
        function()
            Timer.tween(0.5, basementState, {billY = 290})
            Timer.after(0.5, function() Timer.tween(1, basementState, {billY = 295}) end)
        end
        )
            

end

function Basement:enter()
    -- Sensor for door back to living room
    World.addEntity(Sensor(900, 200, 100, 200, function()
        Assets.getAsset("Open"):play()
        GameState.switch(LivingRoom)
        return true
    end
    ))

    -- Messy clothes
    World.addEntity(Sensor(700, 600, 100, 100, function()
        Assets.getAsset("Touch"):play()
        --Inventory.addToInventory(Item("Glue", Assets.getAsset("Glue")))
        -- itemsInRoom["Glue"] = false
        SpeechBox.startSpeech("Again, I thought I told Bill to clean up...")
        return true
    end, Assets.getAsset("Clothes"), true))



    if itemsInRoom["Glue"] then
    -- Get the glue
        World.addEntity(Sensor(1000, 500, 100, 100, function()
            Assets.getAsset("Touch"):play()
            Inventory.addToInventory(Item("Glue", Assets.getAsset("Glue")))
            itemsInRoom["Glue"] = false
            SpeechBox.startSpeech("You got some glue.")

            return false
        end
        , Assets.getAsset("GlueItem"), true))

    end
    
    if itemsInRoom["Mustache"] then
        World.addEntity(Sensor(1010, 565, 100, 100, function()
            Assets.getAsset("Touch"):play()
            Inventory.addToInventory(Item("Mustache", Assets.getAsset("Mustache")))
            itemsInRoom["Mustache"] = false
            SpeechBox.startSpeech("You got a dandy mustache.")

            return false
        end
        , Assets.getAsset("MustacheItem"), true))

    end

        World.addEntity(Sensor(1000, 500, 100, 100, function()
            Assets.getAsset("Touch"):play()
            SpeechBox.startSpeech('The cult' .. "'"..'s art and craft table is looking wonderful.')

            return true
        end
        ))
    


    -- It's Bill!
    World.addEntity(Sensor(250, 295, 100, 200, function()
        
        if Inventory.getActiveItem() == nil and not basementState.billCovered then
            SpeechBox.startSpeech("Oh! it's Bill. He can't be seen like this.")
            Assets.getAsset("Touch"):play()

        elseif basementState.billCovered then
            SpeechBox.startSpeech('"The perfect disguise..."')
            Assets.getAsset("Touch"):play()
        
        elseif Inventory.getActiveItem() == "Duck" then
            SpeechBox.startSpeech("You offer Bill a duck in these trying times.\nHe cannot accept the Duck.")
            Assets.getAsset("Touch"):play()
            
        elseif not Inventory.getActiveItem() == "Blanket" then
            SpeechBox.startSpeech("I don't think that will conceal Bill.")
            Assets.getAsset("Touch"):play()

        elseif Inventory.getActiveItem() == "Blanket" then
            SpeechBox.startSpeech("Now the unbelievers not know of Bill.")
            basementState.billCovered = true
            Objective.objectiveList["Bill"] = true -- completed objective
            Assets.getAsset("FanFare"):play()
        else
            SpeechBox.startSpeech("I don't think that'll cover Bill...")
            Assets.getAsset("Touch"):play()
        end
        return true
    end
    ))
end

function Basement:update(dt)
    InventoryGUI.update(dt)
    SpeechBox.update(dt)
    World.update(dt)
    
end

function Basement:draw()
    love.graphics.draw(Assets.getAsset("BasementBG"))

    -- Draw Bill
    if basementState.billCovered then
        love.graphics.draw(Assets.getAsset("Bill2"), basementState.billX, basementState.billY)
    else
        love.graphics.draw(Assets.getAsset("Bill1"), basementState.billX, basementState.billY)
    end

    InventoryGUI.draw()
    World.draw() -- draws entities
    SpeechBox.draw()
    -- DrawGrid.drawGrid()
    
end

function Basement:leave()
    World.clearEntities()
end

return Basement