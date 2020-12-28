-- Libaries
local Timer     = require("lib.timer")
local Object    = require("lib.classic")

-- Modules
-- local DrawGrid = require("src.test.drawGrid") -- for drawing grid on screen to see where to place sensors

local Animation = Object:extend()

-- Animation Manager
-- Given a position (x, y) and a table of image frames,
-- iterate through the frames in steps of 0.2 seconds for (playtime) seconds.
function Animation:new( x, y, imgTable, numOfFrames, playtime, timestep)
    
    self.x = x or 0
    self.y = y or 0
    self.imgTable = imgTable

    self.time     = 0 -- for running timer
    self.timeStep = timestep or 0.2
    self.playtime = playtime
    self.playing     = false
    

    self.frame       = 0
    self.numOfFrames = numOfFrames
end

function Animation:draw()
    -- 
    if self.playing then
        love.graphics.draw(self.imgTable[self.frame+1], self.x, self.y)
    else
        love.graphics.draw(self.imgTable[#self.imgTable], self.x, self.y)
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
        self.frame = math.fmod(self.frame, self.numOfFrames)
        self.time = 0
    end
end

return Animation