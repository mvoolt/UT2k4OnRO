//===================================================================
// RORocketWeapon
//
// Copyright (C) 2004 John "Ramm-Jaeger"  Gibson
//
// Base class for Rocket Launching weapons
//===================================================================


class RORocketWeapon extends ROProjectileWeapon
	abstract;

//=============================================================================
// Variables
//=============================================================================

var     ROFPAmmoRound            RocketAttachment;     // The first person ammo round attached to the rocket

simulated function Destroyed()
{
    if (RocketAttachment != None)
        RocketAttachment.Destroy();

	Super.Destroyed();
}

defaultproperties
{
	InventoryGroup=5 // give rocket weapon there own inventory slot
	Priority=8
}
