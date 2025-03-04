//===================================================================
// ROTankCannonShell
//
// Copyright (C) 2004 John "Ramm-Jaeger"  Gibson
//
// Base class for RO tank cannon shells.
//===================================================================
class ROTankCannonShell extends ROAntiVehicleProjectile;

var bool bHitWater;

struct RangePoint
{
	var() int           	Range;     			// Meter distance for this range setting
	var() float           	RangeValue;     	// The adjustment value for this range setting
};

var() 	array<RangePoint>	MechanicalRanges; 	// The range setting values for tank cannons that do mechanical pitch adjustments for aiming
var() 	array<RangePoint>	OpticalRanges;    	// The range setting values for tank cannons that do optical sight adjustments for aiming
var		bool				bMechanicalAiming;  // Uses the Mechanical Range settings for this projectile
var		bool				bOpticalAiming;  	// Uses the Optical Range settings for this projectile

var Effects Corona; // Tracer

// for tank cannon aiming. Returns the proper pitch adjustment to hit a target at a particular range
simulated static function int GetPitchForRange(int Range)
{
	local int i;

	if( !default.bMechanicalAiming )
		return 0;

	for (i = 0; i < default.MechanicalRanges.Length; i++)
	{
		if( default.MechanicalRanges[i].Range >= Range )
		{
			return default.MechanicalRanges[i].RangeValue;
		}
	}

	return 0;
}
// for tank cannon aiming. Returns the proper Y adjustment of the scope to hit a target at a particular range
simulated static function float GetYAdjustForRange(int Range)
{
	local int i;

	if( !default.bOpticalAiming )
		return 0;

	for (i = 0; i < default.OpticalRanges.Length; i++)
	{
		if( default.OpticalRanges[i].Range >= Range )
		{
			return default.OpticalRanges[i].RangeValue;
		}
	}

	return 0;
}

simulated function Destroyed()
{
	local vector TraceHitLocation, TraceHitNormal;
	local Material HitMaterial;
	local ESurfaceTypes ST;
	local bool bShowDecal, bSnowDecal;

	if( ROTankCannonPawn(Instigator) != none && ROTankCannon(ROTankCannonPawn(Instigator).Gun) != none)
	{
		ROTankCannon(ROTankCannonPawn(Instigator).Gun).HandleShellDebug(SavedHitLocation);
	}

	if( !bDidExplosionFX )
	{
	    if ( SavedHitActor == none )
	    {
	       Trace(TraceHitLocation, TraceHitNormal, Location + Vector(Rotation) * 16, Location, false,, HitMaterial);
	    }

	    if (HitMaterial == None)
			ST = EST_Default;
		else
			ST = ESurfaceTypes(HitMaterial.SurfaceType);

	    if ( SavedHitActor != none )
	    {

	        PlaySound(VehicleHitSound,,5.5*TransientSoundVolume);
	        if ( EffectIsRelevant(SavedHitLocation,false) )
	        {
	        	Spawn(ShellHitVehicleEffectClass,,,SavedHitLocation + SavedHitNormal*16,rotator(SavedHitNormal));
	    		if ( (ExplosionDecal != None) && (Level.NetMode != NM_DedicatedServer) )
	    			Spawn(ExplosionDecal,self,,SavedHitLocation, rotator(-SavedHitNormal));
	        }
	    }
	    else
	    {
	        if ( EffectIsRelevant(SavedHitLocation,false) )
	        {
				if( !PhysicsVolume.bWaterVolume )
				{
					Switch(ST)
					{
						case EST_Snow:
						case EST_Ice:
							Spawn(ShellHitSnowEffectClass,,,SavedHitLocation + SavedHitNormal*16,rotator(SavedHitNormal));
							PlaySound(DirtHitSound,,5.5*TransientSoundVolume);
							bShowDecal = true;
							bSnowDecal = true;
							break;
						case EST_Rock:
						case EST_Gravel:
						case EST_Concrete:
							Spawn(ShellHitRockEffectClass,,,SavedHitLocation + SavedHitNormal*16,rotator(SavedHitNormal));
							PlaySound(RockHitSound,,5.5*TransientSoundVolume);
							bShowDecal = true;
							break;
						case EST_Wood:
						case EST_HollowWood:
							Spawn(ShellHitWoodEffectClass,,,SavedHitLocation + SavedHitNormal*16,rotator(SavedHitNormal));
							PlaySound(WoodHitSound,,5.5*TransientSoundVolume);
							bShowDecal = true;
							break;
						case EST_Water:
							Spawn(ShellHitWaterEffectClass,,,SavedHitLocation + SavedHitNormal*16,rotator(SavedHitNormal));
							bShowDecal = false;
							break;
						default:
							Spawn(ShellHitDirtEffectClass,,,SavedHitLocation + SavedHitNormal*16,rotator(SavedHitNormal));
							PlaySound(DirtHitSound,,5.5*TransientSoundVolume);
							bShowDecal = true;
							break;
					}

		    		if ( bShowDecal && Level.NetMode != NM_DedicatedServer )
		    		{
		    			if( bSnowDecal && ExplosionDecalSnow != None)
						{
		    				Spawn(ExplosionDecalSnow,self,,SavedHitLocation, rotator(-SavedHitNormal));
		    			}
		    			else if( ExplosionDecal != None)
						{
		    				Spawn(ExplosionDecal,self,,SavedHitLocation, rotator(-SavedHitNormal));
		    			}
		    		}
				}
	        }
	    }
    }

	if ( Corona != None )
		Corona.Destroy();

	Super.Destroyed();
}

