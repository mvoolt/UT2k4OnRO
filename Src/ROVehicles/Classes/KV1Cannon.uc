//===================================================================
// KV1Cannon
//
// Copyright (C) 2004 John "Ramm-Jaeger"  Gibson
//
// KV1 tank cannon class
//===================================================================
class KV1Cannon extends ROTankCannon;

// Special tracer handling for this type of cannon
simulated function UpdateTracer()
{
	local rotator SpawnDir;

	if (Level.NetMode == NM_DedicatedServer || !bUsesTracers)
		return;


 	if (Level.TimeSeconds > mLastTracerTime + mTracerInterval)
	{
		if (Instigator != None && Instigator.IsLocallyControlled())
		{
			SpawnDir = WeaponFireRotation;
		}
		else
		{
			SpawnDir = GetBoneRotation(WeaponFireAttachmentBone);
		}

        if (Instigator != None && !Instigator.PlayerReplicationInfo.bBot)
        {
        	SpawnDir.Pitch += AddedPitch;
        }

        Spawn(DummyTracerClass,,, WeaponFireLocation, SpawnDir);

		mLastTracerTime = Level.TimeSeconds;
	}
}

defaultproperties
{
    Mesh=Mesh'allies_kv1_anm.KV1_turret_ext'
    skins(0)=Texture'allies_vehicles_tex.ext_vehicles.KV1_ext'
    skins(1)=Texture'allies_vehicles_tex.int_vehicles.kv1_int'
	HighDetailOverlay=Material'allies_vehicles_tex.int_vehicles.kv1_int_s'
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
	CustomPitchDownLimit=64500
	CannonFireSound(0)=sound'Vehicle_Weapons.Kv1s.76mm_fire01'
	CannonFireSound(1)=sound'Vehicle_Weapons.Kv1s.76mm_fire02'
	CannonFireSound(2)=sound'Vehicle_Weapons.Kv1s.76mm_fire03'
    FireForce="Explosion05"
    ProjectileClass=class'ROVehicles.KV1CannonShell'
    PrimaryProjectileClass=class'ROVehicles.KV1CannonShell'
    SecondaryProjectileClass=class'ROVehicles.KV1CannonShellHE'
	EffectEmitterClass=class'ROEffects.TankCannonFireEffect'
    FireInterval=12
    FireSoundVolume=512
    AltFireProjectileClass=class'ROInventory.DP28Bullet'
    AltFireInterval=0.1
    AmbientEffectEmitterClass=class'TankMGEmitter'
    bAmbientEmitterAltFireOnly=true
    AltFireOffset=(X=21.0,Y=18.0,Z=-0.5)
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
    RotationsPerSecond=0.05 // 20 seconds to rotate 360
    AIInfo(0)=(bLeadTarget=true,bTrySplash=False,WarnTargetPct=0.75,RefireRate=0.5)
	AIInfo(1)=(bLeadTarget=true,bTrySplash=False,AimError=600,WarnTargetPct=0.75,RefireRate=0.015)
    //Spread=0.015
    Spread=0.0

    AddedPitch=375

    // RO Vehicle sound vars
    ReloadSoundOne=Sound'Vehicle_reloads.Reloads.t34_85_reload_01'
    ReloadSoundTwo=Sound'Vehicle_reloads.Reloads.t34_85_reload_02'
    ReloadSoundThree=Sound'Vehicle_reloads.Reloads.t34_85_reload_03'
    ReloadSoundFour=Sound'Vehicle_reloads.Reloads.t34_85_reload_04'
    RotateSound=Sound'Vehicle_Weapons.Turret.hydraul_turret_traverse'
    SoundVolume=130

	VehHitpoints(0)=(PointRadius=9.0,PointHeight=0.0,PointScale=1.0,PointBone=com_player,PointOffset=(X=-5.0,Y=0.0,Z=0.0))
	VehHitpoints(1)=(PointRadius=15.0,PointHeight=0.0,PointScale=1.0,PointBone=com_player,PointOffset=(X=-10.0,Y=0.0,Z=-20.0))

	GunnerAttachmentBone=com_attachment

	RangeSettings(0)=0
	RangeSettings(1)=400
	RangeSettings(2)=600
	RangeSettings(3)=800
	RangeSettings(4)=1000
	RangeSettings(5)=1200
	RangeSettings(6)=1400
	RangeSettings(7)=1600
	RangeSettings(8)=1800
	RangeSettings(9)=2000
	RangeSettings(10)=2200
	RangeSettings(11)=2400
	RangeSettings(12)=2600
	RangeSettings(13)=2800
	RangeSettings(14)=3000
	RangeSettings(15)=3200
	RangeSettings(16)=3400
	RangeSettings(17)=3600
	RangeSettings(18)=3800
	RangeSettings(19)=4000
	RangeSettings(20)=4200
	RangeSettings(21)=4400
	RangeSettings(22)=4600
	RangeSettings(23)=4800
	RangeSettings(24)=5000
	RangeSettings(25)=5200
	RangeSettings(26)=5400
	RangeSettings(27)=5600
	RangeSettings(28)=5800
	RangeSettings(29)=6000

	// Ammo
	InitialPrimaryAmmo=54
	InitialSecondaryAmmo=60
	InitialAltAmmo=60
	ReloadSound=sound'Vehicle_reloads.DT_ReloadHidden'
	NumAltMags=15
}
