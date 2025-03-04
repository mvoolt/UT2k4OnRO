//==============================================================================
// ROThrowableExplosiveProjectile
// started by Antarian 2/15/04
//
// Copyright (C) 2004 Jeffrey Nakai
//
// Parent class for all Red Orchestra throwable explosive projectiles
//==============================================================================

class ROThrowableExplosiveProjectile extends Projectile
	abstract;


//==============================================================================
// variables
//==============================================================================
var()		float		DampenFactor,
						DampenFactorParallel;
var()		int			ShrapnelCount;
var			byte		Bounces;
var			float		FuzeLengthTimer;
var			sound		ExplosionSound[3];
var			bool		bDud;
var()		float	    FailureRate;				// decimal percentage of duds/100

// View shake vars
var			float		ShakeScale;		// How much larger than the explosion radius should the view shake
var			float		BlurTime;       // How long blur effect should last for this projectile
// camera shakes //
var() 		vector 		ShakeRotMag;           	// how far to rot view
var() 		vector 		ShakeRotRate;          	// how fast to rot view
var() 		float  		ShakeRotTime;          	// how much time to rot the instigator's view
var() 		vector 		ShakeOffsetMag;        	// max view offset vertically
var() 		vector 		ShakeOffsetRate;       	// how fast to offset view vertically
var() 		float  		ShakeOffsetTime;       	// how much time to offset view
var()		float		BlurEffectScalar;

// Scare the bots away from this
var AvoidMarker Fear;

var 		bool		bAlreadyExploded;	// This projectile already exploded, and is waiting to be destroyed
var         byte        ThrowerTeam;        // The team number of the person that threw this projectile.

//==============================================================================
// replication
//==============================================================================
replication
{
	reliable if (Role == ROLE_Authority && bNetInitial)
		FuzeLengthTimer, Bounces;
}

simulated function PostBeginPlay()
{
    super.PostBeginPlay();

    if( InstigatorController != none )
    {
        ThrowerTeam = InstigatorController.PlayerReplicationInfo.Team.TeamIndex;
    }
}

//------------------------------------------------------------------------------
// Reset
//------------------------------------------------------------------------------

function Reset()
{
	Destroy();
}

//-----------------------------------------------------------------------------
// Tick
//-----------------------------------------------------------------------------

simulated function Tick(float DeltaTime)
{
	FuzeLengthTimer -= DeltaTime;

	if (FuzeLengthTimer <= 0.0 && !bAlreadyExploded/*&& !bDud*/)
	{
		bAlreadyExploded = true;
		Explode(Location, vect(0,0,1));
	}
}

/* HurtRadius()
 Hurt locally authoritative actors within the radius.

 Red Orchestra
 Overriden here to do a trace to each actor to determine if something (like a vehicle) is between the
 explosive and the actor taking damage

 TODO - this is a first pass, might want to add some code so that explosives like satchels still damage/kill
 actors if they're within a certain blast radius - Antarian
*/
simulated function HurtRadius( float DamageAmount, float DamageRadius, class<DamageType> DamageType, float Momentum, vector HitLocation )
{
	local actor Victims;
	local float damageScale, dist;
	local vector dir;
	local ROPawn P;
	local array<ROPawn> CheckedROPawns;
	local int i;
	local bool bAlreadyChecked;

	// Antarian 9/12/2004
	local vector TraceHitLocation,
				 TraceHitNormal;
	local actor	 TraceHitActor;

	if ( bHurtEntry )
		return;

	// Just return if the player switches teams after throwing the explosive. This prevent poeple TK exploiting by switching teams 
	if( Role == ROLE_Authority )
	{
    	if ( Instigator == None || Instigator.Controller == None )
    	{
    	   if( InstigatorController.PlayerReplicationInfo.Team.TeamIndex != ThrowerTeam )
    	   {
               Destroy();
    	       return;
           }
    	}
    	else
    	{
    	   if( Instigator.Controller.PlayerReplicationInfo.Team.TeamIndex != ThrowerTeam )
    	   {
               Destroy();
    	       return;
           }
    	}
	}

	bHurtEntry = true;
	foreach VisibleCollidingActors( class 'Actor', Victims, DamageRadius, HitLocation )
	{
		// don't let blast damage affect fluid - VisibleCollisingActors doesn't really work for them - jag
		if( (Victims != self) && (Hurtwall != Victims) && (Victims.Role == ROLE_Authority) && !Victims.IsA('FluidSurfaceInfo') )
		{
			// Antarian 9/12/2004
			// do a trace to the actor
			TraceHitActor = Trace(TraceHitLocation, TraceHitNormal, Victims.Location, Location);

			// if there's a vehicle between the player and explosion, don't apply damage
			if( (Vehicle(TraceHitActor) != none) && (TraceHitActor != Victims) )
				continue;
			// end of Antarian's 9/12/2004 contribution

			dir = Victims.Location - HitLocation;
			dist = FMax(1,VSize(dir));
			dir = dir/dist;
			damageScale = 1 - FMax(0,(dist - Victims.CollisionRadius)/DamageRadius);

			P = ROPawn(Victims);

			if( P == none )
			{
				P = ROPawn(Victims.Base);
			}

			if( P != none )
			{
		        for (i = 0; i < CheckedROPawns.Length; i++)
				{
		        	if (CheckedROPawns[i] == P)
					{
						bAlreadyChecked = true;
						break;
					}
				}

				if( bAlreadyChecked )
				{
					bAlreadyChecked = false;
					P = none;
					continue;
				}

				damageScale *= P.GetExposureTo(Location + 15 * -Normal(PhysicsVolume.Gravity));

				CheckedROPawns[CheckedROPawns.Length] = P;

				if ( damageScale <= 0)
				{
					P = none;
					continue;
				}
				else
				{
					Victims = P;
					P = none;
				}
			}

			if ( Instigator == None || Instigator.Controller == None )
				Victims.SetDelayedDamageInstigatorController( InstigatorController );
			if ( Victims == LastTouched )
				LastTouched = None;
			Victims.TakeDamage
			(
				damageScale * DamageAmount,
				Instigator,
				Victims.Location - 0.5 * (Victims.CollisionHeight + Victims.CollisionRadius) * dir,
				(damageScale * Momentum * dir),
				DamageType
			);
			if (Vehicle(Victims) != None && Vehicle(Victims).Health > 0)
				Vehicle(Victims).DriverRadiusDamage(DamageAmount, DamageRadius, InstigatorController, DamageType, Momentum, HitLocation);

		}
	}
	if ( (LastTouched != None) && (LastTouched != self) && (LastTouched.Role == ROLE_Authority) && !LastTouched.IsA('FluidSurfaceInfo') )
	{
		Victims = LastTouched;
		LastTouched = None;
		dir = Victims.Location - HitLocation;
		dist = FMax(1,VSize(dir));
		dir = dir/dist;
		damageScale = FMax(Victims.CollisionRadius/(Victims.CollisionRadius + Victims.CollisionHeight),1 - FMax(0,(dist - Victims.CollisionRadius)/DamageRadius));
		if ( Instigator == None || Instigator.Controller == None )
			Victims.SetDelayedDamageInstigatorController(InstigatorController);
		Victims.TakeDamage
		(
			damageScale * DamageAmount,
			Instigator,
			Victims.Location - 0.5 * (Victims.CollisionHeight + Victims.CollisionRadius) * dir,
			(damageScale * Momentum * dir),
			DamageType
		);
		if (Vehicle(Victims) != None && Vehicle(Victims).Health > 0)
			Vehicle(Victims).DriverRadiusDamage(DamageAmount, DamageRadius, InstigatorController, DamageType, Momentum, HitLocation);
	}

	bHurtEntry = false;
}

