//==============================================================================
// M1937Cannon
//
// Red Orchestra Source - William Miller
// Copyright (C) 2007 Tripwire Interactive, LLC
//
// M-1937 45mm AT Gun Cannon class
//==============================================================================
class M1937Cannon extends ATGunCannon;

#exec OBJ LOAD FILE=..\Sounds\Ahz_Sounds.uax

//==============================================================================
// defaultproperties
//==============================================================================
defaultproperties
{
    Mesh=Mesh'allies_ahz_45mm_anm.45mm_turret'
    skins(0)=Texture'allies_ahz_guns_tex.45mm.45mm_ext'
	bUseHighDetailOverlayIndex=false //true
    BeginningIdleAnim=crouch_idle_binoc
    YawBone=Turret
    YawStartConstraint=-4500 //-3000
    YawEndConstraint=4500    //3000
    PitchBone=Gun

    PitchUpLimit=15000
    PitchDownLimit=45000
	CustomPitchUpLimit=6000          // -8 degrees
	CustomPitchDownLimit=63500        //+25 degrees

    CannonFireSound(0)=sound'Vehicle_Weapons.PanzerIII.50mm_fire01'
	CannonFireSound(1)=sound'Vehicle_Weapons.PanzerIII.50mm_fire02'
	CannonFireSound(2)=sound'Vehicle_Weapons.PanzerIII.50mm_fire03'
    ProjectileClass=class'M1937CannonShell'
    PrimaryProjectileClass=class'M1937CannonShell'
    SecondaryProjectileClass=class'M1937CannonShellHE'
	EffectEmitterClass=class'ROEffects.TankCannonFireEffect'
    FireInterval=0.5
    FireSoundVolume=250
    CrewSoundVolume=512
    ShakeRotMag=(Z=110)
    ShakeRotRate=(Z=1100)
    ShakeRotTime=2
    ShakeOffsetMag=(Z=5)
    ShakeOffsetRate=(Z=100)
    ShakeOffsetTime=2
    WeaponFireAttachmentBone=Barrel
    WeaponFireOffset=0.0   //50.0
    bAimable=True
    RotationsPerSecond=0.05 // 20 seconds to rotate 360
    AIInfo(0)=(bLeadTarget=true,bTrySplash=False,WarnTargetPct=0.75,RefireRate=0.5)
	AIInfo(1)=(bLeadTarget=true,bTrySplash=False,AimError=600,WarnTargetPct=0.75,RefireRate=0.015)
    Spread=0.0

	// ROVehicleWeapon Vars
	MaxPositiveYaw=4500 //3000
	MaxNegativeYaw=-4500 //-3000
	bLimitYaw = true

    // RO Vehicle sound vars
    ReloadSoundOne=Sound'Vehicle_reloads.Reloads.Panzer_III_reload_01'
    ReloadSoundTwo=sound'Vehicle_reloads.Reloads.Panzer_III_reload_02'
    ReloadSoundThree=sound'Vehicle_reloads.Reloads.Panzer_III_reload_03'
    ReloadSoundFour=sound'Vehicle_reloads.Reloads.Panzer_III_reload_04'
    ReloadSoundReady=sound'Ahz_Sounds.ATGun.rus_loaded01'
    FireSoundCmdr=sound'Ahz_Sounds.ATGun.rus_fire01'
    RotateSound=Sound'Vehicle_Weapons.Turret.manual_turret_traverse'

                                                                                                           // X = FRONT/BACK, Y=LEFT/RIGHT, Z=UP/DOWN
	VehHitpoints(0)=(PointRadius=9.0,PointHeight=0.0,PointScale=1.0,PointBone=com_player,PointOffset=(X=0.0,Y=0.0,Z=18.0))
	VehHitpoints(1)=(PointRadius=20.0,PointHeight=0.0,PointScale=1.0,PointBone=com_player,PointOffset=(X=-15.0,Y=0.0,Z=-5.0))

	GunnerAttachmentBone=com_attachment

	RangeSettings(0)=0
	RangeSettings(1)=500
	RangeSettings(2)=1000
	RangeSettings(3)=1500
	RangeSettings(4)=2000
	RangeSettings(5)=2500

	// Ammo
	InitialPrimaryAmmo=60
	InitialSecondaryAmmo=30
}


