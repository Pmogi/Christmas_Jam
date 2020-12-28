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

    self.currentPuzzle = "Decorations"
    self.hintCount = 0
    self.decoCount = 0

    
end

function Bedroom:enter(  )
    self.granimation =     Animation(430, 320, Assets.getAsset("grannyFrames"), 2, 2.5, 0.2)
    self.candleAnimation = Animation(420, 375, Assets.getAsset("candleFrames"), 4, 1000, 0.2)  
    self.candleAnimation:play()

    -- grandma FSM to own function
     World.addEntity(Sensor(651, 342, 100, 100,
                            function()
                                if Inventory.getActiveItem() == "cookiesicon" then
                                        SpeechBox.startSpeech("Ohhh, Raisin Oatmeal and Prune cookies! These were my favorite cookies growing up.")
                                        Assets.playAudio("GrannyLaugh")
                                        self.granimation:play()
                                        Inventory.removeItem("cookiesicon")
                                        Inventory.removeItem("cookiesiconglow")
                                        Inventory.removeActiveItem()
                                        roomState["cookiesPlaced"] = true
                                        Objective.completeObjective("Cookies")
                                else
                                        self:grannyFSM()
                                end
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
                            SpeechBox.startSpeech("Ahhh, they used to play this song when I met my husband. Did I ever tell you that Rose?", 4)
                            -- granny talk sound
                            Assets.playAudio("GrannyRelief")
                            self.granimation:play()
                            Objective.completeObjective("Record") -- completed record objective
                            
                            Assets.getAsset("mainBGM"):pause()
                            Assets.getAsset("recordBGM"):play()
                            
                            -- use up the item
                            Inventory.removeItem("recordicon")
                            Inventory.removeItem("recordiconglow")
                            Inventory.removeActiveItem("recordicon")

                            -- start music in room
                            roomState["record"] = true
                        
                        elseif not roomState["record"] then
                            -- play hmmm sound
                            Assets.playAudioRandomPitch("Hmm", 0.9, 1.1)
                            SpeechBox.startSpeech("I wonder if there's a record I can play on this...")
                        else
                            -- granny talk sound
                            Assets.playAudioRandomPitch("GrannyRelief", 0.9, 1.1)
                            self.granimation:play()
                            SpeechBox.startSpeech("Do you remember this song Rose?")
                        end

                        return true
                    end
        ))
    
    -- World.addEntity(Sensor())
    --World.addEntity(Sensor)

    -- If prunes haven't been picked up, spawn prunes
    if itemsInRoom["prunes"] then
        World.addEntity(Sensor(1000, 425, 0, 0,
                        function()
                            -- granny voice
                            Assets.playAudio("GrannyStartled")
                            Assets.playAudioRandomPitch("Grab", 0.9, 1.1)
                            SpeechBox.startSpeech("W-Why are you taking my prunes?")
                            self.granimation:play()
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
            Assets.playAudioRandomPitch("Hmm", 0.9, 1.1)
            SpeechBox.startSpeech("Despite everything, it's still you.")
            return true
        end
    ))

    -- deco wreath
    World.addEntity(Sensor(805, 215, 200, 75, 
    function()
        if not roomState["wreathPlaced"] and Inventory.getActiveItem() == "decorationicon" then
            roomState["wreathPlaced"] = true
            self.decoCount = self.decoCount + 1
            Assets.playAudio("GrannySurprise")
            self.granimation:play()
            SpeechBox.startSpeech("What a lovely wreath, we'd put this out on the front porch.")
            
        elseif roomState["wreathPlaced"] then
            -- grannnoise
            Assets.playAudio("GrannyRelief")
            self.granimation:play()
            SpeechBox.startSpeech("What a lovely wreath, we'd put this out on the front porch.")
        else
            -- Granny sound -- 
            self.granimation:play()
            Assets.playAudio("GrannySurprise")
            SpeechBox.startSpeech("I'd love to hang something there.")
        end

        if self.decoCount == 3 then
                self.granimation:play()
                Assets.playAudio("GrannyRelief")
                SpeechBox.startSpeech("Oh my, my room looks so festive now! T-t-hank you, Rose.")
                Inventory.removeActiveItem()
                Inventory.removeItem("decorationicon")
                Inventory.removeItem("decorationiconglow")
                Objective.completeObjective("Decorations")
                return false
        end
        return true
    end
))

    -- deco pillow
World.addEntity(Sensor(275, 439, 100, 75, 
    function()
        
        if not roomState["pillowPlaced"] and Inventory.getActiveItem() == "decorationicon" then
            roomState["pillowPlaced"] = true
            self.decoCount = self.decoCount + 1
            Assets.playAudio("GrannySurprise")
            self.granimation:play()
            SpeechBox.startSpeech("oh my jolly pillow! every winter, herby would take a nap on that couch hugging this pillow...")

        elseif roomState["pillowPlaced"] then
            self.granimation:play()
            Assets.playAudio("GrannyRelief")
            SpeechBox.startSpeech("oh my jolly pillow! every winter, herby would take a nap on that couch hugging this pillow...")
        else
            -- Granny sound -- 
            self.granimation:play()
            Assets.playAudio("GrannySurprise")
            SpeechBox.startSpeech("I'd love my jolly pillow to be over there...")
        end
        
        if self.decoCount == 3 then
                self.granimation:play()
                Assets.playAudio("GrannyRelief")
                SpeechBox.startSpeech("Oh my, my room looks so festive now! T-t-hank you, Rose.")
                Inventory.removeActiveItem()
                Inventory.removeItem("decorationicon")
                Inventory.removeItem("decorationiconglow")
                Objective.completeObjective("Decorations")
                return false
        end
        return true
    end
))

    -- deco tree
