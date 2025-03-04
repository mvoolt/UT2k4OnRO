//=============================================================================
// PanzerFaustFire
//=============================================================================
// Rocket firing class for the PanzerFaust
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class PanzerFaustFire extends ROProjectileFire;

var 	name		FireIronAnimOne;  	// Iron Fire animation for range setting one
var 	name		FireIronAnimTwo;    // Iron Fire animation for range setting two
var 	name		FireIronAnimThree;  // Iron Fire animation for range setting three


event ModeDoFire()
{
    if ( Level.NetMode != NM_DedicatedServer )
    {
        if ( RORocketWeapon(Owner).RocketAttachment  != none)
           RORocketWeapon(Owner).RocketAttachment.Destroy();
    }

	Super.ModeDoFire();

	PanzerFaustWeapon(Weapon).PostFire();
}

function PlayFiring()
{
	local name Anim;

	if ( Weapon.Mesh != None )
	{
		if ( FireCount > 0 )
		{
			if( Weapon.bUsingSights && Weapon.HasAnim(FireIronLoopAnim))
			{
			 	Weapon.PlayAnim(FireIronLoopAnim, FireAnimRate, 0.0);
			}
			else
			{
				if ( Weapon.HasAnim(FireLoopAnim) )
				{
					Weapon.PlayAnim(FireLoopAnim, FireLoopAnimRate, 0.0);
				}
				else
				{
					Weapon.PlayAnim(FireAnim, FireAnimRate, FireTweenTime);
				}
			}
		}
		else
		{
			if( Weapon.bUsingSights )
			{
				switch(PanzerFaustWeapon(Weapon).RangeIndex)
				{
					case 0:
						Anim = FireIronAnimOne;
						break;
					case 1:
						Anim = FireIronAnimTwo;
						break;
					case 2:
						Anim = FireIronAnimThree;
						break;
				}
			 	Weapon.PlayAnim(Anim, FireAnimRate, FireTweenTime);
			}
			else
			{
				Weapon.PlayAnim(FireAnim, FireAnimRate, FireTweenTime);
			}
		}
	}

	Weapon.PlayOwnedSound(FireSounds[Rand(FireSounds.Length)],SLOT_None,FireVolume,,,,false);

    ClientPlayForceFeedback(FireForce);  // jdf

    FireCount++;
}


defaultproperties
{
	//** Ammo properties **//
    AmmoClass=class'PanzerFaustAmmo'
    AmmoPerFire=1

    //** Projectile firing **//
    ProjectileClass = class'PanzerFaustRocket'
    ProjSpawnOffset=(X=25,Y=0,Z=0)
    FAProjSpawnOffset=(X=-25,Y=-0,Z=-0)
    SpreadStyle=SS_Random
	Spread = 75

    //** Recoil **//
  	maxVerticalRecoilAngle=1000
  	maxHorizontalRecoilAngle=600

    //** Functionality **//
	bWaitForRelease = true // Set to true for non automatic weapons

    //** Animation **//
    // Rates
    FireAnimRate=1.0
    FireRate=2.6
    TweenTime=0.0
    // Firing
    FireAnim=ShootHip
    FireIronAnim=Shoot
    FireIronAnimOne=Shoot30
    FireIronAnimTwo=Shoot
    FireIronAnimThree=Shoot90

    //** Sounds **//
  	FireSounds(0) = Sound'Inf_Weapons.Panzerfaust60.panzerfaust60_fire01'
  	FireSounds(1) = Sound'Inf_Weapons.Panzerfaust60.panzerfaust60_fire02'
  	FireSounds(2) = Sound'Inf_Weapons.Panzerfaust60.panzerfaust60_fire03'

    //** Effects **//
    FlashEmitterClass=none//class'ROMuzzleFlash1st'
    SmokeEmitterClass = class'ROEffects.ROMuzzleSmoke'

    //** Bot/AI **//
    bSplashDamage=false
    bRecommendSplashDamage=false
    bSplashJump=false
    BotRefireRate=0.5
	WarnTargetPct=+0.9
	AimError=1200

    //** View shake **//
    ShakeOffsetMag=(X=3.0,Y=1.0,Z=5.0)
    ShakeOffsetRate=(X=1000.0,Y=1000.0,Z=1000.0)
    ShakeOffsetTime=1.0
    ShakeRotMag=(X=50.0,Y=50.0,Z=500.0)
    ShakeRotRate=(X=12500.0,Y=12500.0,Z=7500.0)
    ShakeRotTime=6.0

    AddedPitch=-100;
    bUsePreLaunchTrace=false

	MuzzleBone=warhead

    //** Misc **//
    FireForce="RocketLauncherFire"  // jdf
}
