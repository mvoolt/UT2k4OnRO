//=============================================================================
// MP41Pickup
//=============================================================================
// MP41 Weapon pickup
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class MP41Pickup extends MP40Pickup
   notplaceable;

//=============================================================================
// Functions
//=============================================================================

static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheStaticMesh(StaticMesh'WeaponPickupSM.Weapons.mp41');
	L.AddPrecacheStaticMesh(StaticMesh'WeaponPickupSM.pouches.mp40pouch');
	L.AddPrecacheMaterial(Material'Weapons3rd_tex.German.mp41_world');
	L.AddPrecacheMaterial(Material'Weapons1st_tex.SMG.MP41_S');
	L.AddPrecacheMaterial(Material'InterfaceArt_tex.HUD.mg40_ammo');
}

defaultproperties
{
    InventoryType=class'MP41Weapon'

    PickupMessage="You got the MP41 smg."
    TouchMessage="Pick Up: MP41 smg"

    StaticMesh=StaticMesh'WeaponPickupSM.Weapons.mp41'
}
