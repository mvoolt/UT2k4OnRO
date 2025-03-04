//=============================================================================
// Kar98ScopedBullet
//=============================================================================
// Realistic bullets
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2003-2004 Erik Christensen
//=============================================================================

class Kar98ScopedBullet extends ROBullet;

//=============================================================================
// defaultproperties
//=============================================================================

defaultproperties
{
	BallisticCoefficient=0.390
	Damage=115
	MyDamageType=class'Kar98ScopedDamType'
	MyVehicleDamage=class'Kar98ScopedVehDamType'
	Speed=37808 // 2363 fps
}
