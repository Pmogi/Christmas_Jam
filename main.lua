-- Lib
GameState       = require("lib.gamestate")
local Timer     = require("lib.timer")
local Camera    = require("lib.camera")

-- Module
local Assets = require("src.assets")
local Objective = require("src.systems.objective")


-- -- States
-- 
Kitchen =    require("src.states.kitchen")
Attic   =    require("src.states.attic")
Bedroom =    require("src.states.bedroom")
LivingRoom = require("src.states.livingRoom")
-- Backyard = 
-- Recipe =
Recipe   =    require("src.states.recipeBook")
local World    = require("src.systems.world")

-- Test Harness
-- 

function love.load()    
    GameState.registerEvents{'draw', 'update', 'init', 'enter', 'exit'}
    cursor = love.mouse.setCursor(cursorNormal)

    camera = Camera(love.graphics.getWidth()/2, love.graphics.getHeight()/2)

    GameState.switch(Kitchen) -- Switching state
    -- love.graphics.setFont(Assets.getAsset("font"))
    love.window.setMode(1280, 720, {centered=true})

    cursorNormal = love.mouse.newCursor("assets/image/cursor/cursorNormal.png", 0, 0)
    cursorHighlighted = love.mouse.newCursor("assets/image/cursor/cursorHighlighted.png", 0, 0)
end

function love.update(dt)
    Timer.update(dt) -- update timer module
    World.update(dt)
    Objective.update(dt)
end

-- For custom mouse cursor
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

