//=============================================================================
// F1GrenadeDamType
//=============================================================================
// Damage type
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2003 Erik Christensen
//=============================================================================

class F1GrenadeDamType extends ROGrenadeDamType
	abstract;

//=============================================================================
// defaultproperties  `quit
//=============================================================================

defaultproperties
{
	DeathString="%o was blown up by %k's F1 grenade."
	MaleSuicide="%o was careless with his own grenade."
	FemaleSuicide="%o was careless with her own grenade."

	WeaponClass=class'F1GrenadeWeapon'

	HUDIcon=Texture'InterfaceArt_tex.deathicons.rusgrenade'

	DeathOverlayMaterial=Material'Effects_Tex.PlayerDeathOverlay'
	DeathOverlayTime=999
}
