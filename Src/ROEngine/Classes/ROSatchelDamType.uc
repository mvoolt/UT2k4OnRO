//=============================================================================
// ROSatchelDamType
//=============================================================================
// Satchel Charge.
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2004 John "Ramm-Jaeger" Gibson
//=============================================================================

class ROSatchelDamType extends ROWeaponDamageType
	abstract;

//=============================================================================
// defaultproperties
//=============================================================================

defaultproperties
{
	DeathString="%o was blown up by %k's satchel charge."
	MaleSuicide="%o was careless with his own satchel charge."
	FemaleSuicide="%o was careless with her own satchel charge."

	HUDIcon=Texture'InterfaceArt_tex.deathicons.satchel'

	GibModifier=4.0

//	WeaponClass=class'ROSatchelChargeWeapon'
	bDetonatesGoop=true
	bDelayedDamage=true
	bLocationalHit=false
	KDamageImpulse=5000
    KDeathVel=300.000000
	KDeathUpKick=75
	bExtraMomentumZ=true
	bArmorStops=false

	KDeadLinZVelScale=0.0015
	KDeadAngVelScale=0.0015

	TankDamageModifier=1.0
	APCDamageModifier=1.0
	VehicleDamageModifier=1.0
	TreadDamageModifier=1.0

	HumanObliterationThreshhold=400

	DeathOverlayMaterial=Material'Effects_Tex.PlayerDeathOverlay'
	DeathOverlayTime=999
}
