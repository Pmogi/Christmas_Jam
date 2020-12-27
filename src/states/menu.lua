local Suit = require("lib.suit")
local GameState = require("lib.gamestate")
local Timer     = require("lib.timer")

local Assets = require("src/assets")

local MainMenu = {}

local mainMenu = Suit.new()

local textPos = {x1 = -100, x2 = 1000}

function MainMenu:draw()
    -- love.graphics.draw(Assets.getAsset("LivingRoomBG"), 0 , 0, 0,  5, 5)
    love.graphics.print("Gifts For", textPos.x1, 300, 0, 2)
    love.graphics.print("Granny"   , textPos.x2, 350, 0, 2)
    
    mainMenu:draw()
end

function MainMenu:update(dt)
    if mainMenu:Button("Start Game", (love.graphics.getWidth()/2)-150 , 3*love.graphics.getHeight()/4).hit then
        GameState.switch(LivingRoom)
        --Assets.getAsset("Bloop"):play()
    end
end

function MainMenu:enter()
    love.graphics.setFont(love.graphics.newFont(36))
    Timer.tween(1, textPos, {x1 = love.graphics.getWidth()/2 - 200}, 'out-in-elastic')
    Timer.tween(1, textPos, {x2 = love.graphics.getWidth()/2 - 200}, 'out-in-elastic')
    Timer.after(1, function() Assets.getAsset("Touch"):play() end)
end

function MainMenu:leave()
    love.graphics.setFont(love.graphics.newFont(18))

end
return MainMenu