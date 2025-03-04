//=============================================================================
// ROClientTracer
//=============================================================================
// Client side only tracer bullets with real physics
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 John "Ramm-Jaeger" Gibson
//=============================================================================

class ROClientTracer extends ROClientBullet
	abstract;

//=============================================================================
// Variables
//=============================================================================

//var	xEmitter	Trail;
var 	class<Emitter>      mTracerClass;
var() 	Emitter 			mTracer;
var() 	float				mTracerInterval;
var() 	float				mTracerPullback;
var() 	Effects 			Corona;
var byte Bounces;
var() 	float				DampenFactor;
var() 	float				DampenFactorParallel;
var		StaticMesh			DeflectedMesh;
//=============================================================================
// Functions
//=============================================================================

//-----------------------------------------------------------------------------
// PostBeginPlay - Spawn tracer effect
//-----------------------------------------------------------------------------
simulated function PostBeginPlay()
{
    if ( Level.bDropDetail )
	{
		bDynamicLight = false;
		LightType = LT_None;
	}

	Super.PostBeginPlay();

	if (Level.NetMode != NM_DedicatedServer)
	{
		mTracer = Spawn(mTracerClass,self,,(Location+(Normal(Velocity))*mTracerPullback));
	}

    SetRotation( rotator(Velocity));
}

simulated function tick(float deltatime)
{
	super.Tick(DeltaTime);

	SetRotation( rotator(Velocity));
}


//-----------------------------------------------------------------------------
// Destroyed - Stop the tracer effect
//-----------------------------------------------------------------------------

simulated function Destroyed()
{
//	if (Trail != None)
//		Trail.mRegen = false;
	if(mTracer != none)
	   mTracer.Destroy();
	if( Corona != none )
		Corona.destroy();
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
		if( VSizeSquared(Velocity) < 250000 )
		{
			bBounce = false;
			Bounces = 0;
			Destroy();
		}
		else
            Deflect(HitNormal);

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
		if( VSizeSquared(Velocity) < 500000 )
		{
			bBounce = false;
			Bounces = 0;
			Destroy();
		}
		else
            Deflect(HitNormal);
     }
}

simulated function Landed( Vector HitNormal )
{
    SetPhysics(PHYS_None);
    Destroy();
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
	local bool bDeflect;

	if (Other == Instigator || Other.Base == Instigator || !Other.bBlockHitPointTraces )
		return;

	if ( Level.NetMode != NM_DedicatedServer )
	{
		if( ROVehicleWeapon(Other) != none && !ROVehicleWeapon(Other).HitDriverArea(HitLocation, Velocity))
		{
			VehEffect = Spawn(class'ROVehicleHitEffect',,, HitLocation, rotator(Normal(Velocity)) /*rotator(-HitNormal)*/);
			VehEffect.InitHitEffects(HitLocation,Normal(-Velocity));

			bDeflect=true;
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

        Other = Instigator.HitPointTrace(TempHitLocation, HitNormal, HitLocation + (65535 * X), HitPoints, HitLocation,, 1);

		HitPawn = ROPawn(Other);
	}

	if ( HitPawn != none )
	{
        bHitWhipAttachment = false;
	}


    if( !bHitWhipAttachment )
    {
		if( bDeflect && VSizeSquared(Velocity) > 500000)
			Deflect(Normal(-Velocity));
		else
			Destroy();
	}
}

simulated function Deflect(vector HitNormal)
{
	local vector VNorm;

	if( VSizeSquared(Velocity) < 750000 )
	{
		if(mTracer != none)
		   mTracer.Destroy();
	}

    if( StaticMesh != DeflectedMesh )
    {
    	SetStaticMesh(DeflectedMesh);
    }

    SetPhysics(PHYS_Falling);
    bTrueBallistics = false;
    Acceleration = PhysicsVolume.Gravity;

	if (Bounces > 0)
    {
	     Velocity *= 0.6;

		// Reflect off Wall w/damping
    	VNorm = (Velocity dot HitNormal) * HitNormal;
    	VNorm = VNorm + VRand()*FRand()*5000;  //Spread
    	Velocity = -VNorm * DampenFactor + (Velocity - VNorm) * DampenFactorParallel;
        Bounces--;
        return;
    }
	bBounce = false;
}

//=============================================================================
// defaultproperties
//=============================================================================

defaultproperties
{
    LightType=LT_Steady
    LightBrightness=90.000000
    LightRadius=16.000000
    LightHue=45
    LightSaturation=169
    LightCone=16
    bDynamicLight=True

    // new vars
	bUnlit=True
    AmbientGlow=254

    //mTracerInterval=0.06
    mTracerPullback=150.00

    bBounce=true
    Bounces=2
    DampenFactor=0.1
	DampenFactorParallel=0.05
}
