--- Prevent rage from ending for a turn after a character swaps between totems.
--- Rage totems overwrite one another, and the old totem is removed after the
--- new one is applied, which also removes `RAGE_STOP_REMOVE`.
--- Instead of expanding the possibility of conflicts by modifying each status's
--- `OnRemoveFunctors`, simply restore the rage end preventer status manually.
--- @param character GUIDSTRING
--- @param status string
--- @return nil
function ExtendRageWhenSwappingTotems(character, status, _, _)
    if Osi.IsStatusFromGroup(status, 'SG_Rage') == 1 then
        if Osi.HasActiveStatusWithGroup(character, 'SG_Rage') == 1 and Osi.HasActiveStatus(character, 'RAGE_STOP_REMOVE') == 0 then
            Osi.ApplyStatus(character, 'RAGE_STOP_REMOVE', 6, 1, character)
        end
    end
end

Ext.Osiris.RegisterListener("StatusRemoved", 4, "after", ExtendRageWhenSwappingTotems)
