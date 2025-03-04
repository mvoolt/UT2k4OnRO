//===================================================================
// TigerCannon
//
// Copyright (C) 2005 Tripwire Interactive LLC
// By -  John "Ramm-Jaeger"  Gibson
//
// Tiger1 tank cannon class
//===================================================================
class TigerCannon extends ROTankCannon;

DefaultProperties
{
    Mesh=Mesh'axis_tiger1_anm.tiger1_turret_ext'
    skins(0)=Texture'axis_vehicles_tex.ext_vehicles.Tiger1_ext'
    skins(1)=Texture'axis_vehicles_tex.int_vehicles.tiger1_int'
	HighDetailOverlay=Material'axis_vehicles_tex.int_vehicles.tiger1_int_s'
	bUseHighDetailOverlayIndex=true
	HighDetailOverlayIndex=1
    BeginningIdleAnim=com_idle_close
    YawBone=turret
    YawStartConstraint=0
    YawEndConstraint=65535
    PitchBone=gun
    PitchUpLimit=15000
    PitchDownLimit=45000
	CustomPitchUpLimit=6000
	CustomPitchDownLimit=64000
	CannonFireSound(0)=sound'Vehicle_Weapons.Tiger.88mm_fire01'
	CannonFireSound(1)=sound'Vehicle_Weapons.Tiger.88mm_fire02'
	CannonFireSound(2)=sound'Vehicle_Weapons.Tiger.88mm_fire03'
    FireForce="Explosion05"
    ProjectileClass=class'ROVehicles.TigerCannonShell'
    PrimaryProjectileClass=class'ROVehicles.TigerCannonShell'
    SecondaryProjectileClass=class'ROVehicles.TigerCannonShellHE'
	EffectEmitterClass=class'ROEffects.TankCannonFireEffect'
    FireInterval=15
    FireSoundVolume=512
    AltFireProjectileClass=class'ROInventory.ROMG34bullet'
    AltFireInterval=0.07
    AmbientEffectEmitterClass=class'TankMGEmitter'
    bAmbientEmitterAltFireOnly=true
    AltFireOffset=(X=10.0,Y=31.0,Z=2.0)
	AltFireSoundClass=sound'Inf_Weapons.mg34_p_fire_loop'
	AltFireSoundScaling=3.0
	AltFireEndSound=sound'Inf_Weapons.mg34_p.mg34_p_fire_end'
	bAmbientAltFireSound=true
	bAltFireTracersOnly=true
	bUsesTracers=true
	mTracerInterval=0.28
	DummyTracerClass=class'ROInventory.MG34ClientTracer'
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
    WeaponFireOffset=265.0
    bAimable=True
    RotationsPerSecond=0.016 // 60 seconds to rotate 360
    AIInfo(0)=(bLeadTarget=true,bTrySplash=False,WarnTargetPct=0.75,RefireRate=0.5)
	AIInfo(1)=(bLeadTarget=true,bTrySplash=False,AimError=600,WarnTargetPct=0.75,RefireRate=0.015)
    //Spread=0.015
    Spread=0.0

    // RO Vehicle sound vars
    ReloadSoundOne=Sound'Vehicle_reloads.Reloads.Tiger_reload_01'
    ReloadSoundTwo=Sound'Vehicle_reloads.Reloads.Tiger_reload_02'
    ReloadSoundThree=Sound'Vehicle_reloads.Reloads.Tiger_reload_03'
    ReloadSoundFour=Sound'Vehicle_reloads.Reloads.Tiger_reload_04'
    RotateSound=Sound'Vehicle_Weapons.Turret.hydraul_turret_traverse'
    SoundVolume=130


	VehHitpoints(0)=(PointRadius=9.0,PointHeight=0.0,PointScale=1.0,PointBone=com_player,PointOffset=(X=-3.0,Y=0.0,Z=12.0))
	VehHitpoints(1)=(PointRadius=16.0,PointHeight=0.0,PointScale=1.0,PointBone=com_player,PointOffset=(X=-3.0,Y=0.0,Z=-11.0))

	GunnerAttachmentBone=com_attachment

	RangeSettings(0)=0
	RangeSettings(1)=100
	RangeSettings(2)=200
	RangeSettings(3)=300
	RangeSettings(4)=400
	RangeSettings(5)=500
	RangeSettings(6)=600
	RangeSettings(7)=700
	RangeSettings(8)=800
	RangeSettings(9)=900
	RangeSettings(10)=1000
	RangeSettings(11)=1200
	RangeSettings(12)=1400
	RangeSettings(13)=1600
	RangeSettings(14)=1800
	RangeSettings(15)=2000
	RangeSettings(16)=2200
	RangeSettings(17)=2400
	RangeSettings(18)=2600
	RangeSettings(19)=2800
	RangeSettings(20)=3000
	RangeSettings(21)=3200
	RangeSettings(22)=3400
	RangeSettings(23)=3600
	RangeSettings(24)=3800
	RangeSettings(25)=4000

	// Ammo
	InitialPrimaryAmmo=50
	InitialSecondaryAmmo=42
	InitialAltAmmo=150
	ReloadSound=sound'Vehicle_reloads.MG34_ReloadHidden'
	NumAltMags=4

	hudAltAmmoIcon=Texture'InterfaceArt_tex.HUD.mg42_ammo'
}
