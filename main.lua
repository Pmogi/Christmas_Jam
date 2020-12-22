-- Lib
GameState       = require("lib.gamestate")
local Timer     = require("lib.timer")
local Camera    = require("lib.camera")

-- Module
local Assets = require("src/assets")
local Objective = require("src.systems.objective")



-- -- States
local Menu       = require("src.states.mainMenu")
LivingRoom = require("src.states.livingRoom")
local Bathroom   = require("src.states.bathroom")
Basement   = require("src.states.basement")
local Calender   = require("src.states.calendar")

local World    = require("src.systems.world")


-- Test Harness

function love.load()    
    GameState.registerEvents{'draw', 'update', 'init', 'enter', 'exit'}

    camera = Camera(love.graphics.getWidth()/2, love.graphics.getHeight()/2)

    GameState.switch(Menu)
    love.graphics.setFont(Assets.getAsset("font"))
end

function love.update(dt)
    Timer.update(dt) -- update timer module
    World.update(dt)
    Objective.update(dt)
end
