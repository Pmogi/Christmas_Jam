-- lib 
local Object = require("lib.classic")

local Item = Object:extend()

function Item:new(id, img, drawPriority)
    self.id = id
    self.img = img
    
    self.toDraw = true
    self.prior = drawPriority
    self.hovored = false
end

-- top left pixel for item
function Item:draw(x, y)
    if self.toDraw then
        love.graphics.draw(x, y)
    end
end


-- toggle whether item is being drawn or not
function Item:toggleDraw()
    if self.toDraw then
        self.toDraw = false
    else
        self.toDraw = true
    end
end


function Item:update(dt)
    
end

return Item