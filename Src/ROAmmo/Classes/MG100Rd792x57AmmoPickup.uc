//=============================================================================
// MG100Rd792x57AmmoPickup
//=============================================================================
// Ammo pickup for german machine guns that use 100 round belt ammo
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class MG100Rd792x57AmmoPickup extends ROAmmoPickup;

defaultproperties
{
    InventoryType=class'MG100Rd792x57Ammo'

    PickupMessage="100 round 792x57mm belt added to inventory."
    TouchMessage="Pick Up: 100 round 792x57mm ammo belt"
    PickupForce="MinigunAmmoPickup"  // jdf

    AmmoAmount=100

    MaxDesireability=0.300000

    CollisionRadius=10.0
    CollisionHeight=3.0
    PrePivot=(X=0.0,Y=0.0,Z=5.0)

    StaticMesh=StaticMesh'WeaponPickupSM.Ammo.mg42magazine'
    DrawType=DT_StaticMesh
    DrawScale=1.0
}
