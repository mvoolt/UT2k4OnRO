//=============================================================================
// G43ScopedPickup
//=============================================================================
// G43 Sniper Weapon pickup
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class G43ScopedPickup extends ROWeaponPickup
   notplaceable;

//=============================================================================
// Functions
//=============================================================================

static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheStaticMesh(StaticMesh'WeaponPickupSM.Weapons.g43scope');
	L.AddPrecacheStaticMesh(StaticMesh'WeaponPickupSM.pouches.g43pouch');
	L.AddPrecacheMaterial(Material'Weapons3rd_tex.German.g43_world');
	L.AddPrecacheMaterial(Material'Weapons1st_tex.Rifles.g43_sniper_s');
	L.AddPrecacheMaterial(Material'Weapons1st_tex.Bullets.kar98k_stripper_s');
	L.AddPrecacheMaterial(Material'Weapons1st_tex.SniperScopes.g43_scope_s');
	L.AddPrecacheMaterial(Material'InterfaceArt_tex.HUD.G43_ammo');
	L.AddPrecacheMaterial(Material'Weapon_overlays.Scopes.Ger_sniperscope_overlay');
}

defaultproperties
{
    InventoryType=class'G43ScopedWeapon'

    PickupMessage="You got the G43 Scoped."
    TouchMessage="Pick Up: G43 Scoped"
    PickupForce="AssaultRiflePickup"  // jdf

	MaxDesireability=+0.78

    StaticMesh=StaticMesh'WeaponPickupSM.Weapons.g43scope'
    DrawType=DT_StaticMesh
    DrawScale=1.0

    CollisionRadius=25.0
    CollisionHeight=3.0
    PrePivot=(X=0.0,Y=0.0,Z=3.0)
}
