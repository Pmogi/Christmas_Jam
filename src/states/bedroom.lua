-- Modules
local Assets = require("src/assets")
local Sensor = require("src.entities.sensor")
local SpeechBox = require("src.systems.speechbox")
local Item      = require("src.entities.item")
local Inventory    = require("src.systems.inventory")
local InventoryGUI = require("src.systems.inventoryGUI")
local World    = require("src.systems.world")
local Objective = require("src.systems.objective")

local Animation = require("src.systems.animation")
local DrawGrid = require("src.test.drawGrid") -- for drawing grid on screen to see where to place sensors


local Bedroom = {}

local roomState = {}
local itemsInRoom = {}

 

function Bedroom:init()
    roomState["cookiesPlaced"] = false
    roomState["wreathPlaced"]  = false
    roomState["pillowPlaced"]  = false
    roomState["treePlaced"]    = false
    roomState["record"]        = false

    itemsInRoom["prunes"] = true

    
end

function Bedroom:enter(  )
    self.granimation =     Animation(400, 300, Assets.getAsset("grannyFrames"), 2, 2.5, 0.2)
    self.candleAnimation = Animation(420, 370, Assets.getAsset("candleFrames"), 4, 1000, 0.2)  
    self.candleAnimation:play()

    -- grandma FSM to own function

    -- 
    
    
    
    -- Go to living room
    World.addEntity(Sensor(0, 300, 100, 500, 
                        function()
                            -- play door sound -- 
                            GameState.switch(LivingRoom)
                        end
))

    -- Record player
    World.addEntity(Sensor(1100, 450, 100, 100,
                    function()
                       if not roomState["record"] and Inventory.getActiveItem() == "Record" then
                            SpeechBox.startSpeech("Granny: Ahhh, they used to play this song when I met my husband. Did I ever tell you that Rose?")
                            -- granny talk sound
                            self.granimation:play()
                            -- start music in room
                            roomState["record"] = true
                        
                        elseif not roomState["record"] then
                            -- play hmmm sound
                            SpeechBox.startSpeech("I wonder if there's a record I can play on this...")
                        else
                            -- granny talk sound
                            self.granimation:play()
                            SpeechBox.startSpeech("Granny: Do you remember this song Rose?")
                        end
                    end
        ))

    --World.addEntity(Sensor)

    -- If prunes haven't been picked up, spawn prunes
    if itemsInRoom["prunes"] then
        World.addEntity(Sensor(1000, 400, 0, 0,
                        function()
                            SpeechBox.startSpeech("You obtained a cannister of prunes.")
                            Inventory.addToInventory(Item("prune", Assets.getAsset("Prunes")))
                            itemsInRoom["prunes"] = false
                            return false
                        end
            , Assets.getAsset("prune"), true))
    end

    -- 
    World.addEntity(Sensor(1030, 300, 200, 100, 
        function()
            -- hmmm sound -- 
            SpeechBox.startSpeech("Despite everything, it's still you.")
            return true
        end
    ))

end



function Bedroom:update( dt )
    if (love.keyboard.isDown('g')) then
        self.granimation:play()
    end

    self.granimation:update(dt)
    self.candleAnimation:update(dt) 

    InventoryGUI.update(dt)
    SpeechBox.update(dt)
    World.update(dt)
end

function Bedroom:draw( )
    love.graphics.draw(Assets.getAsset("bedroomBG"))

    self.granimation:draw()
    self.candleAnimation:draw()


    -- record
    if not roomState["record"] then
        love.graphics.draw(Assets.getAsset("recordPlayer1"), 1100, 425)
    else
        love.graphics.draw(Assets.getAsset("recordPlayer2"), 1100, 425)
    end

    -- decorations





    InventoryGUI.draw()
    World.draw() -- draw entities    
    SpeechBox.draw()
    
    
    DrawGrid.drawGrid()
end

function Bedroom:leave( )
    World.clearEntities()
end

-- talks based on objectives available
function grannyFSM()

end

return Bedroom
