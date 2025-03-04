//=============================================================================
// MP40Fire
//=============================================================================
// Bullet firing class for the SVT40 rifle
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class MP40Fire extends ROAutomaticFire;

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
    AmmoClass=class'MP32Rd9x19Ammo'
    AmmoPerFire=1

    //** Projectile firing **//
    ProjectileClass = class'MP40Bullet'
    ProjSpawnOffset=(X=25,Y=0,Z=0)
    FAProjSpawnOffset=(X=-20,Y=0,Z=0)
    SpreadStyle=SS_Random
	Spread = 410

    //** Shell Ejection **//
	ShellIronSightOffset=(X=15,Y=0,Z=0)
	//ShellHipOffset=(X=0,Y=0,Z=0)
	//ShellRotOffsetIron=(Pitch=14000,Yaw=0,Roll=0)
    //ShellRotOffsetHip=(Pitch=-3000,Yaw=-5000,Roll=0)

    //** Recoil **//
  	maxVerticalRecoilAngle=800
  	maxHorizontalRecoilAngle=400

    //** Functionality **//
	bWaitForRelease = false // Set to true for non automatic weapons

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
  	FireSounds(0) = Sound'Inf_Weapons.mp40.mp40_fire01'
  	FireSounds(1) = Sound'Inf_Weapons.mp40.mp40_fire02'
  	FireSounds(2) = Sound'Inf_Weapons.mp40.mp40_fire03'
  	NoAmmoSound=Sound'Inf_Weapons_Foley.Misc.dryfire_smg'

    //** Effects **//
    FlashEmitterClass=class'ROEffects.MuzzleFlash1stMP'
    SmokeEmitterClass = class'ROEffects.ROMuzzleSmoke'
    ShellEjectClass=class'ROAmmo.ShellEject1st9x19mm'

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
    PctStandIronRecoil = .90   // this is the percentage of recoil felt compared to firing from the hip
    PctCrouchRecoil = 0.75      	// this is the percentage of recoil felt compared to standing
    PctCrouchIronRecoil = 0.60  	// this is the percentage of recoil felt compared to standard crouch
    PctProneRecoil = 0.6        // this is the percantage of recoil felt compared to standing
    PctProneIronRecoil = 0.50    // this is the percentage of recoil felt compared to standard prone
    RecoilRate=0.075

    //** Misc **//
    FireForce="AssaultRifleFire"  // jdf
}
