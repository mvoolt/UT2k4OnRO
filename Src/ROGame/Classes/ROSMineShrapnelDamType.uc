//=============================================================================
// ROSMineShrapnelDamType
//=============================================================================
// Damage type
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2003 Erik Christensen
//=============================================================================

class ROSMineShrapnelDamType extends DamageType
	abstract;

//=============================================================================
// defaultproperties
//=============================================================================

defaultproperties
{
	DeathString="%o couldn't evade the S-Mine's shrapnel."
	MaleSuicide="%o couldn't evade the S-Mine's shrapnel."
	FemaleSuicide="%o couldn't evade the S-Mine's shrapnel."

	GibModifier=0.0
	KDamageImpulse=100
}
