//=============================================================================
// MG34Pickup
//=============================================================================
// MG34 Weapon pickup
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================
class MG34Pickup extends ROMGWeaponPickup
   notplaceable;

//-----------------------------------------------------------------------------
// StaticPrecache
//-----------------------------------------------------------------------------

static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Material'Weapons1st_tex.Arms.hands_gergloves');

	L.AddPrecacheStaticMesh(StaticMesh'WeaponPickupSM.Weapons.mg34');
	L.AddPrecacheStaticMesh(StaticMesh'WeaponPickupSM.Ammo.mg34magazine');
	L.AddPrecacheStaticMesh(StaticMesh'EffectsSM.Ger_Tracer');
	L.AddPrecacheMaterial(Material'Weapons3rd_tex.German.MG34_World');
	L.AddPrecacheMaterial(Material'Weapons1st_tex.MG.MG42_S');
	L.AddPrecacheMaterial(Material'Weapons1st_tex.MG.MGbipod_S');
	L.AddPrecacheMaterial(Material'Weapons1st_tex.MG.MGBelt_S');
	L.AddPrecacheMaterial(Material'InterfaceArt_tex.HUD.MG34_ammo');
}

defaultproperties
{
    InventoryType=class'ROInventory.MG34Weapon'

    PickupMessage="You got the MG34."
    TouchMessage="Pick Up: MG34"
    PickupForce="AssaultRiflePickup"  // jdf

	MaxDesireability=+0.4

    StaticMesh=StaticMesh'WeaponPickupSM.MG34'
    DrawType=DT_StaticMesh
    DrawScale=1.0

    CollisionRadius=25.0
    CollisionHeight=3.0
    PrePivot=(X=0.0,Y=0.0,Z=3.0)
}
