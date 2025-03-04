//=============================================================================
// PPSH41VehDamType
//=============================================================================
// Vehicle Damage type
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 John "Ramm-Jaeger" Gibson
//=============================================================================

class PPSh41VehDamType extends ROVehicleDamageType
	abstract;

//=============================================================================
// defaultproperties
//=============================================================================

defaultproperties
{
	DeathString="%o was killed by %k's PPSh41."
	MaleSuicide="%o turned the gun on himself."
	FemaleSuicide="%o turned the gun on herself."

	WeaponClass=class'PPSh41Weapon'

	GibModifier=0.0
	KDamageImpulse=200

	PawnDamageEmitter=class'ROEffects.ROBloodPuff'

	HUDIcon=Texture'InterfaceArt_tex.deathicons.b762mm'
}
