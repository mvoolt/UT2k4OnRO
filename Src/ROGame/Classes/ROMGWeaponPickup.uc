//=============================================================================
// ROMGWeaponPickup
// started by Antarian on 3/8/04
//
// Copyright (C) 2004 Jeffrey Nakai
//
// Base class for MG pickups, we need extra variables here to support barrel
//	heating
//
// Future Idea:  Have steam coming off the pickup
//=============================================================================
class ROMGWeaponPickup extends ROWeaponPickup
   abstract;

var		float		ROMGCelsiusTemp;
var		float		BarrelCoolingRate;
var		bool		bBarrelFailed;


function InitDroppedPickupFor(Inventory Inv)
{
		//WeaponTODO: reimplement this

    local ROWeapon W;
    W = ROWeapon(Inv);

    if( (ROMGBase(W) != none) && (ROMGBase(W).BarrelArray[ROMGBase(W).ActiveBarrel] != none) )
    {
    	ROMGCelsiusTemp = ROMGBase(W).BarrelArray[ROMGBase(W).ActiveBarrel].ROMGCelsiusTemp;
    	BarrelCoolingRate = ROMGBase(W).BarrelArray[ROMGBase(W).ActiveBarrel].BarrelCoolingRate;
		bBarrelFailed = ROMGBase(W).BarrelArray[ROMGBase(W).ActiveBarrel].bBarrelFailed;
    }

    super.InitDroppedPickupFor(Inv);
}


function Tick( float dt )
{
	// make sure it's run on the
	if( Role < ROLE_Authority )
		return;

	// continue to lower the barrel temp
	ROMGCelsiusTemp -= dt * BarrelCoolingRate;
}