simulated function PostBeginPlay()
{
    // Set a longer lifespan for the shell if there is a possibility of a very long range shot
	Switch(Level.ViewDistanceLevel)
	{
		case VDL_Default_1000m:
			break;
		case VDL_Medium_2000m:
            Lifespan *= 1.3;
			break;
		case VDL_High_3000m:
            Lifespan *= 1.8;
			break;
		case VDL_Extreme_4000m:
            Lifespan *= 2.8;
			break;
	}

	if ( Level.NetMode != NM_DedicatedServer)
	{
		Corona = Spawn(class'RocketCorona',self);
	}

	if (PhysicsVolume.bWaterVolume)
	{
		bHitWater = True;
		Velocity=0.6*Velocity;
	}
    if ( Level.bDropDetail )
	{
		bDynamicLight = false;
		LightType = LT_None;
	}

	super.PostBeginPlay();
}

simulated function Landed( vector HitNormal )
{
	Explode(Location,HitNormal);
}

function BlowUp(vector HitLocation)
{
	HurtRadius(Damage, DamageRadius, MyDamageType, MomentumTransfer, HitLocation );
	MakeNoise(1.0);
}

simulated function Explode(vector HitLocation, vector HitNormal)
{
	local vector TraceHitLocation, TraceHitNormal;
	local Material HitMaterial;
	local ESurfaceTypes ST;
	local bool bShowDecal, bSnowDecal;

	if( ROTankCannonPawn(Instigator) != none && ROTankCannon(ROTankCannonPawn(Instigator).Gun) != none)
	{
		ROTankCannon(ROTankCannonPawn(Instigator).Gun).HandleShellDebug(HitLocation);
	}

	if( !bDidExplosionFX )
	{
	    if ( SavedHitActor == none )
	    {
	       Trace(TraceHitLocation, TraceHitNormal, Location + Vector(Rotation) * 16, Location, false,, HitMaterial);
	    }

	    if (HitMaterial == None)
			ST = EST_Default;
		else
			ST = ESurfaceTypes(HitMaterial.SurfaceType);

	    if ( SavedHitActor != none )
	    {

	        PlaySound(VehicleHitSound,,5.5*TransientSoundVolume);
	        if ( EffectIsRelevant(Location,false) )
	        {
	        	Spawn(ShellHitVehicleEffectClass,,,HitLocation + HitNormal*16,rotator(HitNormal));
	    		if ( (ExplosionDecal != None) && (Level.NetMode != NM_DedicatedServer) )
	    			Spawn(ExplosionDecal,self,,Location, rotator(-HitNormal));
	        }
	    }
	    else
	    {
	        if ( EffectIsRelevant(Location,false) )
	        {
				if( !PhysicsVolume.bWaterVolume )
				{
					Switch(ST)
					{
						case EST_Snow:
						case EST_Ice:
							Spawn(ShellHitSnowEffectClass,,,HitLocation + HitNormal*16,rotator(HitNormal));
							PlaySound(DirtHitSound,,5.5*TransientSoundVolume);
							bShowDecal = true;
							bSnowDecal = true;
							break;
						case EST_Rock:
						case EST_Gravel:
						case EST_Concrete:
							Spawn(ShellHitRockEffectClass,,,HitLocation + HitNormal*16,rotator(HitNormal));
							PlaySound(RockHitSound,,5.5*TransientSoundVolume);
							bShowDecal = true;
							break;
						case EST_Wood:
						case EST_HollowWood:
							Spawn(ShellHitWoodEffectClass,,,HitLocation + HitNormal*16,rotator(HitNormal));
							PlaySound(WoodHitSound,,5.5*TransientSoundVolume);
							bShowDecal = true;
							break;
						case EST_Water:
							Spawn(ShellHitWaterEffectClass,,,HitLocation + HitNormal*16,rotator(HitNormal));
							bShowDecal = false;
							break;
						default:
							Spawn(ShellHitDirtEffectClass,,,HitLocation + HitNormal*16,rotator(HitNormal));
							PlaySound(DirtHitSound,,5.5*TransientSoundVolume);
							bShowDecal = true;
							break;
					}

		    		if ( bShowDecal && Level.NetMode != NM_DedicatedServer )
		    		{
		    			if( bSnowDecal && ExplosionDecalSnow != None)
						{
		    				Spawn(ExplosionDecalSnow,self,,Location, rotator(-HitNormal));
		    			}
		    			else if( ExplosionDecal != None)
						{
		    				Spawn(ExplosionDecal,self,,Location, rotator(-HitNormal));
		    			}
		    		}
				}
	        }
	    }
    }

	if ( Corona != None )
		Corona.Destroy();

	super.Explode(HitLocation, HitNormal);
}


