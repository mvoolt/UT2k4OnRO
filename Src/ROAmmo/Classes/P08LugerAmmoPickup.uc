//=============================================================================
// P08LugerAmmoPickup
//=============================================================================
// Ammo pickup for the P08 Luger
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class P08LugerAmmoPickup extends ROMultiMagAmmoPickup;

defaultproperties
{
    InventoryType=class'P08LugerAmmo'

    PickupMessage="You picked up a P08 Luger mag pouch."
    TouchMessage="Pick Up: P08 Luger mag pouch"
    PickupForce="MinigunAmmoPickup"  // jdf

    AmmoAmount=8

    MaxDesireability=0.300000

    CollisionRadius=10.0
    CollisionHeight=3.0
    PrePivot=(X=0.0,Y=0.0,Z=5.0)

    StaticMesh=StaticMesh'WeaponPickupSM.pouches.pistolpouch'
    DrawType=DT_StaticMesh
    DrawScale=1.0
}
