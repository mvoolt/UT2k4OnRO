//=============================================================================
// P38AmmoPickup
//=============================================================================
// Ammo pickup for the P38
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class P38AmmoPickup extends ROMultiMagAmmoPickup;

defaultproperties
{
    InventoryType=class'P38Ammo'

    PickupMessage="You picked up a P38 mag pouch."
    TouchMessage="Pick Up: P38 mag pouch"
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
