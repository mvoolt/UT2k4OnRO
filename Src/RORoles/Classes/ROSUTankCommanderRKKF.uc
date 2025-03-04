//=============================================================================
// ROSUSquadLeaderRKKF
//=============================================================================
// Defines the characteristics of a given role
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2004
//=============================================================================
class ROSUTankCommanderRKKF extends ROSU_RKKF_Units;

//=============================================================================
// defaultproperties
//=============================================================================

defaultproperties
{
	MyName="Tank Commander"
	AltName="Komandir tanka"
	Article="a "
	PluralName="Tank Commanders"
	PrimaryWeaponType=WT_SMG
	PrimaryWeapons(0)=(Item=class'ROInventory.PPD40Weapon',Amount=6,AssociatedAttachment=class'ROInventory.ROPPSh41AmmoPouch')
	PrimaryWeapons(1)=(Item=class'ROInventory.PPSH41Weapon',Amount=6,AssociatedAttachment=class'ROInventory.ROPPSh41AmmoPouch')
	PrimaryWeapons(2)=(Item=class'ROInventory.PPS43Weapon',Amount=6,AssociatedAttachment=class'ROInventory.ROPPS43AmmoPouch')
    SecondaryWeapons(0)=(Item=class'ROInventory.TT33Weapon',Amount=1)
	Grenades(0)=(Item=class'ROInventory.F1GrenadeWeapon',Amount=2)
	Headgear(0)=class'ROInventory.ROSovietSidecap'
	GivenItems(0)="ROInventory.BinocularsItem"
	InfoText="Komandir tanka - Difficulty: Very Advanced||The Komandir tanka is the tank commander, either an NCO or officer. His primary task was to spot targets for the gunner, as well as to direct the rest of the tank crew. He was usually the only crew member with any form of all-round view. He might, as a platoon commander, be required to lead a complete platoon of tanks, as well as direct his own. It was a complex job, made more complex in some tanks with the requirement for the commander to also man the main gun."
	bEnhancedAutomaticControl=true
	PointValue=3.0
	ObjCaptureWeight=2
	bIsLeader=true
	MenuImage=Texture'InterfaceArt_tex.SelectMenus.Komandirtanka'
	bCanBeTankCrew=true
	bCanBeTankCommander=true
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
