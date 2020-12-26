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


local LivingRoom = {}

function LivingRoom:init()
        

end

function LivingRoom:enter()


        -- Go to kitchen
        World.addEntity(Sensor(601,233, 113,200, 
                            function()
                                    -- play door sound -- 
                                    GameState.switch(Kitchen)
                            end
        ))

        -- Go to living room
        World.addEntity(Sensor(824,230,100,100,
                            function()
                                    -- play door sound --
                                    GameState.switch(Bedroom)
                            end
        ))
end

function LivingRoom:update(dt)

end

function LivingRoom:draw()
        love.graphics.draw(Assets.getAsset("livingRoomBG"))
        
        DrawGrid.drawGrid()
end

function LivingRoom:leave()
        World.clearEntities()

end


return LivingRoom
