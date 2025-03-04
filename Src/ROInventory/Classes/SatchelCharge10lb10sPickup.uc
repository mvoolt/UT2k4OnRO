//=============================================================================
// SatchelCharge10lb10sPickup
//=============================================================================
// SatchelCharge10lb10s Weapon pickup
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class SatchelCharge10lb10sPickup extends ROOneShotWeaponPickup
   notplaceable;

//=============================================================================
// Functions
//=============================================================================

static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheStaticMesh(StaticMesh'WeaponPickupSM.Projectile.satchel');
	L.AddPrecacheStaticMesh(StaticMesh'WeaponPickupSM.Projectile.Satchel_throw');
	L.AddPrecacheMaterial(Material'Weapons3rd_tex.German.satchel_world');
	L.AddPrecacheMaterial(Material'Weapons1st_tex.Grenades.SatchelCharge');
	//L.AddPrecacheMaterial(Material'ROInterfaceArt.HUD.hud_sticknade');
}

defaultproperties
{
    InventoryType=class'SatchelCharge10lb10sWeapon'

    PickupMessage="You got the 10 lb Satchel Charge."
    TouchMessage="Pick Up: 10 lb Satchel Charge"
    PickupSound=Sound'Inf_Weapons_Foley.AmmoPickup'
    PickupForce="AssaultRiflePickup"  // jdf

	MaxDesireability=+0.78

    StaticMesh=StaticMesh'WeaponPickupSM.Projectile.satchel'
    DrawType=DT_StaticMesh
    DrawScale=1.0

    CollisionRadius=15.0
    CollisionHeight=3.0
    PrePivot=(X=0.0,Y=0.0,Z=3.0)
}
