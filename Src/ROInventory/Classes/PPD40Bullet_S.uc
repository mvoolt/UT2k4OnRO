//=============================================================================
// PPD40Bullet_S
//=============================================================================
// Server side only bullet
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2003-2004 John Gibson
//=============================================================================

class PPD40Bullet_S extends ROServerBullet;

defaultproperties
{
	BallisticCoefficient=0.150 // ?
	Damage=50
	MyDamageType=class'PPD40DamType'
	MyVehicleDamage=class'PPD40VehDamType'
	Speed=25000 // 1600 fps
}
