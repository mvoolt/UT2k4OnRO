//=============================================================================
// ROGECombatEngineerSplinterH
//=============================================================================
// Defines the characteristics of a given role
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2003-2004 Erik Christensen
// 04/22/2004 changed InfoText DRR
//=============================================================================

class ROGECombatEngineerSplinterH extends ROGE_Splinter_Heer;

//=============================================================================
// defaultproperties
//=============================================================================

defaultproperties
{
	MyName="Combat Engineer"
	AltName="Stürmpioniere"
	Article="a "
	PluralName="Combat Engineers"
	PrimaryWeaponType=WT_SMG
	PrimaryWeapons(0)=(Item=class'ROInventory.MP40Weapon',Amount=6,AssociatedAttachment=class'ROInventory.ROMP40AmmoPouch')
	//Grenades(0)=(Item=class'ROInventory.NebelGranate39Weapon',Amount=1)
	Grenades(0)=(Item=class'ROInventory.StielGranateWeapon',Amount=1)
	GivenItems(0)="ROInventory.SatchelCharge10lb10sWeapon"
	Headgear(0)=class'ROInventory.ROGermanHelmetTwo'
	InfoText="Stürmpioniere - Difficulty: Advanced||Combat engineers were specialists, trained originally as infantry, followed by additional Engineering training. They provided direct support to the division, carrying out the following tasks on a regular basis: demolitions, assaults on heavily-fortified positions, laying mines and booby-traps, finding and lifting enemy mines, building of emergency bridges, and assault river crossings."
//	MenuImage=Material'ROInterfaceArt.RO_G_Officer'
	MenuImage=Texture'InterfaceArt_tex.SelectMenus.Sturmpionier'
}
