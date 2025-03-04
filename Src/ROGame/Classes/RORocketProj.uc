//===================================================================
// RORocketProj
//
// Copyright (C) 2004 John "Ramm-Jaeger"  Gibson
//
// Base class for RO rocket projectiles - right now basically a
// modified UT rocket rocket with custom physics
//===================================================================
class RORocketProj extends ROAntiVehicleProjectile;

#exec OBJ LOAD FILE=Inf_Weapons.uax

var 			bool 				bHitWater;
var				PanzerfaustTrail 	SmokeTrail;				// Smoke trail emitter
//var 			Effects 			Corona;					// Corona effect
var				sound				ExplodeSound[3];        // sound of this rocket exploding

// Physics
var() 		float 		StraightFlightTime;          // How long the rocket has propellant and flies straight
var 		float 		TotalFlightTime;             // How long the rocket has been in flight
var 		bool 		bOutOfPropellant;            // Rocket is out of propellant
// Physics debugging
var 		vector 		OuttaPropLocation;

simulated function PostBeginPlay()
{
	if ( Level.NetMode != NM_DedicatedServer)
	{
		SmokeTrail = Spawn(class'PanzerfaustTrail',self);
		SmokeTrail.SetBase(self);

		//Corona = Spawn(class'RocketCorona',self);
	}

	Velocity = speed * vector(Rotation);

	if (PhysicsVolume.bWaterVolume)
	{
		bHitWater = True;
		Velocity=0.6*Velocity;
	}

	Super.PostBeginPlay();
}

simulated function PostNetBeginPlay()
{
	local PlayerController PC;

	Super.PostNetBeginPlay();

	if ( Level.NetMode == NM_DedicatedServer )
		return;

	if ( Level.bDropDetail || (Level.DetailMode == DM_Low) )
	{
		bDynamicLight = false;
		LightType = LT_None;
	}
	else
	{
		PC = Level.GetLocalPlayerController();
		if ( (Instigator != None) && (PC == Instigator.Controller) )
			return;
		if ( (PC == None) || (PC.ViewTarget == None) || (VSize(PC.ViewTarget.Location - Location) > 3000) )
		{
			bDynamicLight = false;
			LightType = LT_None;
		}
	}
}

simulated function Tick(float DeltaTime)
{
    super.Tick(DeltaTime);

    if( !bOutOfPropellant )
    {
        if ( TotalFlightTime <= StraightFlightTime )
        {
            TotalFlightTime += DeltaTime;
        }
        else
        {
            OuttaPropLocation = Location;
            bOutOfPropellant = true;
        }
    }

    if(  bOutOfPropellant && Physics != PHYS_Falling )
    {
         //log(" Rocket flew "$(VSize(LaunchLocation - OuttaPropLocation)/52.48)$" meters before running out of juice");
         SetPhysics(PHYS_Falling);
    }
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
	        PlaySound(ExplodeSound[Rand(3)],,2.5*TransientSoundVolume);
	        if ( EffectIsRelevant(Location,false) )
	        {
	        	Spawn(ShellHitVehicleEffectClass,,,HitLocation + HitLocation*16,rotator(HitLocation));
	    		if ( (ExplosionDecal != None) && (Level.NetMode != NM_DedicatedServer) )
	    			Spawn(ExplosionDecal,self,,Location, rotator(-HitLocation));
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
							PlaySound(ExplodeSound[Rand(3)],,2.5*TransientSoundVolume);
							bShowDecal = true;
							bSnowDecal = true;
							break;
						case EST_Rock:
						case EST_Gravel:
						case EST_Concrete:
							Spawn(ShellHitRockEffectClass,,,HitLocation + HitNormal*16,rotator(HitNormal));
							PlaySound(ExplodeSound[Rand(3)],,2.5*TransientSoundVolume);
							bShowDecal = true;
							break;
						case EST_Wood:
						case EST_HollowWood:
							Spawn(ShellHitWoodEffectClass,,,HitLocation + HitNormal*16,rotator(HitNormal));
							PlaySound(ExplodeSound[Rand(3)],,2.5*TransientSoundVolume);
							bShowDecal = true;
							break;
						case EST_Water:
							Spawn(ShellHitWaterEffectClass,,,HitLocation + HitNormal*16,rotator(HitNormal));
							PlaySound(WaterHitSound,,5.5*TransientSoundVolume);
							bShowDecal = false;
							break;
						default:
							Spawn(ShellHitDirtEffectClass,,,HitLocation + HitNormal*16,rotator(HitNormal));
							PlaySound(ExplodeSound[Rand(3)],,2.5*TransientSoundVolume);
							bShowDecal = true;
							break;
					}

		    		if ( bShowDecal && Level.NetMode != NM_DedicatedServer )
		    		{
		    			if( bSnowDecal && ExplosionDecalSnow != None)
						{
		    				Spawn(ExplosionDecalSnow,self,,HitLocation, rotator(-HitNormal));
		    			}
		    			else if( ExplosionDecal != None)
						{
		    				Spawn(ExplosionDecal,self,,HitLocation, rotator(-HitNormal));
		    			}
		    		}
				}
	        }
	    }
	}

    super.Explode(HitLocation, HitNormal);
}

