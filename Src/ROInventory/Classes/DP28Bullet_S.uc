//=============================================================================
// DP28Bullet_S
//=============================================================================
// Server side only bullet
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2003-2004 John Gibson
//=============================================================================

class DP28Bullet_S extends ROServerBullet;

defaultproperties
{
	BallisticCoefficient=0.370 // ?
	Damage=115
	MyDamageType=class'DP28DamType'
    MyVehicleDamage=class'DP28VehDamType'
	Speed=44082 // 2760 fps
}
