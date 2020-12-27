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


local Backyard = {}

roomState = {}
itemsInRoom = {}

function Backyard:init()
        roomState["shed"] = false
end



function Backyard:enter()
        World.addEntity(Sensor(324,250, 400,300,
            function()
                    if not roomState["shed"] and Inventory.getActiveItem() == "keyicon" then
                            roomState["shed"] = true
                            -- play open sound
                    else
                            -- play "hmm" sound
                            SpeechBox.startSpeech("Darn, it's locked. There's gotta be a key somewhere...")      
                    end
                            return true
                    end))
        
        World.addEntity(Sensor(417,680,150,100,
            function()
                    GameState.switch(Kitchen)
            end))
end

function Backyard:update( dt )
        InventoryGUI.update(dt)
        SpeechBox.update(dt)
        World.update(dt)

end

function Backyard:leave()        
    -- remove sensors
    World.clearEntities()
end

function Backyard:draw( )
    camera:attach()
    love.graphics.draw(Assets.getAsset("backyardBG"))
    DrawGrid.drawGrid()
    if not roomState["shed"] then
        love.graphics.draw(Assets.getAsset("backyardShed1"), 270, 250)
    else
        love.graphics.draw(Assets.getAsset("backyardShed2"), 270, 250)
    end
    InventoryGUI.draw()
    World.draw() -- draw entities
    SpeechBox.draw()
    camera:detach()
end

return Backyard
