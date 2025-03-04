//=============================================================================
// ROSUCombatEngineerFallNKVD
//=============================================================================
// Defines the characteristics of a given role
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2004
//=============================================================================
class ROSUCombatEngineerFallNKVD extends ROSU_FallCamo_NKVD;

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
	MyName="Combat Engineer"
	AltName="Saper"
	Article="a "
	PluralName="Combat Engineers"
	PrimaryWeaponType=WT_SMG
	PrimaryWeapons(0)=(Item=class'ROInventory.PPD40Weapon',Amount=6,AssociatedAttachment=class'ROInventory.ROPPSh41AmmoPouch')
	PrimaryWeapons(1)=(Item=class'ROInventory.PPSH41Weapon',Amount=6,AssociatedAttachment=class'ROInventory.ROPPSh41AmmoPouch')
	PrimaryWeapons(2)=(Item=class'ROInventory.PPS43Weapon',Amount=6,AssociatedAttachment=class'ROInventory.ROPPS43AmmoPouch')
	//Grenades(0)=(Item=class'ROInventory.RDG1GrenadeWeapon',Amount=1)
	Grenades(0)=(Item=class'ROInventory.F1GrenadeWeapon',Amount=1)
	GivenItems(0)="ROInventory.SatchelCharge10lb10sWeapon"
	Headgear(0)=class'ROInventory.ROSovietSidecap'
	Headgear(1)=class'ROInventory.ROSovietHelmet'
	Headgear(2)=class'ROInventory.ROSovietHelmetTwo'
	InfoText="Saper - Difficulty: Advanced||Combat engineers were specialists, trained originally as infantry, followed by additional Engineering training. They provided direct support to the division, carrying out the following tasks on a regular basis: demolitions, assaults on heavily-fortified positions, laying mines and booby-traps, finding and lifting enemy mines, building of emergency bridges, and assault river crossings."
	bEnhancedAutomaticControl=true
	MenuImage=Texture'InterfaceArt_tex.SelectMenus.Saper'
}
