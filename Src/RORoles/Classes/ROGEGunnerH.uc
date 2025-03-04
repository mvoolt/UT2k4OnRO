//=============================================================================
// ROGEGunnerH
//=============================================================================
// Defines the characteristics of a given role
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2003-2004 Erik Christensen
//=============================================================================

class ROGEGunnerH extends ROGE_Standard_Heer;

//=============================================================================
// defaultproperties
//=============================================================================

defaultproperties
{
	MyName="Machine-gunner"
	AltName="MG-Schütze"
	Article="a "
	PluralName="Machine-gunners"
	PrimaryWeaponType=WT_LMG
	PrimaryWeapons(0)=(Item=class'ROInventory.MG34Weapon',Amount=6)
	// Temp?
	PrimaryWeapons(1)=(Item=class'ROInventory.MG42Weapon',Amount=6)
	SecondaryWeapons(0)=(Item=class'ROInventory.P08LugerWeapon',Amount=1)
	SecondaryWeapons(1)=(Item=class'ROInventory.P38Weapon',Amount=1)
	Grenades(0)=(Item=class'ROInventory.StielGranateWeapon',Amount=1)
	Headgear(0)=class'ROInventory.ROGermanHelmet'
	GivenItems(0)="ROInventory.BinocularsItem"
	InfoText="MG-Schütze - Difficulty: Advanced||Armed with a light machine gun, the MG-Schütze provides the squad with its primary source of firepower.  The LMG can deliver insurmountable damage to the enemy, but careful use is required to avoid overheating or wasting ammunition.  Since the LMG is not a close combat weapon, the MG-Schütze also requires protection from his squad.  With intelligent use, a spotter, and sufficient ammo reserves, the MG-Schütze can keep the enemy at bay almost indefinitely.||Loadout: MG34, P38|* The MG-Schütze can bring the LMG into action more quickly than others as well as handle barrel changes; a leader spotting for him will increase his accuracy."
	MenuImage=Texture'InterfaceArt_tex.SelectMenus.MG-Schutze'
	bIsGunner=true
}
