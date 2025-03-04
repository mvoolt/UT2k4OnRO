//=============================================================================
// PTRDAmmoPickup
//=============================================================================
// Ammo pickup for PTRD AT rifle using 14.5mm ammo
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class PTRDAmmoPickup extends ROMultiMagAmmoPickup;

defaultproperties
{
    InventoryType=class'PTRDAmmo'

    PickupMessage="You picked up a 14.5mm PTRD ammo pouch."
    TouchMessage="Pick Up: 14.5mm PTRD ammo pouch"
    PickupForce="MinigunAmmoPickup"  // jdf

    AmmoAmount=1

    MaxDesireability=0.300000

    CollisionRadius=10.0
    CollisionHeight=3.0
    PrePivot=(X=0.0,Y=0.0,Z=5.0)

    StaticMesh=StaticMesh'WeaponPickupSM.pouches.ptrdpouch'
    DrawType=DT_StaticMesh
    DrawScale=1.0
}
