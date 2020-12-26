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

local Animation = require("src.systems.animation")


local Bedroom = {}

local roomState = {}
local itemsInRoom = {}

 

function Bedroom:init()
    roomState["cookiesPlaced"] = false
    roomState["wreathPlaced"]  = false
    roomState["pillowPlaced"]  = false
    roomState["treePlaced"]    = false
    roomState["record"]        = false

    itemsInRoom["prune"] = true

    
end

function Bedroom:enter(  )
    self.granimation =     Animation(400, 300, Assets.getAsset("grannyFrames"), 2, 2.5, 0.2)
    self.candleAnimation = Animation(420, 370, Assets.getAsset("candleFrames"), 4, 1000, 0.2)
    
    self.candleAnimation:play()
    
    
    -- add entities

    -- grandma FSM to own function

    -- 
    
    
    
    -- Go to living room
    World.addEntity(Sensor(0, 300, 100, 500, 
                        function()
                            -- play door sound -- 
                            GameState.switch(LivingRoom)
                        end
))



end

function Bedroom:update( dt )
    if (love.keyboard.isDown('g')) then
        self.granimation:play()
    end

    self.granimation:update(dt)
    self.candleAnimation:update(dt) 
end

function Bedroom:draw( )
    love.graphics.draw(Assets.getAsset("bedroomBG"))

    self.granimation:draw()
    self.candleAnimation:draw()

    DrawGrid.drawGrid()
end

function Bedroom:leave( )
    World.clearEntities()
end

return Bedroom