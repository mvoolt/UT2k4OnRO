//=============================================================================
// P08LugerVehDamType
//=============================================================================
// Vehicle Damage type
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 John "Ramm-Jaeger" Gibson
//=============================================================================

class P08LugerVehDamType extends ROVehicleDamageType
	abstract;

//=============================================================================
// defaultproperties
//=============================================================================

defaultproperties
{
	DeathString="%o was killed by %k's Luger."
	MaleSuicide="%o turned the gun on himself."
	FemaleSuicide="%o turned the gun on herself."

	WeaponClass=class'P08LugerWeapon'

	GibModifier=0.0
	KDamageImpulse=200

	PawnDamageEmitter=class'ROEffects.ROBloodPuff'

	HUDIcon=Texture'InterfaceArt_tex.deathicons.b9mm'
}
