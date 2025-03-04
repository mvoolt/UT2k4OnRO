//=============================================================================
// RDG1GrenadeProjectile
//=============================================================================
// Grenade projectile for the Russian RDG1 smoke grenade
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2006 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

//=============================================================================

class RDG1GrenadeProjectile extends StielGranateProjectile;

#exec OBJ LOAD File=Inf_WeaponsTwo.uax

var float DestroyTimer;
var bool bCalledDestroy;
var Emitter SmokeEmitter;
var sound SmokeSound;

//-----------------------------------------------------------------------------
// Landed
//-----------------------------------------------------------------------------

simulated function Landed(vector HitNormal)
{
	if (Bounces <= 0)
	{
		SetPhysics(PHYS_None);
	}
	else
	{
		HitWall(HitNormal, None);
	}
}

//-----------------------------------------------------------------------------
// BlowUp
//-----------------------------------------------------------------------------

function BlowUp(vector HitLocation)
{
	//DelayedHurtRadius(Damage, DamageRadius, MyDamageType, MomentumTransfer, HitLocation);

	if (Role == ROLE_Authority)
		MakeNoise(1.0);
}

//-----------------------------------------------------------------------------
// Explode
//-----------------------------------------------------------------------------

simulated function Explode(vector HitLocation, vector HitNormal)
{
	BlowUp(HitLocation);

	if( Role == ROLE_Authority )
	{
		AmbientSound = SmokeSound;
	}

	PlaySound(ExplosionSound[Rand(3)],, 1.0,,200);

    //DoShakeEffect();

	if (Level.NetMode != NM_DedicatedServer)
	{
	    SmokeEmitter = Spawn(ExplodeDirtEffectClass,self,, Location, rotator(vect(0,0,1)));
	    SmokeEmitter.SetBase(Self);
	}
}

simulated function Destroyed()
{
    super(ROThrowableExplosiveProjectile).Destroyed();

    if( SmokeEmitter != none )
    {
    	SmokeEmitter.Kill();
    }
}

function Reset()
{
    if( SmokeEmitter != none )
    {
    	SmokeEmitter.Destroy();
    }

	super.Reset();
}


simulated function Tick(float DeltaTime)
{
	super.Tick(DeltaTime);

	DestroyTimer -= DeltaTime;

	if (DestroyTimer <= 0.0 && !bCalledDestroy)
	{
		bCalledDestroy = true;
		Destroy();
	}
}

//=============================================================================
// defaultproperties
//=============================================================================

defaultproperties
{
	StaticMesh=StaticMesh'WeaponPickupSM.Projectile.RGD1_throw'
	ExplosionSound(0)=sound'Inf_WeaponsTwo.smokegrenade.smoke_ignite'
	ExplosionSound(1)=sound'Inf_WeaponsTwo.smokegrenade.smoke_ignite' // replaceme
	ExplosionSound(2)=sound'Inf_WeaponsTwo.smokegrenade.smoke_ignite' // replaceme
	DrawScale=1.0
	ShrapnelCount=0
	Damage=0
	DamageRadius=0
	Speed=1100
	FuzeLengthTimer=4.5
	DestroyTimer=30.0
	LifeSpan=30.0
	MyDamageType=class'RDG1GrenadeDamType'
	ExplodeDirtEffectClass=class'GrenadeSmokeEffect'
	SmokeSound=sound'Inf_WeaponsTwo.smokegrenade.smoke_loop'
    SoundVolume=255
    SoundRadius=200
	bAlwaysRelevant=true // has to be always relevant so that the smoke effect always gets spawned even if the other player can't see it
}
