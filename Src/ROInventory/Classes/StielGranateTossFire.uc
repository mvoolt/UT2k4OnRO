//=============================================================================
// StielGranateTossFire
//=============================================================================
// grenade toss firing class for the German StielHandGranate grenade
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class StielGranateTossFire extends ROThrownExplosiveFire;

defaultproperties
{
	//** Ammo properties **//
    AmmoClass=class'StielGranateAmmo'
    AmmoPerFire=1

    //** Projectile firing **//
    ProjectileClass = class'StielGranateProjectile'
    ProjSpawnOffset=(X=25,Y=0,Z=0)
    SpreadStyle=SS_Random
	Spread = 75
    minimumThrowSpeed=100.0
    maximumThrowSpeed=500.0
    speedFromHoldingPerSec=800.0
    AddedPitch=0

    //** Functionality **//
	bWaitForRelease = true // Set to true for non automatic weapons

    //** Animation **//
    // Rates
    FireAnimRate=1.0
    // Set the fire rate to something ridiculously high since we manually set the next fire time
    // each time you bring up another explosive
    FireRate=50.0//1.0
    TweenTime=0.01
    // Firing
    FireAnim=Toss
	PreFireAnim=Underhand_Pull_Pin

    //** Effects **//
    //FlashEmitterClass=class'ROMuzzleFlash1st'
    //SmokeEmitterClass = class'ROEffects.ROMuzzleSmoke'

    //** Bot/AI **//
    bSplashDamage=true
    bRecommendSplashDamage=true
    bSplashJump=false
    BotRefireRate=0.5
	WarnTargetPct=+0.9
	AimError=200
    bTossed=true

    //** View shake **//
//    ShakeOffsetMag=(X=3.0,Y=1.0,Z=5.0)
//    ShakeOffsetRate=(X=1000.0,Y=1000.0,Z=1000.0)
//    ShakeOffsetTime=1.0
//    ShakeRotMag=(X=50.0,Y=50.0,Z=500.0)
//    ShakeRotRate=(X=12500.0,Y=12500.0,Z=7500.0)
//    ShakeRotTime=6.0

    bUsePreLaunchTrace=false

    //** Misc **//
    FireForce="RocketLauncherFire"  // jdf
}
