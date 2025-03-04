//=============================================================================
// ROBullet
//=============================================================================
// Realistic bullets
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2003-2004 John Gibson & Erik Christensen
//=============================================================================

class ROBullet extends ROBallisticProjectile
	abstract;

//=============================================================================
// Variables
//=============================================================================

// Constants
const 		MinPenetrateVelocity = 163;				// A bullet must travel ??? fps to penetrate a person.

// General
var()	class<ROHitEffect>		ImpactEffect;
//var()	class<ROVehicleHitEffect>	VehicleImpactEffect;

// Effects
var()		class<ROBulletWhiz>	WhizSoundEffect;        // Bullet whip sound effect class
var 		class<Actor> 		SplashEffect;           // Water splash effect class

// Internal use
var 		bool	 			bCollided;              // Server side variable used to help give a buffer for the client to catch up
var 		float 				DestroyTime;            // How long for the server to wait to destroy the actor after it has collided
var 		Actor 				WallHitActor;           // Internal var used for storing the wall that was hit so the same wall doesn't get hit again

var		class<DamageType>  		MyVehicleDamage;		// Stupid hack we need because takedamage doesn't like our roweapondamage for vehicles

//-----------------------------------------------------------------------------
// Tick
//-----------------------------------------------------------------------------

simulated function Tick(float DeltaTime)
{
	if ( bCollided )
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

//-----------------------------------------------------------------------------
// HitWall - The bullet hit a wall
//-----------------------------------------------------------------------------

simulated function HitWall(vector HitNormal, actor Wall)
{
	local ROVehicleHitEffect VehEffect;
    local RODestroyableStaticMesh DestroMesh;

	if ( WallHitActor != none && WallHitActor == Wall)
	{
		return;
	}
	WallHitActor = Wall;

    DestroMesh = RODestroyableStaticMesh(Wall);

	if (Role == ROLE_Authority)
	{
		// Have to use special damage for vehicles, otherwise it doesn't register for some reason - Ramm
		if( ROVehicle(Wall) != none )
		{
			Wall.TakeDamage(Damage - 20 * (1 - VSize(Velocity) / default.Speed), instigator, Location, MomentumTransfer * Normal(Velocity), MyVehicleDamage);
		}
		else if ( Mover(Wall) != None || DestroMesh != none || Vehicle(Wall) != none || ROVehicleWeapon(Wall) != none)
		{
			Wall.TakeDamage(Damage - 20 * (1 - VSize(Velocity) / default.Speed), instigator, Location, MomentumTransfer * Normal(Velocity), MyDamageType);
		}
		MakeNoise(1.0);
	}

	if( ROVehicle(Wall) != none)
	{
		if (Level.NetMode != NM_DedicatedServer)
		{
			VehEffect = Spawn(class'ROVehicleHitEffect',,, Location, rotator(-HitNormal));
			VehEffect.InitHitEffects(Location,HitNormal);
 		}
	}
	// Spawn the bullet hit effect client side
	else if (ImpactEffect != None && (Level.NetMode != NM_DedicatedServer))
	{
			Spawn(ImpactEffect,,, Location, rotator(-HitNormal));
	}

	super.HitWall(HitNormal, Wall);

	// Don't want to destroy the bullet if its going through something like glass
    if( DestroMesh != none && DestroMesh.bWontStopBullets )
    {
    	return;
    }

	// Give the bullet a little time to play the hit effect client side before destroying the bullet
     if (Level.NetMode == NM_DedicatedServer)
     {
     	bCollided = true;
     	SetCollision(False,False);
     }
     else
     {
     	Destroy();
     }
}

//-----------------------------------------------------------------------------
// ProcessTouch - We hit something, so damage it if it's a player
//-----------------------------------------------------------------------------

simulated function ProcessTouch(Actor Other, Vector HitLocation)
{
	local Vector	X, Y, Z;
	local float	V;
	local bool	bHitWhipAttachment;
	local ROVehicleHitEffect VehEffect;
	local ROPawn HitPawn;

	local Vector TempHitLocation, HitNormal;
	local array<int>	HitPoints;

	if (Other == Instigator || Other.Base == Instigator || !Other.bBlockHitPointTraces )
		return;

    if ( Level.NetMode != NM_DedicatedServer )
    {
		if( ROVehicleWeapon(Other) != none && !ROVehicleWeapon(Other).HitDriverArea(HitLocation, Velocity))
		{
			VehEffect = Spawn(class'ROVehicleHitEffect',,, HitLocation, rotator(Normal(Velocity)) /*rotator(-HitNormal)*/);
			VehEffect.InitHitEffects(HitLocation,Normal(-Velocity));
		}
	}

	V = VSize(Velocity);

	// If the bullet collides right after launch, it doesn't have any velocity yet.
	// Use the rotation instead and give it the default speed - Ramm
	if( V < 25 )
	{
		GetAxes(Rotation, X, Y, Z);
		V=default.Speed;
	}
	else
	{
	  	GetAxes(Rotator(Velocity), X, Y, Z);
	}

 	if( ROBulletWhipAttachment(Other) != none )
	{
    	bHitWhipAttachment=true;

        if(!Other.Base.bDeleteMe)
        {
	        Other = Instigator.HitPointTrace(TempHitLocation, HitNormal, HitLocation + (65535 * X), HitPoints, HitLocation,, 1);

			if( Other == none )
				return;

			HitPawn = ROPawn(Other);
		}
		else
		{
			return;
		}
	}

	if (V > MinPenetrateVelocity * ScaleFactor)
	{
        if (Role == ROLE_Authority)
        {
	    	if ( HitPawn != none )
	    	{
 				// Hit detection debugging
				/*log("Bullet hit "$HitPawn.PlayerReplicationInfo.PlayerName);
				HitPawn.HitStart = HitLocation;
				HitPawn.HitEnd = HitLocation + (65535 * X);*/

                if( !HitPawn.bDeleteMe )
                	HitPawn.ProcessLocationalDamage(Damage - 20 * (1 - V / default.Speed), Instigator, TempHitLocation, MomentumTransfer * X, MyDamageType,HitPoints);

                // Hit detection debugging
				//if( Level.NetMode == NM_Standalone)
				//	HitPawn.DrawBoneLocation();

				 bHitWhipAttachment = false;
	    	}
	    	else
	    	{
				Other.TakeDamage(Damage - 20 * (1 - V / default.Speed), Instigator, HitLocation, MomentumTransfer * X, MyDamageType);
			}
		}
		else
		{

	    	if ( HitPawn != none )
	    	{
		        bHitWhipAttachment = false;
	    	}
        }
	}

     if( !bHitWhipAttachment )
		Destroy();
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

	if ( !Level.bDropDetail && (Level.DetailMode != DM_Low) && (SplashEffect != None) && !Instigator.PhysicsVolume.bWaterVolume )
	{
		// check for splash
		bTraceWater = true;
		HitActor = Trace(HitLocation,HitNormal,SplashLocation - 50 * vect(0,0,1) , SplashLocation + 15 * vect(0,0,1),true);
		bTraceWater = false;
		if ( (FluidSurfaceInfo(HitActor) != None) || ((PhysicsVolume(HitActor) != None) && PhysicsVolume(HitActor).bWaterVolume) )
			Spawn(SplashEffect,,,HitLocation,rot(16384,0,0));
	}
}

//=============================================================================
// defaultproperties
//=============================================================================

defaultproperties
{
     MaxSpeed=100000
     MomentumTransfer=100
     Physics=PHYS_Projectile
     RemoteRole=ROLE_SimulatedProxy
     LifeSpan=5.000000
     DestroyTime=0.1
     DrawType=DT_None
     TossZ=0.0
     bDebugBallistics=false
	CollisionRadius=0.0
	CollisionHeight=0.0

	// Effects
    ImpactEffect=class'ROBulletHitEffect'
    WhizSoundEffect=class'ROBulletWhiz'
    SplashEffect=class'ROBulletHitWaterEffect'

    MyVehicleDamage=class'ROVehicleDamageType'

	bUseCollisionStaticMesh=true
}
