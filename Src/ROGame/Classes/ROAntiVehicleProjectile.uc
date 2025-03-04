//===================================================================
// ROAntiVehicleProjectile
//
// Copyright (C) 2004 John "Ramm-Jaeger"  Gibson
//
// Base class for all vehicle destroying projectiles
//===================================================================

class ROAntiVehicleProjectile extends ROBallisticProjectile
	abstract;

//=============================================================================
// Variables
//=============================================================================

var 		int 		NumDeflections; 			// Added this so it won't infinitely deflect, getting stuck in a loop

// Penetration calculation
var 		int 		PenetrationTable[11];

// Impact Damage
var class<DamageType> 	ShellImpactDamage;
var 		int   		ImpactDamage;

// Deflection
var 		sound 		VehicleDeflectSound;
var() 		float 		DampenFactor;
var() 		float 		DampenFactorParallel;

var 		vector 		LaunchLocation;
var 		Pawn 		SavedHitActor;
var 		Actor 		SavedTouchActor;
var 		vector 		SavedHitLocation;
var 		vector 		SavedHitNormal;

// Internal use
var 		bool 		bCollided;            		// Server side variable used to help give a buffer for the client to catch up
var 		float 		DestroyTime;           		// How long for the server to wait to destroy the actor after it has collided

// Impact sounds
var 		sound 		VehicleHitSound; 			// sound of this shell penetrating a vehicle
var 		sound 		DirtHitSound;               // Sound of this shell hitting dirt
var 		sound 		RockHitSound;               // Sound of this shell hitting rock
var 		sound 		WaterHitSound;              // Sound of this shell hitting water
var 		sound 		WoodHitSound;               // Sound of this shell hitting wood

// Effects
var()   class<Emitter>  ShellHitVehicleEffectClass; // Effect for this shell hitting a vehicle
var()   class<Emitter>  ShellDeflectEffectClass; 	// Effect for this shell hitting a vehicle
var()   class<Emitter>  ShellHitDirtEffectClass;    // Effect for this shell hitting dirt
var()   class<Emitter>  ShellHitSnowEffectClass;    // Effect for this shell hitting snow
var()   class<Emitter>  ShellHitWoodEffectClass;    // Effect for this shell hitting wood
var()   class<Emitter>  ShellHitRockEffectClass;    // Effect for this shell hitting rock
var()   class<Emitter>  ShellHitWaterEffectClass;   // Effect for this shell hitting water

var bool Firsthit;
var bool Drawdebuglines;
var	bool bDidExplosionFX; // Already did the explosion effects

//var()	float			DestroyBelowVelocitySquared; // When the shell drops below this velocity just destroy it as it is likely stuck on something

//=============================================================================
// Variables
//=============================================================================

simulated function PostBeginPlay()
{
    LaunchLocation = Location;

  	super.PostBeginPlay();
}

simulated function Tick(float DeltaTime)
{
    super.Tick(DeltaTime);

	if ( bCollided && Level.NetMode == NM_DedicatedServer )
	{
		if ( DestroyTime <= 0.0 )
		{
			Destroy();
		}
		else
		{
			DestroyTime -= DeltaTime;
		}
	}
}

simulated function Explode(vector HitLocation, vector HitNormal)
{
	if( bCollided )
		return;

	BlowUp(HitLocation);

	// Save the hit info for when the shell is destroyed
	SavedHitLocation = HitLocation;
	SavedHitNormal = HitNormal;
	AmbientSound=none;

    bDidExplosionFX = true;

	if (Level.NetMode == NM_DedicatedServer)
	{
		bCollided = true;
		SetCollision(False,False);
	}
	else
	{
		bCollided = true;
		Destroy();
	}
}


simulated function int GetPenetrationNumber(vector Distance)
{
	local float MeterDistance;

	MeterDistance = VSize(Distance)/52.48;

 	// Distance debugging
 	//log(self$" traveled "$MeterDistance$" meters for penetration calculations");
	//Level.Game.Broadcast(self, self$" traveled "$MeterDistance$" meters for penetration calculations");

	if( MeterDistance < 50)			return PenetrationTable[0];
	else if ( MeterDistance < 100)	return PenetrationTable[1];
	else if ( MeterDistance < 300)	return PenetrationTable[2];
	else if ( MeterDistance < 600)	return PenetrationTable[3];
	else if ( MeterDistance < 900)	return PenetrationTable[4];
	else if ( MeterDistance < 1200)	return PenetrationTable[5];
	else if ( MeterDistance < 1500)	return PenetrationTable[6];
	else if ( MeterDistance < 1800)	return PenetrationTable[7];
	else if ( MeterDistance < 2100)	return PenetrationTable[8];
	else if ( MeterDistance < 2400)	return PenetrationTable[9];
	else if ( MeterDistance < 2700)	return PenetrationTable[10];
	else 							return PenetrationTable[10];
}

