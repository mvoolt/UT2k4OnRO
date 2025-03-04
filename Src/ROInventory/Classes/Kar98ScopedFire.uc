//=============================================================================
// Kar98ScopedFire
//=============================================================================
// Bullet firing class for the Scoped Kar98 rifle
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class Kar98ScopedFire extends ROBoltFire;

defaultproperties
{
	//** Ammo properties **//
    AmmoClass=class'Kar792x57Ammo'
    AmmoPerFire=1

    //** Projectile firing **//
    ProjectileClass = class'Kar98ScopedBullet'
    ProjSpawnOffset=(X=25,Y=0,Z=0)
    FAProjSpawnOffset=(X=-30,Y=0,Z=0)
    SpreadStyle=SS_Random
	Spread = 30

    //** Shell Ejection **//
	ShellIronSightOffset=(X=10,Y=3,Z=-5)
	ShellHipOffset=(X=0,Y=0,Z=0)
	ShellRotOffsetIron=(Pitch=14000,Yaw=0,Roll=0)
    ShellRotOffsetHip=(Pitch=-3000,Yaw=-5000,Roll=0)

    //** Recoil **//
  	maxVerticalRecoilAngle=1500
  	maxHorizontalRecoilAngle=600
  	PctRestDeployRecoil=0.25

    //** Functionality **//
	bWaitForRelease = true // Set to true for non automatic weapons

    //** Animation **//
    // Rates
    FireAnimRate=1.0
    FireRate=2.6
    TweenTime=0.0
    // Firing
    FireAnim=Shoot_Last
    FireIronAnim=Scope_shoot

    //** Sounds **//
  	FireSounds(0) = Sound'Inf_Weapons.kar98.kar98_fire01'
  	FireSounds(1) = Sound'Inf_Weapons.kar98.kar98_fire02'
  	FireSounds(2) = Sound'Inf_Weapons.kar98.kar98_fire03'

    //** Effects **//
    FlashEmitterClass=class'ROEffects.MuzzleFlash1stKar'
    SmokeEmitterClass = class'ROEffects.ROMuzzleSmoke'
    ShellEjectClass=class'ROAmmo.ShellEject1st762x54mm'

    //** Bot/AI **//
    bSplashDamage=false
    bRecommendSplashDamage=false
    bSplashJump=false
    BotRefireRate=0.5
	WarnTargetPct=+0.9
	AimError=550

    //** View shake **//
    ShakeOffsetMag=(X=3.0,Y=1.0,Z=5.0)
    ShakeOffsetRate=(X=1000.0,Y=1000.0,Z=1000.0)
    ShakeOffsetTime=1.0
    ShakeRotMag=(X=50.0,Y=50.0,Z=400.0)
    ShakeRotRate=(X=12500.0,Y=12500.0,Z=12500.0)
    ShakeRotTime=5.0

    //** Misc **//
    FireForce="RocketLauncherFire"  // jdf
}
