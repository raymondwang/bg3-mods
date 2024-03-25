# Dynamic Wildheart

Selecting the Wildheart subclass now grants you access to each Bestial Heart. You can attune to a different animal each time you Rage, and you can change Bestial Hearts while raging as a bonus action without expending an additional Rage Charge.

## Overview

Wildheart Barbarian is one of my favorite subclasses in the game, but I find the limitation of a single animal totem to be unnecessarily restrictive. Each animal offers a unique playstyle, and the encounter variation in the game means that they're useful (and not useful!) in different contexts. For example, when fighting undead enemies who are immune to bleeding, Tiger Heart Barbarians are unfairly punished; for most players, this just means that they need to respec during Act Two. The Bear and Eagle Hearts are always good, and I suspect that not many players have ever even tried Elk or Wolf.

This mod reworks the Wildheart subclass to remove this restriction. Each time you Rage, you can select which Bestial Heart to attune to, gaining their passives and active abilities. While raging, you can change Bestial Hearts with a bonus action without expending an additional Rage Charge.

This makes Wildheart Barbarians significantly more versatile in a balanced way. If you're expecting to take a lot of damage next turn, you can switch to Bear Heart for its resistances, or to Elk Heart to run away with increased movement speed. Tiger Heart Barbarians can bleed and maim a group of enemies, then switch to Eagle or Elk Heart to knock them all prone. Wolf Heart can be situationally useful to focus down a boss with a team of martials, but it's almost never picked today because it requires a specific team composition to compete with the other animals; with Dynamic Wildheart, you can use a different Rage until the situation calls for a coordinated smackdown.

Notes:

- To minimize the risk of conflicts, I intentionally avoided changing any logic related to character progression. This means that each time you level up as a Wildheart Barbarian, you will still be given an option to select a Bestial Heart. This choice is now mostly for flavor; it only affects the following:

- Because each Bestial Heart comes with a unique active ability (e.g. Diving Strike, Tiger's Bloodlust), each ability is now only unlocked when its associated Rage status is active. These abilities will appear in the Temporary tab in the rightmost section of your action bar, next to the End Rage ability.
- Changing Bestial Hearts has the effect of refreshing your Rage status, which affects the following:
    - The duration of your Rage status is refreshed to 10 turns. I don't think I've ever been in a battle that has lasted more than 10 turns in this game, so I'm not concerned with the balance of this. 
    - Normally, the Bear Heart ability, Unrelenting Ferocity, can only be used once per Rage. It's now possible to refresh this ability by switching between Rages, if you want.
    - Any equipment that activates when you Rage will also trigger again, namely the Bonespike Helmet and Bonespike Garb. This is a nontrivial buff to these pieces of gear by design — they're far too weak for the time you get them in Act Three, since their effects were essentially once per combat before. Since reactivating Rage still costs one bonus action, I don't think these items become overpowered by any stretch of the imagination.
- Changing Bestial Hearts will *not* trigger effects that activate when your Rage ends, like Reason's Grasp.

## Installation

Use the BG3ModManager. Add this mod to your load order.

The BG3 Script Extender is required in order to ensure that Rage doesn't end if you change totems and end your turn without attacking an enemy or taking damage. You can install it with the mod manager through its Tools tab, or by pressing CTRL + Shift + Alt + T while the mod manager is focused. No additional configuration is required.

This mod should be safe to install at any time.

## Uninstallation

I've intentionally kept the risk of conflicts in this mod as low as possible. As a result, this mod should be safe to uninstall at any time, as long as nobody is actively raging. (Even then, it might be fine, but I haven't tested it.)

## Compatibility

This mod uses self-referential inheritance to minimize the risk of conflicts with other mods. As a result, it should be compatible with _most_ other Barbarian mods, barring complete class reworks.

I've specifically tested compatibility with the following mods:

- OneDnd Short Rest Rage Recovery
- Rebalance: Class Spells
- Unofficial Bug Fixer
- Unshackled Rage

If you find any mod incompatibilities, please let me know in the comments.