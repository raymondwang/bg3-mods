Ext.Require('IsLongRunningSpellAnimation.lua')

-- Pretty arbitrary. 10 ticks (~1/3 of a second) feels like enough time has
-- passed for all effects stemming from a single attack animation (including all
-- melee swings or spell casts) to finish resolving, without being long enough
-- that we might eat into the next attack (including dual wield attacks).
local numTicksForDefaultAttackAnimation = 10

-- Some spells have a continued stream of attacks that can last significantly
-- longer, e.g. an upcasted Magic Missile. We still don't have any sort of
-- material way to calculate this duration, but we can just artificially inflate
-- our timeout if we detect that the current spell cast will take longer.
-- The risk of getting this wrong is pretty low; in the worst case scenario,
-- a spell could proc a status one more time than expected.
local numTicksForLongRunningSpellAnimation = 30

--- Wait until an attack and all of its downstream effects have resolved by
--- waiting for an arbitrary number of ticks.
--- @param fn function
function DeferTaskUntilAfterAttackResolves(fn)
    local numTicksForCurrentAnimation = IsLongRunningSpellAnimation()
        and numTicksForLongRunningSpellAnimation or numTicksForDefaultAttackAnimation

    local numTicksResolved = 0
    local eventID

    -- https://github.com/Norbyte/bg3se/blob/main/Docs/API.md#tick
    eventID = Ext.Events.Tick:Subscribe(function()
        numTicksResolved = numTicksResolved + 1
        if numTicksResolved >= numTicksForCurrentAnimation then
            fn()
            Ext.Events.Tick:Unsubscribe(eventID)
        end
    end)
end
