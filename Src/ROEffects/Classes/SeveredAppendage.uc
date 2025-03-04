//===================================================================
// SeveredAppendage
// Copyright (C) 2005 Tripwire Interactive LLC
// John "Ramm-Jaeger"  Gibson
//
// Base class for body parts that have been blown off
//===================================================================
class SeveredAppendage extends Actor
    abstract;

#exec OBJ LOAD FILE=Inf_Player.uax

var class <Emitter>		BleedingEmitterClass;		// class of the bleeding emitter
var class<ProjectedDecal> 		DripClass;
var() Emitter Trail;
var() float DampenFactor;
var sound	HitSound;
var() float	MaxSpeed;	// Maximum speed this Gib should move

simulated function Destroyed()
{
    if( Trail != none )
        Trail.Destroy();

	Super.Destroyed();
}

simulated final function RandSpin(float spinRate)
{
	DesiredRotation = RotRand();
	RotationRate.Yaw = spinRate * 2 *FRand() - spinRate;
	RotationRate.Pitch = spinRate * 2 *FRand() - spinRate;
	RotationRate.Roll = spinRate * 2 *FRand() - spinRate;
}

simulated function Landed( Vector HitNormal )
{
    HitWall( HitNormal, None );
}

simulated function HitWall( Vector HitNormal, Actor Wall )
{
    local float Speed, MinSpeed;
    local rotator LandRot;
	local float VelocitySquared;
	local float HitVolume;

    Velocity = DampenFactor * ((Velocity dot HitNormal) * HitNormal*(-2.0) + Velocity);
    RandSpin(100000);
    Speed = VSize(Velocity);
	if (  Level.DetailMode == DM_Low )
    	MinSpeed = MaxSpeed/2;//250;
	else
		MinSpeed = MaxSpeed/3;//150;
	if( Speed > MinSpeed )
    {
 		if( (Level.NetMode != NM_DedicatedServer) && !Level.bDropDetail )
 		{
 			if ( DripClass != None )
				Spawn( DripClass,,, Location, Rotator(-HitNormal) );
			if ( (LifeSpan < 7.3)  && (Level.DetailMode != DM_Low) )
			{
		    	VelocitySquared = VSizeSquared(Velocity);

				//log("impact velocity: "$VSize(Velocity)$" VelocitySquared: "$VelocitySquared);

				HitVolume = FMin(0.75,(VelocitySquared/(MaxSpeed*MaxSpeed)));

				//log("HitVolume = "$HitVolume);

				PlaySound(HitSound, SLOT_None, HitVolume);

				//PlaySound(HitSounds[Rand(2)]);
			}
		}
    }

    if( Speed < 20 )
    {
 		if( !Level.bDropDetail && (Level.DetailMode != DM_Low) && DripClass != none )
			Spawn( DripClass,,, Location, Rotator(-HitNormal) );
        bBounce = False;

        LandRot = Rotation;
		LandRot.Pitch = rotator(HitNormal).Pitch;
		LandRot.Pitch += 16384;
		SetRotation(LandRot);

		if( Trail != None )
        	Trail.Destroy();

        SetPhysics(PHYS_None);
    }
}

simulated function SpawnTrail()
{
    if ( Level.NetMode != NM_DedicatedServer )
    {
		Trail = Spawn(BleedingEmitterClass, self,, Location, Rotation);
		Trail.LifeSpan = LifeSpan;//1.8;

		Trail.SetPhysics( PHYS_Trailer );
		RandSpin( 64000 );
	}
}

static function PrecacheContent(LevelInfo Level)
{
	if ( !class'GameInfo'.static.UseLowGore() )
	{
		Level.AddPrecacheMaterial(Default.Skins[0]);
		Level.AddPrecacheStaticMesh(Default.StaticMesh);
	}
}

defaultproperties
{
	bUnlit=true
	TransientSoundVolume=+0.17
	BleedingEmitterClass=class'ROBloodSpurt'
	DripClass=class'ROSmallBloodDrops'
	LifeSpan=8.0
    bCollideWorld=true
    bCollideActors=false
    MaxSpeed=100

    RemoteRole=ROLE_None

    Physics=PHYS_Falling
    bBounce=True
    bFixedRotationDir=True

    DampenFactor=0.35
    Mass=30
    bUseCylinderCollision=true

    HitSound=sound'Inf_Player.BodyImpact'
    Skins(0)=Texture'Effects_Tex.Gore_Effects'
}
