//=============================================================================
// ROGERiflemanSplinterH
//=============================================================================
// Defines the characteristics of a given role
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2003-2004 Erik Christensen
//=============================================================================

class ROGESemiAutoSplinterH extends ROGE_Splinter_Heer;

//=============================================================================
// defaultproperties
//=============================================================================

defaultproperties
{
	MyName="Semi-Auto Rifleman"
	AltName="Schütze mit MK"
	Article="a "
	PluralName="Semi-Auto Riflemen"
	PrimaryWeaponType=WT_SemiAuto
	PrimaryWeapons(0)=(Item=class'ROInventory.G43Weapon',Amount=9,AssociatedAttachment=class'ROInventory.ROG43AmmoPouch')
	Grenades(0)=(Item=class'ROInventory.StielGranateWeapon',Amount=2)
	Headgear(0)=class'ROInventory.ROGermanHelmetTwo'
	InfoText="Schütze mit MK - Difficulty: Easy||Some of the Schütze were issued with automatic rifles, as they became available. They had the same vital role of taking and holding ground. These were standard riflemen lucky enough to get their hands on the latest technology in rifles to engage the enemy at moderate to long range.||Loadout: G43, grenades."
	MenuImage=Texture'InterfaceArt_tex.SelectMenus.SchutzemitMK'
}
