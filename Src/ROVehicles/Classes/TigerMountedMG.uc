//===================================================================
// TigerMountedMG
//
// Copyright (C) 2004 John "Ramm-Jaeger"  Gibson
//
// Tiger 1 tank mounted machine gun
//===================================================================

class TigerMountedMG extends HiddenTankHullMG;

defaultproperties
{
    Mesh=Mesh'axis_tiger1_anm.tiger1_mg_ext'
    YawBone=MG_Yaw//mg_placement1
    YawStartConstraint=0
    YawEndConstraint=65535
    PitchBone=MG_Pitch//mg_placement1
    PitchUpLimit=15000//3000
    PitchDownLimit=45000//63000
    bInstantFire=false//True
    ProjectileClass = class'ROInventory.ROMG34bullet'
    AmbientEffectEmitterClass=class'TankMGEmitter'
    FireInterval=0.07058 // 850 rpm
    FireSoundClass=sound'Inf_Weapons.mg34_p_fire_loop'
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
    WeaponFireOffset=16.0
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
	mTracerInterval=0.28
	DummyTracerClass=class'ROInventory.MG34ClientTracer'

    AIInfo(0)=(bInstantHit=true,AimError=750)
    CullDistance=8000.0

    // ROVehicleWeapon Vars
    MaxPositiveYaw = 10000//13655   // 75 degrees
    MaxNegativeYaw = -10000//-13655  // 75 degrees
    bLimitYaw = true

    InitialPrimaryAmmo=150
    NumMags=4
    ReloadSound=sound'Vehicle_reloads.MG34_ReloadHidden'

    hudAltAmmoIcon=Texture'InterfaceArt_tex.HUD.mg42_ammo'
}
