//=============================================================================
// ROGERiflemanSS
//=============================================================================
// Defines the characteristics of a given role
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2003-2004 Erik Christensen
//=============================================================================

class ROGERiflemanSS extends ROGE_Standard_SS;

//=============================================================================
// defaultproperties
//=============================================================================

defaultproperties
{
	MyName="SS Rifleman"
	AltName="Schütze-SS"
	Article="a "
	PluralName="Riflemen"
	PrimaryWeaponType=WT_Rifle
	PrimaryWeapons(0)=(Item=class'ROInventory.Kar98Weapon',Amount=18,AssociatedAttachment=class'ROInventory.ROKar98AmmoPouch')
	//SecondaryWeapons(0)=(Item=class'ROInventory.ROc96Base',Amount=1)
	SecondaryWeapons(0)=(Item=class'ROInventory.P08LugerWeapon',Amount=1)
	SecondaryWeapons(1)=(Item=class'ROInventory.P38Weapon',Amount=1)
    Grenades(0)=(Item=class'ROInventory.StielGranateWeapon',Amount=2)
	Headgear(0)=class'ROInventory.ROGermanHelmet'
	InfoText="Stoßtruppe-SS - Difficulty: Easy||Schütze - Difficulty: Medium||The Schütze is the main-stay of the German infantry platoon.  He is tasked with the vital role of taking and holding ground.  Using his standard issue rifle, he can effectively engage the enemy at moderate to long range.||Loadout: Kar98K, bayonet, grenades"
	MenuImage=Texture'InterfaceArt_tex.SelectMenus.Schutze'
}
