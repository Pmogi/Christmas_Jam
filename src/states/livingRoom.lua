--libraries

-- Modules
local Assets = require("src/assets")
local Sensor = require("src.entities.sensor")
local SpeechBox = require("src.systems.speechbox")
local Item      = require("src.entities.item")
local Inventory    = require("src.systems.inventory")
local InventoryGUI = require("src.systems.inventoryGUI")
local World    = require("src.systems.world")
local Objective = require("src.systems.objective")
local Win  = require("src.states.win")

--local DrawGrid = require("src.test.drawGrid") -- for drawing grid on screen to see where to place sensors

local Bathroom   = require("src.states.bathroom")



local LivingRoom = {}

local itemsInRoom = {}

local roomState = {}


function LivingRoom:init()
    self.background = Assets.getAsset("LivingRoomBG")
    itemsInRoom["Eraser"]  = true
    itemsInRoom["Duck"]    = true
    itemsInRoom["Blanket"] = true
    itemsInRoom["Scissors"]= true
    
    roomState["Drawer1"] = true -- determines which state to draw
    roomState["Drawer2"] = true
    roomState["Painting"]= false -- Mustache status of yogsothoth painting
end

function LivingRoom:enter()
    -- load the entities into the scene
    
    -- sensor for couch dialog
    World.addEntity(Sensor(450, 400 , 200, 125, function()
        if Inventory.getActiveItem() == "Duck" then
            SpeechBox.startSpeech('You take a break on the couch with ducky.')
        else
            SpeechBox.startSpeech('"What a cozy looking couch..."')
        end
        
        Assets.getAsset("Touch"):play()
        return true
     end))


    -- )
    -- Sensor for context on painting and objective
    World.addEntity(Sensor(605, 215 , 125, 125, function()
        if Inventory.getActiveItem() == "Mustache" and not roomState["Painting"] then
            -- put on mustache
            Assets.getAsset("FanFare"):play()
            SpeechBox.startSpeech('Perfect!')
            Objective.objectiveList["Painting"] = true -- completed objective
            roomState["Painting"] = true
        
        elseif not roomState["Painting"] then
            SpeechBox.startSpeech('The lord must be hidden from the nonbelievers.')
        else
            SpeechBox.startSpeech('"Praise be to Y̤͙̞̻̜͜o̕g̛̠̬̰͙͎-̬͎̝̹̫͕So͇̦t̞͢ḥ̪̤̥̙̳͘a̯̖̻͈̪ṯ̝̫ͅh̜̭̤̰͎͉͡, but the cops must not know of them."')
        end
        
        Assets.getAsset("Touch"):play()
        return true end))


    -- sensor for table paper dialog
    World.addEntity(Sensor(500, 575 , 100, 100, function()
         SpeechBox.startSpeech('"Didn' .. "'t " .. 'I tell Bill to clean up?"' )
         Assets.getAsset("Touch"):play()
         return true
         end))

    -- Go to Bathroom State when clicking on left door
    World.addEntity(Sensor(0, 400 , 135, 200, function()
        --SpeechBox.startSpeech('"Door"' )
        GameState.switch(Bathroom)
        Assets.getAsset("Open"):play()
        return true
        end))


    -- Go to Basement State when clicking on right door
    World.addEntity(Sensor(800, 300 , 200, 200, function()
        --SpeechBox.startSpeech('"Door"' )
        GameState.switch(Basement)
        Assets.getAsset("Open"):play()
        return true
        end))
    
        
    -- sensor for opening drawer 1 
        World.addEntity(Sensor(220, 300 , 100, 200, function()
            Assets.getAsset("Grab"):play()
            
            -- add duck on opening drawer
            if roomState["Drawer1"] then
                roomState["Drawer1"] = false
                
                if itemsInRoom["Scissors"] then
                    World.addEntity(
                        Sensor(220, 435, 0, 0, 
                            function ()
                                SpeechBox.startSpeech("You got Scissors.")
                                Assets.getAsset("Grab"):play()
                                Inventory.addToInventory(Item("Scissors", Assets.getAsset("Scisors")))
                                itemsInRoom["Scissors"]   = false
                                return false -- this destroys the object on grab
                            end,
                    Assets.getAsset("ScissorsItem"), true))
                end
            end
        return false
        end), false, true)

    -- Clicking calender goes to the calender state
    World.addEntity(Sensor(150, 325, 100, 100, function()
        Assets.getAsset("Touch"):play()
        GameState.switch(Calender)
    return true
    end, Assets.getAsset("Calender"), true))



    -- Go to win state
    World.addEntity(Sensor(love.graphics.getWidth()-50, love.graphics.getHeight()-50, 50, 50, 
    function()
        if Objective.wonState() then
            Assets.getAsset("FanFare"):play()
            
        end
    return true
    end))



    -- sensor for opening drawer 2
    World.addEntity(Sensor(1000, 435 , 200, 150, function()
            -- SpeechBox.startSpeech("")
            Assets.getAsset("Grab"):play()
            
            -- add duck on opening drawer
            if roomState["Drawer2"] then
                roomState["Drawer2"] = false
                
                if itemsInRoom["Duck"] then
                    World.addEntity(
                        Sensor(1020, 495, 0, 0, 
                            function ()
                                SpeechBox.startSpeech("You got a duck.")
                                Assets.getAsset("Grab"):play()
                                Inventory.addToInventory(Item("Duck", Assets.getAsset("Duck")))
                                itemsInRoom["Duck"]   = false
                                return false -- this destroys the object on grab
                            end,
                    Assets.getAsset("DuckItem"), true))
                end
            end
        return false
        end), false, true)

    

    -- if eraser is in the room, add the eraser item
    if itemsInRoom["Eraser"] then
        World.addEntity(
            Sensor(450, 585, 0, 0, 
            function ()
                SpeechBox.startSpeech("You got an eraser.")
                Assets.getAsset("Grab"):play()
                Inventory.addToInventory(Item("Eraser", Assets.getAsset("Eraser")))
                itemsInRoom["Eraser"] = false
                return false -- this destroys the object on grab
            end,
            Assets.getAsset("EraserItem"), true)
        )
    end

    -- if eraser is in the room, add the eraser item
    if itemsInRoom["Blanket"] then
     World.addEntity(
        Sensor(485, 475, 0, 0, 
        function ()
            SpeechBox.startSpeech("You got a blanket.")
            Assets.getAsset("Grab"):play()
            Inventory.addToInventory(Item("Blanket", Assets.getAsset("Blanket")))
            itemsInRoom["Blanket"] = false
            return false -- this destroys the object on grab
        end,
        Assets.getAsset("BlanketItem"), true)
        )
    end
