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
    roomState["box"] = false

    itemsInRoom["record"] = false
end



function Attic:enter()
    if not roomState["box"] then
        -- World.addEntity(Sensor())
    end
end

function Attic:update( dt )

end

function Attic:leave(  )        
    -- remove sensors
end

function Attic:draw(  )
    love.graphics.draw(Assets.getAsset("atticBG"))

end

return Attic