simulated function ProcessTouch(Actor Other, Vector HitLocation)
{
	local ROVehicle HitVehicle;
	local ROVehicleWeapon HitVehicleWeapon;
	local bool bHitVehicleDriver;

	local Vector TempHitLocation, HitNormal;
	local array<int>	HitPoints;

	HitVehicleWeapon = ROVehicleWeapon(Other);
	HitVehicle = ROVehicle(Other.Base);

    if( Other == none || (SavedTouchActor != none && SavedTouchActor == Other) || Other.bDeleteMe ||
		ROBulletWhipAttachment(Other) != none  )
    {
    	return;
    }

    SavedTouchActor = Other;

	if ( (Other != instigator) && (Other.Base != instigator) && (!Other.IsA('Projectile') || Other.bProjTarget) )
	{
	    if( HitVehicleWeapon != none && HitVehicle != none )
	    {
		   SavedHitActor = Pawn(Other.Base);

			if ( HitVehicleWeapon.HitDriverArea(HitLocation, Velocity) )
			{
				if( HitVehicleWeapon.HitDriver(HitLocation, Velocity) )
				{
					bHitVehicleDriver = true;
				}
				else
				{
					return;
				}
			}

		    if( HitVehicle.IsA('ROTreadCraft') && !ROTreadCraft(HitVehicle).ShouldPenetrate(HitLocation, Normal(Velocity), GetPenetrationNumber(LaunchLocation-HitLocation), ShellImpactDamage))
		    {
				if( Drawdebuglines && Firsthit )
				{
					FirstHit=false;
					DrawStayingDebugLine( Location, Location-(Normal(Velocity)*500), 0, 255, 0);
				}

				// Don't save hitting this actor since we deflected
        		SavedHitActor = none;
        		// Don't update the position any more
				bUpdateSimulatedPosition=false;

		        DeflectWithoutNormal(Other.Base, HitLocation);
		        if( Instigator != none && Instigator.Controller != none && ROBot(Instigator.Controller) != none )
		        	ROBot(Instigator.Controller).NotifyIneffectiveAttack(HitVehicle);
		        return;
		    }

		    // Don't update the position any more and don't move the projectile any more.
			bUpdateSimulatedPosition=false;
			SetPhysics(PHYS_None);
			SetDrawType(DT_None);

			if ( Role == ROLE_Authority )
			{
				if ( !Other.Base.bStatic && !Other.Base.bWorldGeometry )
				{
					if ( Instigator == None || Instigator.Controller == None )
					{
						Other.Base.SetDelayedDamageInstigatorController( InstigatorController );
						if( bHitVehicleDriver )
						{
						    Other.SetDelayedDamageInstigatorController( InstigatorController );
						}
					}

					if( Drawdebuglines && Firsthit )
					{
						FirstHit=false;
						DrawStayingDebugLine( Location, Location-(Normal(Velocity)*500), 255, 0, 0);
					}

					if ( savedhitactor != none )
					{
						Other.Base.TakeDamage(ImpactDamage, instigator, Location, MomentumTransfer * Normal(Velocity), ShellImpactDamage);
					}

					if( bHitVehicleDriver )
					{
						Other.TakeDamage(ImpactDamage, instigator, Location, MomentumTransfer * Normal(Velocity), ShellImpactDamage);
					}

					if( Other != none && !Other.bDeleteMe )
					{
						if (DamageRadius > 0 && Vehicle(Other.Base) != None && Vehicle(Other.Base).Health > 0)
							Vehicle(Other.Base).DriverRadiusDamage(Damage, DamageRadius, InstigatorController, MyDamageType, MomentumTransfer, HitLocation);
						HurtWall = Other.Base;
					}
				}
				MakeNoise(1.0);
			}
			Explode(HitLocation + ExploWallOut * Normal(-Velocity), Normal(-Velocity));
			HurtWall = None;

            return;
	    }
	    else
	    {
			if ( (Pawn(Other) != none || RODestroyableStaticMesh(Other) != none) && Role==Role_Authority )
			{
		        if( ROPawn(Other) != none )
		        {

					if(!Other.bDeleteMe)
			        {
				        Other = HitPointTrace(TempHitLocation, HitNormal, HitLocation + (65535 * Normal(Velocity)), HitPoints, HitLocation,, 1);

						if( Other == none )
							return;
						else
							ROPawn(Other).ProcessLocationalDamage(ImpactDamage, instigator, Location, MomentumTransfer * Normal(Velocity), ShellImpactDamage,HitPoints);

					}
					else
					{
						return;
					}
				}
				else
				{
				 	Other.TakeDamage(ImpactDamage, instigator, Location, MomentumTransfer * Normal(Velocity), ShellImpactDamage);
				}
			}
			else if(Role==Role_Authority )
			{
		        if( Instigator != none && Instigator.Controller != none && ROBot(Instigator.Controller) != none )
					ROBot(Instigator.Controller).NotifyIneffectiveAttack(HitVehicle);
			}
	        Explode(HitLocation,Vect(0,0,1));
	    }
	}
}

