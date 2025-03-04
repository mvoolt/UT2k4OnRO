//===================================================================
// T3485MountedMG
//
// Copyright (C) 2004 John "Ramm-Jaeger"  Gibson
//
// Russian T34 tank mounted machine gun
//===================================================================

class T3485MountedMG extends VisibleTankHullMG;

DefaultProperties
{
    Mesh=Mesh'allies_t3485_anm.T3485_MG_ext'
    YawBone=MG_Yaw
    YawStartConstraint=0
    YawEndConstraint=65535
    PitchBone=MG_Pitch
    PitchUpLimit=15000
    PitchDownLimit=45000
    bInstantFire=false//True
    ProjectileClass = class'ROInventory.DP28Bullet'
    AmbientEffectEmitterClass=class'TankMGEmitter'
    FireInterval=0.1
    FireSoundClass=sound'Inf_Weapons.dt_fire_loop'
    SoundVolume=255
    AmbientSoundScaling=1.3
    ShakeOffsetMag=(X=1.0,Y=1.0,Z=1.0)
    ShakeOffsetRate=(X=1000.0,Y=1000.0,Z=1000.0)
    ShakeOffsetTime=2
    ShakeRotMag=(X=50.0,Y=50.0,Z=50.0)
    ShakeRotRate=(X=10000.0,Y=10000.0,Z=10000.0)
    ShakeRotTime=2
    FireForce="minifireb"
    bIsRepeatingFF=True
    bAmbientFireSound=True
    WeaponFireAttachmentBone=MG_Yaw
    WeaponFireOffset=11.0
    DualFireOffset=0.0
    bAimable=True
    DamageType=class'ROVehMountedMGDamType'
    DamageMin=25
    DamageMax=25
    Spread=0.01
    RotationsPerSecond=2.0
    bInstantRotation=true
    bDoOffsetTrace=true
    TraceRange=15000

	bUsesTracers=true
	mTracerInterval=0.3
	DummyTracerClass=class'ROInventory.DP28ClientTracer'

    AIInfo(0)=(bInstantHit=true,AimError=750)
    CullDistance=8000.0

    // ROVehicleWeapon Vars
    MaxPositiveYaw = 6000
    MaxNegativeYaw = -10000
    bLimitYaw = true

    InitialPrimaryAmmo=60
    NumMags=15
    ReloadLength=9.6
}
