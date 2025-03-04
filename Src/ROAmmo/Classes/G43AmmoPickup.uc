//=============================================================================
// G43AmmoPickup
//=============================================================================
// Ammo pickup for the G43
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class G43AmmoPickup extends ROMultiMagAmmoPickup;

defaultproperties
{
    InventoryType=class'G43Ammo'

    PickupMessage="You picked up a G43 mag pouch."
    TouchMessage="Pick Up: G43 mag pouch"
    PickupForce="MinigunAmmoPickup"  // jdf

    AmmoAmount=10

    MaxDesireability=0.300000

    CollisionRadius=10.0
    CollisionHeight=3.0
    PrePivot=(X=0.0,Y=0.0,Z=5.0)

    StaticMesh=StaticMesh'WeaponPickupSM.pouches.g43pouch'
    DrawType=DT_StaticMesh
    DrawScale=1.0
}
