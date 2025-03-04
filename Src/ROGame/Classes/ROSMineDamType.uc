//=============================================================================
// ROSMineDamType
//=============================================================================
// Damage type
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2003 Erik Christensen
//=============================================================================

class ROSMineDamType extends DamageType
	abstract;

//=============================================================================
// defaultproperties
//=============================================================================

defaultproperties
{
	DeathString="%o was blown up by a S-Mine."
	MaleSuicide="%o was blown up by a S-Mine."
	FemaleSuicide="%o was blown up by a S-Mine."

	bLocationalHit=false;
	KDamageImpulse=10000
	KDeathUpKick=300

	GibModifier=1.5
}
