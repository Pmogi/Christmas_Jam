-- Libaries
local Timer     = require("lib.timer")

-- Modules
local Assets = require("src/assets")
local Sensor = require("src.entities.sensor")
-- local SpeechBox = require("src.systems.speechbox")
local World    = require("src.systems.world")
local Objective = require("src.systems.objective")
-- local DrawGrid = require("src.test.drawGrid") -- for drawing grid on screen to see where to place sensors

local Cutscene = {}


function Cutscene:enter(  )
    if not self.currentScene then
        -- love.graphics.print("No cutscene loaded.", love.window.width()/2, love.window.height()/2)
        while true do 
            print("error: No cutscene loaded")
        end
        )
    end

    self.currentLetter = 0
    self.timer = 0
    self.timePerLetter = 0.5
    Timer.after(self.timePerLetter * self.scene:getText().len(),
                    function ()
                        -- spawn CONTINUE TO NEXT SCENE sensor
                    end)

end

function Cutscene:init()
    self.currentScene = nil

    
end

function Cutscene:leave()
    World.clearEntities()
end

function Cutscene:update(dt)
    self.timer = self.timer + dt 
    while timer > self.timePerLetter then
        self.currentLetter = self.currentLetter + 1
        self.timer = self.timer - self.timePerLetter
end

function Cutscene:draw()
    local text, textX, textY = self.scene:getText()
    local c = text:sub(1, self.currentLetter)
    love.graphics.print(c, textX, textY)
end

-- load a scene
function Cutscene:newScene(scene)
    local self.scene = scene
end