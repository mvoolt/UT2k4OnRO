//=============================================================================
// TT33AmmoPickup
//=============================================================================
// Ammo pickup for the TT33
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class TT33AmmoPickup extends ROMultiMagAmmoPickup;

defaultproperties
{
    InventoryType=class'TT33Ammo'

    PickupMessage="You picked up a TT33 mag pouch."
    TouchMessage="Pick Up: TT33 mag pouch"
    PickupForce="MinigunAmmoPickup"  // jdf

    AmmoAmount=8

    MaxDesireability=0.300000

    CollisionRadius=10.0
    CollisionHeight=3.0
    PrePivot=(X=0.0,Y=0.0,Z=5.0)

    StaticMesh=StaticMesh'WeaponPickupSM.pouches.tt33pouch'
    DrawType=DT_StaticMesh
    DrawScale=1.0
}
