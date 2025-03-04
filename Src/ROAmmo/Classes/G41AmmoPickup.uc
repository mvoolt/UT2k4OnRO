//=============================================================================
// G41AmmoPickup
//=============================================================================
// Ammo pickup for the G41
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class G41AmmoPickup extends ROMultiMagAmmoPickup;

defaultproperties
{
    InventoryType=class'G41Ammo'

    PickupMessage="You picked up a G41 mag pouch."
    TouchMessage="Pick Up: G41 mag pouch"
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
