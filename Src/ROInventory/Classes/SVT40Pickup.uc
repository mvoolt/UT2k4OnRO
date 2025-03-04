//=============================================================================
// SVT40Pickup
//=============================================================================
// SVT40 Weapon pickup
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class SVT40Pickup extends ROWeaponPickup
   notplaceable;

#exec OBJ LOAD FILE=..\StaticMeshes\WeaponPickupSM.usx
#exec OBJ LOAD File=..\Textures\Weapons3rd_tex.utx
#exec OBJ LOAD File=Weapons1st_tex.utx

//=============================================================================
// Functions
//=============================================================================

static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheStaticMesh(StaticMesh'WeaponPickupSM.Weapons.svt40');
	L.AddPrecacheStaticMesh(StaticMesh'WeaponPickupSM.pouches.svt40pouch');
	L.AddPrecacheMaterial(Material'Weapons3rd_tex.Soviet.svt40_world');
	L.AddPrecacheMaterial(Material'Weapons3rd_tex.Soviet.svt40_bayonet_world');
	L.AddPrecacheMaterial(Material'Weapons1st_tex.Rifles.SVT40_S');
	L.AddPrecacheMaterial(Material'Weapons1st_tex.bayonet.SVTBayonet_S');
	L.AddPrecacheMaterial(Material'InterfaceArt_tex.HUD.svt40_ammo');
}

defaultproperties
{
    InventoryType=class'SVT40Weapon'

    PickupMessage="You got the SVT40."
    TouchMessage="Pick Up: SVT40"
    PickupForce="AssaultRiflePickup"  // jdf

	MaxDesireability=+0.78

    StaticMesh=StaticMesh'WeaponPickupSM.Weapons.svt40'
    DrawType=DT_StaticMesh
    DrawScale=1.0

    CollisionRadius=25.0
    CollisionHeight=3.0
    PrePivot=(X=0.0,Y=0.0,Z=3.0)
}
