//=============================================================================
// P08LugerPickup
//=============================================================================
// P08 Luger Weapon pickup
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class P08LugerPickup extends ROWeaponPickup
   notplaceable;

//=============================================================================
// Functions
//=============================================================================

static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheStaticMesh(StaticMesh'WeaponPickupSM.Weapons.luger');
	L.AddPrecacheStaticMesh(StaticMesh'WeaponPickupSM.pouches.pistolpouch');
	L.AddPrecacheMaterial(Material'Weapons3rd_tex.German.luger_world');
	L.AddPrecacheMaterial(Material'Weapons1st_tex.Pistols.luger_s');
	L.AddPrecacheMaterial(Material'InterfaceArt_tex.HUD.luger_ammo');
}

defaultproperties
{
    InventoryType=class'P08LugerWeapon'

    PickupMessage="You got the P08 Luger."
    TouchMessage="Pick Up: P08 Luger Pistol"
    PickupForce="AssaultRiflePickup"  // jdf

	MaxDesireability=+0.1

    StaticMesh=StaticMesh'WeaponPickupSM.Weapons.luger'
    DrawType=DT_StaticMesh
    DrawScale=1.0

    CollisionRadius=15.0
    CollisionHeight=3.0
    PrePivot=(X=0.0,Y=0.0,Z=3.0)
}
