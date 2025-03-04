//=============================================================================
// DP28AmmoPickup
//=============================================================================
// Ammo pickup for DP28 machine guns
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class DP28AmmoPickup extends ROMultiMagAmmoPickup;

defaultproperties
{
    InventoryType=class'DP28Ammo'

    PickupMessage="DP28 magazines added to inventory."
    TouchMessage="Pick Up: DP28 magazines"
    PickupForce="MinigunAmmoPickup"  // jdf

    AmmoAmount=47

    MaxDesireability=0.300000

    CollisionRadius=10.0
    CollisionHeight=3.0
    PrePivot=(X=0.0,Y=0.0,Z=5.0)

    StaticMesh=StaticMesh'WeaponPickupSM.pouches.dp27pouch'
    DrawType=DT_StaticMesh
    DrawScale=1.0
}
