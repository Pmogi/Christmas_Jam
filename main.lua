-- Lib
GameState       = require("lib.gamestate")

local Timer     = require("lib.timer")


-- Module
local Assets = require("src.assets")
local Objective = require("src.systems.objective")
local World    = require("src.systems.world")


-- -- States
Kitchen =    require("src.states.kitchen")
Attic   =    require("src.states.attic")
Bedroom =    require("src.states.bedroom")
LivingRoom = require("src.states.livingRoom")
Backyard =   require("src.states.backyard")
MainMenu =   require("src.states.menu")
Intro    =   require("src.states.intro")
Ending   =   require("src.states.ending")
Recipe   =   require("src.states.recipeBook")



-- Test Harness
-- 

function love.load()
    love.graphics.setFont(love.graphics.newFont(18))
    
    cursorNormal = love.mouse.newCursor("assets/image/cursor/cursorNormal.png", 0, 0)
    cursorHighlighted = love.mouse.newCursor("assets/image/cursor/cursorHighlighted.png", 0, 0)
    
    GameState.registerEvents{'draw', 'update', 'init', 'enter', 'exit'}
    cursor = love.mouse.setCursor(cursorNormal)

    GameState.switch(MainMenu) -- Initial State


    -- love.graphics.setFont(Assets.getAsset("font"))
    love.window.setMode(1280, 720, {centered=true})
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

