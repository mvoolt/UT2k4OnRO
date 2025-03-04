//=============================================================================
// ROArtilleryDamType
//=============================================================================
//
// Damage Type for Artillery.
//
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2003 John "Ramm-Jaeger" Gibson
//=============================================================================


class ROArtilleryDamType extends ROWeaponDamageType
	abstract;

//=============================================================================
// defaultproperties
//=============================================================================

defaultproperties
{
	DeathString="%o was torn apart by an artillery shell."
	MaleSuicide="%o was careless with his own artillery shell."
	FemaleSuicide="%o was careless with her own artillery shell."

	GibModifier=10.0//1.5

	//WeaponClass=class'ROGrenadeWeapon'
	bDetonatesGoop=true
	bDelayedDamage=true
	bLocationalHit=false
	bKUseOwnDeathVel=true
    KDamageImpulse=7000.000000
	KDeathVel=350
	KDeathUpKick=600
	KDeadLinZVelScale=0.00025
	KDeadAngVelScale=0.002

	HUDIcon=Texture'InterfaceArt_tex.deathicons.artkill'

	VehicleMomentumScaling=1.3
	bThrowRagdoll=true
	GibPerterbation=0.15
	bFlaming=true
	bExtraMomentumZ=true
	bArmorStops=false

	TankDamageModifier=1.0
	APCDamageModifier=1.0
	VehicleDamageModifier=1.0
	TreadDamageModifier=0.0

	HumanObliterationThreshhold=300

	DeathOverlayMaterial=Material'Effects_Tex.PlayerDeathOverlay'
	DeathOverlayTime=999
}
