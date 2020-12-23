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
--local DrawGrid = require("src.test.drawGrid") -- for drawing grid on screen to see where to place sensors


local Kitchen = {}

local kitchenState = {}

local itemsInRoom  = {}

function Kitchen:init()
-- set initial state from Kitchen to world
    self.background = Assets.getAsset("kitchenBG")
    
    kitchenState["atticDoor"] = false
    kitchenState["cabinet"]   = false
    kitchenState["fridge"]    = false

    itemsInRoom["sugar"]      = true
    itemsInRoom["rasins"]     = true
    itemsInRoom["oats"]       = true

end


function Kitchen:enter()
    -- add sensor entities
    
    World.addEntity(Sensor(500, 575 , 100, 100, function()
        SpeechBox.startSpeech('I meant," said Ipslore bitterly, "what is there in this world that truly makes living worthwhile?" Death thought about it. CATS, he said eventually. CATS ARE NICE.”' )
        Assets.getAsset("Touch"):play()
        return true
    end))



end

function Kitchen:update(dt)
    InventoryGUI.update(dt)
    SpeechBox.update(dt)
    World.update(dt)
end

function Kitchen:leave()
    -- Clear entities from the world on leaving room gamestate
    World.clearEntities()
end

function Kitchen:draw()
    camera:attach()
    love.graphics.draw(self.background, 0 , 0)

    InventoryGUI.draw()
    World.draw() -- draw entities    
    SpeechBox.draw()
    camera:detach()

    -- DrawGrid.drawGrid()
end


return Kitchen
