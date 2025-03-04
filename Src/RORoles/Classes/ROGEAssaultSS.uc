//=============================================================================
// ROGEAssaultSS
//=============================================================================
// Defines the characteristics of a given role
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2003-2004 Erik Christensen
//=============================================================================

class ROGEAssaultSS extends ROGE_Standard_SS;

//=============================================================================
// defaultproperties
//=============================================================================

defaultproperties
{
	MyName="SS Assault Troop"
	AltName="Stoﬂtruppe-SS"
	Article="an "
	PluralName="SS Assault Troops"
	PrimaryWeaponType=WT_Assault

    //PrimaryWeapons(0)=(Item=class'ROInventory.ROMP41Base',Amount=6,AssociatedAttachment=class'ROInventory.ROMP40AmmoPouch')
	PrimaryWeapons(0)=(Item=class'ROInventory.MP40Weapon',Amount=6,AssociatedAttachment=class'ROInventory.ROMP40AmmoPouch')
	//SecondaryWeapons(0)=(Item=class'ROInventory.ROc96Base',Amount=1)
	SecondaryWeapons(0)=(Item=class'ROInventory.P08LugerWeapon',Amount=1)
	SecondaryWeapons(1)=(Item=class'ROInventory.P38Weapon',Amount=1)
    Grenades(0)=(Item=class'ROInventory.StielGranateWeapon',Amount=2)
	Headgear(0)=class'ROInventory.ROGermanHelmet'
	VoiceType="ROGame.ROGerman1Voice"
	InfoText="Stoﬂtruppe-SS - Difficulty: Easy||The Germans set up both basic infantry and engineers as Stoﬂtruppe, with the primary objective of equipping them to take on heavily-defended positions. The equipment allows them to lay down heavy fire when close to the enemy, although they are potentially vulnerable at medium range. This was one reason for the introduction of the St¸rmGewehr, with its mix of firepower and range.||Loadout: MP40, grenades"
	bEnhancedAutomaticControl=true
	MenuImage=Texture'InterfaceArt_tex.SelectMenus.Stosstruppe'
}
