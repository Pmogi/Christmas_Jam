local Suit = require("lib.suit")
local GameState = require("lib.gamestate")
local Timer     = require("lib.timer")
local Assets = require("src/assets")

local Assets = require("src/assets")


local Intro = {}

local introButton = Suit.new()

function Intro:draw()
    love.graphics.draw(Assets.getAsset("introScreen"))

    introButton:draw()
end

function Intro:update(dt)
    if introButton:Button("Continue", love.graphics.getWidth()/2 - 150, love.graphics.getHeight()-100).hit then
        GameState.switch(LivingRoom)
    end
end

function Intro:enter()

end

function Intro:leave()
    Assets.getAsset("menuMusic"):stop()
    Assets.getAsset("mainBGM"):play()
end

return Intro