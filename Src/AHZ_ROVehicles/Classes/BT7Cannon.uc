//==============================================================================
// BT7Cannon
//
// Red Orchestra Source - William Miller
// Copyright (C) 2007 Tripwire Interactive, LLC
//
// BT7 Tank Cannon Class
//==============================================================================
class BT7Cannon extends ROTankCannon;

//==============================================================================
// Default Properties
//==============================================================================
defaultproperties
{
    Mesh=Mesh'allies_ahz_bt7_anm.BT7_turret_ext'
    skins(0)=Texture'allies_ahz_vehicles_tex.ext_vehicles.BT7_ext'
    skins(1)=Texture'allies_ahz_vehicles_tex.int_vehicles.BT7_int'
    HighDetailOverlay=Material'allies_ahz_vehicles_tex.int_vehicles.BT7_int'
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
	CustomPitchDownLimit=63500
	CannonFireSound(0)=sound'Vehicle_Weapons.PanzerIII.50mm_fire01'
	CannonFireSound(1)=sound'Vehicle_Weapons.PanzerIII.50mm_fire02'
	CannonFireSound(2)=sound'Vehicle_Weapons.PanzerIII.50mm_fire03'
    FireForce="Explosion05"
    ProjectileClass=class'AHZ_ROVehicles.BT7CannonShell'
    PrimaryProjectileClass=class'AHZ_ROVehicles.BT7CannonShell'
    //SecondaryProjectileClass=class'AHZ_ROVehicles.BT7CannonShellHE'           //Can not verifiy that the BT7 carried HE rouunds
	EffectEmitterClass=class'ROEffects.TankCannonFireEffect'
    FireInterval=4
    FireSoundVolume=500
    AltFireProjectileClass=class'ROInventory.DP28Bullet'
    AltFireInterval=0.1
    AmbientEffectEmitterClass=class'ROVehicles.TankMGEmitter'
    bAmbientEmitterAltFireOnly=true
    AltFireOffset=(X=-77.0,Y=7.5,Z=0.0)      //x=-77.0, but now is causing a problem?
	AltFireSoundClass=sound'Inf_Weapons.dt_fire_loop'
	AltFireSoundScaling=3.0
	AltFireEndSound=sound'Inf_Weapons.dt.dt_fire_end'
	bAmbientAltFireSound=true
	bAltFireTracersOnly=true
	bUsesTracers=true
	mTracerInterval=0.3
	DummyTracerClass=class'ROInventory.DP28ClientTracer'
    ShakeRotMag=(Z=250)
    ShakeRotRate=(Z=2500)
    ShakeRotTime=4
    ShakeOffsetMag=(Z=10)
    ShakeOffsetRate=(Z=200)
    ShakeOffsetTime=4
    AltShakeOffsetMag=(X=0.5,Y=0.5,Z=0.5)
    AltShakeOffsetRate=(X=500.0,Y=500.0,Z=500.0)
    AltShakeOffsetTime=1
    AltShakeRotMag=(X=50.0,Y=50.0,Z=50.0)
    AltShakeRotRate=(X=10000.0,Y=10000.0,Z=10000.0)
    AltShakeRotTime=2
    WeaponFireAttachmentBone=barrel
    WeaponFireOffset=0.0
    bAimable=True
    RotationsPerSecond=0.04 // 17 seconds to rotate 360                         //Increased rotation rate from 0.05
    AIInfo(0)=(bLeadTarget=true,bTrySplash=False,WarnTargetPct=0.75,RefireRate=0.5)
    Spread=0.0

    MaxDriverHitAngle=2.85

    // RO Vehicle sound vars
    ReloadSoundOne=Sound'Vehicle_reloads.Reloads.Panzer_III_reload_01'
    ReloadSoundTwo=sound'Vehicle_reloads.Reloads.Panzer_III_reload_02'
    ReloadSoundThree=sound'Vehicle_reloads.Reloads.Panzer_III_reload_03'
    ReloadSoundFour=sound'Vehicle_reloads.Reloads.Panzer_III_reload_04'
    RotateSound=Sound'Vehicle_Weapons.Turret.manual_turret_traverse'

	//TODO, change below
    VehHitpoints(0)=(PointRadius=9.0,PointHeight=0.0,PointScale=1.0,PointBone=com_player,PointOffset=(X=-7.0,Y=-8.0,Z=20.0))
    VehHitpoints(1)=(PointRadius=15.0,PointHeight=0.0,PointScale=1.0,PointBone=com_player,PointOffset=(X=-7.0,Y=0.0,Z=0.0))

	GunnerAttachmentBone=com_attachment

	ProjectileDescriptions(0)="AP"

	RangeSettings(0)=0
	RangeSettings(1)=250
	RangeSettings(2)=500
	RangeSettings(3)=1000
	RangeSettings(4)=1500
	RangeSettings(5)=2000
	RangeSettings(6)=2500

    //Based on historical ammo quantities
	InitialPrimaryAmmo=132
	//InitialSecondaryAmmo=40                                                   //Can not verifiy that the BT7 carried HE rouunds
	InitialAltAmmo=60
	ReloadSound=sound'Vehicle_reloads.DT_ReloadHidden'
	NumAltMags=20                                                                //Total 1,200

}
