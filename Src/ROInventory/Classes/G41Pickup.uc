//=============================================================================
// G43Pickup
//=============================================================================
// G43 Weapon pickup
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class G41Pickup extends ROWeaponPickup
   notplaceable;

//=============================================================================
// Functions
//=============================================================================

static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheStaticMesh(StaticMesh'WeaponPickupSM.Weapons.g41');
	L.AddPrecacheStaticMesh(StaticMesh'WeaponPickupSM.pouches.kar98pouch');
	L.AddPrecacheMaterial(Material'Weapons3rd_tex.German.g41_world');
	L.AddPrecacheMaterial(Material'Weapons1st_tex2.Rifles.G41_S');
	L.AddPrecacheMaterial(Material'Weapons1st_tex.Bullets.kar98k_stripper_s');
	L.AddPrecacheMaterial(Material'InterfaceArt_tex.HUD.kar98_ammo');
}

defaultproperties
{
    InventoryType=class'G41Weapon'

    PickupMessage="You got the G41."
    TouchMessage="Pick Up: G41"
    PickupForce="AssaultRiflePickup"  // jdf

	MaxDesireability=+0.78

    StaticMesh=StaticMesh'WeaponPickupSM.Weapons.g41'
    DrawType=DT_StaticMesh
    DrawScale=1.0

    CollisionRadius=25.0
    CollisionHeight=3.0
    PrePivot=(X=0.0,Y=0.0,Z=3.0)
}
