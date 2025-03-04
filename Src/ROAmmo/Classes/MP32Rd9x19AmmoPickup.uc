//=============================================================================
// SVT40AmmoPickup
//=============================================================================
// Ammo pickup for MP40 style machine pistols
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class MP32Rd9x19AmmoPickup extends ROMultiMagAmmoPickup;

defaultproperties
{
    InventoryType=class'MP32Rd9x19Ammo'

    PickupMessage="32 round 9x19mm mag pouch added to inventory."
    TouchMessage="Pick Up: 32 round 9mm mag pouch"
    PickupForce="MinigunAmmoPickup"  // jdf

    AmmoAmount=32

    MaxDesireability=0.300000

    CollisionRadius=10.0
    CollisionHeight=3.0
    PrePivot=(X=0.0,Y=0.0,Z=5.0)

    StaticMesh=StaticMesh'WeaponPickupSM.pouches.mp40pouch'
    DrawType=DT_StaticMesh
    DrawScale=1.0
}
