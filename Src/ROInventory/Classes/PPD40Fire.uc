//=============================================================================
// PPD40Fire
//=============================================================================
// Bullet firing class for the PPD40 SMG
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class PPD40Fire extends ROFastAutoFire;

defaultproperties
{
	//** Ammo properties **//
    AmmoClass=class'SMG71Rd762x25Ammo'
    AmmoPerFire=1

    //** Projectile firing **//
    ProjectileClass = class'PPD40Bullet'
	ServerProjectileClass = class'ROInventory.PPD40Bullet_S'
    ProjSpawnOffset=(X=25,Y=0,Z=0)
    FAProjSpawnOffset=(X=-20,Y=0,Z=0)
    SpreadStyle=SS_Random
	Spread = 410

    //** Recoil **//
  	maxVerticalRecoilAngle=750
  	maxHorizontalRecoilAngle=425

    //** Functionality **//
	bWaitForRelease = false // Set to true for non automatic weapons

    //** Animation **//
    // Rates
    FireAnimRate=1.0
    FireRate=0.075   // 800 rpm
    TweenTime=0.0
    // Firing
    PreFireAnim=Shoot1_start
    FireAnim=Shoot_Loop
    FireIronAnim=iron_Shoot_Loop
    FireLoopAnim=Shoot_Loop
    FireIronLoopAnim=iron_Shoot_Loop
    FireEndAnim=Shoot_end
    FireIronEndAnim=iron_shoot_end

    //** Sounds **//
  	AmbientFireSound = sound'Inf_Weapons.ppd40_fire_loop'
    AmbientFireVolume=255
    AmbientFireSoundRadius=750.0
    FireEndSound=sound'Inf_Weapons.ppd40_fire_end'

    //** Effects **//
    FlashEmitterClass=class'ROEffects.MuzzleFlash1stPPSH'
    SmokeEmitterClass = class'ROEffects.ROMuzzleSmoke'
    ShellEjectClass=class'ROAmmo.ShellEject1st762x25mm'
	ShellIronSightOffset=(X=15,Y=0,Z=0)
	ShellRotOffsetIron=(Pitch=5000,Yaw=0,Roll=0)

    //** Bot/AI **//
    bSplashDamage=false
    bRecommendSplashDamage=false
    bSplashJump=false
    BotRefireRate=0.99
	WarnTargetPct=+0.9
	AimError=1200

    //** View shake **//
    ShakeOffsetMag=(X=3.0,Y=1.0,Z=3.0)
    ShakeOffsetRate=(X=1000.0,Y=1000.0,Z=1000.0)
    ShakeOffsetTime=1.0
    ShakeRotMag=(X=50.0,Y=50.0,Z=150.0)
    ShakeRotRate=(X=10000.0,Y=10000.0,Z=10000.0)
    ShakeRotTime=0.5

    //** Recoil modifiers **//
    RecoilRate=0.05

    //** Misc **//
    FireForce="AssaultRifleFire"  // jdf
}

