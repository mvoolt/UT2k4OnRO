//=============================================================================
// ROSatchelChargeProjectile
//=============================================================================


class ROSatchelChargeProjectile extends ROThrowableExplosiveProjectile
	abstract;

//=============================================================================
// Variables
//=============================================================================

var Pawn SavedInstigator;
var PlayerReplicationInfo SavedPRI;

//=============================================================================
// replication
//=============================================================================

/*replication
{
	reliable if (Role == ROLE_Authority && bNetInitial)
}*/

//=============================================================================
// Functions
//=============================================================================

//-----------------------------------------------------------------------------
// PostBeginPlay
//-----------------------------------------------------------------------------

simulated function PostBeginPlay()
{
	if (Role == ROLE_Authority)
	{
		Velocity = Speed * Vector(Rotation);
		//RandSpin(100);

		if (Instigator.HeadVolume.bWaterVolume)
		{
			//bHitWater = true;
			Velocity = 0.25 * Velocity;
		}

		// Broadcast warning message to teammates
		if (Instigator != none && Instigator.Controller != none &&
            Instigator.Controller.PlayerReplicationInfo != none &&
            Instigator.Controller.PlayerReplicationInfo.Team != none)
		{
		    ROTeamGame(Level.Game).BroadcastLocalizedMessage(
                class'RODemolitionChargePlacedMsg',
                Instigator.Controller.PlayerReplicationInfo.Team.TeamIndex);
		}
	}

	if (Instigator != None)
	{
		InstigatorController = Instigator.Controller;
		SavedInstigator = Instigator;
		SavedPRI = Instigator.PlayerReplicationInfo;
	}

	Acceleration = 0.5 * PhysicsVolume.Gravity;

    if( InstigatorController != none )
    {
        ThrowerTeam = InstigatorController.PlayerReplicationInfo.Team.TeamIndex;
    }
}


//-----------------------------------------------------------------------------
// Landed
//-----------------------------------------------------------------------------

simulated function Landed(vector HitNormal)
{
	if (Bounces <= 0)
	{
		SetPhysics(PHYS_None);

		if (Role == ROLE_Authority)
		{
			Fear = Spawn(class'AvoidMarker');
			Fear.SetCollisionSize(DamageRadius,200);
			Fear.StartleBots();
		}
	}
	else
	{
		HitWall(HitNormal, None);
	}
}


//------------------------------------------------------------------------------
// GetHitSurfaceType(RO) - Will get the surface type of the surface the
//	projectile has collided with.
//------------------------------------------------------------------------------
simulated function GetHitSurfaceType( out ESurfaceTypes ST, vector HitNormal)
{
	local vector HitLoc, HitNorm;
	local Material HitMat;

	Trace(HitLoc, HitNorm, Location - (HitNormal * 16), Location, false,, HitMat);

	if (HitMat == None)
		ST = EST_Default;
	else
		ST = ESurfaceTypes(HitMat.SurfaceType);
}

