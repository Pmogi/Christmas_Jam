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
-- local DrawGrid = require("src.test.drawGrid") -- for drawing grid on screen to see where to place sensors

local Animation = Object:extend()

-- Animation Manager
-- Given a position (x, y) and a table of image frames,
-- iterate through the frames in steps of 0.2 seconds for (playtime) seconds.
function Animation:new( x, y, imgTable, numOfFrames , playtime)
    
    self.x = x or 0
    self.y = y or 0
    self.imgTable = imgTable

    self.time     = 0 -- for running timer
    self.timeStep = 0.2
    self.playtime = playtime
    self.playing     = false
    

    self.frame       = 1
    self.numOfFrames = numOfFrames
end

function Animation:draw()
    -- 
    if self.playing then
        print(self.frame)
        love.graphics.draw(self.imgTable[self.frame], self.x, self.y)
    else
        love.graphics.draw(self.imgTable[1], self.x, self.y)
    end
end

function Animation:play()
    self.playing = true
    self.time = 0
    Timer.after(self.playtime, function() self.playing = false end)
end

function Animation:update(dt)
    self.time = self.time + dt

    if self.time > self.timeStep and self.playing then
        self.frame = self.frame + 1
        self.frame = math.fmod(self.frame+1, self.numOfFrames) + 1
        self.time = 0
    end
end

return Animation