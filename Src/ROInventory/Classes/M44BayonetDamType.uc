//=============================================================================
// M44BayonetDamType
//=============================================================================
// class that handles the M44 bayonet damage type
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2006 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class M44BayonetDamType extends ROWeaponBayonetDamageType
	abstract;

//=============================================================================
// defaultproperties
//=============================================================================

defaultproperties
{
	DeathString="%o was stabbed by %k's mounted bayonet."
	MaleSuicide="%o turned the bayonet on himself."
	FemaleSuicide="%o turned the bayonet on herself."

	WeaponClass=class'M44Weapon'

	GibModifier=0.0
	KDamageImpulse=400

	PawnDamageEmitter=class'ROEffects.ROBloodPuff'
}
