//=============================================================================
// PTRDBullet
//=============================================================================
// Bullet for PTRD AT Rifle
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2003-2004 John "Ramm-Jaeger" Gibson
//=============================================================================

class PTRDBullet extends ROBullet;

// TODO: Should really try and combine this with the other shell penetration

// Penetration calculation
var int PenetrationTable[11];
var vector LaunchLocation;
// Deflection
var sound VehicleDeflectSound;
var sound VehicleHitSound;
var()   class<Emitter>  ShellHitVehicleEffectClass;
var byte HitCount;		// How many times we have hit something

// This function was having some wierd effects - Ramm
simulated function PostBeginPlay()
{
	super.PostBeginPlay();

    LaunchLocation = location;
}

//-----------------------------------------------------------------------------
// Tick - Update physics
//-----------------------------------------------------------------------------

simulated function Tick(float DeltaTime)
{
	super.Tick(DeltaTime);

	// Bit of a hack, bCollideActors gets replicated too soon so we don't get
	// the hitwall call client side to do our hit effects. This will prevent
	// that.
	if( HitCount == 0 && !bCollideActors && Level.NetMode == NM_Client)
	{
		SetCollision(True,True);
	}
}

simulated function int GetPenetrationNumber(vector Distance)
{
	local float MeterDistance;

	MeterDistance = VSize(Distance)/52.48;

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

//-----------------------------------------------------------------------------
// ProcessTouch - We hit something, so damage it if it's a player
//-----------------------------------------------------------------------------

simulated function ProcessTouch(Actor Other, Vector HitLocation)
{
	local Vector	X, Y, Z;
	local float	V;
	local bool	bHitWhipAttachment;
	local ROPawn HitPawn;
	local ROVehicle HitVehicle;
	local ROVehicleWeapon HitVehicleWeapon;
	local bool bHitVehicleDriver;
	local Vector TempHitLocation, HitNormal;
	local array<int>	HitPoints;

	if (Other == Instigator || Other.Base == Instigator || !Other.bBlockHitPointTraces )
		return;

	HitCount++;

	HitVehicleWeapon = ROVehicleWeapon(Other);
	HitVehicle = ROVehicle(Other.Base);

    if( HitVehicleWeapon != none && HitVehicle != none )
    {
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

	    if( HitVehicle.IsA('ROTreadCraft') && !ROTreadCraft(HitVehicle).ShouldPenetrate(HitLocation, Normal(Velocity), GetPenetrationNumber(LaunchLocation-HitLocation)))
	    {
			// Spawn the bullet hit effect client side
			if (ImpactEffect != None && (Level.NetMode != NM_DedicatedServer))
			{
		        PlaySound(VehicleDeflectSound,,5.5*TransientSoundVolume,,,1.5);
				Spawn(class'TankAPHitDeflect',,, Location + HitNormal*16,rotator(HitNormal));
			}
	        return;
	    }

		if (Role == ROLE_Authority)
		{
			if ( bHitVehicleDriver )
			{
				HitVehicleWeapon.TakeDamage(Damage - 20 * (1 - VSize(Velocity) / default.Speed), instigator, HitLocation, MomentumTransfer * Normal(Velocity), MyDamageType);
			}
			else
			{
				HitVehicle.TakeDamage(Damage - 20 * (1 - VSize(Velocity) / default.Speed), instigator, HitLocation, MomentumTransfer * Normal(Velocity), MyDamageType);
			}

			MakeNoise(1.0);
		}

	 	if ( Level.NetMode != NM_DedicatedServer)
		{
		    PlaySound(VehicleHitSound,,5.5*TransientSoundVolume,,,1.5);
		    if ( EffectIsRelevant(Location,false) )
		    {
				Spawn(ShellHitVehicleEffectClass,,,HitLocation,rotator(Normal(-Velocity)));
		    }
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

        return;
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
                 if(!HitPawn.bDeleteMe)
				 	HitPawn.ProcessLocationalDamage(Damage - 20 * (1 - V / default.Speed), Instigator, TempHitLocation, MomentumTransfer * X, MyDamageType,HitPoints);
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
// HitWall - The bullet hit a wall
//-----------------------------------------------------------------------------

simulated function HitWall(vector HitNormal, actor Wall)
{
    local RODestroyableStaticMesh DestroMesh;

    DestroMesh = RODestroyableStaticMesh(Wall);

	if ( WallHitActor != none && WallHitActor == Wall)
	{
		return;
	}
	WallHitActor = Wall;

	HitCount++;

    if( Wall.IsA('ROTreadCraft') && !ROTreadCraft(Wall).ShouldPenetrate(Location, Normal(Velocity), GetPenetrationNumber(LaunchLocation-Location)))
    {
		// Spawn the bullet hit effect client side
		if (ImpactEffect != None && (Level.NetMode != NM_DedicatedServer))
		{
			PlaySound(VehicleDeflectSound,,5.5*TransientSoundVolume,,,1.5);
			Spawn(class'TankAPHitDeflect',,, Location + HitNormal*16,rotator(HitNormal));
		}
        return;
    }

	if (Role == ROLE_Authority)
	{
		if ( Mover(Wall) != None || DestroMesh != none || Vehicle(Wall) != none || ROVehicleWeapon(Wall) != none)
			Wall.TakeDamage(Damage - 20 * (1 - VSize(Velocity) / default.Speed), instigator, Location, MomentumTransfer * Normal(Velocity), MyDamageType);
		MakeNoise(1.0);
	}

 	if ( Wall.IsA('ROVehicle') && (Level.NetMode != NM_DedicatedServer))
	{
		PlaySound(VehicleHitSound,,5.5*TransientSoundVolume,,,1.5);
	    if ( EffectIsRelevant(Location,false) )
	    {
			Spawn(ShellHitVehicleEffectClass,,,Location + HitNormal*16,rotator(HitNormal));
	    }
	}
	else if (ImpactEffect != None && (Level.NetMode != NM_DedicatedServer))
	{
		Spawn(ImpactEffect,,, Location, rotator(-HitNormal));
	}

	if (bDebugBallistics && Level.NetMode != NM_DedicatedServer)
		Spawn(class 'RODebugTracer',self,,Location,Rotation);

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

//=============================================================================
// defaultproperties
//=============================================================================

defaultproperties
{
	BallisticCoefficient=0.390
	Damage=125
	MyDamageType=class'PTRDDamType'
	Speed=53120 // 2363 fps

    VehicleHitSound=sound'ProjectileSounds.PTRD_penetrate'
    VehicleDeflectSound=sound'ProjectileSounds.PTRD_deflect'
    ShellHitVehicleEffectClass=class'ROEffects.TankAPHitPenetrateSmall'


	PenetrationTable(0)=8
	PenetrationTable(1)=7
	PenetrationTable(2)=7
	PenetrationTable(3)=6
	PenetrationTable(4)=6
	PenetrationTable(5)=5
	PenetrationTable(6)=4
	PenetrationTable(7)=3
	PenetrationTable(8)=2
	PenetrationTable(9)=1
	PenetrationTable(10)=0
}
