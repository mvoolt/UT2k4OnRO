//=============================================================================
// SVT40AmmoPickup
//=============================================================================
// Ammo pickup for the SVT40
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class SVT40AmmoPickup extends ROMultiMagAmmoPickup;

defaultproperties
{
    InventoryType=class'SVT40Ammo'

    PickupMessage="You picked up a SVT-40 mag pouch."
    TouchMessage="Pick Up: SVT-40 mag pouch"
    PickupForce="MinigunAmmoPickup"  // jdf

    AmmoAmount=10

    MaxDesireability=0.300000

    CollisionRadius=10.0
    CollisionHeight=3.0
    PrePivot=(X=0.0,Y=0.0,Z=5.0)

    StaticMesh=StaticMesh'WeaponPickupSM.pouches.svt40pouch'
    DrawType=DT_StaticMesh
    DrawScale=1.0
}
