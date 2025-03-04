//=============================================================================
// PPSH41Pickup
//=============================================================================
// PPSH41 Weapon pickup
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class PPSh41Pickup extends ROWeaponPickup
   notplaceable;

//=============================================================================
// Functions
//=============================================================================

static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheStaticMesh(StaticMesh'WeaponPickupSM.Weapons.ppsh41');
	L.AddPrecacheStaticMesh(StaticMesh'WeaponPickupSM.pouches.ppshpouch');
	L.AddPrecacheMaterial(Material'Weapons3rd_tex.Soviet.ppsh41_world');
	L.AddPrecacheMaterial(Material'Weapons1st_tex.SMG.PPSH41_S');
	L.AddPrecacheMaterial(Material'InterfaceArt_tex.HUD.ppsh_ammo');
}

defaultproperties
{
    InventoryType=class'PPSh41Weapon'

    PickupMessage="You got the PPSh41 SMG."
    TouchMessage="Pick Up: PPSh41 SMG"
    PickupForce="AssaultRiflePickup"  // jdf

	MaxDesireability=+0.9

    StaticMesh=StaticMesh'WeaponPickupSM.Weapons.ppsh41'
    DrawType=DT_StaticMesh
    DrawScale=1.0

    CollisionRadius=25.0
    CollisionHeight=3.0
    PrePivot=(X=0.0,Y=0.0,Z=3.0)
}
