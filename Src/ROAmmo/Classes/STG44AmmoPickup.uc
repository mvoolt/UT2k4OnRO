//=============================================================================
// STG44AmmoPickup
//=============================================================================
// Ammo pickup for the STG44
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class STG44AmmoPickup extends ROMultiMagAmmoPickup;

defaultproperties
{
    InventoryType=class'STG44Ammo'

    PickupMessage="You picked up a STG44 mag pouch."
    TouchMessage="Pick Up: STG44 mag pouch"
    PickupForce="MinigunAmmoPickup"  // jdf

    AmmoAmount=30

    MaxDesireability=0.300000

    CollisionRadius=10.0
    CollisionHeight=3.0
    PrePivot=(X=0.0,Y=0.0,Z=5.0)

    StaticMesh=StaticMesh'WeaponPickupSM.pouches.stg44pouch'
    DrawType=DT_StaticMesh
    DrawScale=1.0
}