World.addEntity(Sensor(158, 615, 100, 200, 
    function()
        if not roomState["treePlaced"] and Inventory.getActiveItem() == "decorationicon" then
            roomState["treePlaced"] = true
            self.decoCount = self.decoCount + 1
            self.granimation:play()
            Assets.playAudio("GrannyRelief")
            SpeechBox.startSpeech("mmmm, I love the smell of pine trees...")

        elseif roomState["treePlaced"] then
            self.granimation:play()
            Assets.playAudio("GrannyRelief")
            SpeechBox.startSpeech("mmmm, I love the smell of pine trees...")

        else
        -- Granny sound -- 
        self.granimation:play()
        Assets.playAudio("GrannySurprise")
        SpeechBox.startSpeech("Could the christmas tree be over here?")
        
        end

        if self.decoCount == 3 then
                self.granimation:play()
                Assets.playAudio("GrannyRelief")
                SpeechBox.startSpeech("Oh my, my room looks so festive now! T-t-hank you, Rose.")
                Inventory.removeActiveItem()
                Inventory.removeItem("decorationicon")
                Inventory.removeItem("decorationiconglow")
                Objective.completeObjective("Decorations")
                return false
        end
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
    else
        love.graphics.setColor(0.50, 0.50, 0.0, 0.25)
        love.graphics.circle("fill", 850, 220, 20)
        love.graphics.setColor(1, 1, 1)

    end
    
    if roomState["pillowPlaced"]  then
        
        love.graphics.draw(Assets.getAsset("deco1"), 255, 442)

    else
        love.graphics.setColor(0.50, 0.50, 0.0, 0.25)
        love.graphics.circle("fill", 297, 460, 10)
        love.graphics.setColor(1, 1, 1)

    end
    
    if roomState["treePlaced"]  then
        love.graphics.draw(Assets.getAsset("deco3"), 131, 235)
    else
        love.graphics.setColor(0.50, 0.50, 0.0, 0.25)
        love.graphics.circle("fill", 250, 630, 10)
        love.graphics.setColor(1, 1, 1)

    end


    InventoryGUI.draw()
    World.draw() -- draw entities    
    SpeechBox.draw()
    
    
    DrawGrid.drawGrid()
end

function Bedroom:leave( )
    Assets.getAsset("mainBGM"):play()
    Assets.getAsset("recordBGM"):stop()
    World.clearEntities()
end

-- talks based on objectives available
-- Cookies
---- After cookies, dentures

-- Hook -> attic

-- Decorations

function Bedroom:grannyFSM()
    local rec    = Objective.getObjectiveState("Record")
    local cookie = Objective.getObjectiveState("Cookies")
    local deco   = Objective.getObjectiveState("Decorations")

    self.granimation:play()
    -- grandma voice sound
    Assets.playAudio("GrannyRelief")
    
    --- DECORATIONS ----------
    if self.currentPuzzle == "Decorations" then
        if deco then
            SpeechBox.startSpeech("Thank you dearie, I love these decorations. Reminds me of my kids.")
            self.currentPuzzle = "Record"
            self.hintCount = 0

        elseif  not deco and self.hintCount == 0 then
            SpeechBox.startSpeech("Hello Deary, are you here to help me? Could you help find the decorations for my room? They should be in the shed.", 3)
            self.hintCount = self.hintCount + 1

        elseif Inventory.getActiveItem() == "Key" then
            SpeechBox.startSpeech("Ah! That's the key to the shed. Good eye.")
    
        elseif not deco and self.hintCount == 1 then
            SpeechBox.startSpeech("Is the shed locked? I must have lost the key, Lily must have misplaced the key somewhere.", 4)
            self.hintCount = self.hintCount + 1

        elseif not deco and self.hintCount == 2 then
            SpeechBox.startSpeech("My legs aren't as strong as they used to be...")
    
        elseif not deco and self.decoCount == 3 then
            SpeechBox.startSpeech("L-Lilly thank you for decorating my room. It looks wonderful.")
        end
    end
    -- END OF DECORATIONS

    -- RECORD -- no lot of hints cus I assume the player already has the item LOL 
    if self.currentPuzzle == "Record" then
        if Inventory.getActiveItem() == "recordicon" then
            SpeechBox.startSpeech("That's the record! Thank you Lily.")
    
        elseif not rec then
            SpeechBox.startSpeech("Is that you Lilly? Could you find grandma her favorite record?")

        else
            SpeechBox.startSpeech("Thank you dearie, me and grandpa loved this record. We'd boogie down to the beat.")
            self.currentPuzzle = "Cookies"
        end
    end
    -- END OF RECORD 

    --  Cookies
    if self.currentPuzzle == "Cookies" then
        if not cookie and self.hintCount == 0 then
            SpeechBox.startSpeech("R-Rose? Could you make granny her favorite cookies?")
            self.hintCount = self.hintCount + 1
    
        elseif not cookie and self.hintCount == 1 then
            SpeechBox.startSpeech("The cookies recipe should be in the kitchen, I mixed some of the ingredients together, but I can't find some.", 5)
    
        elseif cookie and not Inventory.getActiveItem() == "dentureicon" then
            SpeechBox.startSpeech("Thanks Rose, but I can't eat these anymore without my teeth. I forgot where I put them...")
        elseif cookie and not Inventory.getActiveItem() == "dentureicon" then
            SpeechBox.startSpeech("Thank you so much dearie, you made an old lady's Christmas wonderful. I don't have a lot of time left, so it means a lot to me.", 20)
        end
    end

end

return Bedroom
