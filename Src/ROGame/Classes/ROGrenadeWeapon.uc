//============================================================================
// ROGrenadeWeapon
// Created by Antarian on 1/11/04 as ROGrenadeWeapon
// Renamed ROExplosiveWeapon by Antarian 1/11/04
//
// Copyright (C) 2003, 2004 Jeffrey Nakai
//
// Has the base weapon info for the red orchestra grenades
//============================================================================

class ROGrenadeWeapon extends ROExplosiveWeapon
	abstract;

simulated function Fire(float F)
{
    local ROPlayer player;

    super.Fire(F);

    // Hint check
    player = ROPlayer(Instigator.Controller);
    if (player != none)
        player.CheckForHint(9);
}

function bool IsGrenade()
{
    return true;
}

defaultproperties
{
	InventoryGroup=2
}
