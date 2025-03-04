//=============================================================================
// G43Pickup
//=============================================================================
// G43 Weapon pickup
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class G43Pickup extends ROWeaponPickup
   notplaceable;

//=============================================================================
// Functions
//=============================================================================

static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheStaticMesh(StaticMesh'WeaponPickupSM.Weapons.g43');
	L.AddPrecacheStaticMesh(StaticMesh'WeaponPickupSM.pouches.g43pouch');
	L.AddPrecacheMaterial(Material'Weapons3rd_tex.German.g43_world');
	L.AddPrecacheMaterial(Material'Weapons1st_tex.Rifles.G43_S');
	L.AddPrecacheMaterial(Material'InterfaceArt_tex.HUD.G43_ammo');
}

defaultproperties
{
    InventoryType=class'G43Weapon'

    PickupMessage="You got the G43."
    TouchMessage="Pick Up: G43"
    PickupForce="AssaultRiflePickup"  // jdf

	MaxDesireability=+0.78

    StaticMesh=StaticMesh'WeaponPickupSM.Weapons.g43'
    DrawType=DT_StaticMesh
    DrawScale=1.0

    CollisionRadius=25.0
    CollisionHeight=3.0
    PrePivot=(X=0.0,Y=0.0,Z=3.0)
}
