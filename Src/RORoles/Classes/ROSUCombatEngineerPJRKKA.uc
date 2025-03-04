//=============================================================================
// ROSUCombatEngineerPJRKKA
//=============================================================================
// Defines the characteristics of a given role
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2003-2004 Erik Christensen
// 4/22/2004 changed InfoText DRR
//=============================================================================

class ROSUCombatEngineerPJRKKA extends ROSU_Winter_RKKA;

//=============================================================================
// Functions
//=============================================================================

//-----------------------------------------------------------------------------
// GetHeadgear
//-----------------------------------------------------------------------------

function class<ROHeadgear> GetHeadgear()
{
	if (FRand() < 0.2)
		return Headgear[1];
	else
		return Headgear[0];
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
	GivenItems(0)="ROInventory.SatchelCharge10lb10sWeapon"
	//Grenades(0)=(Item=class'ROInventory.RDG1GrenadeWeapon',Amount=1)
	Grenades(0)=(Item=class'ROInventory.F1GrenadeWeapon',Amount=1)
	Headgear(0)=class'ROInventory.ROSovietFurHat'
	Headgear(1)=class'ROInventory.ROSovietFurHatTwo'
	InfoText="Saper - Difficulty: Advanced||Combat engineers were specialists, trained originally as infantry, followed by additional Engineering training. They provided direct support to the division, carrying out the following tasks on a regular basis: demolitions, assaults on heavily-fortified positions, laying mines and booby-traps, finding and lifting enemy mines, building of emergency bridges, and assault river crossings."
	bEnhancedAutomaticControl=true
	MenuImage=Texture'InterfaceArt_tex.SelectMenus.Saper'
}
