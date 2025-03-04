//=============================================================================
// MG42Fire
//=============================================================================
// Bullet firing class for the MG42 Machine Gun
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class MG42Fire extends ROMGAutomaticFire;

// So we don't have to cast 1200 times per minute :)
var MG42Weapon MGWeapon;

simulated function PostBeginPlay()
{
	super.PostBeginPlay();

	MGWeapon = MG42Weapon(Weapon);
}

event ModeDoFire()
{
	Super.ModeDoFire();

	if( Level.NetMode != NM_DedicatedServer )
		MGWeapon.UpdateAmmoBelt();
}

defaultproperties
{
	//** Ammo properties **//
    AmmoClass=class'MG100Rd792x57Ammo'
    AmmoPerFire=1

    //** Projectile firing **//
    ProjectileClass = class'ROMG34Bullet'
	ServerProjectileClass = class'MG34bullet_S'
    ProjSpawnOffset=(X=25,Y=0,Z=0)
    FAProjSpawnOffset=(X=-145,Y=-15,Z=-15)
    SpreadStyle=SS_Random
	Spread = 350//750

    //** Tracers **//
	DummyTracerClass=class'ROInventory.MG34ClientTracer'
  	bUsesTracers=true
	TracerFrequency=4

    //** Recoil **//
  	maxVerticalRecoilAngle=600//800
  	maxHorizontalRecoilAngle=300//650

    //** Functionality **//
	bWaitForRelease = false // Set to true for non automatic weapons

    //** Animation **//
    // Rates
    FireAnimRate=1.0
    FireRate = 0.05	// 1200 rpm !!!!
    TweenTime=0.0
    // Firing
    FireAnim=Shoot_Loop
    FireIronAnim=Shoot_Loop
    FireLoopAnim = Shoot_Loop
    FireIronLoopAnim=Shoot_Loop
    FireEndAnim=Shoot_end
    FireIronEndAnim=Shoot_end

    //** Sounds **//
  	AmbientFireSound = sound'Inf_Weapons.mg42_fire_loop'
    AmbientFireVolume=255
    AmbientFireSoundRadius=750.0
    FireEndSound=sound'Inf_Weapons.mg42_fire_end'

    //** Effects **//
    FlashEmitterClass=class'ROEffects.MuzzleFlash1stMG'
    SmokeEmitterClass = class'ROEffects.ROMuzzleSmoke'
    ShellEjectClass=class'ROAmmo.ShellEject1st762x54mm'
    ShellIronSightOffset=(X=15,Y=0,Z=-6)
	ShellRotOffsetIron=(Pitch=-1500,Yaw=0,Roll=0)
    ShellRotOffsetHip=(Pitch=0,Yaw=0,Roll=0)

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
    ShakeOffsetTime=2
    ShakeRotMag=(X=25.0,Y=25.0,Z=25.0)
    ShakeRotRate=(X=5000.0,Y=5000.0,Z=5000.0)
    ShakeRotTime=1.75

    //** Recoil modifiers **//
    RecoilRate=0.04

    //** Misc **//
    FireForce="AssaultRifleFire"  // jdf
    PackingThresholdTime = 0.12
}
