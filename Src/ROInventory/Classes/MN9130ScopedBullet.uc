//=============================================================================
// MN9130ScopedBullet
//=============================================================================
// Realistic bullets
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2003-2004 Erik Christensen
//=============================================================================

class MN9130ScopedBullet extends ROBullet;

//=============================================================================
// defaultproperties
//=============================================================================

defaultproperties
{
	BallisticCoefficient=0.370 // ?
	Damage=115
	MyDamageType=class'MN9130ScopedDamType'
	MyVehicleDamage=class'MN9130ScopedVehDamType'
	Speed=42560 // 2660 fps
}
