//=============================================================================
// RDG1GrenadeDamType
//=============================================================================
// Damage type
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2006 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class RDG1GrenadeDamType extends ROGrenadeDamType
	abstract;

//=============================================================================
// defaultproperties
//=============================================================================

defaultproperties
{
	DeathString="%o was burned up by %k's smoke grenade."
	MaleSuicide="%o was careless with his own grenade."
	FemaleSuicide="%o was careless with her own grenade."

	WeaponClass=class'RDG1GrenadeWeapon'

	HUDIcon=Texture'InterfaceArt_tex.deathicons.germgrenade'

	DeathOverlayMaterial=Material'Effects_Tex.PlayerDeathOverlay'
	DeathOverlayTime=999
}
