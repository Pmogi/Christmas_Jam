local Timer     = require("lib.timer")
local SpeechBox = require("src.systems.speechbox")
local Assets = require("src/assets")
local Win  = require("src.states.win")



local Objective = {}

local notified = false

Objective.objectiveList = {
    ["Record"]      = false,
    ["Cookies"]     = false,
    ["Decorations"] = false
}

function Objective.update(dt)
        -- Notifiy the player they won
end

function Objective.completeObjective(objective)
    Objective.objectiveList[objective] = true
end

function Objective.getObjectiveState(objective)
    return Objective.objectiveList[objective]
end

function Objective.hasWon()
    return Objective.objectiveList["Record"] and Objective.objectiveList["Cookies"]  and Objective.objectiveList["Decorations"] 
end


return Objective