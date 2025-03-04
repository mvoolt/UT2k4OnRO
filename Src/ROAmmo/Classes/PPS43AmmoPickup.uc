//=============================================================================
// PPS43AmmoPickup
//=============================================================================
// Ammo pickup for the PPS43
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class PPS43AmmoPickup extends ROMultiMagAmmoPickup;

defaultproperties
{
    InventoryType=class'PPS43Ammo'

    PickupMessage="You picked up a PPS43 mag puch."
    TouchMessage="Pick Up: PPS43 mag pouch"
    PickupForce="MinigunAmmoPickup"  // jdf

    AmmoAmount=35

    MaxDesireability=0.300000

    CollisionRadius=10.0
    CollisionHeight=3.0
    PrePivot=(X=0.0,Y=0.0,Z=5.0)

    StaticMesh=StaticMesh'WeaponPickupSM.pouches.pps43pouch'
    DrawType=DT_StaticMesh
    DrawScale=1.0
}
