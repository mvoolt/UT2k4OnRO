//=============================================================================
// STG44Pickup
//=============================================================================
// STG44 Weapon pickup
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class STG44Pickup extends ROWeaponPickup
   notplaceable;

//=============================================================================
// Functions
//=============================================================================

static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheStaticMesh(StaticMesh'WeaponPickupSM.Weapons.stg44');
	L.AddPrecacheStaticMesh(StaticMesh'WeaponPickupSM.pouches.stg44pouch');
	L.AddPrecacheMaterial(Material'Weapons3rd_tex.German.stg44_world');
	L.AddPrecacheMaterial(Material'Weapons1st_tex.SMG.STG44_S');
	L.AddPrecacheMaterial(Material'InterfaceArt_tex.HUD.stg44_ammo');
}

defaultproperties
{
    InventoryType=class'STG44Weapon'

    PickupMessage="You got the STG44."
    TouchMessage="Pick Up: STG44"
    PickupForce="AssaultRiflePickup"  // jdf

	MaxDesireability=+0.9

    StaticMesh=StaticMesh'WeaponPickupSM.Weapons.stg44'
    DrawType=DT_StaticMesh
    DrawScale=1.0

    CollisionRadius=25.0
    CollisionHeight=3.0
    PrePivot=(X=0.0,Y=0.0,Z=3.0)
}
