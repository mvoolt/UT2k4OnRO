//=============================================================================
// MN762x54RAmmoPickup
//=============================================================================
// Ammo pickup for Mosin Nagant rifles using 7.62x54R ammo
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class MN762x54RAmmoPickup extends ROMultiMagAmmoPickup;

defaultproperties
{
    InventoryType=class'MN762x54RAmmo'

    PickupMessage="You picked up a 7.62x54R ammo pouch."
    TouchMessage="Pick Up: Mosin-Nagant ammo pouch"
    PickupForce="MinigunAmmoPickup"  // jdf

    AmmoAmount=5

    MaxDesireability=0.300000

    CollisionRadius=10.0
    CollisionHeight=3.0
    PrePivot=(X=0.0,Y=0.0,Z=5.0)

    StaticMesh=StaticMesh'WeaponPickupSM.pouches.nagantpouch'
    DrawType=DT_StaticMesh
    DrawScale=1.0
}
