local Suit = require("lib.suit")
local GameState = require("lib.gamestate")
local Timer     = require("lib.timer")
local Assets = require("src/assets")

local Assets = require("src/assets")
local DrawGrid = require("src.test.drawGrid") -- for drawing grid on screen to see where to place sensors
local Animation = require("src.systems.animation")



local Intro = {}

local introButton = Suit.new()

function Intro:draw()
    love.graphics.setColor(self.colorTable.fadeColor, self.colorTable.fadeColor, self.colorTable.fadeColor )
    
    love.graphics.draw(Assets.getAsset("endScreen"))

    introButton:draw()

    if not self.ending then
        self.anim1:draw()
    else
        self.anim2:draw()
    end

    -- DrawGrid.drawGrid()
end

function Intro:update(dt)
    -- button to continue
    if not self.ending then 
        if introButton:Button("Continue", love.graphics.getWidth()/2 - 150, love.graphics.getHeight()-100).hit then
            self.ending = true
            self.anim1 = nil
            self.anim2:play()

            Timer.tween(8, self.colorTable, {fadeColor = 0}, 'in-out-quad')
            Timer.after(12, function() love.event.quit() end)
        end
    end

    if not self.ending then
        self.anim1:update(dt)
    else
        self.anim2:update(dt)
    end

end

function Intro:enter()
    
    Assets.getAsset("mainBGM"):stop()
    Assets.getAsset("endingBGM"):play()
    
    love.graphics.setFont(love.graphics.newFont(18))

    self.anim1 = Animation(200, 500, Assets.getAsset("endingAnim1"), 2, 1000)
    self.anim2 = Animation(200, 500, Assets.getAsset('endingAnim2'), 8, 4, 0.5)

    self.anim1:play()
    self.ending = false

    self.colorTable = {fadeColor = 1}

end

function Intro:leave()
    
end

return Intro