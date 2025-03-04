//===================================================================
// T3485Cannon
//
// Copyright (C) 2004 John "Ramm-Jaeger"  Gibson
//
// Russian T34 tank cannon class
//===================================================================
class T3485Cannon extends ROTankCannon;

defaultproperties
{
    Mesh=Mesh'allies_t3485_anm.t3485_turret_ext'
    skins(0)=Texture'allies_vehicles_tex.ext_vehicles.T3485_ext'
    skins(1)=Texture'allies_vehicles_tex.int_vehicles.T3485_int'
	HighDetailOverlay=Material'allies_vehicles_tex.int_vehicles.T3485_int_s'
	bUseHighDetailOverlayIndex=true
	HighDetailOverlayIndex=1
    BeginningIdleAnim=com_idle_open // replaceme
    YawBone=turret
    YawStartConstraint=0
    YawEndConstraint=65535
    PitchBone=gun
    PitchUpLimit=15000
    PitchDownLimit=45000
	CustomPitchUpLimit=6000
	CustomPitchDownLimit=63500
	CannonFireSound(0)=sound'Vehicle_Weapons.T34_85.85mm_fire01'
	CannonFireSound(1)=sound'Vehicle_Weapons.T34_85.85mm_fire02'
	CannonFireSound(2)=sound'Vehicle_Weapons.T34_85.85mm_fire03'
    FireForce="Explosion05"
    ProjectileClass=class'ROVehicles.T3485CannonShell'
    PrimaryProjectileClass=class'ROVehicles.T3485CannonShell'
    SecondaryProjectileClass=class'ROVehicles.T3485CannonShellHE'
	EffectEmitterClass=class'ROEffects.TankCannonFireEffect'
    FireInterval=12
    FireSoundVolume=512
    AltFireProjectileClass=class'ROInventory.DP28Bullet'
    AltFireInterval=0.1
    AmbientEffectEmitterClass=class'TankMGEmitter'
    bAmbientEmitterAltFireOnly=true
    AltFireOffset=(X=18.0,Y=19.0,Z=0.0)
	AltFireSoundClass=sound'Inf_Weapons.dt_fire_loop'
	AltFireSoundScaling=3.0
	AltFireEndSound=sound'Inf_Weapons.dt.dt_fire_end'
	bAmbientAltFireSound=true
	bAltFireTracersOnly=true
	bUsesTracers=true
	mTracerInterval=0.3
	DummyTracerClass=class'ROInventory.DP28ClientTracer'
    AltShakeOffsetMag=(X=1.0,Y=1.0,Z=1.0)
    AltShakeOffsetRate=(X=1000.0,Y=1000.0,Z=1000.0)
    AltShakeOffsetTime=2
    AltShakeRotMag=(X=50.0,Y=50.0,Z=50.0)
    AltShakeRotRate=(X=10000.0,Y=10000.0,Z=10000.0)
    AltShakeRotTime=2
    ShakeRotMag=(Z=250)
    ShakeRotRate=(Z=2500)
    ShakeRotTime=6
    ShakeOffsetMag=(Z=10)
    ShakeOffsetRate=(Z=200)
    ShakeOffsetTime=10
    WeaponFireAttachmentBone=gun
    WeaponFireOffset=200.0
    bAimable=True
    RotationsPerSecond=0.07 // 14 seconds to rotate 360
    AIInfo(0)=(bLeadTarget=true,bTrySplash=False,WarnTargetPct=0.75,RefireRate=0.5)
	AIInfo(1)=(bLeadTarget=true,bTrySplash=False,AimError=600,WarnTargetPct=0.75,RefireRate=0.015)
    //Spread=0.015
    Spread=0.0

    MaxDriverHitAngle=2.8

    // RO Vehicle sound vars
    ReloadSoundOne=Sound'Vehicle_reloads.Reloads.t34_85_reload_01'
    ReloadSoundTwo=Sound'Vehicle_reloads.Reloads.t34_85_reload_02'
    ReloadSoundThree=Sound'Vehicle_reloads.Reloads.t34_85_reload_03'
    ReloadSoundFour=Sound'Vehicle_reloads.Reloads.t34_85_reload_04'
    RotateSound=Sound'Vehicle_Weapons.Turret.hydraul_turret_traverse'
    SoundVolume=130


	VehHitpoints(0)=(PointRadius=9.0,PointHeight=0.0,PointScale=1.0,PointBone=com_player,PointOffset=(X=-2.0,Y=-13.0,Z=10.0))
	VehHitpoints(1)=(PointRadius=15.0,PointHeight=0.0,PointScale=1.0,PointBone=com_player,PointOffset=(X=-4.0,Y=-8.0,Z=-7.0))

	GunnerAttachmentBone=com_attachment

	RangeSettings(0)=0
	RangeSettings(1)=400
	RangeSettings(2)=500
	RangeSettings(3)=600
	RangeSettings(4)=700
	RangeSettings(5)=800
	RangeSettings(6)=900
	RangeSettings(7)=1000
	RangeSettings(8)=1200
	RangeSettings(9)=1400
	RangeSettings(10)=1600
	RangeSettings(11)=1800
	RangeSettings(12)=2000
	RangeSettings(13)=2200
	RangeSettings(14)=2400
	RangeSettings(15)=2600
	RangeSettings(16)=2800
	RangeSettings(17)=3000
	RangeSettings(18)=3200
	RangeSettings(19)=3400
	RangeSettings(20)=3600
	RangeSettings(21)=3800

	// Ammo
	InitialPrimaryAmmo=30
	InitialSecondaryAmmo=25
	InitialAltAmmo=60
	ReloadSound=sound'Vehicle_reloads.DT_ReloadHidden'
	NumAltMags=15
}
