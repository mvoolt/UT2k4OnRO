//=============================================================================
// ROOneShotWeaponPickup
//=============================================================================
// Base class for all weapon pickups that are only fired once such as
// grenades, panzerfausts, mines, etc
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class ROOneShotWeaponPickup extends ROWeaponPickup
	abstract
	notplaceable;

// Every dropped weapon pickup is one shot only
function InitDroppedPickupFor(Inventory Inv)
{
    local Weapon W;
    W = Weapon(Inv);
    if (W != None)
    {
        AmmoAmount[0] = 1;
        AmmoAmount[1] = 0;
    }

	SetPhysics(PHYS_Falling);
	GotoState('FallingPickup');
	Inventory = Inv;
	bAlwaysRelevant = false;
	bOnlyReplicateHidden = false;
	bUpdateSimulatedPosition = true;
    bDropped = true;
    LifeSpan = DropLifeTime + rand(10);
	bIgnoreEncroachers = false; // handles case of dropping stuff on lifts etc
	NetUpdateFrequency = 8;
}

