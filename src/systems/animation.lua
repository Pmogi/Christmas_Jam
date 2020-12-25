-- Libaries
local Timer     = require("lib.timer")
local Object = require("lib.classic")

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

local Animation = Object:extend()

local Animation:new( x, y, imgTable, numOfFrames , playtime )
    
    self.x = x or 0
    self.y = y or 0
    self.imgTable = imgTable
    self.playtime = playtime or 0.1
    self.play     = false
    

    self.frame       = 1
    self.numOfFrames = numOfFrames
end

local Animation:draw()
    -- 

    if self.play then
        
    end
end

local Animation:play()
    self.play = true
    self.
end

return Animation