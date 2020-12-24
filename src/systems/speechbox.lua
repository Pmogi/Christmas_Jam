local Timer     = require("lib.timer")

local Assets = require("src/assets")


local SpeechBox = {}

local speechText = nil
local drawSpeech = false
local drawBox    = false
local textBoxCooldown = false -- to prevent textboxes being made too quickly, reset with timer

local speechBoxLength = 2.5

local messageQueue = {}

SpeechBox.speechBoxHeightMax = 210
SpeechBox.speechBoxHeight     = 0

function SpeechBox.startSpeech(text)
    if not textBoxCooldown  then
        speechText = text
        drawBox = true
    else
        table.insert( messageQueue, text)
    end

end

function SpeechBox.draw()
    love.graphics.setColor(0, 0, 0, 0.5)
    love.graphics.rectangle("fill", love.graphics.getWidth()/4, love.graphics.getHeight(), 
                                        love.graphics.getWidth()/2 , -SpeechBox.speechBoxHeight         )
        
    if (drawSpeech) then
        -- white box to hold the text
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.rectangle("fill", love.graphics.getWidth()/4+25, love.graphics.getHeight()-15,
                                    love.graphics.getWidth()/2-50, -(SpeechBox.speechBoxHeight-25) )
        
        -- draw the text
        love.graphics.setColor(0, 0, 0, 1)
        -- Finds the amount of wrappings there are in the text given 600 pixels of width
        local width, wrappedText = Assets.getAsset("font"):getWrap(speechText, 725)
        
        for i, str in ipairs(wrappedText) do
            -- iterates down by 12 pixels every wrapping (i*12)
            love.graphics.print(wrappedText[i], love.graphics.getWidth()/4+50, love.graphics.getHeight()-75 + (i*12), 0, 0.75, 0.75)
        end

        
    end
    
    -- reset drawing color to white
    love.graphics.setColor(1, 1, 1, 1)
    
end

function SpeechBox.update(dt)
    if drawBox and not textBoxCooldown then
        -- raise the height of the box with respect to time, and then print the text, after 5 seconds drop box
        Timer.tween(0.25, SpeechBox, {speechBoxHeight = 75})
        Timer.after(0.25, function() drawSpeech = true  end)
        Timer.after(speechBoxLength, function()  Timer.tween(0.25, SpeechBox, {speechBoxHeight = 0})   drawSpeech = false textBoxCooldown = false  end  )
        drawBox = false
        textBoxCooldown = true
    end

    -- print the queued messages until empty queue
    if not drawBox and not textBoxCooldown and not (next(messageQueue) == nil) then
        queuedText = table.remove(messageQueue)
        SpeechBox.startSpeech(queuedText)
    end
end

return SpeechBox