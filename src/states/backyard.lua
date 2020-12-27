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


local Backyard = {}

roomState = {}
itemsInRoom = {}

function Backyard:init()
        roomState["shed"] = false
end



function Backyard:enter()
        World.addEntity(Sensor(324,250, 400,300,
            function()
                    if not roomState["shed"] then
                            roomState["shed"] = true
                            -- play open sound
                    end
                            return false
                    end ), false, false)

end

function Backyard:update( dt )

end

function Backyard:leave(  )        
    -- remove sensors
end

function Backyard:draw(  )
    love.graphics.draw(Assets.getAsset("backyardBG"))
    DrawGrid.drawGrid()
    if not roomState["shed"] then
        love.graphics.draw(Assets.getAsset("backyardShed1"), 270, 250)
    else
        love.graphics.draw(Assets.getAsset("backyardShed2"), 270, 250)
    end
end

return Attic
