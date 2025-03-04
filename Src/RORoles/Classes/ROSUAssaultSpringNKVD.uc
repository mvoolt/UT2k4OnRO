//=============================================================================
// ROSUAssaultSpringNKVD
//=============================================================================
// Defines the characteristics of a given role
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2004
//=============================================================================

class ROSUAssaultSpringNKVD extends ROSU_SpringCamo_NKVD;

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
	MyName="Assault Trooper"
	AltName="Avtomatchik"
	Article="an "
	PluralName="Assault Troops"
	PrimaryWeaponType=WT_Assault
	PrimaryWeapons(0)=(Item=class'ROInventory.PPD40Weapon',Amount=6,AssociatedAttachment=class'ROInventory.ROPPSh41AmmoPouch')
	PrimaryWeapons(1)=(Item=class'ROInventory.PPSH41Weapon',Amount=6,AssociatedAttachment=class'ROInventory.ROPPSh41AmmoPouch')
	PrimaryWeapons(2)=(Item=class'ROInventory.PPS43Weapon',Amount=6,AssociatedAttachment=class'ROInventory.ROPPS43AmmoPouch')
	Grenades(0)=(Item=class'ROInventory.F1GrenadeWeapon',Amount=2)
	Headgear(0)=class'ROInventory.ROSovietSidecap'
	Headgear(1)=class'ROInventory.ROSovietHelmet'
	Headgear(2)=class'ROInventory.ROSovietHelmetTwo'
	InfoText="Avtomatchik - Difficulty: Easy||The Soviets created separate companies and platoons in every Rifle Division made up entirely of SMG-armed Avtomatchiks. The role of the Avtomatchick is to ambush the enemy, infiltrate his positions and assault them. The equipment allows them to lay down heavy fire suddenly when close to the enemy, although they are potentially vulnerable at medium range. The favored weapon was always the Pa-Pa-Shah, with its high rate of firepower and remarkable accuracy when emptying a whole magazine at the enemy.||Loadout: PPSh41, grenades" //||All the Avtomatchik can use the squad LMG if necessary, although they will be less efficient with it."
	bEnhancedAutomaticControl=true
	MenuImage=Texture'InterfaceArt_tex.SelectMenus.Avtomatchik'
}
