# Barbarian Quality of Life

A collection of quality of life improvements and minor bug fixes for Barbarians. Changes include consistent rage bonuses
with intended scaling to make Dexterity builds viable, small buffs to bring the weakest Bestial Hearts up, the ability
to pre-cast Rage outside of combat, and a visible status indicator to denote whether Rage will end early.

## Overview

### Class Changes

**Rage**

- Rage can now be used outside of combat. This is useful if you know that a fight is coming, and want to start the
  encounter strong, or initiate combat with an enraged attack. Note that Rage still needs to be sustained by dealing
  damage to a hostile enemy or taking damage within the turn, so I recommend doing this in turn-based mode right before
  combat starts.
- All Rage boosts (including Rage, Frenzy, Rage: Wild Magic, and all Wildheart Totems) are now applied consistently, for
  all variants. These boosts include:
  - Advantage on Strength checks & saving throws
  - Resistance to physical damage, including Slashing, Piercing, Bludgeoning, & Fall damage
  - Deals an additional 2 (increased to 3 at level 9) damage with melee and improvised weapons, unarmed strikes, and
    while throwing objects. This was previously bugged for Wildheart Totems; half of them did not scale at level 9, and
    some of them didn't apply to Finesse weapons. This applies regardless of whether you are using Strength or Dexterity
    (deviating from the fix in the [Unofficial Bug Fixer](https://www.nexusmods.com/baldursgate3/mods/5595) mod).
- End Rage is now a free action. This isn't huge, but maybe it'll help out Barbarian / caster multiclasses a bit.

**Rage Sustained**

- If you have not attacked or received damage in the last turn, Rage may end when you end your turn. This could be easy
  to lose track of, so I've given this mechanic a name and made it visible. If you have the Rage Sustained status, your
  Rage will not end when you end your turn.
- Sustaining your Rage now no longer requires you to attack an enemy; attacking any character will now extend your Rage,
  even an ally. For better or worse, your Rage has a better chance of surviving a round of confusion.
- Note: because it was opaque before, you may not have realized that the conditions for prolonging your Rage when
  attacking an enemy didn't actually require you to deal any damage. In fact, as long as you attempted an attack on a
  hostile creature, even on a miss, your Rage will be sustained. This also means that missing an ally will sustain your
  Rage, too.

**Loviatar's Love**

- Loviatar's Love is completely incompatible with the logic to extend Rage via receiving damage today. I'm not sure that
  this has been documented anywhere; I discovered it while working on [Dynamic Wildheart Barbarian](https://www.nexusmods.com/baldursgate3/mods/8274).
  If a Barbarian has the Loviatar's Love passive, receiving damage will **never** sustain your Rage, which is a huge
  hidden downside to the passive for a class that otherwise felt like it had a lot of synergy with it!
- To fix this interaction, I've completely stubbed out the functionality of Loviatar's Love in the base game files, and
  reimplemented it from scratch using the Script Extender.

**Danger Sense**

- Danger Sense is actually bugged in the player's favor in the base game. Tooltip has been updated to reflect its actual
  effect: "You sense when things aren't as they should be. You have **Advantage** on Dexterity Saving Throws. To gain
  this benefit, you can't be Blinded or Incapacitated."

### Subclass Changes

I'm biased toward Wildheart, so the changes here are oriented around it. If you have other suggestions or requests for
improvements to other subclasses, let me know in the comments.

**Elk Heart**

Elk Heart is the second weakest Bestial Heart today, so I've made some small changes here to make its unique ability,
Primal Stampede, a bit more competitive.

- Attack roll now uses your weapon accuracy, instead of unarmed accuracy (!).
- Prone check now uses [Manoeuvre Save DC](https://bg3.wiki/wiki/Manoeuvres#Save_DC), instead of 10 + Strength modifier.
  This is a small buff at higher levels, and a huge one for Dexterity builds.
- Instead of a flat 1d4 across all levels, the damage roll (in addition to Strength modifier) is increased at higher 
  Barbarian levels: at level 6 it becomes 1d6, and at level 10 it becomes 1d8.
- Movement range increased by 33%, and animation speed doubled to feel less clunky.

**Tiger Heart**

- For all the Barbamonk enjoyers: Tiger's Bloodlust is now usable while unarmed. Note that the tooltip and damage 
  preview won't work very well, but this behavior is consistent with that of unarmed Diving Strike.

**Wolf Heart**

Wolf Heart is the weakest Bestial Heart (in my opinion). I wanted to make it feel better without making it stronger than
the strongest Bestial Hearts (Bear & Eagle) by focusing on its niche of playing as a pack leader.

Special thanks to Syrchalis for his work to auto-cast Inciting Howl when entering Rage: Wolf Heart in his
[Rebalance - Class Spells](https://www.nexusmods.com/baldursgate3/mods/5846) mod, and for letting me pull them in here!
Make sure to check out his other mods; I used them a lot to learn how to make mods, and they're the gold standard for my
impression of balance.

- Rage: Wolf Heart now grants [Pack Tactics](https://bg3.wiki/wiki/Pack_Tactics) to the Barbarian, to give yourself
  Advantage on targets surrounded by your allies.
- Entering Rage will now automatically cast Inciting Howl on your allies for two turns.
- Inciting Howl now only costs a bonus action, and lasts for two turns.

**Aspect of the Beast: Crocodile**

In the base game, the Crocodile Aspect does two things: make you faster on wet surfaces (including grease and ice), and
give you Advantage on saving throws on slippery surfaces. But slipping on slippery surfaces always uses a Dexterity
saving throw, and, as mentioned above, Danger Sense is bugged to give Barbarians Advantage on all Dexterity saving
throws at level 2 already. As a result, this Aspect is completely useless: you gain a little movement speed, but don't
gain any additional resistance to slipping on ice.

- The Crocodile Aspect now grants **immunity** to slipping on grease or ice.

**Aspect of the Beast: Honey Badger**

- Can now trigger in response to any status in the poisoned, frightened, or charmed [status groups](https://bg3.wiki/wiki/Status_groups),
  instead of only in response to the specifically named statuses.
- Honestly, this passive could still use a lot of work to be made truly viable outside of meme builds, but any changes
  may be better saved for a separate mod that's a little less concerned with balance.

**Aspect of the Beast: Wolverine**

- Can no longer trigger on yourself or your allies.

### Equipment

**Enraging Heart Garb**

Sort of unbelievably, this armor does literally nothing today. It has no passive or active effects whatsoever in the
game's code.

- Grants 2 stacks of Wrath when entering Rage, and on each turn that your Rage continues.

## Installation

Use the BG3ModManager. Add this mod to your load order.

The BG3 Script Extender is required to restore the functionality of Loviatar's Love.

This mod should be safe to install at any time.

## Uninstallation

This mod should be safe to uninstall at any time.

## Compatibility

This mod is a collection of disparate fixes, so its scope is somewhat broad. While it should be compatible with most
other mods, it may have to be loaded later in the load order than some other mods. It should be specifically ordered
**after** the following mods:

- Rebalance: Class Spells
- Unofficial Bug Fixer

If you find any mod incompatibilities, please let me know in the comments.