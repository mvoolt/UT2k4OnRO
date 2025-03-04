//=============================================================================
// P08LugerFire
//=============================================================================
// Bullet firing class for the P08 Luger pistol
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class P08LugerFire extends ROPistolFire;

defaultproperties
{
	//** Ammo properties **//
    AmmoClass=class'P08LugerAmmo'
    AmmoPerFire=1

    //** Projectile firing **//
    ProjectileClass = class'P08LugerBullet'
    ProjSpawnOffset=(X=25,Y=0,Z=0)
    FAProjSpawnOffset=(X=-15,Y=0,Z=0)
    SpreadStyle=SS_Random
	Spread = 725

    //** Shell Ejection **//
	ShellIronSightOffset=(X=10,Y=0,Z=0)
	ShellHipOffset=(X=0,Y=-7,Z=0)
	//ShellRotOffsetIron=(Pitch=14000,Yaw=0,Roll=0)
    //ShellRotOffsetHip=(Pitch=-3000,Yaw=-3000,Roll=0)

    //** Recoil **//
  	maxVerticalRecoilAngle=500
  	maxHorizontalRecoilAngle=200

    //** Functionality **//
	bWaitForRelease = true // Set to true for non automatic weapons

    //** Animation **//
    // Rates
    FireAnimRate=1.0
    FireRate=0.2
    TweenTime=0.0
    // Firing
    FireAnim=Shoot
    FireIronAnim=Iron_Shoot
    FireLastAnim=shoot_empty
    FireIronLastAnim=iron_shoot_empty

    //** Sounds **//
  	FireSounds(0) = Sound'Inf_Weapons.lugerP08.lugerP08_fire01'
  	FireSounds(1) = Sound'Inf_Weapons.lugerP08.lugerP08_fire02'
  	FireSounds(2) = Sound'Inf_Weapons.lugerP08.lugerP08_fire03'

    //** Effects **//
    FlashEmitterClass=class'ROEffects.MuzzleFlash1stPistol'
    ShellEjectClass=class'ROAmmo.ShellEject1st9x19mm'

    //** Bot/AI **//
    bSplashDamage=false
    bRecommendSplashDamage=false
    bSplashJump=false
    BotRefireRate=0.5
	WarnTargetPct=+0.9
	AimError=800

    //** View shake **//
    ShakeOffsetMag=(X=3.0,Y=1.0,Z=3.0)
    ShakeOffsetRate=(X=1000.0,Y=1000.0,Z=1000.0)
    ShakeOffsetTime=1.0
    ShakeRotMag=(X=50.0,Y=50.0,Z=50.0)
    ShakeRotRate=(X=10000.0,Y=10000.0,Z=10000.0)
    ShakeRotTime=1.0

    //** Misc **//
    FireForce="AssaultRifleFire"  // jdf
}
