//===================================================================
// ROMountedTankMG
//
// Copyright (C) 2004 John "Ramm-Jaeger"  Gibson
//
// Base class for mounted tank machine guns
//===================================================================

class ROMountedTankMG extends ROVehicleWeapon
      abstract;

static function StaticPrecache(LevelInfo L)
{
   // L.AddPrecacheMaterial(Material'VMparticleTextures.TankFiringP.CloudParticleOrangeBMPtex');
}

simulated function UpdatePrecacheMaterials()
{
   // Level.AddPrecacheMaterial(Material'VMparticleTextures.TankFiringP.CloudParticleOrangeBMPtex');

    Super.UpdatePrecacheMaterials();
}

// Limit the left and right movement of the turret based on the rotation of the vehicle
simulated function int LimitYaw(int yaw)
{
    local int NewYaw;
    local int VehYaw;

    if ( !bLimitYaw )
    {
        return yaw;
    }

    VehYaw = VehicleWeaponPawn(Owner).GetVehicleBase().Rotation.Yaw;

    NewYaw = yaw;

   	if(yaw > VehYaw + MaxPositiveYaw )
   	{
   		NewYaw = VehYaw + MaxPositiveYaw;
   	}
   	else if( yaw < VehYaw + MaxNegativeYaw )
   	{
   		NewYaw = VehYaw + MaxNegativeYaw;
  	}

  	return NewYaw;
}

function byte BestMode()
{
	return 0;
}

defaultproperties
{
    //Mesh=Mesh'ONSWeapons-A.TankMachineGun'
    YawBone=Object01
    //YawStartConstraint=0
    //YawEndConstraint=65535

    YawStartConstraint=65535
    YawEndConstraint=-65535

    PitchBone=Object02
    PitchUpLimit=12500
    PitchDownLimit=59500
    bInstantFire=True
    AmbientEffectEmitterClass=class'TankMGEmitter'
    FireInterval=0.1
    SoundVolume=255
    AmbientSoundScaling=3.0//1.3
    ShakeOffsetMag=(X=1.0,Y=1.0,Z=1.0)
    ShakeOffsetRate=(X=1000.0,Y=1000.0,Z=1000.0)
    ShakeOffsetTime=2
    ShakeRotMag=(X=50.0,Y=50.0,Z=50.0)
    ShakeRotRate=(X=10000.0,Y=10000.0,Z=10000.0)
    ShakeRotTime=2
    FireForce="minifireb"
    bIsRepeatingFF=True
    bAmbientFireSound=True
    WeaponFireAttachmentBone=Object02
    WeaponFireOffset=85.0
    bAimable=True
    DamageType=class'ROVehMountedMGDamType'
    DamageMin=25
    DamageMax=25
    Spread=0.01
    RotationsPerSecond=2.0
    bInstantRotation=true
    bDoOffsetTrace=true
    TraceRange=15000

    AIInfo(0)=(bInstantHit=true,AimError=750)
    CullDistance=8000.0

    bUsesTracers=true
    bIsMountedTankMG=true
    hudAltAmmoIcon=Texture'InterfaceArt_tex.HUD.dp27_ammo'
}
