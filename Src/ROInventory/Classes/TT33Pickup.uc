//=============================================================================
// TT33Pickup
//=============================================================================
// TT33 Weapon pickup
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class TT33Pickup extends ROWeaponPickup
   notplaceable;

//=============================================================================
// Functions
//=============================================================================

static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheStaticMesh(StaticMesh'WeaponPickupSM.Weapons.tt33');
	L.AddPrecacheStaticMesh(StaticMesh'WeaponPickupSM.pouches.tt33pouch');
	L.AddPrecacheMaterial(Material'Weapons3rd_tex.Soviet.tt33_world');
	L.AddPrecacheMaterial(Material'Weapons1st_tex.Pistols.TT33_S');
	L.AddPrecacheMaterial(Material'InterfaceArt_tex.HUD.tt33_ammo');
}

defaultproperties
{
    InventoryType=class'TT33Weapon'

    PickupMessage="You got the TT33."
    TouchMessage="Pick Up: TT33 Pistol"
    PickupForce="AssaultRiflePickup"  // jdf

	MaxDesireability=+0.1

    StaticMesh=StaticMesh'WeaponPickupSM.Weapons.tt33'
    DrawType=DT_StaticMesh
    DrawScale=1.0

    CollisionRadius=15.0
    CollisionHeight=3.0
    PrePivot=(X=0.0,Y=0.0,Z=3.0)
}
