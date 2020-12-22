local Timer     = require("lib.timer")
local SpeechBox = require("src.systems.speechbox")
local Assets = require("src/assets")
local Win  = require("src.states.win")



local Objective = {}

local notified = false

Objective.objectiveList = {
    ["Painting"] = false,
    ["Book"]     = false,
    ["Bill"]     = false,
    ["Calender"] = false,
    ["Won"] = false
}

function Objective.update(dt)
    if  Objective.objectiveList["Painting"] and
            Objective.objectiveList["Book"] and
            Objective.objectiveList["Bill"]  and
            Objective.objectiveList["Calender"] and
            not Objective.objectiveList["Won"] and not notified then
    
        -- Notifiy the player they won
        Timer.after(5, 
            function ()
                SpeechBox.startSpeech("Everything is completed, time to leave the house.")
                Assets.getAsset("FanFare"):play()
                notified = true
                Objective.objectiveList["Won"] = true
                GameState.switch(Win)
            end
            )
    end
end

function Objective.wonState() 
    return Objective.objectiveList["Won"]
end

return Objective