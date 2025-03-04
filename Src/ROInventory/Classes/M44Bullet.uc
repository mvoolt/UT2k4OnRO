//=============================================================================
// M44Bullet
//=============================================================================
// Realistic bullets
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2006 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class M44Bullet extends ROBullet;

//=============================================================================
// defaultproperties
//=============================================================================

defaultproperties
{
	BallisticCoefficient=0.370 // ?
	Damage=115
	MyDamageType=class'M44DamType'
	MyVehicleDamage=class'M44VehDamType'
	Speed=40224 // 2514 fps
}
