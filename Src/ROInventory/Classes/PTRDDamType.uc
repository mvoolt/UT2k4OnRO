//=============================================================================
// PTRDDamType
//=============================================================================
// Damage type
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2003 John "Ramm-Jaeger" Gibson
//=============================================================================

class PTRDDamType extends ROWeaponProjectileDamageType
	abstract;

//=============================================================================
// defaultproperties
//=============================================================================

defaultproperties
{
	DeathString="%o was killed by %k's PTRD."
	MaleSuicide="%o turned the gun on himself."
	FemaleSuicide="%o turned the gun on herself."

    PawnDamageEmitter=ROEffects.ROBloodPuffLarge

	WeaponClass=class'PTRDWeapon'

	GibModifier=4.0

	VehicleMomentumScaling=0.6
	bThrowRagdoll=true
	GibPerterbation=0.15
	bLocationalHit=true
	KDamageImpulse=4500
	KDeathVel=200.000000
	KDeathUpKick=25

	TankDamageModifier=1.0
	APCDamageModifier=0.5
	VehicleDamageModifier=0.35
	TreadDamageModifier=1.0

	HUDIcon=Texture'InterfaceArt_tex.deathicons.b762mm' // Replaceme
}
