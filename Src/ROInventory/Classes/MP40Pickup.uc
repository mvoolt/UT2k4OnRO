//=============================================================================
// MP40Pickup
//=============================================================================
// MP40 Weapon pickup
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class MP40Pickup extends ROWeaponPickup
   notplaceable;

//=============================================================================
// Functions
//=============================================================================

static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheStaticMesh(StaticMesh'WeaponPickupSM.Weapons.mp40');
	L.AddPrecacheStaticMesh(StaticMesh'WeaponPickupSM.pouches.mp40pouch');
	L.AddPrecacheMaterial(Material'Weapons3rd_tex.German.mp40_world');
	L.AddPrecacheMaterial(Material'Weapons1st_tex.SMG.MP40_S');
	L.AddPrecacheMaterial(Material'InterfaceArt_tex.HUD.mg40_ammo');
}

defaultproperties
{
    InventoryType=class'MP40Weapon'

    PickupMessage="You got the MP40 smg."
    TouchMessage="Pick Up: MP40 smg"
    PickupForce="AssaultRiflePickup"  // jdf

	MaxDesireability=+0.78

    StaticMesh=StaticMesh'WeaponPickupSM.Weapons.mp40'
    DrawType=DT_StaticMesh
    DrawScale=1.0

    CollisionRadius=25.0
    CollisionHeight=3.0
    PrePivot=(X=0.0,Y=0.0,Z=3.0)
}
