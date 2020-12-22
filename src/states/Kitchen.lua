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
-- local DrawGrid = require("src.test.drawGrid") -- for drawing grid on screen to see where to place sensors


local Kitchen = {}

local kitchenState = {}

local itemsInRoom  = {}

function Kitchen:init()
-- set initial state from Kitchen to world
    self.background = Assets.getAsset("kitchenBG")



end


function Kitchen:enter()
-- add sensor entities


end

function Kitchen:update(dt)

end

function Kitchen:leave()
-- Clear entities from the world on leaving

end

function Kitchen:draw()
    camera:attach()
    love.graphics.draw(self.background, 0 , 0)

    camera:detach()
end


return Kitchen