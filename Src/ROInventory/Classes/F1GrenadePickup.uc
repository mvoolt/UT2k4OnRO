//=============================================================================
// F1GrenadePickup
//=============================================================================
// F1Grenade Weapon pickup
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class F1GrenadePickup extends ROOneShotWeaponPickup
   notplaceable;

//=============================================================================
// Functions
//=============================================================================

static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheStaticMesh(StaticMesh'WeaponPickupSM.Projectile.F1Grenade');
	L.AddPrecacheStaticMesh(StaticMesh'WeaponPickupSM.Projectile.F1Grenade-throw');
	L.AddPrecacheMaterial(Material'Weapons3rd_tex.Soviet.f1grenade_world');
	L.AddPrecacheMaterial(Material'Weapons1st_tex.Grenades.F1grenade_S');
	L.AddPrecacheMaterial(Material'InterfaceArt_tex.HUD.F1nade_ammo');
}

defaultproperties
{
    InventoryType=class'F1GrenadeWeapon'

    PickupMessage="You got the F1 Grenade."
    TouchMessage="Pick Up: F1 Grenade"
    PickupSound=Sound'Inf_Weapons_Foley.AmmoPickup'
    PickupForce="AssaultRiflePickup"  // jdf

	MaxDesireability=+0.78

    StaticMesh=StaticMesh'WeaponPickupSM.Projectile.F1Grenade'
    DrawType=DT_StaticMesh
    DrawScale=1.0

    CollisionRadius=15.0
    CollisionHeight=3.0
    PrePivot=(X=0.0,Y=0.0,Z=3.0)
}
