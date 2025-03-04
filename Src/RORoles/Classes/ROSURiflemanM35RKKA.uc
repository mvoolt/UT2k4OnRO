//=============================================================================
// ROSURiflemanM35RKKA
//=============================================================================
// Defines the characteristics of a given role
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2003-2004 Erik Christensen
//=============================================================================

class ROSURiflemanM35RKKA extends ROSU_Spring_RKKA;

//=============================================================================
// Functions
//=============================================================================

//-----------------------------------------------------------------------------
// GetHeadgear
//-----------------------------------------------------------------------------

function class<ROHeadgear> GetHeadgear()
{
	if (FRand() < 0.2)
	{
		if (FRand() < 0.5)
			return Headgear[2];
		else
			return Headgear[1];
	}
	else
	{
		return Headgear[0];
	}
}

//=============================================================================
// defaultproperties
//=============================================================================

defaultproperties
{
	MyName="Rifleman"
	AltName="Strelok"
	Article="a "
	PluralName="Riflemen"
	PrimaryWeaponType=WT_Rifle
	PrimaryWeapons(0)=(Item=class'ROInventory.MN9130Weapon',Amount=15,AssociatedAttachment=class'ROInventory.ROMN9130AmmoPouch')
	PrimaryWeapons(1)=(Item=class'ROInventory.M38Weapon',Amount=15,AssociatedAttachment=class'ROInventory.ROMN9130AmmoPouch')
	Grenades(0)=(Item=class'ROInventory.F1GrenadeWeapon',Amount=2)
	Headgear(0)=class'ROInventory.ROSovietSidecap'
	Headgear(1)=class'ROInventory.ROSovietHelmet'
	Headgear(2)=class'ROInventory.ROSovietHelmetTwo'
	InfoText="Strelok - Difficulty: Medium||The Soviet Strelok was the main-stay of the infantry platoon. His job is the key role of taking and holding ground. The standard rifle will reach out accurately a good distance, although longer ranges are best left to the Sniper. The Strelok is expected to close with the enemy, with rifle fire, grenade, bayonet and whatever other close-combat weapons come to hand and defeat him.||Loadout: MN 91/30, grenades" //||All the Strelok can use the squad LMG if necessary, although they will be less efficient with it."
	MenuImage=Texture'InterfaceArt_tex.SelectMenus.Strelok'
}
