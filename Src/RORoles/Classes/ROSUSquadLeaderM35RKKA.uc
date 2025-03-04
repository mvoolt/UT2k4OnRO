//=============================================================================
// ROSUSquadLeaderM35RKKA
//=============================================================================
// Defines the characteristics of a given role
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2003-2004 Erik Christensen
//=============================================================================

class ROSUSquadLeaderM35RKKA extends ROSU_Spring_RKKA;

//=============================================================================
// defaultproperties
//=============================================================================

defaultproperties
{
	MyName="Squad Leader"
	AltName="Komandir otdeleniya"
	Article="a "
	PluralName="Squad Leaders"
	PrimaryWeaponType=WT_SMG
	PrimaryWeapons(0)=(Item=class'ROInventory.PPD40Weapon',Amount=6,AssociatedAttachment=class'ROInventory.ROPPSh41AmmoPouch')
	PrimaryWeapons(1)=(Item=class'ROInventory.PPSH41Weapon',Amount=6,AssociatedAttachment=class'ROInventory.ROPPSh41AmmoPouch')
	PrimaryWeapons(2)=(Item=class'ROInventory.PPS43Weapon',Amount=6,AssociatedAttachment=class'ROInventory.ROPPS43AmmoPouch')
	SecondaryWeapons(0)=(Item=class'ROInventory.TT33Weapon',Amount=1)
	Grenades(0)=(Item=class'ROInventory.RDG1GrenadeWeapon',Amount=2)
	//Grenades(1)=(Item=class'ROInventory.F1GrenadeWeapon',Amount=2)
	GivenItems(0)="ROInventory.BinocularsItem"
	Headgear(0)=class'ROInventory.ROSovietOfficerHat'
	InfoText="Komandir otdeleniya - Difficulty: Very Advanced||The Komandir otdeleniya [Ko] is the Squad Leader, an NCO by rank. His role is to direct the squad in combat and to see to the completion of the squad's objectives. He is equipped for close-range combat and will direct the fire of the squad at medium and long ranges, rather than join in. His weaponry is intended to provide last-minute close-range fire support to the squad. He is, of course, also expected to lead by example. In Soviet usage, he is also responsible for ammo resupply for the squad.||Loadout: PPSh41, grenades||* The Ko counts one and a half times when taking and holding objectives."
	bEnhancedAutomaticControl=true
	PointValue=3.0
	ObjCaptureWeight=2
	bIsLeader=true
	MenuImage=Texture'InterfaceArt_tex.SelectMenus.KO'
}
