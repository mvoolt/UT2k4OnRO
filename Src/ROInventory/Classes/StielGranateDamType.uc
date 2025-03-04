//=============================================================================
// StielGranateDamType
//=============================================================================
// Damage type
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2003 Erik Christensen
//=============================================================================

class StielGranateDamType extends ROGrenadeDamType
	abstract;

//=============================================================================
// defaultproperties
//=============================================================================

defaultproperties
{
	DeathString="%o was blown up by %k's StG39 grenade."
	MaleSuicide="%o was careless with his own grenade."
	FemaleSuicide="%o was careless with her own grenade."

	WeaponClass=class'StielGranateWeapon'

	HUDIcon=Texture'InterfaceArt_tex.deathicons.germgrenade'

	DeathOverlayMaterial=Material'Effects_Tex.PlayerDeathOverlay'
	DeathOverlayTime=999
}
