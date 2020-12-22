local Assets = require("src/assets")
local Inventory    = require("src.systems.inventory")
local InventoryGUI = require("src.systems.inventoryGUI")
local LivingRoom = require("src.states.livingRoom")
local Sensor = require("src.entities.sensor")
local SpeechBox = require("src.systems.speechbox")
local Objective = require("src.systems.objective")



-- local DrawGrid = require("src.test.drawGrid") -- for drawing grid on screen to see where to place sensors

local World    = require("src.systems.world")


Calender = {}

calenderState = {}

function Calender:init()
    calenderState["bloodRitual"] = true
end

function Calender:enter()
    -- Objective to remove blood ritual on calender
    World.addEntity(Sensor(800, 600 , 200, 125, function()
        if Inventory.getActiveItem() == "Eraser" then
            Assets.getAsset("FanFare"):play()
            calenderState["bloodRitual"] = false
            Objective.objectiveList["Calender"] = true
            
            SpeechBox.startSpeech('Perfect, now the nonbelievers will never know.')
            return false
        else
            Assets.getAsset("Touch"):play()
            SpeechBox.startSpeech("It's probably not good to have BLOOD RITUAL on here...")
            return true
        end

    end
    ))

    -- Bill Birthday click
    World.addEntity(Sensor(500, 500 , 100, 100, function()
            Assets.getAsset("Touch"):play()
            SpeechBox.startSpeech("Bill's birthday was delightful.")
            return true
    end
    ))

    -- Go back to the living room
    World.addEntity(Sensor(300, 600 , 100, 100, function()
        Assets.getAsset("Touch"):play()
        GameState.switch(LivingRoom)
        return true
end
))


    -- Click on weird dog
    World.addEntity(Sensor(300, 0 , 400, 400, function()
        Assets.getAsset("Touch"):play()
        SpeechBox.startSpeech("What a good puppy.")
        return true
    
    end
    ))

end

function Calender:draw()
    love.graphics.draw(Assets.getAsset("LivingRoomBG"), 0 , 0, 0,  5, 5)
    
    if calenderState["bloodRitual"] then
        love.graphics.draw(Assets.getAsset("CalenderRoom1"), love.graphics.getWidth()/4)
    else
        love.graphics.draw(Assets.getAsset("CalenderRoom2"), love.graphics.getWidth()/4)
    end

    InventoryGUI.draw()
    World.draw() -- draw entities    
    SpeechBox.draw()

end

function Calender:update(dt)
    InventoryGUI.update(dt)
    SpeechBox.update(dt)
    World.update(dt)

    -- for now rpess space to leave calendar
    if (love.keyboard.isDown('space')) then
        GameState.switch(LivingRoom)
    end
end

function Calender:leave()
    World.clearEntities() 
end

return Calender