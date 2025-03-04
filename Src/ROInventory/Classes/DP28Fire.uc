//=============================================================================
// DP28Fire
//=============================================================================
// Bullet firing class for the DP28 Machine Gun
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class DP28Fire extends ROMGAutomaticFire;

defaultproperties
{
	//** Ammo properties **//
    AmmoClass=class'DP28Ammo'
    AmmoPerFire=1

    //** Projectile firing **//
    ProjectileClass = class'DP28Bullet'
	ServerProjectileClass = class'DP28Bullet_S'
    ProjSpawnOffset=(X=25,Y=0,Z=0)
    FAProjSpawnOffset=(X=-20,Y=0,Z=0)
    SpreadStyle=SS_Random
	Spread = 250//550

    //** Shell Ejection **//
	ShellIronSightOffset=(X=15,Y=0,Z=-5)
	ShellHipOffset=(X=-20,Y=0,Z=0)
	ShellRotOffsetIron=(Pitch=0,Yaw=0,Roll=0)
    ShellRotOffsetHip=(Pitch=0,Yaw=10000,Roll=0)

    //** Tracers **//
	DummyTracerClass=class'ROInventory.DP28ClientTracer'
  	bUsesTracers=true
	TracerFrequency=3

    //** Recoil **//
  	maxVerticalRecoilAngle=750
  	maxHorizontalRecoilAngle=300//550

    //** Functionality **//
	bWaitForRelease = false // Set to true for non automatic weapons

    //** Animation **//
    // Rates
    FireAnimRate=1.0
    FireRate=0.1 // 600 RPM
    TweenTime=0.0
    // Firing
    FireAnim=Shoot_Loop
    FireIronAnim=Bipod_Shoot_Loop
    FireLoopAnim = Shoot_Loop
    FireIronLoopAnim=Bipod_Shoot_Loop
    FireEndAnim=Shoot_end
    FireIronEndAnim=Bipod_Shoot_End

    //** Sounds **//
  	AmbientFireSound = sound'Inf_Weapons.dp1927_fire_loop'
    AmbientFireVolume=255
    AmbientFireSoundRadius=750.0
    FireEndSound=sound'Inf_Weapons.dp1927_fire_end'

    //** Effects **//
    FlashEmitterClass=class'ROEffects.MuzzleFlash1stDP'
    SmokeEmitterClass = class'ROEffects.ROMuzzleSmoke'
    ShellEjectClass=class'ROAmmo.ShellEject1st762x54mmGreen'

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
    ShakeRotMag=(X=75.0,Y=50.0,Z=150.0)
    ShakeRotRate=(X=10000.0,Y=10000.0,Z=10000.0)
    ShakeRotTime=0.5

    //** Recoil modifiers **//
    RecoilRate=0.05

    //** Misc **//
    FireForce="AssaultRifleFire"  // jdf
    PackingThresholdTime = 0.12
}
