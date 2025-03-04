//=============================================================================
// G43ScopedDamType
//=============================================================================
// Damage type
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2003 Erik Christensen
//=============================================================================

class G43ScopedDamType extends ROWeaponProjectileDamageType
	abstract;

//=============================================================================
// defaultproperties
//=============================================================================

defaultproperties
{
	DeathString="%o was sniped by %k's G43."
	MaleSuicide="%o turned the gun on himself."
	FemaleSuicide="%o turned the gun on herself."

	WeaponClass=class'G43ScopedWeapon'

	GibModifier=0.0
    KDeathVel=115.000000
    KDamageImpulse=2500
	KDeathUpKick=5

	PawnDamageEmitter=class'ROEffects.ROBloodPuff'

	HUDIcon=Texture'InterfaceArt2_tex.deathicons.sniperkill'
}
