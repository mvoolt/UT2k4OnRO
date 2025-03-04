//=============================================================================
// SatchelCharge10lb10sProjectile
//=============================================================================
// Satchel projectile for the 10lb 10second satchel charge
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

//=============================================================================

class SatchelCharge10lb10sProjectile extends ROSatchelChargeProjectile;

//=============================================================================
// defaultproperties
//=============================================================================

defaultproperties
{
	StaticMesh=StaticMesh'WeaponPickupSM.Projectile.Satchel_throw'
	Speed=300
	DrawScale=1.0
	ShrapnelCount=0
	Damage=550
	DamageRadius=1200
	MyDamageType=class'ROSatchelDamType'
}
