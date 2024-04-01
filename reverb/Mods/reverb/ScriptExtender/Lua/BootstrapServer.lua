--- comment
--- @param turns integer
--- @return integer
local turnsInSeconds = function(turns)
  return turns * 6
end

local numTicksForAttackToResolve = 6
--- Delays a function call for a given number of ticks.
--- Server runs at a target of 30hz, so each tick is ~33ms and 30 ticks is ~1 second. This IS synced between server and client.
--- @param fn function
function DeferAfterAttackResolves(fn)
  local ticksPassed = 0
  local eventID
  eventID = Ext.Events.Tick:Subscribe(function()
    ticksPassed = ticksPassed + 1
    if ticksPassed >= numTicksForAttackToResolve then
      fn()
      Ext.Events.Tick:Unsubscribe(eventID)
    end
  end)
end

local TECHNICAL_STATUS_TO_APPLIED_STATUS = {
  ['RUI_FROST_TECHNICAL_ONCE_PER_TURN_HAT'] = 'MAG_FROST',
  ['RUI_FROST_TECHNICAL_MARKOHESHKIR'] = 'MAG_FROST',

  ['RUI_NOXIOUS_FUMES_TECHNICAL_GLOVES'] = 'MAG_ACID_NOXIOUS_FUMES',
  ['RUI_NOXIOUS_FUMES_TECHNICAL_MARKOHESHKIR'] = 'MAG_ACID_NOXIOUS_FUMES',

  ['RUI_REVERBERATION_TECHNICAL_AMULET'] = 'MAG_THUNDER_REVERBERATION',
  ['RUI_REVERBERATION_TECHNICAL_BOOTS'] = 'MAG_THUNDER_REVERBERATION',
  ['RUI_REVERBERATION_TECHNICAL_GLOVES'] = 'MAG_THUNDER_REVERBERATION',
  ['RUI_REVERBERATION_TECHNICAL_MARKOHESHKIR'] = 'MAG_THUNDER_REVERBERATION',
}

---
--- @param target GUIDSTRING
--- @param status string
--- @param causee GUIDSTRING
function ReplaceTechnicalStatusAfterAttackResolves(target, status, causee)
  print(string.format("STATUS APPLIED: %s", status))

  local statusToApply = TECHNICAL_STATUS_TO_APPLIED_STATUS[status]
  if not statusToApply then return end

  print(string.format("DEFERRING APPLICATION OF STATUS FOR TECHNICAL STATUS %s", status))

  DeferAfterAttackResolves(function()
    print("APPLYING STATUS: " .. statusToApply)

    if statusToApply == 'MAG_FROST' then
      Osi.ApplyStatus(target, statusToApply, turnsInSeconds(2), 0, causee)
      Osi.ApplyStatus(target, 'MAG_FROST_DURATION_TECHNICAL', turnsInSeconds(1), 0, causee)
    elseif statusToApply == 'MAG_ACID_NOXIOUS_FUMES' then
      Osi.ApplyStatus(target, statusToApply, turnsInSeconds(3), 0, causee)
    elseif statusToApply == 'MAG_THUNDER_REVERBERATION' then
      Osi.ApplyStatus(target, statusToApply, turnsInSeconds(2), 0, causee)
      Osi.ApplyStatus(target, 'MAG_THUNDER_REVERBERATION_DURATION_TECHNICAL', turnsInSeconds(1), 0, causee)
    end

    if not string.find(status, 'ONCE_PER_TURN') then
      Osi.RemoveStatus(target, status)
    end
  end)
end

Ext.Osiris.RegisterListener("StatusApplied", 4, "after", ReplaceTechnicalStatusAfterAttackResolves)
