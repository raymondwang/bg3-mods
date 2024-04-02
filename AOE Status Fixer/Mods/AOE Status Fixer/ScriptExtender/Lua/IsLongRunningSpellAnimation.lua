local LONG_RUNNING_SPELL_IDS = {
    -- Eldritch Blast has up to 4 projectiles at max level with Gemini Gloves.
    ['Projectile_EldritchBlast'] = true,

    ['Projectile_MagicMissile'] = true,
    ['Projectile_CursedTome_CurriculumofStrategy'] = true,
    ['Projectile_LOW_SorcerousSundries_ArtistryOfWar'] = true,

    ['Projectile_ScorchingRay'] = true,
    ['Projectile_MAG_ScorchingRay_3'] = true,
    ['Projectile_MAG_ScorchingRay_Shot'] = true,
}

local isLongRunningSpell = false

--- Subscribe to each spell cast and identify whether the spell is considered
--- "long-running", in which case we want our task deferral to delay longer.
--- Note that every attack is considered to be a spell, including melee attacks. 
--- @param caster GUIDSTRING
--- @param spell string
--- @param spellType string
--- @param spellElement string
--- @param storyActionID integer
Ext.Osiris.RegisterListener('UsingSpell', 5, 'before', function(caster, spell, spellType, spellElement, storyActionID)
    local spellStat = Ext.Stats.Get(spell)
    local rootSpellID = spellStat and spellStat.RootSpellID or nil
    local currentSpell = rootSpellID ~= nil and rootSpellID ~= '' and rootSpellID or spell
    isLongRunningSpell = LONG_RUNNING_SPELL_IDS[currentSpell] or false
end)

function IsLongRunningSpellAnimation() return isLongRunningSpell end
