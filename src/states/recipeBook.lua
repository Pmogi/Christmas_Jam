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


local RecipeBook = {}

function RecipeBook:init()

end

function RecipeBook:enter()
        World.addEntity(Sensor(935, 0, 200,125,
                            function()
                                -- play paper/rustle sound sound?    
                                GameState.switch(Kitchen)
                            end
        ))

        World.addEntity(Sensor(200, 200, 800, 200, 
                                function()
                                        --play hmm sound
                                        SpeechBox.startSpeech("These are the most grandma sounding cookies I've ever heard of.")
                                        return true
                                end
                        ))

        World.addEntity(Sensor(400, 600, 400, 100, 
                                function()
                                        --play hmm sound
                                        SpeechBox.startSpeech("Granny was definitely from a different era...")
                                        return true
                                end))
end

function RecipeBook:update(dt)
        SpeechBox.update(dt)
        World.update(dt)
end

function RecipeBook:draw()
        width = 1280
        love.graphics.draw(Assets.getAsset("recipeBook"), width / 8, 0)
        SpeechBox.draw()
        -- DrawGrid.drawGrid()
end

function RecipeBook:leave()
        World.clearEntities()
end


return RecipeBook
