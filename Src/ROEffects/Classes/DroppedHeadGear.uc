//===================================================================
// DroppedHeadGear
// Copyright (C) 2005 Tripwire Interactive LLC
// John "Ramm-Jaeger"  Gibson
//
// Base class for headgear that has come off
//===================================================================
class DroppedHeadGear extends Actor;

#exec OBJ LOAD FILE=Inf_Player.uax

var() float DampenFactor;
var sound	HitSound;
var() float	MaxSpeed;	// Maximum speed this Gib should move

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
    //local rotator LandRot;
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
        bBounce = False;

        //LandRot = Rotation;
		//LandRot.Pitch = rotator(HitNormal).Pitch;
		//LandRot.Pitch += 16384;
		//SetRotation(LandRot);

        SetPhysics(PHYS_None);
    }
}

defaultproperties
{
	TransientSoundVolume=+0.17
	LifeSpan=8.0
    bCollideWorld=true
    bCollideActors=false
    MaxSpeed=75

	DrawType=DT_Mesh

    RemoteRole=ROLE_None

    Physics=PHYS_Falling
    bBounce=True
    bFixedRotationDir=True

    DampenFactor=0.35
    Mass=30
    bUseCylinderCollision=true
    CollisionHeight=4.0
    CollisionRadius=6.0

    //PrePivot=(Z=7.0)

    HitSound=sound'Inf_Player.BodyImpact'

	// Make headgear have the same lighting properties as the pawn
	// even after they are detached
	MaxLights=8
    ScaleGlow=1.0
	AmbientGlow=5
	bDramaticLighting = true
}
