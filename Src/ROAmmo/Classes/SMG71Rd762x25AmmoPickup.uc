//=============================================================================
// SMG71Rd762x25AmmoPickup
//=============================================================================
// Ammo pickup for PPSH style smgs
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class SMG71Rd762x25AmmoPickup extends ROMultiMagAmmoPickup;

defaultproperties
{
    InventoryType=class'SMG71Rd762x25Ammo'

    PickupMessage="You picked up a 71 round 7.62x25mm drum pouch"
    TouchMessage="Pick Up: 71 round 7.62x25mm drum pouch"
    PickupForce="MinigunAmmoPickup"  // jdf

    AmmoAmount=71

    MaxDesireability=0.300000

    CollisionRadius=10.0
    CollisionHeight=3.0
    PrePivot=(X=0.0,Y=0.0,Z=5.0)

    StaticMesh=StaticMesh'WeaponPickupSM.pouches.ppshpouch'
    DrawType=DT_StaticMesh
    DrawScale=1.0
}
