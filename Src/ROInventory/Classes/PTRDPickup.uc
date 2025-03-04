//=============================================================================
// PTRDPickup
//=============================================================================
// PTRD Weapon pickup
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================
class PTRDPickup extends ROWeaponPickup
   notplaceable;

#exec OBJ LOAD FILE=InterfaceArt_tex.utx

//-----------------------------------------------------------------------------
// StaticPrecache
//-----------------------------------------------------------------------------

static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheStaticMesh(StaticMesh'WeaponPickupSM.Weapons.ptrd');
	L.AddPrecacheStaticMesh(StaticMesh'WeaponPickupSM.pouches.ptrdpouch');
	L.AddPrecacheMaterial(Material'Weapons3rd_tex.Soviet.ptrd_world');
	L.AddPrecacheMaterial(Material'Weapons1st_tex.Rifles.PTRD_S');
	L.AddPrecacheMaterial(Material'InterfaceArt_tex.HUD.PTRD_ammo');
}

defaultproperties
{
    InventoryType=class'ROInventory.PTRDWeapon'

    PickupMessage="You got the PTRD."
    TouchMessage="Pick Up: PTRD AT Rifle"
    PickupForce="AssaultRiflePickup"  // jdf

	MaxDesireability=+0.4

    StaticMesh=StaticMesh'WeaponPickupSM.ptrd'
    DrawType=DT_StaticMesh
    DrawScale=1.0

    CollisionRadius=25.0
    CollisionHeight=3.0
    PrePivot=(X=0.0,Y=0.0,Z=3.0)
}
