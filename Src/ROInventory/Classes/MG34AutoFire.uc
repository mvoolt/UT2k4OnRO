//=============================================================================
// MG34AutoFire
//=============================================================================
// Automatic bullet firing class for the MG34 Machine Gun
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class MG34AutoFire extends ROMGAutomaticFire;

defaultproperties
{
	//** Ammo properties **//
    AmmoClass=class'MG50Rd792x57DrumAmmo'
    AmmoPerFire=1

    //** Projectile firing **//
    ProjectileClass = class'ROMG34Bullet'
	ServerProjectileClass = class'MG34bullet_S'
    ProjSpawnOffset=(X=25,Y=0,Z=0)
    FAProjSpawnOffset=(X=-20,Y=0,Z=0)
    SpreadStyle=SS_Random
	Spread = 250//750
	bModeExclusive=true

    //** Shell Ejection **//
	ShellIronSightOffset=(X=20,Y=0,Z=-10)
	//ShellHipOffset=(X=0,Y=-7,Z=0)
	ShellRotOffsetIron=(Pitch=-13000,Yaw=0,Roll=0)
    ShellRotOffsetHip=(Pitch=-13000,Yaw=0,Roll=0)

    //** Tracers **//
	DummyTracerClass=class'ROInventory.MG34ClientTracer'
  	bUsesTracers=true
	TracerFrequency=4

    //** Recoil **//
  	maxVerticalRecoilAngle=600//850
  	maxHorizontalRecoilAngle=300//750

    //** Functionality **//
	bWaitForRelease = false // Set to true for non automatic weapons

    //** Animation **//
    // Rates
    FireAnimRate=1.0
    FireRate = 0.07		// 850 rpm
    TweenTime=0.0
    // Firing
    FireAnim=Shoot_Loop
    FireIronAnim=Shoot_Loop
    FireLoopAnim = Shoot_Loop
    FireIronLoopAnim=Bipod_Shoot_Loop
    FireEndAnim=Hip_Shoot_end
    FireIronEndAnim=Bipod_Shoot_End

    //** Sounds **//
  	AmbientFireSound = sound'Inf_Weapons.mg34_fire_loop'
    AmbientFireVolume=255
    AmbientFireSoundRadius=750.0
    FireEndSound=sound'Inf_Weapons.mg34_fire_end'

    //** Effects **//
    FlashEmitterClass=class'ROEffects.MuzzleFlash1stMG'
    SmokeEmitterClass = class'ROEffects.ROMuzzleSmoke'
    ShellEjectClass=class'ROAmmo.ShellEject1st762x54mm'


    //** Bot/AI **//
    bSplashDamage=false
    bRecommendSplashDamage=false
    bSplashJump=false
    BotRefireRate=0.99
	WarnTargetPct=+0.9
	AimError=1800

    //** View shake **//
    ShakeOffsetMag=(X=3.0,Y=1.0,Z=3.0)
    ShakeOffsetRate=(X=1000.0,Y=1000.0,Z=1000.0)
    ShakeOffsetTime=2
    ShakeRotMag=(X=50.0,Y=50.0,Z=50.0)
    ShakeRotRate=(X=10000.0,Y=10000.0,Z=10000.0)
    ShakeRotTime=2

    //** Recoil modifiers **//
    RecoilRate=0.04
    PctHipMGPenalty=1.5

    //** Misc **//
    FireForce="AssaultRifleFire"  // jdf
    PackingThresholdTime = 0.12
}