//------------------------------------------------------------------------------
// GetDampenAndSoundValue(RO) - Gets the DampenFactor's and hit sound for the
//	surface the projectile hits
//------------------------------------------------------------------------------
simulated function GetDampenAndSoundValue( ESurfaceTypes ST )
{
	switch( ST )
	{
		case EST_Default:
			DampenFactor=0.15;
    		DampenFactorParallel=0.5;
    		ImpactSound=sound'Inf_Weapons_Foley.grenadeland';
			break;

		case EST_Rock:
			DampenFactor=0.2;
    		DampenFactorParallel=0.5;
    		ImpactSound=sound'Inf_Weapons_Foley.grenadeland';
			break;

		case EST_Dirt:
			DampenFactor=0.1;
    		DampenFactorParallel=0.45;
    		ImpactSound=sound'Inf_Weapons_Foley.grenadeland';
			break;

		case EST_Metal:
			DampenFactor=0.2;
    		DampenFactorParallel=0.5;
    		ImpactSound=sound'Inf_Weapons_Foley.grenadeland';
			break;

		case EST_Wood:
			DampenFactor=0.15;
    		DampenFactorParallel=0.4;
    		ImpactSound=sound'Inf_Weapons_Foley.grenadeland';
			break;

		case EST_Plant:
			DampenFactor=0.1;
    		DampenFactorParallel=0.1;
    		ImpactSound=sound'Inf_Weapons_Foley.grenadeland';
			break;

		case EST_Flesh:
			DampenFactor=0.1;
    		DampenFactorParallel=0.3;
    		ImpactSound=sound'Inf_Weapons_Foley.grenadeland';
			break;

		case EST_Ice:
			DampenFactor=0.2;
    		DampenFactorParallel=0.55;
    		ImpactSound=sound'Inf_Weapons_Foley.grenadeland';
			break;

		case EST_Snow:
			DampenFactor=0.0;
    		DampenFactorParallel=0.0;
    		ImpactSound=sound'Inf_Weapons_Foley.grenadeland';
			break;

		case EST_Water:
			DampenFactor=0.0;
    		DampenFactorParallel=0.0;
    		ImpactSound=sound'Inf_Weapons.ShellRifleWater';
			break;

		case EST_Glass:
			DampenFactor=0.3;
    		DampenFactorParallel=0.55;
    		ImpactSound=sound'Inf_Weapons_Foley.grenadeland';
			break;
	}
}



//-----------------------------------------------------------------------------
// HitWall
//-----------------------------------------------------------------------------

simulated function HitWall(vector HitNormal, actor Wall)
{
	local vector VNorm;
    local ESurfaceTypes ST;

	GetHitSurfaceType(ST, HitNormal);
    GetDampenAndSoundValue(ST);

	// Reflect off Wall w/damping
	//VNorm = (Velocity dot HitNormal) * HitNormal;
	//Velocity = -VNorm * DampenFactor + (Velocity - VNorm) * DampenFactorParallel;
	//Velocity = -HitNormal * Velocity * 0.3;
	Bounces--;

	if (Bounces <= 0)
	{
		bBounce = false;
		//SetPhysics(PHYS_None);
	}
	else
	{
	    // Reflect off Wall w/damping
    	VNorm = (Velocity dot HitNormal) * HitNormal;
    	Velocity = -VNorm * DampenFactor + (Velocity - VNorm) * DampenFactorParallel;
		//Velocity = 0.3 * (Velocity - 2.0 * HitNormal * (Velocity dot HitNormal));
		//RandSpin(100000);
		Speed = VSize(Velocity);
	}

	if ((Level.NetMode != NM_DedicatedServer) && (Speed > 250) && ImpactSound != none )
		PlaySound(ImpactSound, SLOT_Misc);
}

//-----------------------------------------------------------------------------
// BlowUp
//-----------------------------------------------------------------------------

function BlowUp(vector HitLocation)
{
	local ROObjSatchel	satchelobjActor;
	local Volume		demoVolume;


	if (Instigator != None)
	{
		SavedInstigator = Instigator;
		SavedPRI = Instigator.PlayerReplicationInfo;
	}

	DelayedHurtRadius(Damage, DamageRadius, MyDamageType, MomentumTransfer, HitLocation);

	if (Role == ROLE_Authority)
		MakeNoise(1.0);

	foreach TouchingActors(class'Volume',demoVolume)
	{
		if( ROObjSatchel(demoVolume.AssociatedActor) != none )
		{
			satchelobjActor = ROObjSatchel(demoVolume.AssociatedActor);

			if(satchelobjActor.WithinArea(self) )
			{
				satchelobjActor.Trigger(self, SavedInstigator);
			}
		}

		if( RODemolitionVolume(demoVolume) != none )
			RODemolitionVolume(demoVolume).Trigger(self, SavedInstigator);
	}
}


//-----------------------------------------------------------------------------
// Explode
//-----------------------------------------------------------------------------
simulated function Explode(vector HitLocation, vector HitNormal)
{
	BlowUp(HitLocation);
	Destroy();
}

