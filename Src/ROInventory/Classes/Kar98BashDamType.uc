//=============================================================================
// Kar98BashDamType
//=============================================================================
// Damage type
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2003 Erik Christensen
//=============================================================================

class Kar98BashDamType extends ROWeaponBashDamageType
	abstract;

//=============================================================================
// defaultproperties
//=============================================================================

defaultproperties
{
	DeathString="%o was killed by %k's Kar98K."
	MaleSuicide="%o turned the gun on himself."
	FemaleSuicide="%o turned the gun on herself."

	WeaponClass=class'Kar98Weapon'

	GibModifier=0.0
	KDamageImpulse=400
}
