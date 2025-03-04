//=============================================================================
// StielGranatePickup
//=============================================================================
// StielGranate Weapon pickup
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class StielGranatePickup extends ROOneShotWeaponPickup
   notplaceable;

//=============================================================================
// Functions
//=============================================================================

static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheStaticMesh(StaticMesh'WeaponPickupSM.Projectile.Stielhandgranate');
	L.AddPrecacheStaticMesh(StaticMesh'WeaponPickupSM.Projectile.Stielhandgranate_throw');
	L.AddPrecacheMaterial(Material'Weapons3rd_tex.German.Stielhandgranate');
	L.AddPrecacheMaterial(Material'Weapons1st_tex.Grenades.Stiel_S');
	L.AddPrecacheMaterial(Material'InterfaceArt_tex.HUD.sticknade_ammo');
}

defaultproperties
{
    InventoryType=class'StielGranateWeapon'

    PickupMessage="You got the German Stick Grenade."
    TouchMessage="Pick Up: German Stick Grenade"
    PickupSound=Sound'Inf_Weapons_Foley.AmmoPickup'
    PickupForce="AssaultRiflePickup"  // jdf

	MaxDesireability=+0.78

    StaticMesh=StaticMesh'WeaponPickupSM.Projectile.Stielhandgranate'
    DrawType=DT_StaticMesh
    DrawScale=1.0

    CollisionRadius=15.0
    CollisionHeight=3.0
    PrePivot=(X=0.0,Y=0.0,Z=3.0)
}
