local LOVIATARS_LOVE_HP_PERCENTAGE_THRESHOLD = 30

---Loviatar's Love is secretly incompatible with Rage_Damaged, which means that a Barbarian with Loviatar's Love cannot
---extend their Rage by receiving damage. This is a pretty weird issue, and I couldn't figure out how why these passives
---were incompatible. Instead, this just stubs out the default functionality for Loviatar's Love and reimplements it as
---a script.
---@param entity GUIDSTRING
---@param percentage number
function ToggleLoviatarsLoveActiveStatusOnHitpointsChanged(entity, percentage)
    if (Osi.HasPassive(entity, 'GOB_CalmnessInPain') == 1) then
        local isLoviatarsLoveActive = Osi.HasActiveStatus(entity, 'GOB_CALMNESS_IN_PAIN_ACTIVE') == 1

        if (percentage <= LOVIATARS_LOVE_HP_PERCENTAGE_THRESHOLD and not isLoviatarsLoveActive) then
            Osi.ApplyStatus(entity, 'GOB_CALMNESS_IN_PAIN_ACTIVE', -1, 1, entity)
        elseif (percentage > LOVIATARS_LOVE_HP_PERCENTAGE_THRESHOLD and isLoviatarsLoveActive) then
            Osi.RemoveStatus(entity, 'GOB_CALMNESS_IN_PAIN_ACTIVE')
        end
    end
end

Ext.Osiris.RegisterListener("HitpointsChanged", 2, "after", ToggleLoviatarsLoveActiveStatusOnHitpointsChanged)
