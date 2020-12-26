-- Libaries
local Object = require("lib.classic")

-- Modules
-- local DrawGrid = require("src.test.drawGrid") -- for drawing grid on screen to see where to place sensors

local Scene = Object:extend()

function Scene:new(imgs, text, x, y, nextState)
    -- imgs is the bg image and any animations
    -- self.img = {bgIMG, anim1, anim2, etc..}
    self.imgs = imgs
    self.text = text or "error"
    self.x = x
    self.y = y
    self.nextState = nextState
end

-- return text, and starting position of text
function Scene:getText()
    return self.text, x, y
end

-- return 
function Scene:getImg()
    return self.img
end

function Scene:getNextState()
    return self.nextState
end

return Scene