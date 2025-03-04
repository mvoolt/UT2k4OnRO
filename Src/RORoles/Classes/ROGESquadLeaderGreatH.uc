//=============================================================================
// ROGESquadLeaderGreatH
//=============================================================================
// Defines the characteristics of a given role
//=============================================================================

class ROGESquadLeaderGreatH extends ROGE_Greatcoat_Heer;

//=============================================================================
// defaultproperties
//=============================================================================

defaultproperties
{
	MyName="Squad Leader"
	AltName="Gruppenführer"
	Article="a "
	PluralName="Squad Leaders"
 	PrimaryWeaponType=WT_SMG
	PrimaryWeapons(0)=(Item=class'ROInventory.MP40Weapon',Amount=6,AssociatedAttachment=class'ROInventory.ROMP40AmmoPouch')
	GivenItems(0)="ROInventory.BinocularsItem"
	SecondaryWeapons(0)=(Item=class'ROInventory.P08LugerWeapon',Amount=1)
	SecondaryWeapons(1)=(Item=class'ROInventory.P38Weapon',Amount=1)
	Grenades(0)=(Item=class'ROInventory.NebelGranate39Weapon',Amount=2)
	//Grenades(1)=(Item=class'ROInventory.StielGranateWeapon',Amount=2)
	Headgear(0)=class'ROInventory.ROGermanHat'
	InfoText="Gruppenführer - Difficulty: Very Advanced||The Gruppenführer is the leader of the squad - an NCO by rank.  His job is to see to the completion of the squad's objectives by directing his men in combat and ensuring the LMG's firepower is put to good use.  Equipped for close quarters combat, the Gruppenführer is better off directing the squad's firepower at longer ranges than engaging himself.|| Loadout: MP40, grenades||* The Gruppenführer counts one and a half times when taking and holding objectives."
	ObjCaptureWeight=2
	bEnhancedAutomaticControl=true
	PointValue=3.0
	bIsLeader=true
	MenuImage=Texture'InterfaceArt_tex.SelectMenus.Gruppenfuhrer'
}
