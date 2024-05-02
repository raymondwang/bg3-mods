Ext.Require('DeferTaskUntilAfterAttackResolves.lua')

local PLACEHOLDER_STATUS_TO_APPLIED_STATUS = {
    ['RUI_FROST_GLOVES_PLACEHOLDER'] = 'MAG_FROST',
    ['RUI_FROST_HAT_PLACEHOLDER_DO_NOT_REMOVE'] = 'MAG_FROST',
    ['RUI_FROST_MARKOHESHKIR_PLACEHOLDER'] = 'MAG_FROST',

    ['RUI_NOXIOUS_FUMES_GLOVES_PLACEHOLDER'] = 'MAG_ACID_NOXIOUS_FUMES',
    ['RUI_NOXIOUS_FUMES_MARKOHESHKIR_PLACEHOLDER'] = 'MAG_ACID_NOXIOUS_FUMES',

    ['RUI_POISON_MARKOHESHKIR_PLACEHOLDER'] = 'POISONED',

    ['RUI_REVERBERATION_AMULET_PLACEHOLDER'] = 'MAG_THUNDER_REVERBERATION',
    ['RUI_REVERBERATION_BOOTS_PLACEHOLDER'] = 'MAG_THUNDER_REVERBERATION',
    ['RUI_REVERBERATION_GLOVES_PLACEHOLDER'] = 'MAG_THUNDER_REVERBERATION',
    ['RUI_REVERBERATION_MARKOHESHKIR_PLACEHOLDER'] = 'MAG_THUNDER_REVERBERATION',

    ['RUI_FAERIE_FIRE_LONGBOW_PLACEHOLDER_DO_NOT_REMOVE'] = 'NOOP',
    ['RUI_SNOWBURST_RING_PLACEHOLDER'] = 'NOOP',
}

--- Simulate a "OncePerAttack" process with custom placeholder statuses.
--- When a placeholder status is applied, we want to swap it out with its real
--- status as quickly as possible, but leave the placeholder status intact until
--- the attack has finished, letting it clog up any repeated status applications
--- within the same "attack".
--- @param target GUIDSTRING
--- @param status string
--- @param source GUIDSTRING
local function HandlePlaceholderStatusApplied(target, status, source)
    local statusToApply = PLACEHOLDER_STATUS_TO_APPLIED_STATUS[status]
    if not statusToApply then return end

    if statusToApply == 'MAG_FROST' then
        Osi.ApplyStatus(target, 'MAG_FROST', 12, 0, source)
        Osi.ApplyStatus(target, 'MAG_FROST_DURATION_TECHNICAL', 6, 0, source)
    elseif statusToApply == 'MAG_ACID_NOXIOUS_FUMES' then
        Osi.ApplyStatus(target, 'MAG_ACID_NOXIOUS_FUMES', 18, 0, source)
    elseif statusToApply == 'POISONED' then
        Osi.ApplyStatus(target, 'POISONED', 12, 0, source)
    elseif statusToApply == 'MAG_THUNDER_REVERBERATION' then
        Osi.ApplyStatus(target, 'MAG_THUNDER_REVERBERATION', 12, 0, source)
        Osi.ApplyStatus(target, 'MAG_THUNDER_REVERBERATION_DURATION_TECHNICAL', 6, 0, source)
    end

    -- Statuses suffixed with DO_NOT_REMOVE should function as OncePerTurn:
    if string.find(status, 'DO_NOT_REMOVE') then return end

    DeferTaskUntilAfterAttackResolves(function() Osi.RemoveStatus(target, status) end)
end

Ext.Osiris.RegisterListener('StatusApplied', 4, 'after', HandlePlaceholderStatusApplied)
