//=============================================================================
// STG44Fire
//=============================================================================
// Bullet firing class for the STG44 rifle
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class STG44Fire extends ROAutomaticFire;

function ModeTick(float dt)
{
    Super.ModeTick(dt);

	// WeaponTODO: See how to properly reimplement this
	if ( bIsFiring && !AllowFire() /*|| bNowWaiting */)  // stopped firing, magazine empty or barrel overheat
    {
		Weapon.StopFire(ThisModeNum);
	}
}


defaultproperties
{
	//** Ammo properties **//
    AmmoClass=class'STG44Ammo'
    AmmoPerFire=1

    //** Projectile firing **//
    ProjectileClass = class'STG44Bullet'
    ProjSpawnOffset=(X=25,Y=0,Z=0)
    FAProjSpawnOffset=(X=-28,Y=0,Z=0)
    SpreadStyle=SS_Random
	Spread = 200

    //** Recoil **//
  	maxVerticalRecoilAngle=790
  	maxHorizontalRecoilAngle=625

    //** Animation **//
    // Rates
    FireAnimRate=1.0
    FireRate=0.12
    TweenTime=0.0
    // Firing
    FireAnim=Shoot_Loop
    FireIronAnim=iron_Shoot_Loop
    FireLoopAnim = Shoot_Loop
    FireIronLoopAnim=iron_Shoot_Loop
    FireEndAnim=Shoot_end
    FireIronEndAnim=iron_shoot_end

    //** Sounds **//
  	FireSounds(0) = Sound'Inf_Weapons.stg44.stg44_fire01'
  	FireSounds(1) = Sound'Inf_Weapons.stg44.stg44_fire02'
  	FireSounds(2) = Sound'Inf_Weapons.stg44.stg44_fire03'

    //** Effects **//
    FlashEmitterClass=class'ROEffects.MuzzleFlash1stSTG'
    SmokeEmitterClass = class'ROEffects.ROMuzzleSmoke'
    ShellEjectClass=class'ROAmmo.ShellEject1st556mm'
	ShellIronSightOffset=(X=10,Y=0,Z=-5)
	//ShellHipOffset=(X=-10,Y=55,Z=20)
	ShellRotOffsetIron=(Pitch=2000,Yaw=0,Roll=0)
	bReverseShellSpawnDirection=true

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
    ShakeRotMag=(X=50.0,Y=50.0,Z=175.0)
    ShakeRotRate=(X=10000.0,Y=10000.0,Z=10000.0)
    ShakeRotTime=0.75

    //** Recoil modifiers **//
    RecoilRate=0.075

    //** Misc **//
    FireForce="AssaultRifleFire"  // jdf
    PreLaunchTraceDistance=1836.0 // 35 meters
}
