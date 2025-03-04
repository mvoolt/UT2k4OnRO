//=============================================================================
// ROOneShotWeapon
//=============================================================================
// Base class for all weapons that are only fired once such as
// grenades, mines, etc
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class ROOneShotWeapon extends ROWeapon
	abstract;

function DropFrom(vector StartLocation)
{
    local int m, i;
	local Pickup Pickup;
	local rotator R;

    if (!bCanThrow )
        return;

    ClientWeaponThrown();

    for (m = 0; m < NUM_FIRE_MODES; m++)
    {
        if (FireMode[m].bIsFiring)
            StopFire(m);
    }

	if ( Instigator != None )
	{
		DetachFromPawn(Instigator);
	}

	// Destroy empty weapons without pickups if needed (panzerfaust, etc)
    if( AmmoAmount(0) < 1 )
    {
     	Destroy();
    }
	else
	{
		for ( i=0; i<AmmoAmount(0); i++ )
		{
			R.Yaw = rand(65536);
			Pickup = Spawn(PickupClass,,, StartLocation,R);
			if ( Pickup != None )
			{
		    	Pickup.InitDroppedPickupFor(self);
			    Pickup.Velocity = Velocity >> R;

		        if (Instigator.Health > 0)
		            WeaponPickup(Pickup).bThrown = true;

		        Pickup = none;
		    }
		}

	   	Destroy();
    }
}

function bool HandlePickupQuery( pickup Item )
{
    local WeaponPickup wpu;
	local int i;

	if ( bNoAmmoInstances )
	{
		// handle ammo pickups
		for ( i=0; i<2; i++ )
		{
			if ( (item.inventorytype == AmmoClass[i]) && (AmmoClass[i] != None) )
			{
				if ( AmmoCharge[i] >= MaxAmmo(i) )
					return true;

				item.AnnouncePickup(Pawn(Owner));
				AddAmmo(Ammo(item).AmmoAmount, i);
				item.SetRespawn();
				return true;
			}
			else if ( WeaponPickup(item) != none && item.inventorytype == class && (AmmoClass[i] != None) )
			{
				if ( AmmoCharge[i] >= MaxAmmo(i) || WeaponPickup(item).AmmoAmount[i] < 1 )
					return true;

				item.AnnouncePickup(Pawn(Owner));
				AddAmmo(WeaponPickup(item).AmmoAmount[i], i);
				item.SetRespawn();
				return true;
			}
		}
	}

	if (class == Item.InventoryType)
    {
        wpu = WeaponPickup(Item);
        if (wpu != None)
            return !wpu.AllowRepeatPickup();
        else
            return false;
    }

    // Drop current weapon and pickup the one on the ground
    if( Instigator.Weapon != none && Instigator.Weapon.InventoryGroup == InventoryGroup &&
		Item.InventoryType.default.InventoryGroup == InventoryGroup && Instigator.CanThrowWeapon())
	{
		ROPlayer(Instigator.Controller).ThrowWeapon();
		return false;
	}

	// Avoid multiple weapons in the same slot
    if (Item.InventoryType.default.InventoryGroup == InventoryGroup)
		return true;

    if ( Inventory == None )
		return false;

	return Inventory.HandlePickupQuery(Item);
}


