//=============================================================================
// ROServerBullet
//=============================================================================
// A server side only bullet. This is used with the high ROF weapon attachment
// to reduce network traffic
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2003-2005 John "Ramm-Jaeger" Gibson
//=============================================================================

class ROServerBullet extends ROBullet
	abstract;

//=============================================================================
// Functions
//=============================================================================

//-----------------------------------------------------------------------------
// HitWall - The bullet hit a wall
//-----------------------------------------------------------------------------

simulated function HitWall(vector HitNormal, actor Wall)
{
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
	local Vector TempHitLocation, HitNormal;
	local array<int>	HitPoints;

	if (Other == Instigator || Other.Base == Instigator || !Other.bBlockHitPointTraces )
		return;

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

 	if( ROBulletWhipAttachment(Other) != none)
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
	}

     if( !bHitWhipAttachment )
		Destroy();
}

//=============================================================================
// defaultproperties
//=============================================================================

defaultproperties
{
     // Only exists on the server
     RemoteRole=ROLE_None
}
