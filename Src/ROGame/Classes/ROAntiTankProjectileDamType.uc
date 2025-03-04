//=============================================================================
// ROAntiTankProjectileDamType
//=============================================================================
// Damage type
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2004 John "Ramm-Jaeger" Gibson
//=============================================================================

class ROAntiTankProjectileDamType extends ROWeaponProjectileDamageType
	abstract;

//=============================================================================
// defaultproperties
//=============================================================================

defaultproperties
{
	DeathString="%o was killed by %k's Panzerfaust."
	MaleSuicide="%o was careless with his Panzerfaust."
	FemaleSuicide="%o was careless with her Panzerfaust."

//	WeaponClass=class'ROWeapon'

	GibModifier=10.0

	PawnDamageEmitter=class'ROEffects.ROBloodPuff'

	bDetonatesGoop=true
	bDelayedDamage=true
	bLocationalHit=false
	bKUseOwnDeathVel=true
	KDamageImpulse=3000
	KDeathVel=200
	KDeathUpKick=300

	HUDIcon=Texture'InterfaceArt_tex.deathicons.Strike' // Replaceme

	TankDamageModifier=1.0
	APCDamageModifier=1.0
	VehicleDamageModifier=1.0
	TreadDamageModifier=1.0
}
