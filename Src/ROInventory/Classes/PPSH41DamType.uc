//=============================================================================
// PPSH41DamType
//=============================================================================
// Damage type
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2003 Erik Christensen
//=============================================================================

class PPSH41DamType extends ROWeaponProjectileDamageType
	abstract;

//=============================================================================
// defaultproperties
//=============================================================================

defaultproperties
{
	DeathString="%o was killed by %k's PPSh41."
	MaleSuicide="%o turned the gun on himself."
	FemaleSuicide="%o turned the gun on herself."

	WeaponClass=class'PPSh41Weapon'

	GibModifier=0.0
    KDeathVel=100.000000
    KDamageImpulse=1000
	KDeathUpKick=0

	PawnDamageEmitter=class'ROEffects.ROBloodPuff'

	HUDIcon=Texture'InterfaceArt_tex.deathicons.b762mm'
}
