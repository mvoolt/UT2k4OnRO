//=============================================================================
// ROSUSniperSpringNKVD
//=============================================================================
// Defines the characteristics of a given role
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2004
//=============================================================================
class ROSUSniperSpringNKVD extends ROSU_SpringCamo_NKVD;

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
	MyName="Sniper"
	AltName="Sniper"
	Article="a "
	PluralName="Snipers"
	PrimaryWeaponType=WT_Sniper
	PrimaryWeapons(0)=(Item=class'ROInventory.MN9130ScopedWeapon',Amount=15,AssociatedAttachment=class'ROInventory.ROMN9130AmmoPouch')
	PrimaryWeapons(1)=(Item=class'ROInventory.SVT40ScopedWeapon',Amount=6,AssociatedAttachment=class'ROInventory.SVT40AmmoPouch')
	SecondaryWeapons(0)=(Item=class'ROInventory.TT33Weapon',Amount=1)
	Grenades(0)=(Item=class'ROInventory.F1GrenadeWeapon',Amount=1)
	Headgear(0)=class'ROInventory.ROSovietSidecap'
	Headgear(1)=class'ROInventory.ROSovietHelmet'
	Headgear(2)=class'ROInventory.ROSovietHelmetTwo'
	InfoText="Sniper - Difficulty: Medium||The Sniper operated with his unit. While a specialist in marksmanship and camouflage, he is expected to support the other members of the unit. His targets include enemy snipers, officers and machine-gunners. He is also tasked with designating targets with tracer rounds for the squad and supporting artillery. Finally, he is expected to add his fire to that of his unit and, ultimately, engage in close combat \"with grenades, dagger and rifle butt\", rather than leave his comrades unsupported.||Loadout: SVT40 w/ scope, TT33, grenades||The Sniper will be far more accurate with a scoped rifle than anyone else."
	MenuImage=Texture'InterfaceArt_tex.SelectMenus.sniper'
}
