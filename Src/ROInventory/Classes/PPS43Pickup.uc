//=============================================================================
// PPS43Pickup
//=============================================================================
// PPS43 Weapon pickup
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class PPS43Pickup extends ROWeaponPickup
   notplaceable;

//=============================================================================
// Functions
//=============================================================================

static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheStaticMesh(StaticMesh'WeaponPickupSM.Weapons.pps43');
	L.AddPrecacheStaticMesh(StaticMesh'WeaponPickupSM.pouches.pps43pouch');
	L.AddPrecacheMaterial(Material'Weapons3rd_tex.Soviet.pps43_world');
	L.AddPrecacheMaterial(Material'Weapons1st_tex.SMG.pps43_s');
	L.AddPrecacheMaterial(Material'InterfaceArt_tex.HUD.pps43_ammo');
}

defaultproperties
{
    InventoryType=class'PPS43Weapon'

    PickupMessage="You got the PPS43 SMG."
    TouchMessage="Pick Up: PPS43 SMG"
    PickupForce="AssaultRiflePickup"  // jdf

	MaxDesireability=+0.9

    StaticMesh=StaticMesh'WeaponPickupSM.Weapons.pps43'
    DrawType=DT_StaticMesh
    DrawScale=1.0

    CollisionRadius=25.0
    CollisionHeight=3.0
    PrePivot=(X=0.0,Y=0.0,Z=3.0)
}
