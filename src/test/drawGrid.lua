DrawGrid = {}

function DrawGrid.drawGrid()
    love.graphics.setColor(0, 0, 0)
    for i=1,12 do 
        love.graphics.line(i*100, 0, i*100, love.graphics.getHeight())
    end

    for i=1,7 do 
        love.graphics.line(0, i*100, love.graphics.getWidth(), i*100)
    end

    love.graphics.setColor(1, 1, 1)
end


return DrawGrid