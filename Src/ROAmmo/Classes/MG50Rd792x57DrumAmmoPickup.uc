//=============================================================================
// MG100Rd792x57AmmoPickup
//=============================================================================
// Ammo pickup for German machine guns using 50 round ammo drums
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class MG50Rd792x57DrumAmmoPickup extends ROMultiMagAmmoPickup;

defaultproperties
{
    InventoryType=class'MG50Rd792x57DrumAmmo'

    PickupMessage="50 round 792x57mm drums added to inventory."
    TouchMessage="Pick Up: 50 round 792x57mm ammo drums"
    PickupForce="MinigunAmmoPickup"  // jdf

    AmmoAmount=50

    MaxDesireability=0.300000

    CollisionRadius=10.0
    CollisionHeight=3.0
    PrePivot=(X=0.0,Y=0.0,Z=5.0)

    StaticMesh=StaticMesh'WeaponPickupSM.Ammo.mg34magazine'
    DrawType=DT_StaticMesh
    DrawScale=1.0
}
