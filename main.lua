-- Lib
GameState       = require("lib.gamestate")
local Timer     = require("lib.timer")
local Camera    = require("lib.camera")

-- Module
local Assets = require("src.assets")
local Objective = require("src.systems.objective")



-- -- States
local Menu       = require("src.states.mainMenu")
LivingRoom = require("src.states.livingRoom")

local Bathroom   = require("src.states.bathroom")
Basement   = require("src.states.basement")
local Calender   = require("src.states.calendar")

-- 
Kitchen = require("src.states.kitchen")

local World    = require("src.systems.world")
cursorNormal = love.mouse.newCursor("assets/image/cursor/cursorNormal.png", 0, 0)
cursorHighlighted = love.mouse.newCursor("assets/image/cursor/cursorHighlighted.png", 0, 0)

-- Test Harness

function love.load()    
    GameState.registerEvents{'draw', 'update', 'init', 'enter', 'exit'}
    cursor = love.mouse.setCursor(cursorNormal)

    camera = Camera(love.graphics.getWidth()/2, love.graphics.getHeight()/2)

    GameState.switch(Kitchen) -- NOTE: changed to switch to the kitchen state
    love.graphics.setFont(Assets.getAsset("font"))
end

function love.mousepressed(x, y, button)
        if button == 1 then
                love.mouse.setCursor(cursorHighlighted)
        end
end

function love.mousereleased(x, y, button)
        if button == 1 then
                love.mouse.setCursor(cursorNormal)
        end
end



function love.update(dt)
    Timer.update(dt) -- update timer module
    World.update(dt)
    Objective.update(dt)
end
