//=============================================================================
// Kar98Pickup
//=============================================================================
// Kar98 Weapon pickup
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class Kar98Pickup extends ROWeaponPickup
   notplaceable;

//-----------------------------------------------------------------------------
// StaticPrecache
//-----------------------------------------------------------------------------

static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheStaticMesh(StaticMesh'WeaponPickupSM.Weapons.k98');
	L.AddPrecacheStaticMesh(StaticMesh'WeaponPickupSM.pouches.kar98pouch');
	L.AddPrecacheMaterial(Material'Weapons3rd_tex.German.Kar98_world');
	L.AddPrecacheMaterial(Material'Weapons3rd_tex.German.kar98_bayammo_world');
	L.AddPrecacheMaterial(Material'Weapons1st_tex.Rifles.Kar98k_1_S');
	L.AddPrecacheMaterial(Material'Weapons1st_tex.Bullets.kar98k_stripper_s');
	L.AddPrecacheMaterial(Material'Weapons1st_tex.Bayonet.KarBayonet_S');
	L.AddPrecacheMaterial(Material'InterfaceArt_tex.HUD.kar98_ammo');
}

defaultproperties
{
    InventoryType=class'ROInventory.Kar98Weapon'

    PickupMessage="You got the Kar98k."
    TouchMessage="Pick Up: Kar98k"
    PickupForce="AssaultRiflePickup"  // jdf

	MaxDesireability=+0.4

    StaticMesh=StaticMesh'WeaponPickupSM.k98'
    DrawType=DT_StaticMesh
    DrawScale=1.0

    CollisionRadius=25.0
    CollisionHeight=3.0
    PrePivot=(X=0.0,Y=0.0,Z=3.0)
}

