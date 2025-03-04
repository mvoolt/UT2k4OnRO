//=============================================================================
// ROGESniperH
//=============================================================================
// Defines the characteristics of a given role
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2003-2004 Erik Christensen
//=============================================================================

class ROGESniperH extends ROGE_Standard_Heer;

//=============================================================================
// defaultproperties
//=============================================================================

defaultproperties
{
	MyName="Sniper"
	AltName="Scharfschütze"
	Article="a "
	PluralName="Snipers"
	PrimaryWeaponType=WT_Sniper
	PrimaryWeapons(0)=(Item=class'ROInventory.Kar98ScopedWeapon',Amount=18,AssociatedAttachment=class'ROInventory.ROKar98AmmoPouch')
    PrimaryWeapons(1)=(Item=class'ROInventory.G43ScopedWeapon',Amount=6,AssociatedAttachment=class'ROInventory.ROKar98AmmoPouch')
	SecondaryWeapons(0)=(Item=class'ROInventory.P08LugerWeapon',Amount=1)
	SecondaryWeapons(1)=(Item=class'ROInventory.P38Weapon',Amount=1)
	Grenades(0)=(Item=class'ROInventory.StielGranateWeapon',Amount=1)
	Headgear(0)=class'ROInventory.ROGermanHelmet'
	InfoText="Scharfschütze - Difficulty: Medium||The Scharfschütze is a specialist in the area of marksmanship and camouflage.  He operated separately from the infantry platoon until 1944 - acting as a lone wolf until then so to speak.  Identifying and eliminating important enemy personnel is his job.  The Scharfschütze is effective at long range - especially when hidden, but he has little means to protect himself up close.  If spotted, it is best that he slip away quietly rather than face a direct confrontation.|| Loadout: Kar98K w/ scope, P38, grenades||* The Scharfschütze is more accurate with a scoped rifle than anyone else."
	MenuImage=Texture'InterfaceArt_tex.SelectMenus.Scharf'
}
