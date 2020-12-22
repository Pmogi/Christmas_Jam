local World = {}

local entityList = {}

function World.addEntity(entity)
    
    table.insert( entityList, entity )
end

function World.draw()
    
    -- Camera 
    --
    
    for i,entity in pairs(entityList) do 
        if entity.drawable then
            entity:draw()
        end
    end
    
    --camera:detach()
end

function World.update(dt)
    for i,entity in pairs(entityList) do
        if entity.alive then
            entity:update(dt)
        else
            table.remove( entityList, i )
        end
    end
end

function World.clearEntities() 
    for i in pairs(entityList) do
        entityList[i] = nil
    end 
end

    

return World