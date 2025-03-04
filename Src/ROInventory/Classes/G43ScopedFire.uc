//=============================================================================
// G43ScopedFire
//=============================================================================
// Bullet firing class for the G43 sniper rifle
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class G43ScopedFire extends ROSemiAutoFire;

defaultproperties
{
	//** Ammo properties **//
    AmmoClass=class'G43Ammo'
    AmmoPerFire=1

    //** Projectile firing **//
    ProjectileClass = class'G43ScopedBullet'
    ProjSpawnOffset=(X=25,Y=0,Z=0)
    FAProjSpawnOffset=(X=-30,Y=0,Z=0)
    SpreadStyle=SS_Random
	Spread = 125

    //** Shell Ejection **//
	ShellIronSightOffset=(X=15,Y=0,Z=0)
	//ShellHipOffset=(X=0,Y=0,Z=0)
	//ShellRotOffsetIron=(Pitch=14000,Yaw=0,Roll=0)
    ShellRotOffsetHip=(Pitch=-3000,Yaw=-3000,Roll=0)

    //** Recoil **//
  	maxVerticalRecoilAngle=2100
  	maxHorizontalRecoilAngle=1000
  	PctRestDeployRecoil = 0.75

    //** Functionality **//
	bWaitForRelease = true // Set to true for non automatic weapons

    //** Animation **//
    // Rates
    FireAnimRate=1.0
    FireRate=0.2
    TweenTime=0.0
    // Firing
    FireAnim=Shoot
    FireIronAnim=Scope_Shoot

    //** Sounds **//
  	FireSounds(0) = Sound'Inf_Weapons.g43.g43_fire01'
  	FireSounds(1) = Sound'Inf_Weapons.g43.g43_fire02'
  	FireSounds(2) = Sound'Inf_Weapons.g43.g43_fire03'

    //** Effects **//
    FlashEmitterClass=class'ROEffects.MuzzleFlash1stSVT'
    SmokeEmitterClass = class'ROEffects.ROMuzzleSmoke'
    ShellEjectClass=class'ROAmmo.ShellEject1st762x54mm'

    //** Bot/AI **//
    bSplashDamage=false
    bRecommendSplashDamage=false
    bSplashJump=false
    BotRefireRate=0.5
	WarnTargetPct=+0.9
	AimError=1200

    //** View shake **//
    ShakeOffsetMag=(X=3.0,Y=1.0,Z=3.0)
    ShakeOffsetRate=(X=1000.0,Y=1000.0,Z=1000.0)
    ShakeOffsetTime=1
    ShakeRotMag=(X=50.0,Y=50.0,Z=200.0)
    ShakeRotRate=(X=12500.0,Y=10000.0,Z=10000.0)
    ShakeRotTime=2.0

    //** Misc **//
    FireForce="RocketLauncherFire"  // jdf
}

