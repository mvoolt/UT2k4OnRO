//=============================================================================
// PPSH41Fire
//=============================================================================
// Bullet firing class for the PPSH41 SMG
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class PPSH41Fire extends ROFastAutoFire;

defaultproperties
{
	//** Ammo properties **//
    AmmoClass=class'SMG71Rd762x25Ammo'
    AmmoPerFire=1

    //** Projectile firing **//
    ProjectileClass = class'PPSh41Bullet'
	ServerProjectileClass = class'ROInventory.PPSh41Bullet_S'
    ProjSpawnOffset=(X=25,Y=0,Z=0)
    FAProjSpawnOffset=(X=-20,Y=0,Z=0)
    SpreadStyle=SS_Random
	Spread = 460

    //** Recoil **//
  	maxVerticalRecoilAngle=730
  	maxHorizontalRecoilAngle=400

    //** Functionality **//
	bWaitForRelease = false // Set to true for non automatic weapons

    //** Animation **//
    // Rates
    FireAnimRate=1.0
    FireRate=0.0667
    TweenTime=0.0
    // Firing
    PreFireAnim=Shoot1_start
    FireAnim=Shoot_Loop
    FireIronAnim=iron_Shoot_Loop
    FireLoopAnim = Shoot_Loop
    FireIronLoopAnim=iron_Shoot_Loop
    FireEndAnim=Shoot_end
    FireIronEndAnim=iron_shoot_end

    //** Sounds **//
  	AmbientFireSound = sound'Inf_Weapons.ppsh41_fire_loop'
    AmbientFireVolume=255
    AmbientFireSoundRadius=750.0
    FireEndSound=sound'Inf_Weapons.ppsh41_fire_end'

    //** Effects **//
    FlashEmitterClass=class'ROEffects.MuzzleFlash1stPPSH'
    SmokeEmitterClass = class'ROEffects.ROMuzzleSmoke'
    ShellEjectClass=class'ROAmmo.ShellEject1st762x25mm'
	ShellIronSightOffset=(X=15,Y=0,Z=0)
	ShellRotOffsetIron=(Pitch=11000,Yaw=0,Roll=0)

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
    ShakeOffsetTime=1.0
    ShakeRotMag=(X=50.0,Y=50.0,Z=150.0)
    ShakeRotRate=(X=10000.0,Y=10000.0,Z=10000.0)
    ShakeRotTime=0.5

    //** Recoil modifiers **//
    RecoilRate=0.05

    //** Misc **//
    FireForce="AssaultRifleFire"  // jdf
}

//defaultproperties
//{
//  	ProjectileClass = class'ROPPSh41Bullet'
//  	ServerProjectileClass = class'ROInventory.ROPPSh41Bullet_S'
//
///* RO ANIMATIONS VARIABLES */
//  	PreFireAnim = Shoot1_start
//  	FireEndAnim = Shoot_end        // end animation for the firing loop
//  	FireLoopAnim = Shoot_Loop     // animation that is looped during the firing loop
//  	ROIronFireLoopAnim = Iron_Shoot_Loop
//  	ROIronFireEndAnim = iron_shoot_end
//
///* RO sound VARIABLES */
//  	AmbientFireSound = sound'Inf_Weapons.ppsh41_fire_loop'
//  	NoAmmoSound = Sound'empty_pistol'
//    AmbientFireVolume=255
//    AmbientFireSoundRadius=750.0
//    FireEndSound=sound'Inf_Weapons.ppsh41_fire_end'
//    LoopFireAnimRate=1.0
//    IronLoopFireAnimRate=1.0
//
//
///* RO SPECIFIC VARIABLES */
//  	maxVerticalRecoilAngle = 730//790      // The max vertical recoil angle possible without modifiers
//  	maxHorizontalRecoilAngle = 400//625    // The max horizontal recoil angle possible without modifiers
//
///* UT VARIABLES THAT WERE CHANGED for RO */
//  	AmmoClass=class'ROAmmo.ROppsh41Ammo'
//  	FireRate = 0.0666
//  	Spread = 460
//  	AimError = 1800
//  	BotRefireRate = 0.99
//
///* STANDARD UNCHANGED UT VARIABLES */
//    FlashEmitterClass=class'ROEffects.ROMuzzleFlash1st'
//    SpreadStyle=SS_Random
//
//    ShakeOffsetMag=(X=3.0,Y=1.0,Z=3.0)
//    ShakeOffsetRate=(X=1000.0,Y=1000.0,Z=1000.0)
//    ShakeOffsetTime=1.0
//    ShakeRotMag=(X=50.0,Y=50.0,Z=150.0)
//    ShakeRotRate=(X=10000.0,Y=10000.0,Z=10000.0)
//    ShakeRotTime=0.5
//}

