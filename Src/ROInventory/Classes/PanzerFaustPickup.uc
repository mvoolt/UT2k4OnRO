//=============================================================================
// PanzerFaustPickup
//=============================================================================
// PanzerFaust Weapon pickup
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class PanzerFaustPickup extends ROWeaponPickup
   notplaceable;

//=============================================================================
// Functions
//=============================================================================

static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheStaticMesh(StaticMesh'WeaponPickupSM.Weapons.Panzerfaust');
	L.AddPrecacheStaticMesh(StaticMesh'WeaponPickupSM.Ammo.Warhead3rd');
	L.AddPrecacheStaticMesh(StaticMesh'WeaponPickupSM.Ammo.Warhead1st');
	L.AddPrecacheMaterial(Material'Weapons3rd_tex.German.Panzerfaust_world');
	L.AddPrecacheMaterial(Material'Weapons1st_tex.Grenades.Panzerfaust_S');
	L.AddPrecacheMaterial(Material'InterfaceArt_tex.HUD.panzerfaust_ammo');
}

// Every dropped panzerfaust is one shot only
function InitDroppedPickupFor(Inventory Inv)
{
    local Weapon W;
    W = Weapon(Inv);
    if (W != None)
    {
        AmmoAmount[0] = 1;
        AmmoAmount[1] = 0;
    }

	SetPhysics(PHYS_Falling);
	GotoState('FallingPickup');
	Inventory = Inv;
	bAlwaysRelevant = false;
	bOnlyReplicateHidden = false;
	bUpdateSimulatedPosition = true;
    bDropped = true;
    LifeSpan = DropLifeTime + rand(10);
	bIgnoreEncroachers = false; // handles case of dropping stuff on lifts etc
	NetUpdateFrequency = 8;
}


defaultproperties
{
    InventoryType=class'PanzerFaustWeapon'

    PickupMessage="You got the Panzerfaust."
    TouchMessage="Pick Up: Panzerfaust"
    PickupForce="AssaultRiflePickup"  // jdf

	MaxDesireability=+0.78

    StaticMesh=StaticMesh'WeaponPickupSM.Weapons.Panzerfaust'
    DrawType=DT_StaticMesh
    DrawScale=1.0

    CollisionRadius=25.0
    CollisionHeight=3.0
    PrePivot=(X=0.0,Y=0.0,Z=3.0)
}