simulated function Destroyed()
{
	local vector TraceHitLocation, TraceHitNormal;
	local Material HitMaterial;
	local ESurfaceTypes ST;
	local bool bShowDecal, bSnowDecal;

    if ( SavedHitActor == none )
    {
       Trace(TraceHitLocation, TraceHitNormal, Location + Vector(Rotation) * 16, Location, false,, HitMaterial);
    }

	if( !bDidExplosionFX )
	{
	    if (HitMaterial == None)
			ST = EST_Default;
		else
			ST = ESurfaceTypes(HitMaterial.SurfaceType);

	    if ( SavedHitActor != none )
	    {

	        PlaySound(VehicleHitSound,,5.5*TransientSoundVolume);
	        PlaySound(ExplodeSound[Rand(3)],,2.5*TransientSoundVolume);
	        if ( EffectIsRelevant(Location,false) )
	        {
	        	Spawn(ShellHitVehicleEffectClass,,,SavedHitLocation + SavedHitNormal*16,rotator(SavedHitNormal));
	    		if ( (ExplosionDecal != None) && (Level.NetMode != NM_DedicatedServer) )
	    			Spawn(ExplosionDecal,self,,Location, rotator(-SavedHitNormal));
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
							Spawn(ShellHitSnowEffectClass,,,SavedHitLocation + SavedHitNormal*16,rotator(SavedHitNormal));
							PlaySound(ExplodeSound[Rand(3)],,2.5*TransientSoundVolume);
							bShowDecal = true;
							bSnowDecal = true;
							break;
						case EST_Rock:
						case EST_Gravel:
						case EST_Concrete:
							Spawn(ShellHitRockEffectClass,,,SavedHitLocation + SavedHitNormal*16,rotator(SavedHitNormal));
							PlaySound(ExplodeSound[Rand(3)],,2.5*TransientSoundVolume);
							bShowDecal = true;
							break;
						case EST_Wood:
						case EST_HollowWood:
							Spawn(ShellHitWoodEffectClass,,,SavedHitLocation + SavedHitNormal*16,rotator(SavedHitNormal));
							PlaySound(ExplodeSound[Rand(3)],,2.5*TransientSoundVolume);
							bShowDecal = true;
							break;
						case EST_Water:
							Spawn(ShellHitWaterEffectClass,,,SavedHitLocation + SavedHitNormal*16,rotator(SavedHitNormal));
							PlaySound(WaterHitSound,,5.5*TransientSoundVolume);
							bShowDecal = false;
							break;
						default:
							Spawn(ShellHitDirtEffectClass,,,SavedHitLocation + SavedHitNormal*16,rotator(SavedHitNormal));
							PlaySound(ExplodeSound[Rand(3)],,2.5*TransientSoundVolume);
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


	if ( SmokeTrail != None )
	{
		SmokeTrail.HandleOwnerDestroyed();
		//SmokeTrail.Destroy();
	}
//	if ( Corona != None )
//		Corona.Destroy();
	Super.Destroyed();
}

defaultproperties
{
    ShellImpactDamage=class'RORocketImpactDamage'
    ImpactDamage=400
    Physics = PHYS_Projectile
    StraightFlightTime=0.2
    bUpdateSimulatedPosition=true
    bTrueBallistics=false

    WaterHitSound=Sound'ProjectileSounds.cannon_rounds.AP_Impact_Water'

    ShellHitVehicleEffectClass=class'ROEffects.PanzerfaustHitTank'
    ShellHitDirtEffectClass=class'ROEffects.PanzerfaustHitDirt'
    ShellHitSnowEffectClass=class'ROEffects.PanzerfaustHitSnow'
    ShellHitWoodEffectClass=class'ROEffects.PanzerfaustHitWood'
    ShellHitRockEffectClass=class'ROEffects.PanzerfaustHitConcrete'
    ShellHitWaterEffectClass=class'ROEffects.PanzerfaustHitWater'
}

