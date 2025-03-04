//=============================================================================
// ROSURiflemanGreatRKKA
//=============================================================================
// Defines the characteristics of a given role
//=============================================================================

class ROSUSemiAutoGreatRKKA extends ROSU_Greatcoat_RKKA;

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
	MyName="Semi-Auto Rifleman"
	AltName="Strelok-avto"
	Article="a "
	PluralName="Semi-Auto Riflemen"
	PrimaryWeaponType=WT_SemiAuto
	PrimaryWeapons(0)=(Item=class'ROInventory.SVT40Weapon',Amount=6,AssociatedAttachment=class'ROInventory.SVT40AmmoPouch')
	Grenades(0)=(Item=class'ROInventory.F1GrenadeWeapon',Amount=2)
	Headgear(0)=class'ROInventory.ROSovietSidecap'
	Headgear(1)=class'ROInventory.ROSovietHelmet'
	Headgear(2)=class'ROInventory.ROSovietHelmetTwo'
	InfoText="Strelok-avto - Difficulty: Easy||The Soviets were the first to experiment with arming the riflemen with semi-automatic weapons before the war. They had the same key role of taking and holding ground. The SVT is nearly as accurate as the standard rifle and will reach out accurately a good distance, although longer ranges are best left to the Sniper. The Strelok is expected to close with the enemy, with rifle fire, grenade, bayonet and whatever other close-combat weapons come to hand and defeat him.||Loadout: SVT40, bayonet, grenades"
	MenuImage=Texture'InterfaceArt_tex.SelectMenus.Strelokavto'
}
