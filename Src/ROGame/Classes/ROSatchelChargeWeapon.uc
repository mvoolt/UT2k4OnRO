//============================================================================
// ROSatchelChargeWeapon
// Created by Antarian on 1/11/04
//
// Copyright (C) 2004 Jeffrey Nakai
//
// Base class for Red Orchestra Satchel Charge type weapons
//============================================================================

class ROSatchelChargeWeapon extends ROExplosiveWeapon
	abstract;

simulated state RaisingWeapon
{
    simulated function EndState()
    {
        local ROPlayer player;

		super.EndState();

        player = ROPlayer(Instigator.Controller);
		if (player != none)
		    player.CheckForHint(7);
    }
}

defaultproperties
{
	InventoryGroup=6
}

