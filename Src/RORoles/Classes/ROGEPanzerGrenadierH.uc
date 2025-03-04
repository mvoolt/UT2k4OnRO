//=============================================================================
// ROGEPanzerGrenadierH
//=============================================================================
// Placeholder German anti tank class
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2003-2004 John "Ramm-Jaeger" Gibson
//=============================================================================

class ROGEPanzerGrenadierH extends ROGE_Standard_Heer;

//=============================================================================
// defaultproperties
//=============================================================================

defaultproperties
{
	MyName="Anti-tank soldier"
	AltName="PaK-Soldat"
	Article="an "
	PluralName="Anti-tank soldiers"
	PrimaryWeaponType=WT_SMG
	PrimaryWeapons(0)=(Item=class'ROInventory.MP40Weapon',Amount=6,AssociatedAttachment=class'ROInventory.ROMP40AmmoPouch')
	GivenItems(0)="ROInventory.PanzerFaustWeapon"
	Headgear(0)=class'ROInventory.ROGermanHelmet'
	VoiceType="ROGame.ROGerman1Voice"
	InfoText="PaK-Soldat - Difficulty: Advanced||Mid war the German army introduced a powerful new anti-tank weapon. The Panzerfaust or 'Tank-Fist' used a shaped charge to penetrate the armor of enemy tanks. Armed with this weapon, the standard infantry soldier was now a serious threat to enemy armor."
	bEnhancedAutomaticControl=false
	MenuImage=Texture'InterfaceArt_tex.SelectMenus.Pak-soldat'
}
