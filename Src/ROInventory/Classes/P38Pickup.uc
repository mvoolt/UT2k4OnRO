//=============================================================================
// P38Pickup
//=============================================================================
// P38 Weapon pickup
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class P38Pickup extends ROWeaponPickup
   notplaceable;

//=============================================================================
// Functions
//=============================================================================

static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheStaticMesh(StaticMesh'WeaponPickupSM.Weapons.p38');
	L.AddPrecacheStaticMesh(StaticMesh'WeaponPickupSM.pouches.pistolpouch');
	L.AddPrecacheMaterial(Material'Weapons3rd_tex.German.p38_world');
	L.AddPrecacheMaterial(Material'Weapons1st_tex.Pistols.p38_S');
	L.AddPrecacheMaterial(Material'InterfaceArt_tex.HUD.p38_ammo');
}

defaultproperties
{
    InventoryType=class'P38Weapon'

    PickupMessage="You got the P38."
    TouchMessage="Pick Up: P38 Pistol"
    PickupForce="AssaultRiflePickup"  // jdf

	MaxDesireability=+0.1

    StaticMesh=StaticMesh'WeaponPickupSM.Weapons.p38'
    DrawType=DT_StaticMesh
    DrawScale=1.0

    CollisionRadius=15.0
    CollisionHeight=3.0
    PrePivot=(X=0.0,Y=0.0,Z=3.0)
}
