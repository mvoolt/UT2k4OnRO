//=============================================================================
// MG34Bullet_S
//=============================================================================
// Server side MG34 bullet
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 John Ramm-Jaeger" Gibson
//=============================================================================

class MG34Bullet_S extends ROServerBullet;

defaultproperties
{
	BallisticCoefficient=0.390
	Damage=115
	MyDamageType=class'ROMG34DamType'
	MyVehicleDamage=class'ROMG34VehDamType'
	Speed=37808 // 2363 fps
}
