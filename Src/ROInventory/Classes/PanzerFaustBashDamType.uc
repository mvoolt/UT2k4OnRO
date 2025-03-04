//=============================================================================
// PanzerFaustBashDamType
//=============================================================================
// Damage type
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2003 Erik Christensen
//=============================================================================

class PanzerFaustBashDamType extends ROWeaponBashDamageType
	abstract;

//=============================================================================
// defaultproperties
//=============================================================================

defaultproperties
{
	DeathString="%o was smacked with %k's Panzerfaust."
	MaleSuicide="%o turned the rocket on himself."
	FemaleSuicide="%o turned the rocket on herself."

	WeaponClass=class'PanzerFaustWeapon'

	GibModifier=0.0
	KDamageImpulse=400
}
