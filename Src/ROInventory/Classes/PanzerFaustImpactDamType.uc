//=============================================================================
// PanzerFaustImpactDamType
//=============================================================================
// Damage type
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2006 John "Ramm-Jaeger" Gibson
//=============================================================================

class PanzerFaustImpactDamType extends RORocketImpactDamage
	abstract;

//=============================================================================
// defaultproperties
//=============================================================================

defaultproperties
{
	DeathString="%o was killed by %k's Panzerfaust."
	MaleSuicide="%o was careless with his Panzerfaust."
	FemaleSuicide="%o was careless with her Panzerfaust."

	WeaponClass=class'PanzerFaustWeapon'

	GibModifier=10.0

	PawnDamageEmitter=class'ROEffects.ROBloodPuff'

	bDetonatesGoop=true
	bDelayedDamage=true
	bLocationalHit=true
	bKUseOwnDeathVel=true
	KDamageImpulse=4000
	KDeathVel=225
	KDeathUpKick=100
	bArmorStops=true // This is actually a UT variable, but since we have no armor pickups, lets use it to show that side armor stops this round

	HUDIcon=Texture'InterfaceArt2_tex.deathicons.faustkill'

	DeathOverlayMaterial=Material'Effects_Tex.PlayerDeathOverlay'
	DeathOverlayTime=999

	TankDamageModifier=1.0
	APCDamageModifier=1.0
	VehicleDamageModifier=1.0
	TreadDamageModifier=1.0
}
