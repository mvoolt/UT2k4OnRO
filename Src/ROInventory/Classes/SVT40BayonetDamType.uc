//=====================================================
// SVT40BayonetDamType
// started by Antarian 9/17/03
//
// Copyright (C) 2003 Jeffrey Nakai
//
// class that handles the SVT40 bayonet damage type
//=====================================================

class SVT40BayonetDamType extends ROWeaponBayonetDamageType
	abstract;

//=============================================================================
// defaultproperties
//=============================================================================

defaultproperties
{
	DeathString="%o was stabbed by %k's mounted bayonet."
	MaleSuicide="%o turned the bayonet on himself."
	FemaleSuicide="%o turned the bayonet on herself."

	WeaponClass=class'SVT40Weapon'

	GibModifier=0.0
	KDamageImpulse=400

	PawnDamageEmitter=class'ROEffects.ROBloodPuff'
}
