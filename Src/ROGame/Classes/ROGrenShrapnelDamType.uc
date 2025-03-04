//=============================================================================
// RODamTypeGrenShrapnel
//=============================================================================
// Damage type
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2003 Erik Christensen
//=============================================================================

class ROGrenShrapnelDamType extends ROWeaponProjectileDamageType
	abstract;

//=============================================================================
// defaultproperties
//=============================================================================

defaultproperties
{
	DeathString="%o was killed by %k's shrapnel."
	MaleSuicide="%o was killed by his own shrapnel."
	FemaleSuicide="%o was killed by his own shrapnel."

//	WeaponClass=class'ROExplosiveWeapon'

	bDelayedDamage=true

	PawnDamageEmitter=class'ROEffects.ROBloodPuff'
}
