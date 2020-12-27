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

    self.hintCount = 0

    
end

function Bedroom:enter(  )
    self.granimation =     Animation(430, 320, Assets.getAsset("grannyFrames"), 2, 2.5, 0.2)
    self.candleAnimation = Animation(420, 375, Assets.getAsset("candleFrames"), 4, 1000, 0.2)  
    self.candleAnimation:play()

    -- grandma FSM to own function
     World.addEntity(Sensor(651, 342, 100, 100,
                            function()
                                self:grannyFSM()
                                return true
                            end))
    -- 
    
    
    
    -- Go to living room
    World.addEntity(Sensor(0, 300, 100, 500, 
                        function()
                            -- play door sound -- 
                            GameState.switch(LivingRoom)
                        end
))

    -- Record player
    World.addEntity(Sensor(1100, 475, 100, 100,
                    function()
                       if not roomState["record"] and Inventory.getActiveItem() == "recordicon" then
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

                        return true
                    end
        ))

    --World.addEntity(Sensor)

    -- If prunes haven't been picked up, spawn prunes
    if itemsInRoom["prunes"] then
        World.addEntity(Sensor(1000, 425, 0, 0,
                        function()
                            SpeechBox.startSpeech("You obtained a cannister of prunes.")
                            Inventory.addToInventory(Item("pruneicon", Assets.getAsset("pruneicon")))
                            itemsInRoom["prunes"] = false
                            return false
                        end
            , Assets.getAsset("prune"), true))
    end

    -- 
    World.addEntity(Sensor(1050, 370, 200, 75, 
        function()
            -- hmmm sound -- 
            SpeechBox.startSpeech("Despite everything, it's still you.")
            return true
        end
    ))

end



function Bedroom:update( dt )

    self.granimation:update(dt)
    self.candleAnimation:update(dt) 

    InventoryGUI.update(dt)
    SpeechBox.update(dt)
    World.update(dt)
end

function Bedroom:draw()
    love.graphics.draw(Assets.getAsset("bedroomBG"))

    self.granimation:draw()
    self.candleAnimation:draw()


    -- record
    if not roomState["record"] then
        love.graphics.draw(Assets.getAsset("recordPlayer1"), 1100, 450)
    else
        love.graphics.draw(Assets.getAsset("recordPlayer2"), 1100, 450)
    end

    -- decorations
    if roomState["cookiesPlaced"] then
        love.graphics.draw(Assets.getAsset("cookies"), 555,515 )
    end

    if roomState["wreathPlaced"]  then
        love.graphics.draw(Assets.getAsset("deco2"), 850, 220)
    end
    
    if roomState["pillowPlaced"]  then
        love.graphics.draw(Assets.getAsset("deco1"), 255, 442)
    end
    
    if roomState["treePlaced"]  then
        love.graphics.draw(Assets.getAsset("deco3"), 131, 235)
    end

    InventoryGUI.draw()
    World.draw() -- draw entities    
    SpeechBox.draw()
    
    
    DrawGrid.drawGrid()
end

function Bedroom:leave( )
    World.clearEntities()
end

-- talks based on objectives available
-- Cookies
---- After cookies, dentures

-- Hook -> attic

-- Decorations

function Bedroom:grannyFSM()
    local rec =   Objective.getObjectiveState("Record")
    local cookie = Objective.getObjectiveState("Cookies")
    local deco   =Objective.getObjectiveState("Decorations")

    self.granimation:play()
    -- grandma voice sound
    
    --- DECORATIONS ----------
    if  not deco and self.hintCount == 0 then
        SpeechBox.startSpeech("Hello Deary, are you here to help me? Could you help find the decorations for my room? They should be in the shed.")
        self.hintCount = self.hintCount + 1

    elseif Inventory.getActiveItem() == "Key" then
        SpeechBox.startSpeech("Ah! That's the key to the shed. Good eye.")
    
    elseif not deco and self.hintCount == 1 then
        print("test")
        SpeechBox.startSpeech("Is the shed locked? I must have lost the key, Lily must have misplaced the key somewhere.")
        self.hintCount = self.hintCount + 1

    elseif not deco and self.hintCount == 2 then
        SpeechBox.startSpeech("My legs aren't as strong as they used to be...")

    -- Completed objective
    elseif not rec and not cookie and deco then
        SpeechBox.startSpeech("Thank you dearie, I love these decorations. Reminds me of my kids.")
        self.hintCount = 0
    -- END OF DECORATIONS

    -- RECORD -- no lot of hints cus I assume the player already has the item LOL 
    elseif not rec then
        SpeechBox.startSpeech("Is that you Lilly? Could you find grandma the record?")

    elseif rec and not cookie then
        SpeechBox.startSpeech("Thank you dearie, me and grandpa loved this record. We'd boogie down to the beat.")
    
    -- END OF RECORD 

    --  Cookies
    elseif not cookie and self.hintCount == 0 then
        SpeechBox.startSpeech("R-Rose? Could you make granny her favorite cookies?")
        self.hintCount = self.hintCount + 1
    
    elseif not cookie and self.hintCount == 1 then
        SpeechBox.startSpeech("The cookies recipe should be in the kitchen, I mixed some of the ingredients together, but I can't find some.")
    
    else
        SpeechBox.startSpeech("Thank you so much dearie, you made an old lady's Christmas wonderful. I don't have a lot of time left, so it means a lot to me.")
    end
    
    return true
end

return Bedroom
