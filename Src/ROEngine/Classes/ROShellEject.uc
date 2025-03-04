//=====================================================
// ROShellEject
// started by Antarian 7/25/03
//
// Copyright (C) 2003 Jeffrey Nakai
//
// This is the base shell ejection class.
// Making the shells projectiles will give us more control of them
//=====================================================

// Ramm: Refactor - lets use an emitter or something so this isn't so heavy. This
// spawns an actor every time you fire a weapon

class ROShellEject extends Projectile
	abstract;

//-----------------------------------------------------------------------------
// Projectile variables.

// Impact reflection variables
var() 	float 	DampenFactor,
				DampenFactorParallel;
var() 	byte	Bounces;

var()	int		RandomYawRange;		// Random yaw variation for spawning
var()	int		RandomPitchRange;	// Random pitch variation for spawning
var()	int		RandomRollRange;	// Random pitch variation for spawning
var()	float	MinStartSpeed;      // Minimum speed to eject at
var()	float	MaxStartSpeed;      // Minimum speed to eject at

simulated function Reset()
{
	Destroy();
}

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();

	LifeSpan = +10.00;

	RandSpin(150000);

	Acceleration = 0.5 * PhysicsVolume.Gravity;
}

// no need for a hurt radius on shell cases
simulated function DelayedHurtRadius( float a, float e, class<DamageType> i, float o, vector u ) {}

simulated function PhysicsVolumeChange( PhysicsVolume Volume )
{
	if (Volume.bWaterVolume)
		Velocity *= 0.15;

	PlaySound(Sound'Inf_Weapons.ShellRifleWater', SLOT_Misc,0.15,,20,,false );
}

simulated function Landed( Vector HitNormal )
{
	HitWall(HitNormal, none);
}

//=============================================================================
// GetHitSurfaceType(RO) - Will get the surface type of the surface the
//	projectile has collided with.
//=============================================================================
simulated function GetHitSurfaceType( out ESurfaceTypes ST, vector HitNormal)
{
	local vector HitLoc, HitNorm;
	local Material HitMat;

	if (Level.NetMode == NM_DedicatedServer)
		return;

	Trace(HitLoc, HitNorm, Location - (HitNormal * 16), Location, false,, HitMat);

	if (HitMat == None)
		ST = EST_Default;
	else
		ST = ESurfaceTypes(HitMat.SurfaceType);
}

//=============================================================================
// GetDampenAndSoundValue(RO) - Gets the DampenFactor's and hit sound for the
//	surface the projectile hits
//=============================================================================
simulated function GetDampenAndSoundValue( ESurfaceTypes ST )
{
	switch( ST )
	{
		case EST_Default:
			DampenFactor=0.3;
    		DampenFactorParallel=0.5;
    		ImpactSound=Sound'Inf_Weapons.ShellRifleDirt';
			break;

		case EST_Rock:
			DampenFactor=0.4;
    		DampenFactorParallel=0.7;
    		ImpactSound=Sound'Inf_Weapons.ShellRifleDirt';
			break;

		case EST_Dirt:
			DampenFactor=0.3;
    		DampenFactorParallel=0.4;
    		ImpactSound=Sound'Inf_Weapons.ShellRifleDirt';
			break;

		case EST_Metal:
		case EST_MetalArmor:
			DampenFactor=0.4;
    		DampenFactorParallel=0.7;
    		ImpactSound=Sound'Inf_Weapons.ShellRifleConcrete';
			break;

		case EST_Wood:
			DampenFactor=0.25;
    		DampenFactorParallel=0.6;
    		ImpactSound=Sound'Inf_Weapons.ShellRifleWood';
			break;

		case EST_Plant:
			DampenFactor=0.1;
    		DampenFactorParallel=0.3;
    		ImpactSound=Sound'Inf_Weapons.ShellRifleDirt';
			break;

		case EST_Flesh:
			DampenFactor=0.1;
    		DampenFactorParallel=0.2;
    		ImpactSound=Sound'Inf_Weapons.ShellRifleDirt';
			break;

		case EST_Ice:
			DampenFactor=0.4;
    		DampenFactorParallel=0.7;
    		ImpactSound=Sound'Inf_Weapons.ShellRifleConcrete';
			break;

		case EST_Snow:
			DampenFactor=0.0;
    		DampenFactorParallel=0.05;
    		ImpactSound=Sound'Inf_Weapons.ShellRifleDirt';
			break;

		case EST_Water:
			DampenFactor=0.0;
    		DampenFactorParallel=0.05;
    		ImpactSound=Sound'Inf_Weapons.ShellRifleWater';
			break;

		case EST_Glass:
			DampenFactor=0.4;
    		DampenFactorParallel=0.7;
    		ImpactSound=Sound'Inf_Weapons.ShellRifleConcrete';
			break;

		case EST_Gravel:
			DampenFactor=0.3;
    		DampenFactorParallel=0.4;
    		ImpactSound=Sound'Inf_Weapons.ShellRifleDirt';
			break;

		case EST_Concrete:
			DampenFactor=0.4;
    		DampenFactorParallel=0.7;
    		ImpactSound=Sound'Inf_Weapons.ShellRifleConcrete';
			break;

		case EST_HollowWood:
			DampenFactor=0.25;
    		DampenFactorParallel=0.6;
    		ImpactSound=Sound'Inf_Weapons.ShellRifleWood';
			break;

		case EST_Mud:
			DampenFactor=0.0;
    		DampenFactorParallel=0.05;
    		ImpactSound=Sound'Inf_Weapons.ShellRifleDirt';
			break;

		default:
			DampenFactor=0.3;
    		DampenFactorParallel=0.5;
    		ImpactSound=Sound'Inf_Weapons.ShellRifleDirt';
			break;
	}
}

