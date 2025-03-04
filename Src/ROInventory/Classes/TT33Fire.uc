//=============================================================================
// TT33Fire
//=============================================================================
// Bullet firing class for the TT33 pistol
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class TT33Fire extends ROPistolFire;

defaultproperties
{
	//** Ammo properties **//
    AmmoClass=class'TT33Ammo'
    AmmoPerFire=1

    //** Projectile firing **//
    ProjectileClass = class'TT33Bullet'
    ProjSpawnOffset=(X=25,Y=0,Z=0)
    FAProjSpawnOffset=(X=-15,Y=0,Z=0)
    SpreadStyle=SS_Random
	Spread = 825

    //** Shell Ejection **//
	ShellIronSightOffset=(X=10,Y=0,Z=0)
	ShellHipOffset=(X=0,Y=3,Z=0)
	//ShellRotOffsetIron=(Pitch=14000,Yaw=0,Roll=0)
    //ShellRotOffsetHip=(Pitch=-3000,Yaw=-3000,Roll=0)
    bReverseShellSpawnDirection=true

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
  	FireSounds(0) = Sound'Inf_Weapons.tt33.tt33_fire01'
  	FireSounds(1) = Sound'Inf_Weapons.tt33.tt33_fire02'
  	FireSounds(2) = Sound'Inf_Weapons.tt33.tt33_fire03'

    //** Effects **//
    FlashEmitterClass=class'ROEffects.MuzzleFlash1stPistol'
    ShellEjectClass=class'ROAmmo.ShellEject1st762x25mm'
	ShellRotOffsetIron=(Pitch=10000,Yaw=0,Roll=0)
    ShellRotOffsetHip=(Pitch=2500,Yaw=4000,Roll=0)


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

//defaultproperties
//{
//  	ProjectileClass = class'ROTT33Bullet'
//
//  	maxVerticalRecoilAngle=500
//  	maxHorizontalRecoilAngle=200
//// RO added or changed default properties
//  	AmmoClass=class'ROAmmo.ROtt33Ammo'
//  	bMultiFireSounds = true
//  	RONumWeapSounds = 3
//  	ROFireSound(0) = Sound'Inf_Weapons.tt33.tt33_fire01'
//  	ROFireSound(1) = Sound'Inf_Weapons.tt33.tt33_fire02'
//  	ROFireSound(2) = Sound'Inf_Weapons.tt33.tt33_fire02'
//  	NoAmmoSound=Sound'ROweaponsounds_old.generalwpn.empty_pistol'
//
//  	Spread = 825
//  	FireAnim=shoot
//  	FireAnimLast = shoot_empty
//  	FireAnimIron = iron_shoot
//  	FireAnimIronLast = iron_shoot_empty
//  	FireRate = 0.20
//
///* STANDARD UNCHANGED UT VARIABLES */
//    bPawnRapidFireAnim=true
//
//    FlashEmitterClass=class'ROMuzzleFlash1st'
//
//    SpreadStyle=SS_Random
//
//    AimError=800
//
//    ShakeOffsetMag=(X=3.0,Y=1.0,Z=3.0)
//    ShakeOffsetRate=(X=1000.0,Y=1000.0,Z=1000.0)
//    ShakeOffsetTime=1.0
//    ShakeRotMag=(X=50.0,Y=50.0,Z=50.0)
//    ShakeRotRate=(X=10000.0,Y=10000.0,Z=10000.0)
//    ShakeRotTime=1.0
//}

