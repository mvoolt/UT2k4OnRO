//=================================================
// ROMasterAmmoPickup
// created by Antarian on 12/28/03
//
// Copyright (C) 2003 Jeffrey Nakai
//
// TEMPORARY class
//=================================================


class ROPlaceableAmmoPickup extends ROAmmoPickup
	abstract;

/* Reset()
reset actor to initial state - used when restarting level without reloading.
*/
function Reset()
{
	if ( Inventory != None )
		destroy();
	else
	{
		if (myMarker != None && myMarker.bSuperPickup)
			GotoState('Sleeping', 'DelayedSpawn');
		else
			GotoState('Pickup');
		super(Ammo).Reset();
	}
}
