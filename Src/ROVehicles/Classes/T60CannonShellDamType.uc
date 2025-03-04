//=============================================================================
// T60CannonShellDamType
//=============================================================================
// Damage type
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 John "Ramm-Jaeger" Gibson
//=============================================================================

class T60CannonShellDamType extends ROWeaponProjectileDamageType
	abstract;

//=============================================================================
// defaultproperties
//=============================================================================

defaultproperties
{
	DeathString="%o was killed by %k's tank shell."
	MaleSuicide="%o fired his shell prematurely."
	FemaleSuicide="%o fired her shell prematurely."

	HUDIcon=Texture'InterfaceArt_tex.deathicons.Strike'

	WeaponClass=class'PTRDWeapon'

	GibModifier=3.0

	VehicleMomentumScaling=0.3
	bThrowRagdoll=true
	GibPerterbation=0.15
	bLocationalHit=true
	KDamageImpulse=4500
	KDeathVel=200.000000
	KDeathUpKick=15

	TankDamageModifier=0.5
	APCDamageModifier=0.35
	VehicleDamageModifier=0.35
	TreadDamageModifier=1.0

	PawnDamageEmitter=class'ROEffects.ROBloodPuff'
}
