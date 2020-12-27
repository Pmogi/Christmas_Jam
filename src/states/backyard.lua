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
        roomState["shed"] = true

        itemsInRoom["decoration"] = true
end



function Backyard:enter()
    -- if the shed hasn't been opened yet, spawn shed puzzle
    if not roomState["shed"] then
        World.addEntity(Sensor(324,250, 400,300,
                function()
                    if not roomState["shed"] and Inventory.getActiveItem() == "keyicon" then
                        -- play open sound    
                        roomState["shed"] = true
                        spawnDecorations()
                        return false      
                    else
                        -- play "hmm" sound
                        SpeechBox.startSpeech("Darn, it's locked. There's gotta be a key somewhere...")      
                    end
                    return true
                end))
    end

    
    -- just in case the player missed the decorations
    if itemsInRoom["decoration"] and roomState["shed"] then
        spawnDecorations()
    end
        
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
    
    
    if not roomState["shed"] then
        love.graphics.draw(Assets.getAsset("backyardShed1"), 270, 250)
    else
        love.graphics.draw(Assets.getAsset("backyardShed2"), 270, 250)
    end

    
    
    InventoryGUI.draw()
    World.draw() -- draw entities
    SpeechBox.draw()
    camera:detach()
    DrawGrid.drawGrid()

end

function spawnDecorations()
    print("hello")
    World.addEntity(Sensor(401, 425, 0, 0, 
                    function()
                        Inventory.addToInventory(Item("decorationicon", Assets.getAsset("decorationicon")))
                    end,
                    Assets.getAsset("decoration"), true))
end

return Backyard