simulated function Destroyed()
{
	local int i;
	local Vector Start;
	local ESurfaceTypes ST;

	// if the satchel qualifies as a dud, don't detonate it
//	if( FRand() <= FailureRate /*&& !bDud*/ )
//	{
//		bDud = true;
//		return;
//	}

	WeaponLight();

	PlaySound(ExplosionSound[Rand(3)],, 5.0, false, 4000, 1.0, true);

	Start = Location + 32 * vect(0,0,1);

	// TODO - Investigate this
	if (Role == ROLE_Authority)
	{
		for (i = 0; i < ShrapnelCount; i++)
		{
			Spawn(class'ROShrapnelChunk',, '', Start);
		}
	}

    DoShakeEffect();

	if (EffectIsRelevant(Location,false))
	{
		// if the satchel is still moving we'll need to spawn a different explosion effect
		if( Physics == PHYS_Falling )
		{
			Spawn(class'ROSatchelExplosion',,, Start, rotator(vect(0,0,1)));
		}

		// if the satchel has stopped and is on the ground we'll spawn a ground explosion
		// effect and spawn some dirt flying out
		else if( Physics == PHYS_None )
		{
			GetHitSurfaceType(ST, vect(0,0,1));

	     	if (  ST == EST_Snow || ST == EST_Ice )
	    	{
	    	    //Spawn(ExplodeSnowEffectClass,,, Start, rotator(HitNormal));
	    	    Spawn(class'ROSatchelExplosion',,, Start, rotator(vect(0,0,1)));
	    	    Spawn(ExplosionDecalSnow, self,, Location, rotator(-vect(0,0,1)));
	    	}
	    	else
	    	{
		        Spawn(class'ROSatchelExplosion',,, Start, rotator(vect(0,0,1)));
		        Spawn(ExplosionDecal, self,, Location, rotator(-vect(0,0,1)));
	    	}
		}
	}

    Super.Destroyed();
}

//-----------------------------------------------------------------------------
// PhysicsVolumeChange
//-----------------------------------------------------------------------------

simulated function PhysicsVolumeChange( PhysicsVolume Volume )
{
	if (Volume.bWaterVolume)
		Velocity *= 0.25;
}


simulated function WeaponLight()
{
    if ( !Level.bDropDetail )
    {
		bDynamicLight = true;
        SetTimer(0.15, false);
    }
    //else
	//	Timer();
}

simulated function Timer()
{
    bDynamicLight = false;
}

//=============================================================================
// defaultproperties
//=============================================================================

defaultproperties
{
	Bounces=5
	FuzeLengthTimer=10.0
	Speed=1000
	MaxSpeed=1500
	MomentumTransfer=8000
	Physics=PHYS_Falling
	MyDamageType=class'ROSatchelDamType'
	bFixedRotationDir=true
	//bRotateToDesired=true
	TossZ=+150.0
	//TossZ=0.0
	DampenFactor=0.05
	DampenFactorParallel=0.8
	ExplosionSound(0)=sound'Inf_Weapons.satchel.satchel_explode01'
	ExplosionSound(1)=sound'Inf_Weapons.satchel.satchel_explode02'
	ExplosionSound(2)=sound'Inf_Weapons.satchel.satchel_explode03'
	ImpactSound=sound'Inf_Weapons_Foley.grenadeland'
	ExplosionDecal=class'ROEffects.GrenadeMark'
	ExplosionDecalSnow=class'ROEffects.GrenadeMarkSnow'
	bBounce=true
	DrawType=DT_StaticMesh
	//DesiredRotation=(Pitch=12000,Yaw=5666,Roll=2334)
	CollisionRadius=+15.0
	CollisionHeight=+15.0

	FailureRate = 0.01		// failure rate is default to 1 in 100

	bDynamicLight=false
    LightType=LT_Pulse
    LightEffect=LE_NonIncidence
    LightPeriod=3
    LightBrightness=200
    LightHue=30
    LightSaturation=150
    LightRadius=5.0

	// Shake effect for artillery
    ShakeRotMag=(X=0,Y=0,Z=300)
    ShakeRotRate=(Z=2500)
    ShakeRotTime=3
    ShakeOffsetMag=(Z=10)
    ShakeOffsetRate=(Z=200)
    ShakeOffsetTime=5
    ShakeScale=2.5
    BlurTime=6.0
    BlurEffectScalar=1.75//2.0
}