simulated singular function HitWall(vector HitNormal, actor Wall)
{
	local vector SavedVelocity;
//	local PlayerController PC;

    if ( Wall.Base != none && Wall.Base == instigator )
     	return;

     SavedVelocity = Velocity;

    if( Wall.IsA('ROTreadCraft') && !ROTreadCraft(Wall).ShouldPenetrate(Location, Normal(Velocity), GetPenetrationNumber(LaunchLocation-Location), ShellImpactDamage))
    {
		if( Drawdebuglines && Firsthit )
		{
			 FirstHit=false;
			 DrawStayingDebugLine( Location, Location-(Normal(Velocity)*500), 0, 255, 0);
		}

		// Don't save hitting this actor since we deflected
        SavedHitActor = none;
        // Don't update the position any more
		bUpdateSimulatedPosition=false;

        Deflect(HitNormal, Wall);

        if( Instigator != none && Instigator.Controller != none && ROBot(Instigator.Controller) != none )
			ROBot(Instigator.Controller).NotifyIneffectiveAttack(ROVehicle(Wall));

        return;
    }

    if ((SavedHitActor == Wall) || (Wall.bDeleteMe) )
     	return;

    // Don't update the position any more and don't move the projectile any more.
	bUpdateSimulatedPosition=false;
	SetPhysics(PHYS_None);
	SetDrawType(DT_None);

    SavedHitActor = Pawn(Wall);

	super.HitWall(HitNormal, Wall);

	if ( Role == ROLE_Authority )
	{
		if ((!Wall.bStatic && !Wall.bWorldGeometry) || RODestroyableStaticMesh(Wall) != none || Mover(Wall) != none)
		{
			if ( Instigator == None || Instigator.Controller == None )
				Wall.SetDelayedDamageInstigatorController( InstigatorController );

			if ( savedhitactor != none || RODestroyableStaticMesh(Wall) != none || Mover(Wall) != none)
			{
				if( Drawdebuglines && Firsthit )
				{
					FirstHit=false;
					DrawStayingDebugLine( Location, Location-(Normal(SavedVelocity)*500), 255, 0, 0);
				}
				Wall.TakeDamage(ImpactDamage, instigator, Location, MomentumTransfer * Normal(SavedVelocity), ShellImpactDamage);
			}

			if (DamageRadius > 0 && Vehicle(Wall) != None && Vehicle(Wall).Health > 0)
				Vehicle(Wall).DriverRadiusDamage(Damage, DamageRadius, InstigatorController, MyDamageType, MomentumTransfer, Location);
			HurtWall = Wall;
		}
		else
		{
			if( Instigator != none && Instigator.Controller != none && ROBot(Instigator.Controller) != none )
	        	ROBot(Instigator.Controller).NotifyIneffectiveAttack();
		}
		MakeNoise(1.0);
	}
	Explode(Location + ExploWallOut * HitNormal, HitNormal);
	// We do this in the explode logic
//	if ( (ExplosionDecal != None) && (Level.NetMode != NM_DedicatedServer)  )
//	{
//		if ( ExplosionDecal.Default.CullDistance != 0 )
//		{
//			PC = Level.GetLocalPlayerController();
//			if ( !PC.BeyondViewDistance(Location, ExplosionDecal.Default.CullDistance) )
//				Spawn(ExplosionDecal,self,,Location, rotator(-HitNormal));
//			else if ( (Instigator != None) && (PC == Instigator.Controller) && !PC.BeyondViewDistance(Location, 2*ExplosionDecal.Default.CullDistance) )
//				Spawn(ExplosionDecal,self,,Location, rotator(-HitNormal));
//		}
//		else
//			Spawn(ExplosionDecal,self,,Location, rotator(-HitNormal));
//	}
	HurtWall = None;
	//log(" Shell flew "$(VSize(LaunchLocation - Location)/52.48)$" meters total");
}

