//=============================================================================
// ROSUSquadLeaderRKKF
//=============================================================================
// Defines the characteristics of a given role
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2004
//=============================================================================
class ROSUTankerRKKF extends ROSU_RKKF_Units;

//=============================================================================
// defaultproperties
//=============================================================================

defaultproperties
{
	MyName="Tank Crewman"
	AltName="Ekipazh tanka"
	Article="a "
	PluralName="Tank Crewmen"
	PrimaryWeaponType=WT_SMG
	PrimaryWeapons(0)=(Item=class'ROInventory.PPD40Weapon',Amount=6,AssociatedAttachment=class'ROInventory.ROPPSh41AmmoPouch')
	PrimaryWeapons(1)=(Item=class'ROInventory.PPSH41Weapon',Amount=6,AssociatedAttachment=class'ROInventory.ROPPSh41AmmoPouch')
	PrimaryWeapons(2)=(Item=class'ROInventory.PPS43Weapon',Amount=6,AssociatedAttachment=class'ROInventory.ROPPS43AmmoPouch')
    SecondaryWeapons(0)=(Item=class'ROInventory.TT33Weapon',Amount=1)
	Grenades(0)=(Item=class'ROInventory.F1GrenadeWeapon',Amount=2)
	Headgear(0)=class'ROInventory.ROSovietTankerHat'
	InfoText="Ekipazh tanka - Difficulty: Advanced||The Ekipazh tanka (tank crew) consists of variations on gunner, loader, hull gunner/radio operator and the driver. Each is a specialized role, requiring specialized training. This was a major problem for the Soviets, so they picked those with most years school completed for the technical jobs. Each has a specific view sector out of the tank and is responsible for keeping watch in that direction, as well as performing their primary function."
	bEnhancedAutomaticControl=true
	MenuImage=Texture'InterfaceArt_tex.SelectMenus.Ekipazhtanka'
	bCanBeTankCrew=true
	SleeveTexture=Texture'Weapons1st_tex.RussianTankerSleeves'
	DetachedArmClass=class'SeveredArmSovTanker'
	DetachedLegClass=class'SeveredLegSovTanker'

    RolePawnClass="RORoles.RUTankerPawn"

	Models(0)="R_VehCrew1"
	Models(1)="R_VehCrew2"
	Models(2)="R_VehCrew3"
	Models(3)="R_VehCrew4"
	Models(4)="R_VehCrew5"
	Models(5)="R_VehCrew6"
}
