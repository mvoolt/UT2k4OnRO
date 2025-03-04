//=============================================================================
// ROSUAntiTankPJRKKA
//=============================================================================
// Placeholder Russian anti-tank class - winter
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2003-2004 John "Ramm-Jaeger" Gibson

class ROSUAntiTankPJRKKA extends ROSU_Winter_RKKA;

//=============================================================================
// Functions
//=============================================================================

//-----------------------------------------------------------------------------
// GetHeadgear
//-----------------------------------------------------------------------------

function class<ROHeadgear> GetHeadgear()
{
	if (FRand() < 0.2)
		return Headgear[1];
	else
		return Headgear[0];
}

//=============================================================================
// defaultproperties
//=============================================================================

defaultproperties
{
	MyName="Anti-tank soldier"
	AltName="PT-Soldat"
	Article="an "
	PluralName="Anti-tank soldiers"
	PrimaryWeaponType=WT_PTRD
	PrimaryWeapons(0)=(Item=class'ROInventory.PTRDWeapon',Amount=1,AssociatedAttachment=class'ROInventory.ROPPSh41AmmoPouch')
	SecondaryWeapons(0)=(Item=class'ROInventory.TT33Weapon',Amount=1)
	GivenItems(0)="ROInventory.BinocularsItem"
	Grenades(0)=(Item=class'ROInventory.F1GrenadeWeapon',Amount=2)
	Headgear(0)=class'ROInventory.ROSovietFurHat'
	Headgear(1)=class'ROInventory.ROSovietHelmet'
	Headgear(2)=class'ROInventory.ROSovietHelmetTwo'
	InfoText="PT-Soldat - Difficulty: Advanced||PT-Soldat were armed with special anti-tank rifles firing large caliber armor piercing rounds. While not very effective against the heavily armored areas of tanks, the anti-tank rifles could be used to exploit the more weakly armored areas of enemy vehicles."
	bEnhancedAutomaticControl=false
	MenuImage=Texture'InterfaceArt_tex.SelectMenus.PT-soldat'
}
