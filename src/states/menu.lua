local Suit = require("lib.suit")
local GameState = require("lib.gamestate")
local Timer     = require("lib.timer")

local Assets = require("src/assets")

local MainMenu = {}

local mainMenu = Suit.new()

local textPos = {x1 = -100, x2 = 1000}

function MainMenu:draw()
    love.graphics.draw(Assets.getAsset("kitchenBG"), 0 , 0, 0,  1.5, 1.5)
    love.graphics.print("Gifts For", textPos.x1, 350, 0, 1.2)
    love.graphics.print("Granny"   , textPos.x2, 400, 0, 1.2)
    
    mainMenu:draw()
end

function MainMenu:update(dt)
    if mainMenu:Button("Start Game", (love.graphics.getWidth() -400) , 3*love.graphics.getHeight()/4).hit then
        GameState.switch(Intro)
        love.audio.play(Assets.getAsset("GlassKnock"))
    end
end

function MainMenu:enter()
    love.graphics.setFont(love.graphics.newFont(36))
    Timer.tween(1, textPos, {x1 = love.graphics.getWidth() - 400}, 'out-in-elastic')
    Timer.tween(1, textPos, {x2 = love.graphics.getWidth() - 400}, 'out-in-elastic')
    Timer.after(1, function() Assets.getAsset("Touch"):play() end)

    Assets.getAsset("menuMusic"):play()
end

function MainMenu:leave()
    love.graphics.setFont(love.graphics.newFont(18))

end
return MainMenu