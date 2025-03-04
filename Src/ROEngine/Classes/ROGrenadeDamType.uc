//=============================================================================
// ROGrenadeDamType
//=============================================================================
//
// Damage Type for Grenades.
//
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2003 John "Ramm-Jaeger" Gibson
//=============================================================================


class ROGrenadeDamType extends ROWeaponDamageType
	abstract;

//=============================================================================
// defaultproperties
//=============================================================================

defaultproperties
{
	DeathString="%o was torn apart by %k's grenade."
	MaleSuicide="%o was careless with his own grenade."
	FemaleSuicide="%o was careless with her own grenade."

	GibModifier=1.5

//	WeaponClass=class'ROExplosiveWeapon'
	bDetonatesGoop=true
	bDelayedDamage=true
	bLocationalHit=false
	KDamageImpulse=2000
    KDeathVel=120
	KDeathUpKick=30
	bExtraMomentumZ=true

	KDeadLinZVelScale=0.005
	KDeadAngVelScale=0.0036

	TankDamageModifier=0.0
	APCDamageModifier=0.2
	VehicleDamageModifier=0.50
}
