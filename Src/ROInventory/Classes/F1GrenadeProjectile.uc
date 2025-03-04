//=============================================================================
// F1GrenadeProjectile
//=============================================================================
// Grenade projectile for the Soviet F1 shrapnel grenade
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

//=============================================================================

class F1GrenadeProjectile extends ROGrenadeProjectile;

//=============================================================================
// defaultproperties
//=============================================================================

defaultproperties
{
	StaticMesh=StaticMesh'WeaponPickupSM.Projectile.F1Grenade-throw'
	ExplosionSound(0)=sound'Inf_Weapons.F1.f1_explode01'
	ExplosionSound(1)=sound'Inf_Weapons.F1.f1_explode02'
	ExplosionSound(2)=sound'Inf_Weapons.F1.f1_explode03'
	DrawScale=1.0
	ShrapnelCount=0
	Damage=140
//	DamageRadius=1040 // 65 feet    //1440 - 90 feet
	DamageRadius=940 // 60 feet    //1440 - 90 feet
	MyDamageType=class'F1GrenadeDamType'
}
