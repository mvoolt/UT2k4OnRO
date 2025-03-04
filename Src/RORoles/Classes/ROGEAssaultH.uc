//=============================================================================
// ROGEAssaultH
//=============================================================================
// Defines the characteristics of a given role
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2003-2004 Erik Christensen
//=============================================================================

class ROGEAssaultH extends ROGE_Standard_Heer;

//=============================================================================
// defaultproperties
//=============================================================================

defaultproperties
{
	MyName="Assault Trooper"
	AltName="Stoﬂtruppe"
	Article="an "
	PluralName="Assault Troops"
	PrimaryWeaponType=WT_Assault
	PrimaryWeapons(0)=(Item=class'ROInventory.MP40Weapon',Amount=6,AssociatedAttachment=class'ROInventory.ROMP40AmmoPouch')
	PrimaryWeapons(1)=(Item=class'ROInventory.STG44Weapon',Amount=6,AssociatedAttachment=class'ROInventory.ROSTG44AmmoPouch')
	Grenades(0)=(Item=class'ROInventory.StielGranateWeapon',Amount=2)
	Headgear(0)=class'ROInventory.ROGermanHelmet'
	VoiceType="ROGame.ROGerman1Voice"
	InfoText="Stoﬂtruppe - Difficulty: Easy||The Germans set up both basic infantry and engineers as Stoﬂtruppe, with the primary objective of equipping them to take on heavily-defended positions. The equipment allows them to lay down heavy fire when close to the enemy, although they are potentially vulnerable at medium range. This was one reason for the introduction of the St¸rmGewehr, with its mix of firepower and range.||Loadout: MP40, grenades"
	bEnhancedAutomaticControl=true
	MenuImage=Texture'InterfaceArt_tex.SelectMenus.Stosstruppe'
}
