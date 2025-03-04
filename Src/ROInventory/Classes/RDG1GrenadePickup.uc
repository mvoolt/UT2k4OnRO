//=============================================================================
// RDG1GrenadePickup
//=============================================================================
// Russian RDG1 smoke grenade Weapon pickup
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2006 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class RDG1GrenadePickup extends ROOneShotWeaponPickup
   notplaceable;

//=============================================================================
// Functions
//=============================================================================

static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheStaticMesh(StaticMesh'WeaponPickupSM.Projectile.rgd1');
	L.AddPrecacheStaticMesh(StaticMesh'WeaponPickupSM.Projectile.rgd1_throw');
	L.AddPrecacheMaterial(Material'Weapons3rd_tex.RDG1_world');
	L.AddPrecacheMaterial(Material'Weapons1st_tex.Grenades.RDG_1'); // replaceme
	L.AddPrecacheMaterial(Material'InterfaceArt_tex.HUD.RDG1_ammo');
}

defaultproperties
{
    InventoryType=class'RDG1GrenadeWeapon'

    PickupMessage="You got the Russian RDG-1 Smoke Grenade."
    TouchMessage="Pick Up: Russian RDG-1 Smoke Grenade"
    PickupSound=Sound'Inf_Weapons_Foley.AmmoPickup'
    PickupForce="AssaultRiflePickup"  // jdf

	MaxDesireability=+0.78

    StaticMesh=StaticMesh'WeaponPickupSM.Projectile.rgd1'
    DrawType=DT_StaticMesh
    DrawScale=1.0

    CollisionRadius=15.0
    CollisionHeight=3.0
    PrePivot=(X=0.0,Y=0.0,Z=3.0)
}