simulated function HitWall (vector HitNormal, actor Wall)
{
	local Vector VNorm;
	local ESurfaceTypes ST;
	local rotator LandRot;

	GetHitSurfaceType(ST, HitNormal);
    GetDampenAndSoundValue(ST);

    // Reflect off Wall w/damping
    VNorm = (Velocity dot HitNormal) * HitNormal;
    Velocity = -VNorm * DampenFactor + (Velocity - VNorm) * DampenFactorParallel;

    RandSpin(75000);
    Speed = VSize(Velocity);
    Bounces--;

    if( Speed < 20 || Bounces <= 0 )
	{
		bBounce = false;
		LandRot = Rotation;
		LandRot.Pitch = rotator(HitNormal).Pitch;
		LandRot.Pitch += 16384;
		SetRotation(LandRot);
    	SetPhysics(PHYS_None);
    }
    else if( ImpactSound != none )
    {
		PlaySound(ImpactSound, SLOT_Misc,0.4,,25,,true );
	}
}

simulated function BlowUp(vector HitLocation) {} // doesn't blow up

simulated function Explode(vector HitLocation, vector HitNormal) {}  // doesn't explode

defaultproperties
{
	Bounces = 10
	DampenFactor=0.6
    DampenFactorParallel=0.8
	bBounce=True
	bCanBeDamaged=false
	bAcceptsProjectors=false
	bUseCylinderCollision=true
	DamageRadius=0						// no damage radius
	Damage = 0                         // no damage from projectile
    MaxSpeed=+02000.000000
    speed=175
    MinStartSpeed=125
    MaxStartSpeed=175
    RandomYawRange=2000
    RandomPitchRange=2500
    RandomRollRange=500

    DrawType=DT_StaticMesh
    SoundVolume=0
    bCollideActors=True
    bCollideWorld=True
	bNetTemporary=true
	bGameRelevant=true
	bReplicateInstigator=false          // probably could be false
    Physics=PHYS_Falling               // we want shell to drop
    LifeSpan=+0010.000000
    NetPriority=+0000.000000           // has lower net priority
	MyDamageType=none                  // no damage type
	RemoteRole=ROLE_SimulatedProxy
	bUnlit=true
    bNetInitialRotation=false
	bDisturbFluidSurface=true
	//ImpactSound=Sound'WeaponSounds.BShell1'
	bRotateToDesired = true
}
