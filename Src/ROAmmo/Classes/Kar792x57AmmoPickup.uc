//=============================================================================
// Kar792x57AmmoPickup
//=============================================================================
// Ammo pickup for Kar98 rifles using 7.92x57mm ammo
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class Kar792x57AmmoPickup extends ROMultiMagAmmoPickup;

defaultproperties
{
    InventoryType=class'Kar792x57Ammo'

    PickupMessage="You picked up a 7.92x57mm ammo pouch."
    TouchMessage="Pick Up: 7.92x57mm ammo pouch"
    PickupForce="MinigunAmmoPickup"  // jdf

    AmmoAmount=5

    MaxDesireability=0.300000

    CollisionRadius=10.0
    CollisionHeight=3.0
    PrePivot=(X=0.0,Y=0.0,Z=5.0)

    StaticMesh=StaticMesh'WeaponPickupSM.pouches.kar98pouch'
    DrawType=DT_StaticMesh
    DrawScale=1.0
}
