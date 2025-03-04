//=============================================================================
// ROHighROFWeaponAttachment
//=============================================================================
// An weapon attachment class for weapons with very high (> 500 rpm)
// cyclic rates. This class handles packing hit effect information and
// sending it to clients in sets of two to reduce network bandwidth and
// CPU overhead.
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 John "Ramm-Jaeger" Gibson
//=============================================================================

class ROHighROFWeaponAttachment extends ROWeaponAttachment
	abstract;

//=============================================================================
// Variables
//=============================================================================

// Struct that holds the info we need to launch our client side hit effect
struct ShotInfo
{
	var vector 	ShotLocation;
	var rotator ShotAim;
};

// This struct is used to pack two shot info's for replication
struct DualShotInfo
{
	var ShotInfo FirstShot;
	var ShotInfo Secondshot;
};

// Internal shot replication and tracking vars
var 	DualShotInfo 	SavedDualShot; 				// Last dualshot info recieved on the client
var 	ShotInfo	 	LastShot;					// Last single shotinfo saved server side
var 	bool 		 	bFirstShot;                 // flags whether this is the first or second shot
var 	bool 		 	bUnReplicatedShot;          // We have a shot we haven't replicated the info for yet
var 	byte		 	DualShotCount;              // When this byte is incremented the DualShotInfo will be replicated.
var 	byte		 	SavedDualShotCount;         // The last DualShot Count

var() class<ROClientBullet> ClientProjectileClass; 	// class for the netclient only projectile for this weapon
var() class<ROClientBullet> ClientTracerClass; 	   	// class for the netclient only tracer for this weapon

// Tracer stuff
var()			bool		bUsesTracers;			// true if the weapon uses tracers in it's ammo loadout
var()			int			TracerFrequency;		// how often a tracer is loaded in.  Assume to be 1 in valueof(TracerFrequency)
var				byte		NextTracerCounter;		// when this equals TracerFrequency, spawn a tracer

//=============================================================================
// replication
//=============================================================================

replication
{
	// Bullet whiz var - Server to client
	reliable if( bNetDirty && (Role==ROLE_Authority) )
		SavedDualShot, DualShotCount;
}

//=============================================================================
// Variables
//=============================================================================

// Here we spawn our client side effect rounds if the shot count has changed
simulated function PostNetReceive()
{
	if( DualShotCount != SavedDualShotCount )
	{
		if(Level.NetMode == NM_Client)
		{
		 	if( DualShotCount < 254 )
		    	SpawnClientRounds(false);
		    else
		    	SpawnClientRounds(true);
		}

		SavedDualShotCount = DualShotCount;
	}
}

// Check the tracer count and determine if we should spawn a tracer round
simulated function bool ShouldSpawnTracer()
{
	NextTracerCounter++;

	if( !bUsesTracers )
	{
		return false;
	}
	else if( NextTracerCounter != TracerFrequency )
	{
		return false;
	}
	else if( ClientTracerClass != none )
	{
       	NextTracerCounter = 0;			// reset for next tracer spawn
       	return true;
	}

	return false;
}

// Handles unpacking and spawning the correct client side hit effect rounds
simulated function SpawnClientRounds(bool bFirstRoundOnly)
{
	local Vector Start, HitLocation, TestHitLocation, HitNormal;
	local rotator ProjectileDir;
	local Actor Other;

	// First shot, or single shot
	if( ShouldSpawnTracer() )
	{
		Start = SavedDualShot.FirstShot.ShotLocation;
		ProjectileDir = SavedDualShot.FirstShot.ShotAim;

        if( Instigator != none && Instigator.IsLocallyControlled() && Instigator.IsFirstPerson() )
        {
        	// do nothing
		}
		// Spawn the tracer from the tip of the third person weapon
		else
		{
			Other = Trace(HitLocation, HitNormal, Start + vector(ProjectileDir) * 65525, Start,true);

			if( Other != none )
			{
				Other = none;

				// Make sure tracer wouldn't spawn inside of something
				Other = Trace(TestHitLocation, HitNormal, GetBoneCoords(MuzzleBoneName).Origin + vector(ProjectileDir) * 15, GetBoneCoords(MuzzleBoneName).Origin,true);

                if( Other == none )
				{
					Start = GetBoneCoords(MuzzleBoneName).Origin;
					ProjectileDir = rotator(Normal(HitLocation - Start));
				}
				else
				{
					Other = none;
				}
			}
		}

		Spawn(ClientTracerClass,,, Start, ProjectileDir);
	}
	else
	{
		Spawn(ClientProjectileClass,,, SavedDualShot.FirstShot.ShotLocation, SavedDualShot.FirstShot.ShotAim);
	}

	// Second shot
	if( !bFirstRoundOnly )
	{
		if( ShouldSpawnTracer() )
		{
			Start = SavedDualShot.Secondshot.ShotLocation;
			ProjectileDir = SavedDualShot.Secondshot.ShotAim;

			if( Instigator != none && Instigator.IsLocallyControlled() && Instigator.IsFirstPerson() )
	        {
	        	// do nothing
			}
			// Spawn the tracer from the tip of the third person weapon
			else
			{
				Other = Trace(HitLocation, HitNormal, Start + vector(ProjectileDir) * 65525, Start,true);

				if( Other != none )
				{
					Other = none;

					// Make sure tracer wouldn't spawn inside of something
					Other = Trace(TestHitLocation, HitNormal, GetBoneCoords(MuzzleBoneName).Origin + vector(ProjectileDir) * 15, GetBoneCoords(MuzzleBoneName).Origin,true);

	                if( Other == none )
					{
						Start = GetBoneCoords(MuzzleBoneName).Origin;
						ProjectileDir = rotator(Normal(HitLocation - Start));
					}
					else
					{
						Other = none;
					}
				}
			}

			Spawn(ClientTracerClass,,, Start, ProjectileDir);
		}
		else
		{
			Spawn(ClientProjectileClass,,, SavedDualShot.Secondshot.ShotLocation, SavedDualShot.Secondshot.ShotAim);
		}
	}

}

// This function will take the information about a shot and turn it into a shotinfo struct
function ShotInfo MakeShotInfo( vector NewLocation, rotator SetRotation)
{
	local ShotInfo SI;

	SI.ShotLocation = NewLocation;
	SI.ShotAim = SetRotation;

	return SI;
}

defaultproperties
{
    bNetNotify=True
	TracerFrequency=4
}
