//=============================================================================
// PTRDFire
//=============================================================================
// Bullet firing class for the PTRD AntiTank rifle
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class PTRDFire extends ROBoltFire;

simulated function EjectShell()
{
	local coords EjectCoords;
	local vector EjectOffset;
	local vector X,Y,Z;
	local rotator EjectRot;
	local ROShellEject Shell;

	if( Instigator.bBipodDeployed )
	{
    	if ( ShellEjectClass != None )
    	{
			Weapon.GetViewAxes(X,Y,Z);

			EjectOffset = Instigator.Location + Instigator.EyePosition();
			EjectOffset = EjectOffset + X * ShellIronSightOffset.X + Y * ShellIronSightOffset.Y +  Z * ShellIronSightOffset.Z;

    		EjectRot = Rotator(Y);
			EjectRot.Yaw += 16384;
			Shell=Weapon.Spawn(ShellEjectClass,none,,EjectOffset,EjectRot);
			EjectRot = Rotator(Y);
			EjectRot += ShellRotOffsetIron;

			EjectRot.Yaw = EjectRot.Yaw + Shell.RandomYawRange - Rand(Shell.RandomYawRange * 2);
			EjectRot.Pitch = EjectRot.Pitch + Shell.RandomPitchRange - Rand(Shell.RandomPitchRange * 2);
			EjectRot.Roll = EjectRot.Roll + Shell.RandomRollRange - Rand(Shell.RandomRollRange * 2);

    		Shell.Velocity = (Shell.MinStartSpeed + FRand() * (Shell.MaxStartSpeed-Shell.MinStartSpeed)) * vector(EjectRot);
    	}
	}
	else
	{
	    if ( ShellEjectClass != None )
	    {
        	EjectCoords = Weapon.GetBoneCoords(ShellEmitBone);

			// Find the shell eject location then scale it down 5x (since the weapons are scaled up 5x)
			EjectOffset = EjectCoords.Origin - Weapon.Location;
        	EjectOffset = EjectOffset * 0.2;
        	EjectOffset = Weapon.Location + EjectOffset;

        	EjectOffset = EjectOffset + EjectCoords.XAxis * ShellHipOffset.X + EjectCoords.YAxis * ShellHipOffset.Y +  EjectCoords.ZAxis * ShellHipOffset.Z;

            EjectRot = Rotator(-EjectCoords.YAxis);
	    	Shell=Weapon.Spawn(ShellEjectClass,none,,EjectOffset,EjectRot);
	    	EjectRot = Rotator(EjectCoords.XAxis);
	    	EjectRot += ShellRotOffsetHip;

			EjectRot.Yaw = EjectRot.Yaw + Shell.RandomYawRange - Rand(Shell.RandomYawRange * 2);
			EjectRot.Pitch = EjectRot.Pitch + Shell.RandomPitchRange - Rand(Shell.RandomPitchRange * 2);
			EjectRot.Roll = EjectRot.Roll + Shell.RandomRollRange - Rand(Shell.RandomRollRange * 2);

			Shell.Velocity = (Shell.MinStartSpeed + FRand() * (Shell.MaxStartSpeed-Shell.MinStartSpeed)) * vector(EjectRot);
	    }
	}
}


defaultproperties
{
	//** Ammo properties **//
    AmmoClass=class'PTRDAmmo'
    AmmoPerFire=1

    //** Projectile firing **//
    ProjectileClass = class'PTRDBullet'
    ProjSpawnOffset=(X=25,Y=0,Z=0)
    FAProjSpawnOffset=(X=-225,Y=-15,Z=-15)
    SpreadStyle=SS_Random
	Spread = 75

    //** Recoil **//
  	maxVerticalRecoilAngle=750
  	maxHorizontalRecoilAngle=650

    //** Functionality **//
	bWaitForRelease = true // Set to true for non automatic weapons
    bUsePreLaunchTrace=false

    //** Animation **//
    // Rates
    FireAnimRate=1.0
    FireRate=2.4
    TweenTime=0.0
    // Firing
    FireAnim=Shoot
    FireIronAnim=Shoot

    //** Sounds **//
  	FireSounds(0) = Sound'Inf_Weapons.PTRD_fire01'
  	FireSounds(1) = Sound'Inf_Weapons.PTRD_fire02'
  	FireSounds(2) = Sound'Inf_Weapons.PTRD_fire03'

    //** Effects **//
    FlashEmitterClass=class'ROEffects.MuzzleFlash1stPTRD'
    SmokeEmitterClass = class'ROEffects.ROMuzzleSmoke'
    ShellEjectClass=class'ROAmmo.ShellEject1st14mm'
	ShellIronSightOffset=(X=10,Y=3,Z=0)
	ShellRotOffsetIron=(Pitch=-10000,Yaw=0,Roll=0)
    bAnimNotifiedShellEjects=false

    //** Bot/AI **//
    bSplashDamage=false
    bRecommendSplashDamage=false
    bSplashJump=false
    BotRefireRate=0.5
	WarnTargetPct=+0.9
	AimError=800

    //** View shake **//
    ShakeOffsetMag=(X=6.0,Y=2.0,Z=10.0)
    ShakeOffsetRate=(X=1000.0,Y=1000.0,Z=1000.0)
    ShakeOffsetTime=4.0
    ShakeRotMag=(X=100.0,Y=100.0,Z=800.0)//(X=1000.0,Y=50.0,Z=50.0)
    ShakeRotRate=(X=12500.0,Y=12500.0,Z=12500.0)
    ShakeRotTime=7.0//1.0

    //** Misc **//
    FireForce="RocketLauncherFire"  // jdf
}
