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

local granimation = Animation(400, 300, Assets.getAsset("grannyFrames"), 2, 2.5)

function Bedroom:init()
    roomState["cookiesPlaced"] = false
    roomState["wreathPlaced"]  = false
    roomState["pillowPlaced"]  = false
    roomState["treePlaced"]    = false
    roomState["record"]        = false

    itemsInRoom["prune"] = true


end

function Bedroom:enter(  )
    -- animation manager for granny
    
    
    -- add entities


end

function Bedroom:update( dt )
    if (love.keyboard.isDown('g')) then
        granimation:play()
    end

    granimation:update(dt)
end

function Bedroom:draw( )
    love.graphics.draw(Assets.getAsset("bedroomBG"))

    granimation:draw()

    -- DrawGrid.drawGrid()
end

function Bedroom:leave( )
    World.clearEntities()
end

return Bedroom