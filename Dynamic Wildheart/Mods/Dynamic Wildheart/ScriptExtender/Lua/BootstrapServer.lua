--- Prevent rage from ending for a turn when a character swaps between totems.
--- Rage totems overwrite one another, and the old totem is removed after the
--- new one is applied. This listener reapplies the removed status that prevents
--- rage from ending the turn you applied it.
--- @param character GUIDSTRING
--- @param status string
--- @return nil
function ExtendRageWhenSwappingTotems(character, status, _, _)
    if Osi.IsStatusFromGroup(status, 'SG_Rage') == 1 then
        print('STATUS REMOVED: ' .. status)
        if Osi.HasActiveStatusWithGroup(character, 'SG_Rage') == 1 and Osi.HasActiveStatus(character, 'RAGE_STOP_REMOVE') == 0 then
            print('STATUS IS IN STATUS GROUP')
            Osi.ApplyStatus(character, 'RAGE_STOP_REMOVE', 6, 1, character)
            print('APPLIED STATUS')
        end
    end
end

Ext.Osiris.RegisterListener("StatusRemoved", 4, "after", ExtendRageWhenSwappingTotems)
