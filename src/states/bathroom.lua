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
-- local DrawGrid = require("src.test.drawGrid") -- for drawing grid on screen to see where to place sensors


local Bathroom = {}

local bathroomState = {}

local itemsInRoom = {}


function Bathroom:init()
    itemsInRoom["Toothbrush"]       = true
    itemsInRoom["SelfhelpCover"]    = true
    
    bathroomState.toilet     = true -- for flush animation

    bathroomState.necroPaste = false
    bathroomState.necroCover = false -- for the necronomicon puzzle 

    bathroomState.selfHelp   = false
end


function Bathroom:enter()
    -- load entities

    -- Sensor for door back to living room
    World.addEntity(Sensor(975, 400, 200, 200, function()
        Assets.getAsset("Open"):play()
        GameState.switch(LivingRoom)
        return true
    end
    ))

    -- Undertale reference lol
    World.addEntity(Sensor(800, 300, 200, 200, function()
        Assets.getAsset("Touch"):play()
        SpeechBox.startSpeech("Despite everything, it's still you.")
        return true
    end
    ))

    -- Sensor for Toilet animation
    World.addEntity(Sensor(500, 400, 100, 100, function()
        Assets.getAsset("Bloop"):play()
        SpeechBox.startSpeech("Flush!")
        bathroomState.toilet = false
        Timer.after(0.5, function() bathroomState.toilet = true end)
        return true
    end
    ))

    -- 
        World.addEntity(
            Sensor(650, 625, 100, 100, 
            function ()
            if Inventory.getActiveItem() == "Scissors" and itemsInRoom["SelfhelpCover"]   then
                SpeechBox.startSpeech("Sacrafices must be made for The Old One.")
                Assets.getAsset("Grab"):play()
                Inventory.addToInventory(Item("HelpBook", Assets.getAsset("HelpBook")))
                itemsInRoom["SelfhelpCover"] = false
                bathroomState.selfHelp = true             
            
            elseif not itemsInRoom["SelfhelpCover"] then
                SpeechBox.startSpeech("Oh mighty Rachel Hollis,\n please forgiveth me for descrating your tome.")
                Assets.getAsset("Grab"):play()
            else
                SpeechBox.startSpeech("Ah, 'Girl, Wash Your Face', truely a powerful artefact.")
                Assets.getAsset("Grab"):play()
            end

            return true
        end
        ))
    
    

    -- Sensor for door back to living room
    World.addEntity(Sensor(300, 600, 200, 200, function()  
        if Inventory.getActiveItem() == "Duck" then
            Assets.getAsset("Bloop"):play()
            SpeechBox.startSpeech("Rub-a-dub-dub, duck in a tub!")        
        else
            Assets.getAsset("Touch"):play()
            SpeechBox.startSpeech("It's a tub.")
        end

        return true
    end
    ))

    bookPuzzle() 
end


function Bathroom:update(dt)
    InventoryGUI.update(dt)
    SpeechBox.update(dt)
    World.update(dt)
end

function Bathroom:draw()
    love.graphics.draw(Assets.getAsset("BathRoomBG"), 0 , 0)
    World.draw() -- draw entities    

        
    -- draw the different states of the necronomicon
    if bathroomState.necroCover then
        love.graphics.draw(Assets.getAsset("Necro3"), 550, 625, -math.pi/8, 1, 1, Assets.getAsset("Necro1"):getWidth()/2, Assets.getAsset("Necro1"):getHeight()/2)    
    elseif bathroomState.necroPaste then
        love.graphics.draw(Assets.getAsset("Necro2"), 550, 625, -math.pi/8, 1, 1, Assets.getAsset("Necro1"):getWidth()/2, Assets.getAsset("Necro1"):getHeight()/2)
    else
        love.graphics.draw(Assets.getAsset("Necro1"), 550, 625, -math.pi/8, 1, 1, Assets.getAsset("Necro1"):getWidth()/2, Assets.getAsset("Necro1"):getHeight()/2)
    end


    if bathroomState.toilet then
        love.graphics.draw(Assets.getAsset("Toilet1"), 550, 450)
    else
        love.graphics.draw(Assets.getAsset("Toilet2"), 555, 450)
    end



    if not bathroomState.selfHelp then
        love.graphics.draw(Assets.getAsset("SelfHelpItem1"), 650, 625)
    else
        love.graphics.draw(Assets.getAsset("SelfHelpItem2"), 650, 625)
    end

    InventoryGUI.draw()
    SpeechBox.draw()
    -- DrawGrid.drawGrid()
end


function Bathroom:leave()
    World.clearEntities() 
end


function bookPuzzle() 
    World.addEntity(Sensor(400, 600, 200, 200, 
    
function()
    if (not bathroomState.necroPaste or not bathroomState.necroCover) and Inventory.getActiveItem() == "Duck" then
        SpeechBox.startSpeech('Hail to the duck, baby.')
        Assets.getAsset("Touch"):play()

    elseif not bathroomState.necroPaste and not (Inventory.getActiveItem() == "Glue") then
        SpeechBox.startSpeech('The unknowable Tome must be obscured from the unblievers.')
        Assets.getAsset("Touch"):play()

    elseif not bathroomState.necroPaste and Inventory.getActiveItem() == "Glue" then
        SpeechBox.startSpeech('"Now I just need something to cover the Tome."')
        bathroomState.necroPaste = true
        Assets.getAsset("Touch"):play()

    elseif (bathroomState.necroPaste and not bathroomState.necroCover) and not (Inventory.getActiveItem() == "HelpBook") then
        SpeechBox.startSpeech('"This does not properly cover the Tome."')
        Assets.getAsset("Touch"):play()

    elseif (bathroomState.necroPaste and not bathroomState.necroCover) and (Inventory.getActiveItem() == "HelpBook") then
        SpeechBox.startSpeech('"Now the Tome is hidden from the prying eyes of the nonbelievers."')
        Assets.getAsset("FanFare"):play()
        bathroomState.necroCover = true
        Objective.objectiveList["Book"] = true

    else
        SpeechBox.startSpeech("The nonbelievers will be none the wiser.")
        Assets.getAsset("Touch"):play()
    end

    return true
end
    ))

end



return Bathroom