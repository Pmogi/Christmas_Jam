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


local Attic = {}

roomState = {}
itemsInRoom = {}

function Attic:init()
    roomState["recordBox"] = false

    itemsInRoom["record"] = true
    itemsInRoom["key"] = true
end



function Attic:enter()
        Assets.getAsset("recordBGM"):pause()

        local addRecord = function()
                World.addEntity(Sensor(550,490,50,50,
                        function()
                                Assets.playAudio("Grab")
                                SpeechBox.startSpeech("You obtained a record of 'Barry White Sings For Someone You Love'. There's also a note scribbled onto the back of the case that says, 'Merry Christmas my Magnolia, I will love you forever'.", 4)
                                Inventory.addToInventory(Item("recordicon", Assets.getAsset("recordicon")))
                                itemsInRoom["record"] = false
                                return false
                        end, Assets.getAsset("record"), true))
        end
        World.addEntity(Sensor(490,535,300,200,
            function()
                    if not roomState["recordBox"] then
                            roomState["recordBox"] = true
                            -- play open sound
                            Assets.playAudio("Box")
                            addRecord()
                        end 
                        return false
                end), false,false)
        if roomState["recordBox"] and itemsInRoom["record"] then
                addRecord()
        end
        
    if itemsInRoom["key"] then
        World.addEntity(Sensor(200,580,50,50,
            function()
                    Assets.playAudio("Grab")
                    SpeechBox.startSpeech("You obtained a key.", 1)
                    Inventory.addToInventory(Item("keyicon", Assets.getAsset("keyicon")))
                    itemsInRoom["key"] = false
                    return false
            end, Assets.getAsset("key"), true))
    end

        -- go to kitchen
        World.addEntity(Sensor(763,470,300,100,
            function()
                    GameState.switch(Kitchen)
            end))
    end


function Attic:update(dt)
        InventoryGUI.update(dt)
        SpeechBox.update(dt)
        World.update(dt)

end

function Attic:leave()        
    -- remove sensors
    World.clearEntities()
end

function Attic:draw(  )
       
    love.graphics.draw(Assets.getAsset("atticBG"))

    if not roomState["recordBox"] then
            love.graphics.draw(Assets.getAsset("atticRecordBox1"),460,460)
    else
            love.graphics.draw(Assets.getAsset("atticRecordBox2"),460,460)
    end

    InventoryGUI.draw()
    World.draw() -- draw entities
    SpeechBox.draw()
    

    DrawGrid.drawGrid()
end

return Attic
