//=============================================================================
// StielGranateProjectile
//=============================================================================
// Grenade projectile for the Gaerman StielGranate concussion grenade
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

//=============================================================================

class StielGranateProjectile extends ROGrenadeProjectile;

// Give this nade some extra spin
simulated function PostBeginPlay()
{
	super(ROThrowableExplosiveProjectile).PostBeginPlay();

	if (Role == ROLE_Authority)
	{
		Velocity = Speed * Vector(Rotation);

		if (Instigator.HeadVolume.bWaterVolume)
		{
			Velocity = 0.25 * Velocity;
		}
	}

	RotationRate.Pitch = -(90000 + 30000 * FRand());

	Acceleration = 0.5 * PhysicsVolume.Gravity;
}

//=============================================================================
// defaultproperties
//=============================================================================

defaultproperties
{
	StaticMesh=StaticMesh'WeaponPickupSM.Projectile.StielHandgranate_throw'
	ExplosionSound(0)=sound'Inf_Weapons.stielhandgranate24.stielhandgranate24_explode01'
	ExplosionSound(1)=sound'Inf_Weapons.stielhandgranate24.stielhandgranate24_explode02'
	ExplosionSound(2)=sound'Inf_Weapons.stielhandgranate24.stielhandgranate24_explode03'
	DrawScale=1.0
	ShrapnelCount=0
	Damage=180
	DamageRadius=768
	Speed=1100
	FuzeLengthTimer=4.5
	MyDamageType=class'StielGranateDamType'
}
