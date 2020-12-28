local Suit = require("lib.suit")
local GameState = require("lib.gamestate")
local Timer     = require("lib.timer")
local Assets = require("src/assets")

local Assets = require("src/assets")
local DrawGrid = require("src.test.drawGrid") -- for drawing grid on screen to see where to place sensors



local Intro = {}

local introButton = Suit.new()

function Intro:draw()
    love.graphics.draw(Assets.getAsset("introScreen"))

    introButton:draw()

    -- DrawGrid.drawGrid()
end

function Intro:update(dt)
    if introButton:Button("Continue", love.graphics.getWidth()/2 - 150, love.graphics.getHeight()-100).hit then
        love.audio.play(Assets.getAsset("GlassKnock"))
        GameState.switch(LivingRoom)
    end
end

function Intro:enter()
    love.graphics.setFont(love.graphics.newFont(18))
end

function Intro:leave()
    Assets.getAsset("menuMusic"):stop()
    Assets.getAsset("mainBGM"):play()
end

return Intro