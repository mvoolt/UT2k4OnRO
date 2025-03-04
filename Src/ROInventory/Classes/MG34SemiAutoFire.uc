//=============================================================================
// MG34SemiAutoFire
//=============================================================================
// Semi Auto bullet firing class for the MG34 Machine Gun
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class MG34SemiAutoFire extends ROMGSingleFire;

defaultproperties
{
	//** Ammo properties **//
    AmmoClass=class'MG50Rd792x57DrumAmmo'
    AmmoPerFire=1

    //** Projectile firing **//
    ProjectileClass = class'ROMG34Bullet'
    ProjSpawnOffset=(X=25,Y=0,Z=0)
    FAProjSpawnOffset=(X=-20,Y=0,Z=0)
    SpreadStyle=SS_Random
	Spread = 125//750
	bModeExclusive=true

    //** Tracers **//
	DummyTracerClass=class'ROInventory.MG34ClientTracer'
  	bUsesTracers=true
	TracerFrequency=4

    //** Recoil **//
  	maxVerticalRecoilAngle=850
  	maxHorizontalRecoilAngle=750

    //** Functionality **//
	bWaitForRelease = true // Set to true for non automatic weapons

    //** Animation **//
    // Rates
    FireAnimRate=1.0
    FireRate=0.2
    TweenTime=0.0
    // Firing
    FireAnim=Bipod_shoot_single
    FireIronAnim=Shoot_Loop
    FireLoopAnim = Shoot_Loop
    FireIronLoopAnim=Bipod_shoot_single
    FireEndAnim=Shoot_end
    FireIronEndAnim=Bipod_Shoot_End

    //** Sounds **//
  	FireSounds(0) = Sound'Inf_Weapons.mg34_fire_single'

    //** Effects **//
    FlashEmitterClass=class'ROEffects.MuzzleFlash1stMG'
    SmokeEmitterClass = class'ROEffects.ROMuzzleSmoke'
    ShellEjectClass=class'ROAmmo.ShellEject1st762x54mm'
	ShellIronSightOffset=(X=25,Y=0,Z=-10)
	ShellRotOffsetIron=(Pitch=0,Yaw=0,Roll=0)
    ShellRotOffsetHip=(Pitch=0,Yaw=0,Roll=0)

    //** Bot/AI **//
    bSplashDamage=false
    bRecommendSplashDamage=false
    bSplashJump=false
    BotRefireRate=0.5
	WarnTargetPct=+0.9
	AimError=1800

    //** View shake **//
    ShakeOffsetMag=(X=3.0,Y=1.0,Z=3.0)
    ShakeOffsetRate=(X=1000.0,Y=1000.0,Z=1000.0)
    ShakeOffsetTime=2
    ShakeRotMag=(X=50.0,Y=50.0,Z=50.0)
    ShakeRotRate=(X=10000.0,Y=10000.0,Z=10000.0)
    ShakeRotTime=2

    //** Misc **//
    FireForce="RocketLauncherFire"  // jdf

    //** Recoil modifiers **//
    RecoilRate=0.04
    PctHipMGPenalty=1.5
}
