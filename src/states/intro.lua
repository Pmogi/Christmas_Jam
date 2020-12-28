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


    local speechText = 
[[*Ring Ring*    
???: Hello! This is your friend Rose. I've been meaning to ask you something. Could you look after my grandma this holiday? I know it's Christmas Eve, but you owe me one.

You: Sure! What should I do when I get there?

Rose: Oh, I don't know, Granny's such an old lady. Talk to her and try to figure out what she needs." 

You: Alright, you got it. I'll head straight there.
]]


    local width, wrappedText = Assets.getAsset("font"):getWrap(speechText, 1500)
        
    for i, str in ipairs(wrappedText) do
        -- iterates down by 12 pixels every wrapping (i*12)
        love.graphics.print(wrappedText[i], 201, 68 + (i*24), 0, 0.75, 0.75)
    end

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