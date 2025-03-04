//=============================================================================
// NebelGranate39Pickup
//=============================================================================
// German NebelHandGranate 39 smoke grenade Weapon pickup
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2006 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class NebelGranate39Pickup extends ROOneShotWeaponPickup
   notplaceable;

//=============================================================================
// Functions
//=============================================================================

static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheStaticMesh(StaticMesh'WeaponPickupSM.Projectile.gersmokenade');
	L.AddPrecacheStaticMesh(StaticMesh'WeaponPickupSM.Projectile.gersmokenade_throw');
	L.AddPrecacheMaterial(Material'Weapons3rd_tex.gersmokenade_world');
	L.AddPrecacheMaterial(Material'Weapons1st_tex.Grenades.StielGranate_smokenade'); // replaceme
	L.AddPrecacheMaterial(Material'InterfaceArt_tex.HUD.gersmokenade_ammo');
}

defaultproperties
{
    InventoryType=class'NebelGranate39Weapon'

    PickupMessage="You got the German Nb.39 Smoke Grenade."
    TouchMessage="Pick Up: German Nb.39 Smoke Grenade"
    PickupSound=Sound'Inf_Weapons_Foley.AmmoPickup'
    PickupForce="AssaultRiflePickup"  // jdf

	MaxDesireability=+0.78

    StaticMesh=StaticMesh'WeaponPickupSM.Projectile.gersmokenade'
    DrawType=DT_StaticMesh
    DrawScale=1.0

    CollisionRadius=15.0
    CollisionHeight=3.0
    PrePivot=(X=0.0,Y=0.0,Z=3.0)
}
