//=============================================================================
// ROClientBullet
//=============================================================================
// Client side only bullet for hit effects and whiz sounds only
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 John Gibson
//=============================================================================

class ROClientBullet extends ROBullet
	abstract;

//=============================================================================
// Functions
//=============================================================================

//-----------------------------------------------------------------------------
// PostBeginPlay
//-----------------------------------------------------------------------------

simulated function PostBeginPlay()
{
	local Vector	HitNormal;
	local Actor TraceHitActor;

	Acceleration = vect(0,0,0);
	Velocity = Vector(Rotation) * Speed;
	BCInverse = 1 / BallisticCoefficient;

	//if (Role == ROLE_Authority && Instigator.HeadVolume.bWaterVolume)
	//	Velocity *= 0.5;
	//SetCollision(True, True);

	if (bDebugBallistics && ROPawn(Instigator) != None)
	{
		FlightTime = 0;
		OrigLoc = Location;

		TraceHitActor = Trace(TraceHitLoc, HitNormal, Location + 65355 * Vector(Rotation), Location + (Instigator.CollisionRadius + 5) * vector(Rotation), true);

		if( TraceHitActor.IsA('ROBulletWhipAttachment'))
		{
			  TraceHitActor = Trace(TraceHitLoc, HitNormal, Location + 65355 * Vector(Rotation), TraceHitLoc + 5 * Vector(Rotation), true);
		}
				// super slow debugging
     	Spawn(class 'RODebugTracerGreen',self,,TraceHitLoc,Rotation);
     	log("Debug Tracing TraceHitActor ="$TraceHitActor);
	}
}

//-----------------------------------------------------------------------------
// HitWall - The bullet hit a wall
//-----------------------------------------------------------------------------

simulated function HitWall(vector HitNormal, actor Wall)
{
	local ROVehicleHitEffect VehEffect;
    local RODestroyableStaticMesh DestroMesh;

    DestroMesh = RODestroyableStaticMesh(Wall);

	if ( WallHitActor != none && WallHitActor == Wall)
	{
		return;
	}
	WallHitActor = Wall;

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

	super(ROBallisticProjectile).HitWall(HitNormal, Wall);

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
	local ROPawn HitPawn;
	local ROVehicleHitEffect VehEffect;
	local Vector TempHitLocation, HitNormal;
	local array<int>	HitPoints;

	if ( Instigator != none && (Other == Instigator || Other.Base == Instigator) || !Other.bBlockHitPointTraces )
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

		if( Instigator != none )
        	Other = Instigator.HitPointTrace(TempHitLocation, HitNormal, HitLocation + (65535 * X), HitPoints, HitLocation,, 1);

		HitPawn = ROPawn(Other);
	}

	if ( HitPawn != none )
	{
        bHitWhipAttachment = false;
	}

    if( !bHitWhipAttachment )
		Destroy();
}