end

function LivingRoom:leave()
    World.clearEntities() 
end

function LivingRoom:update(dt)
    InventoryGUI.update(dt)
    SpeechBox.update(dt)
    World.update(dt)
end

function LivingRoom:draw()
    love.graphics.draw(self.background, 0 , 0)
    --
    love.graphics.draw(Assets.getAsset("Sofa"), 400, 410, 0, 0.75, 0.75)
    love.graphics.draw(Assets.getAsset("Table"), 425, 585, 0, 0.75, 0.75)
    
    -- toggle the image on click with sensor
    if roomState["Drawer1"] then
        love.graphics.draw(Assets.getAsset("ClosedDrawer1"), 220, 425)
    else
        love.graphics.draw(Assets.getAsset("OpenDrawer1"), 220, 425)
    end

    if roomState["Drawer2"] then
        love.graphics.draw(Assets.getAsset("ClosedDrawer2"), 975, 435 )
    else
        love.graphics.draw(Assets.getAsset("OpenDrawer2"), 975, 435 )
    end

    if roomState["Painting"] then
        love.graphics.draw(Assets.getAsset("Painting2"), 605, 215)
    else
        love.graphics.draw(Assets.getAsset("Painting1"), 605, 215)
    end
    
    if Objective.wonState() then
        love.graphics.rectangle("fill", love.graphics.getWidth()-50, love.graphics.getWidth()-50, 50, 50)
    end

    InventoryGUI.draw()
    World.draw() -- draw entities    
    SpeechBox.draw()


    -- DrawGrid.drawGrid()
    
end

return LivingRoom