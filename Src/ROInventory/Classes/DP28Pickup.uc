//=============================================================================
// DP28Pickup
//=============================================================================
// DP28 Weapon pickup
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================
class DP28Pickup extends ROMGWeaponPickup
   notplaceable;

//-----------------------------------------------------------------------------
// StaticPrecache
//-----------------------------------------------------------------------------

static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheStaticMesh(StaticMesh'WeaponPickupSM.Weapons.DP28');
	L.AddPrecacheStaticMesh(StaticMesh'WeaponPickupSM.pouches.dp27pouch');
	L.AddPrecacheMaterial(Material'Gear_tex.equipment.rus_equipment');
	L.AddPrecacheMaterial(Material'Weapons3rd_tex.Soviet.DP28_World');
	L.AddPrecacheMaterial(Material'Weapons1st_tex.MG.dp28_s');
	L.AddPrecacheMaterial(Material'InterfaceArt_tex.HUD.DP27_ammo');
}

defaultproperties
{
    InventoryType=class'ROInventory.DP28Weapon'

    PickupMessage="You got the DP-28."
    TouchMessage="Pick Up: DP-28 MG"
    PickupForce="AssaultRiflePickup"  // jdf

	MaxDesireability=+0.4

    StaticMesh=StaticMesh'WeaponPickupSM.DP28'
    DrawType=DT_StaticMesh
    DrawScale=1.0

    CollisionRadius=25.0
    CollisionHeight=3.0
    PrePivot=(X=0.0,Y=0.0,Z=3.0)
}
