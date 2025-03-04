//=============================================================================
// G43ScopedBullet
//=============================================================================
// Realistic bullets
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2003-2004 Erik Christensen
//=============================================================================

class G43ScopedBullet extends ROBullet;

//=============================================================================
// defaultproperties
//=============================================================================

defaultproperties
{
	BallisticCoefficient=0.390
	Damage=115
	MyDamageType=class'G43ScopedDamType'
	MyVehicleDamage=class'G43ScopedVehDamType'
	Speed=39104 // 2444 fps
}
