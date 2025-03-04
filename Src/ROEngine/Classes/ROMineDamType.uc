//=============================================================================
// ROMineDamType
//=============================================================================
// Damage type
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2003 Erik Christensen
//=============================================================================

class ROMineDamType extends ROWeaponDamageType
	abstract;

//=============================================================================
// defaultproperties
//=============================================================================

defaultproperties
{
	HUDIcon=Texture'InterfaceArt_tex.deathicons.mine'

	TankDamageModifier=1.0
	APCDamageModifier=1.0
	VehicleDamageModifier=1.10
	TreadDamageModifier=1.0

	DeathString="%o was killed by a mine."
	MaleSuicide="%o was killed by a mine."
	FemaleSuicide="%o was killed by a mine."

	bLocationalHit=false;
	KDamageImpulse=8000
	KDeathUpKick=100
	bArmorStops=false
}