// Bounce the shell off the target
simulated function Deflect(vector HitNormal, actor Wall)
{
	local vector VNorm;
    //local ESurfaceTypes ST;

	// Don't let this thing constantly deflect
	if( NumDeflections > 5 )
	{
		//Destroy();
		//SetCollision(False,False);
		//SetDrawType(DT_None);
		Explode(Location + ExploWallOut * HitNormal, HitNormal);
		return;
	}

	// Once we have bounced, just fall to the ground
    SetPhysics(PHYS_Falling);
    bTrueBallistics = false;
    Acceleration = PhysicsVolume.Gravity;

	AmbientSound=none;

    NumDeflections++;

    // Reflect off Wall w/damping
	VNorm = (Velocity dot HitNormal) * HitNormal;
	Velocity = -VNorm * DampenFactor + (Velocity - VNorm) * DampenFactorParallel;
	//Velocity = 0.3 * (Velocity - 2.0 * HitNormal * (Velocity dot HitNormal));
	//RandSpin(100000);
	// Slow the shell down when it hits
	//Velocity.X *= 0.5;
	//Velocity.Y *= 0.5;

	Speed = VSize(Velocity);

    if (Level.NetMode != NM_DedicatedServer && NumDeflections < 2)
    {
        if ( EffectIsRelevant(Location,false) )
        {
        	Spawn(ShellDeflectEffectClass,,,Location + HitNormal*16,rotator(HitNormal));
        }
		PlaySound(VehicleDeflectSound,,5.5*TransientSoundVolume);
    }
}

// Bounce the shell off the target without Hitnormal information
simulated function DeflectWithoutNormal(actor Wall, vector HitLocation)
{
	local vector VNorm;
	local vector TraceHitLocation, HitNormal;

    Trace(TraceHitLocation, HitNormal, HitLocation + Normal(Velocity) * 50, HitLocation - Normal(Velocity) * 50, True);

	// Don't let this thing constantly deflect
	if( NumDeflections > 5 )
	{
		//Destroy();
		//SetCollision(False,False);
		//SetDrawType(DT_None);
		Explode(HitLocation + ExploWallOut * HitNormal, HitNormal);
		return;
	}

	// Once we have bounced, just fall to the ground
    SetPhysics(PHYS_Falling);
    bTrueBallistics = false;
    Acceleration = PhysicsVolume.Gravity;

	AmbientSound=none;

    NumDeflections++;

    // Reflect off Wall w/damping
	VNorm = (Velocity dot HitNormal) * HitNormal;
	Velocity = -VNorm * DampenFactor + (Velocity - VNorm) * DampenFactorParallel;

	Speed = VSize(Velocity);

    if (Level.NetMode != NM_DedicatedServer && NumDeflections < 2)
    {
        if ( EffectIsRelevant(Location,false) )
        {
        	Spawn(ShellDeflectEffectClass,,,HitLocation + HitNormal*16,rotator(HitNormal));
        }
		PlaySound(VehicleDeflectSound,,5.5*TransientSoundVolume);
    }
}

//-----------------------------------------------------------------------------
// PhysicsVolumeChange
//-----------------------------------------------------------------------------

simulated function PhysicsVolumeChange( PhysicsVolume Volume )
{
	if (Volume.bWaterVolume)
	{
		Velocity *= 0.5;
		if( Level.Netmode != NM_DedicatedServer );
			CheckForSplash(Location);
	}
}

//-----------------------------------------------------------------------------
// CheckForSplash - Do the water hit effect
//-----------------------------------------------------------------------------
simulated function CheckForSplash(vector SplashLocation)
{
	local Actor HitActor;
	local vector HitNormal, HitLocation;

	if ( !Level.bDropDetail && (Level.DetailMode != DM_Low) && (ShellHitWaterEffectClass != None) && !Instigator.PhysicsVolume.bWaterVolume )
	{
		// check for splash
		bTraceWater = true;
		HitActor = Trace(HitLocation,HitNormal,SplashLocation - 50 * vect(0,0,1) , SplashLocation + 15 * vect(0,0,1),true);
		bTraceWater = false;
		if ( (FluidSurfaceInfo(HitActor) != None) || ((PhysicsVolume(HitActor) != None) && PhysicsVolume(HitActor).bWaterVolume) )
		{
			Spawn(ShellHitWaterEffectClass,,,HitLocation,rot(16384,0,0));
			PlaySound(WaterHitSound,,5.5*TransientSoundVolume);
		}
	}
}

defaultproperties
{
    VehicleDeflectSound=Sound'ProjectileSounds.cannon_rounds.AP_deflect'

    DampenFactor=0.5//0.2
    DampenFactorParallel=0.2
    DestroyTime=0.2
    Firsthit=true
    Drawdebuglines=false;
}

