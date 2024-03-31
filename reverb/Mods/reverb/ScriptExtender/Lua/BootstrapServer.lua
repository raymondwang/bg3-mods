
local numTicksForAttackToResolve = 6
---Delays a function call for a given number of ticks.
---Server runs at a target of 30hz, so each tick is ~33ms and 30 ticks is ~1 second. This IS synced between server and client.
---@param fn function
function DeferAfterAttackResolves(fn)
    local ticksPassed = 0
    local eventID
    eventID = Ext.Events.Tick:Subscribe(function ()
        ticksPassed = ticksPassed + 1
        if ticksPassed >= numTicksForAttackToResolve then
            fn()
            Ext.Events.Tick:Unsubscribe(eventID)
        end
    end)
end

---comment
---@param target GUIDSTRING
---@param causee GUIDSTRING
-- function ApplyReverberationStatus(target, causee)
--     Osi.ApplyStatus(target, 'MAG_THUNDER_REVERBERATION', 12, 0, causee)
--     Osi.ApplyStatus(target, 'MAG_THUNDER_REVERBERATION_DURATION_TECHNICAL', 6, 0, causee)
-- end

local TECHNICAL_STATUS_TO_APPLIED_STATUS = {
    ['RUI_REVERBERATION_TECHNICAL_FOR_GLOVES'] = 'MAG_THUNDER_REVERBERATION',
    ['RUI_REVERBERATION_TECHNICAL_FOR_BOOTS'] = 'MAG_THUNDER_REVERBERATION',
}

---comment
---@param target GUIDSTRING
---@param status string
---@param causee GUIDSTRING
---@param storyActionID integer
Ext.Osiris.RegisterListener("StatusApplied", 4, "after", function(target, status, causee, storyActionID)
    print(string.format("STATUS APPLIED: %s", status))

    local appliedStatus = TECHNICAL_STATUS_TO_APPLIED_STATUS[status]
    
    if not appliedStatus then
        return
    end

    print(string.format("DEFERRING APPLICATION OF STATUS FOR TECHNICAL STATUS %s", status))

    DeferAfterAttackResolves(function ()
        print("APPLYING STATUS")
        if (appliedStatus == 'MAG_THUNDER_REVERBERATION') then
            Osi.ApplyStatus(target, 'MAG_THUNDER_REVERBERATION', 12, 0, causee)
            Osi.ApplyStatus(target, 'MAG_THUNDER_REVERBERATION_DURATION_TECHNICAL', 6, 0, causee)
        end
    end)
end)
