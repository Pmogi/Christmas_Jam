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

        itemsInRoom["decoration"] = true
end



function Backyard:enter()
    Assets.getAsset("recordBGM"):pause()
    -- if the shed hasn't been opened yet, spawn shed puzzle
    if roomState["shed"] and itemsInRoom["decoration"] then
            spawnDecorations()
    end

    if not roomState["shed"] then
        World.addEntity(Sensor(380,260, 200,300,
                function()
                    if not roomState["shed"] and Inventory.getActiveItem() == "keyicon" then
                        -- play open sound    
                        Assets.playAudio("ShedDoor")
                        roomState["shed"] = true
                        spawnDecorations()
                        return false      
                    else
                        -- play "hmm" sound
                        Assets.playAudioRandomPitch("Hmm", 0.9, 1.1)
                        SpeechBox.startSpeech("Darn, it's locked. There's gotta be a key somewhere...")      
                    end
                    return true
                end))
    end

    
    -- just in case the player missed the decorations
        
        World.addEntity(Sensor(417,650,150,100,
            function()
                    GameState.switch(Kitchen)
            end, Assets.getAsset("arrow"), true))
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
   -- camera:attach()
    love.graphics.draw(Assets.getAsset("backyardBG"))
    
    
    if not roomState["shed"] then
        love.graphics.draw(Assets.getAsset("backyardShed1"), 310, 300)
    else
        love.graphics.draw(Assets.getAsset("backyardShed2"), 310, 300)
    end

    
    
    InventoryGUI.draw()
    World.draw() -- draw entities
    SpeechBox.draw()
   -- camera:detach()
    -- DrawGrid.drawGrid()

end

function spawnDecorations()
    World.addEntity(Sensor(401, 520, 0, 0, 
                    function()
                        -- rustle/grab sound effect
                        Assets.playAudioRandomPitch("Grab", 0.9, 1.1)
                        SpeechBox.startSpeech("You grab a bunch of christmas decorations.")
                        Inventory.addToInventory(Item("decorationicon", Assets.getAsset("decorationicon")))
                        itemsInRoom["decoration"] = false
                    end,
                    Assets.getAsset("decoration"), true))
end

return Backyard
