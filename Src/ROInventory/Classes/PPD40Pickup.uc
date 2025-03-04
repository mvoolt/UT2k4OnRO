//=============================================================================
// PPD40Pickup
//=============================================================================
// PPD40 Weapon pickup
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class PPD40Pickup extends ROWeaponPickup
   notplaceable;

//=============================================================================
// Functions
//=============================================================================

static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheStaticMesh(StaticMesh'WeaponPickupSM.Weapons.ppd40');
	L.AddPrecacheStaticMesh(StaticMesh'WeaponPickupSM.pouches.ppshpouch');
	L.AddPrecacheMaterial(Material'Weapons3rd_tex.Soviet.ppd40_world');
	L.AddPrecacheMaterial(Material'Weapons1st_tex.SMG.PPD40_1_S');
	L.AddPrecacheMaterial(Material'InterfaceArt_tex.HUD.ppsh_ammo');
}

defaultproperties
{
    InventoryType=class'PPD40Weapon'

    PickupMessage="You got the PPD40 SMG."
    TouchMessage="Pick Up: PPD40 SMG"
    PickupForce="AssaultRiflePickup"  // jdf

	MaxDesireability=+0.9

    StaticMesh=StaticMesh'WeaponPickupSM.Weapons.ppd40'
    DrawType=DT_StaticMesh
    DrawScale=1.0

    CollisionRadius=25.0
    CollisionHeight=3.0
    PrePivot=(X=0.0,Y=0.0,Z=3.0)
}