defaultproperties
{
    Speed=500//22000//15000.0
    MaxSpeed=22000//15000.0
    InitialAccelerationTime=0.2
    MomentumTransfer=10000//125000
    Damage=150.0
    DamageRadius=300.0//660.0
    AmbientSound=sound'Vehicle_Weapons.Misc.projectile_whistle01'
    SoundVolume=255
    SoundRadius=700
    AmbientVolumeScale=5.0
    TransientSoundVolume=1.0
    TransientSoundRadius=1000
    bFullVolume=false
    MyDamageType=class'ROTankShellExplosionDamage'
	ExplosionDecal=class'TankAPMarkDirt'
	ExplosionDecalSnow=class'TankAPMarkSnow'
    RemoteRole=ROLE_SimulatedProxy
    LifeSpan=7.5
    DrawType=DT_StaticMesh
    StaticMesh=StaticMesh'WeaponPickupSM.Ammo.85mm_Shell'
    AmbientGlow=96
    bUnlit=True
    bBounce=false
    bFixedRotationDir=True
    RotationRate=(Roll=50000)
    DesiredRotation=(Roll=30000)
    ForceType=FT_Constant
    ForceScale=5.0
    ForceRadius=100.0
    bCollideWorld=true
    FluidSurfaceShootStrengthMod=10.0
    ShellImpactDamage=class'ROTankShellImpactDamage'
    ImpactDamage=400
    bNetTemporary=false

    Physics = PHYS_Projectile
    bUpdateSimulatedPosition=true//false

    VehicleHitSound=Sound'ProjectileSounds.cannon_rounds.AP_penetrate'

    DirtHitSound=Sound'ProjectileSounds.cannon_rounds.AP_Impact_Dirt'
    RockHitSound=Sound'ProjectileSounds.cannon_rounds.AP_Impact_Rock'
    WaterHitSound=Sound'ProjectileSounds.cannon_rounds.AP_Impact_Water'
    WoodHitSound=Sound'ProjectileSounds.cannon_rounds.AP_Impact_Wood'

    ShellHitVehicleEffectClass=class'ROEffects.TankAPHitPenetrate'
    ShellDeflectEffectClass=class'ROEffects.TankAPHitDeflect'
    ShellHitDirtEffectClass=class'ROEffects.TankAPHitDirtEffect'
    ShellHitSnowEffectClass=class'ROEffects.TankAPHitSnowEffect'
    ShellHitWoodEffectClass=class'ROEffects.TankAPHitWoodEffect'
    ShellHitRockEffectClass=class'ROEffects.TankAPHitRockEffect'
    ShellHitWaterEffectClass=class'ROEffects.TankAPHitWaterEffect'

	bUseCollisionStaticMesh=true
}
