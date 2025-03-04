//=============================================================================
// ROSUGunnerM35RKKA
//=============================================================================
// Defines the characteristics of a given role
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2003-2004 Erik Christensen
//=============================================================================

class ROSUGunnerM35RKKA extends ROSU_Spring_RKKA;

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
	MyName="Machine-gunner"
	AltName="Pulemetchik"
	Article="a "
	PluralName="Machine-gunners"
	PrimaryWeaponType=WT_LMG
	PrimaryWeapons(0)=(Item=class'ROInventory.DP28Weapon',Amount=1)
	SecondaryWeapons(0)=(Item=class'ROInventory.TT33Weapon',Amount=1)
	Grenades(0)=(Item=class'ROInventory.F1GrenadeWeapon',Amount=1)
	Headgear(0)=class'ROInventory.ROSovietSidecap'
	Headgear(1)=class'ROInventory.ROSovietHelmet'
	Headgear(2)=class'ROInventory.ROSovietHelmetTwo'
	GivenItems(0)="ROInventory.BinocularsItem"
	InfoText="Pulemetchik - Difficulty: Advanced||The Pulemetchik provides the main firepower for each squad, whether on attack or defense. The Soviet Light MGs do not have the same firepower as the Germans - but they do not overheat so readily and the ammo is simpler to carry in the standard drums. However, the Soviets added a couple of extra Light MGs into the platoon to combat the German firepower. The LMG is not a close-combat weapon, so the Pulemetchik needs protection by his squad, as well as a constant supply of ammo.||Loadout: Light MG, pistol, entrenching tool||The Pulemetchik can bring the LMG into action more quickly than others; a leader spotting for him will increase his efficiency."
	MenuImage=Texture'InterfaceArt_tex.SelectMenus.Pulemetchik'
	bIsGunner=true
}