//-----------------------------------------------------------------------------
// ProcessTouch
//-----------------------------------------------------------------------------

simulated function ProcessTouch(Actor Other, Vector HitLocation)
{
	if (Other == Instigator || Other.Base == Instigator)
		return;

     if( ROBulletWhipAttachment(Other) != none )
    	{
     	HitWall(Normal(HitLocation - Other.Location), Other);
     }
}

// Shake the ground for poeple near the artillery hit
simulated function DoShakeEffect()
{
	local PlayerController PC;
	local float Dist, scale;

	//viewshake
	if (Level.NetMode != NM_DedicatedServer)
	{
		PC = Level.GetLocalPlayerController();
		if (PC != None && PC.ViewTarget != None)
		{
			Dist = VSize(Location - PC.ViewTarget.Location);
			if (Dist < DamageRadius * ShakeScale)
			{
				scale = (DamageRadius*ShakeScale - Dist) / (DamageRadius*ShakeScale);
                scale *= BlurEffectScalar;

				PC.ShakeView(ShakeRotMag*Scale, ShakeRotRate, ShakeRotTime, ShakeOffsetMag*Scale, ShakeOffsetRate, ShakeOffsetTime);

				if( PC.Pawn != none && ROPawn(PC.Pawn) != none )
				{
					scale = scale - (Scale * 0.50 - ((Scale * 0.50) * ROPawn(PC.Pawn).GetExposureTo(Location + 15 * -Normal(PhysicsVolume.Gravity))));
				}
				ROPlayer(PC).AddBlur(BlurTime*Scale, FMin(1.0,Scale));

				// Hint check
				ROPlayer(PC).CheckForHint(13);
			}
		}
	}
}

simulated function Destroyed()
{
	local ROPawn Victims;
	local float damageScale, dist;
	local vector dir, Start;

	// Move karma ragdolls around when this explodes
	if ( Level.NetMode != NM_DedicatedServer )
	{
		Start = Location + 32 * vect(0,0,1);

		foreach VisibleCollidingActors( class 'ROPawn', Victims, DamageRadius, Start )
		{
			// don't let blast damage affect fluid - VisibleCollisingActors doesn't really work for them - jag
			if( Victims != self)
			{
				dir = Victims.Location - Start;
				dist = FMax(1,VSize(dir));
				dir = dir/dist;
				damageScale = 1 - FMax(0,(dist - Victims.CollisionRadius)/DamageRadius);

				if(Victims.Physics == PHYS_KarmaRagDoll )
				{
					Victims.DeadExplosionKarma(MyDamageType, damageScale * MomentumTransfer * dir, damageScale);
				}
			}
		}
	}

	if ( Fear != None )
		Fear.Destroy();

    Super.Destroyed();
}

defaultproperties
{
	Physics=PHYS_Falling
	DrawType=DT_StaticMesh
	ShakeScale=2.25
	BlurTime=4.0
    BlurEffectScalar=1.35//2.5

	bBlockHitPointTraces=False
	bNetTemporary=false
}
