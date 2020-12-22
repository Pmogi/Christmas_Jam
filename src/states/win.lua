local Assets = require("src/assets")


local Win = {}
function Win:draw()
    love.graphics.draw(Assets.getAsset("endScreen"))
end
return Win