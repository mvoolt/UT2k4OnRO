//=============================================================================
// Kar98Fire
//=============================================================================
// Bullet firing class for the Kar98 rifle
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class Kar98Fire extends ROBoltFire;

defaultproperties
{
	//** Ammo properties **//
    AmmoClass=class'Kar792x57Ammo'
    AmmoPerFire=1

    //** Projectile firing **//
    ProjectileClass = class'Kar98Bullet'
    ProjSpawnOffset=(X=25,Y=0,Z=0)
    FAProjSpawnOffset=(X=-30,Y=0,Z=0)
    SpreadStyle=SS_Random
	Spread = 50

    //** Shell Ejection **//
	ShellIronSightOffset=(X=10,Y=3,Z=-5)
	ShellHipOffset=(X=0,Y=0,Z=0)
	ShellRotOffsetIron=(Pitch=14000,Yaw=0,Roll=0)
    ShellRotOffsetHip=(Pitch=-3000,Yaw=-5000,Roll=0)

    //** Recoil **//
  	maxVerticalRecoilAngle=1500
  	maxHorizontalRecoilAngle=600

    //** Functionality **//
	bWaitForRelease = true // Set to true for non automatic weapons

    //** Animation **//
    // Rates
    FireAnimRate=1.0
    FireRate=2.6
    TweenTime=0.0
    // Firing
    FireAnim=shoot_last
    FireIronAnim=iron_shootrest

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
	AimError=800

    //** View shake **//
    ShakeOffsetMag=(X=3.0,Y=1.0,Z=5.0)
    ShakeOffsetRate=(X=1000.0,Y=1000.0,Z=1000.0)
    ShakeOffsetTime=1.0
    ShakeRotMag=(X=50.0,Y=50.0,Z=300.0)
    ShakeRotRate=(X=12500.0,Y=12500.0,Z=7500.0)
    ShakeRotTime=2.0

    //** Misc **//
    FireForce="RocketLauncherFire"  // jdf
}
