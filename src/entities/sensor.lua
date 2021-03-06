-- An entity that responds to being clicked on 

-- lib 
local Object    = require("lib.classic")
local Timer     = require("lib.timer")


local Sensor = Object:extend()
local activateCoolDown = false


function Sensor:new(x, y, w, h, func, img, drawable)
    self.img = img or nil -- image is not required, for item pick ups
    self.x = x
    self.y = y
    self.mouseHover = false
    
    -- if there's an image, use the width and height of that instead
    if img then
        self.w = self.img:getWidth()
        self.h = self.img:getHeight()
    else    
        self.w = w 
        self.h = h
    end

    -- used to determine if sensor is to be destroyed on next world update
    self.alive = true
    self.drawable = drawable

    -- passed a function pointer to call when clicked on
    self.attatchedFunction = func 
end

function Sensor:draw()
    if self.img then
        love.graphics.draw(self.img, self.x, self.y)
    else
        love.graphics.rectangle('fill', self.x, self.y, self.w, self.h)
    end
end

function Sensor:update( dt )
    local xPos = love.mouse.getX()
    local yPos = love.mouse.getY()

    if (xPos > self.x) and (xPos < self.x + self.w) and (yPos > self.y) and (yPos < self.y + self.h) then
        -- NOTE!!!!!:
        -- FUNKY, but it's how I remove sensors in the world.
        -- If attached function returns true, it persists through a user click.
        -- otherwise, alive is set to false, and the sensor gets cleaned by garbo collector in World.
           
            if love.mouse.isDown(1) and not activateCoolDown then
                    self.alive = self.attatchedFunction()
                    
                    -- one touch, delay next by a half second
                    activateCoolDown = true
                    Timer.after(0.5, function() activateCoolDown = false end)
            else
                    love.mouse.setCursor(cursorHighlighted)
                    self.mouseHover = true
            end
    else if self.mouseHover then
            love.mouse.setCursor(cursorNormal)
            self.mouseHover = false
            end
    end
 end
return Sensor
