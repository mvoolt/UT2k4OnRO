//=============================================================================
// ROThrownExplosiveFire
//=============================================================================
// Base class for all explosive throwing (nades, satchels, mines, etc)
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class ROThrownExplosiveFire extends ROProjectileFire;

// speed variables, deals with objects speeds when they are thrown
var() 		float			minimumThrowSpeed;        	// minimum speed the explosive will have if just clicking, no hold time
var() 		float       	maximumThrowSpeed;    		// the maximum speed an explosive can have with holding NOT INCLUDING PAWN SPEED
var() 		float       	speedFromHoldingPerSec;     // speed increase projectile will have for each second fire button held
var() 		float       	AddedFuseTime; 				// Additional fuse time to add to compensate for the pin pull animation
var			bool			bPullAnimCompensation;		// Add time to the fuse time to compensate for the pin pull animation
//=============================================================================
// functions
//=============================================================================

// Overriden to allow players to throw explosives while prone transitioning
simulated function bool AllowFire()
{
	if( Instigator.IsLocallyControlled() && Level.Netmode == NM_Client /*&& Weapon != none*/ &&
		Weapon.AmmoAmount(ThisModeNum) < ROExplosiveWeapon(Weapon).StartFireAmmoAmount )
	{
		return true;
	}
	else
	{
   		return ( Weapon.AmmoAmount(ThisModeNum) >= AmmoPerFire);
   	}
}

// Overridden to consume ammo on the clients end
event ModeDoFire()
{
    if (!AllowFire())
        return;

    if (MaxHoldTime > 0.0)
        HoldTime = FMin(HoldTime, MaxHoldTime);

    // server
    if (Weapon.Role == ROLE_Authority)
    {
        Weapon.ConsumeAmmo(ThisModeNum, Load);
        DoFireEffect();
		HoldTime = 0;	// if bot decides to stop firing, HoldTime must be reset first
        if ( (Instigator == None) || (Instigator.Controller == None) )
			return;

        if ( AIController(Instigator.Controller) != None )
            AIController(Instigator.Controller).WeaponFireAgain(BotRefireRate, true);

        Instigator.DeactivateSpawnProtection();
    }

    // client
    if (Instigator.IsLocallyControlled())
    {
		if( !bDelayedRecoil )
      		HandleRecoil();

        ShakeView();
        PlayFiring();

        // Consume ammo on the client as well. This should prevent some of the ammo amount
        // related lag bugs
        if( Level.NetMode == NM_Client )
        {
        	// Only consume ammo client side if the ammo count hasn't been net updated yet
        	if( ROExplosiveWeapon(Weapon).StartFireAmmoAmount == Weapon.AmmoAmount(ThisModeNum) )
				Weapon.ConsumeAmmo(ThisModeNum, Load);
        }

        if( !bMeleeMode )
        {
	        if(Instigator.IsFirstPerson() && !bAnimNotifiedShellEjects )
				EjectShell();
			FlashMuzzleFlash();
	        StartMuzzleSmoke();
        }
    }
    else // server
    {
        ServerPlayFiring();
    }

    Weapon.IncrementFlashCount(ThisModeNum);

    // set the next firing time. must be careful here so client and server do not get out of sync
    if (bFireOnRelease)
    {
        if (bIsFiring)
            NextFireTime += MaxHoldTime + FireRate;
        else
            NextFireTime = Level.TimeSeconds + FireRate;
    }
    else
    {
        NextFireTime += FireRate;
        NextFireTime = FMax(NextFireTime, Level.TimeSeconds);
    }

    Load = AmmoPerFire;
    HoldTime = 0;

    if (Instigator.PendingWeapon != Weapon && Instigator.PendingWeapon != None)
    {
        bIsFiring = false;
        Weapon.PutDown();
    }

	ROExplosiveWeapon(Weapon).PostFire();
	ROPawn(Instigator).SetExplosiveHoldAnims(false);
}

event ModeTick(float dt)
{
	local ROExplosiveWeapon Exp;

	if( Weapon.Role == ROLE_Authority )
	{
		Exp = ROExplosiveWeapon(Weapon);

		if( Exp.bPrimed && HoldTime > 0 )
		{
			if( Exp.CurrentFuzeTime  > (AddedFuseTime * -1) )
			{
				Exp.CurrentFuzeTime -= dt;
			}
			else if( !Exp.bAlreadyExploded )
			{
				Exp.bAlreadyExploded = true;

				// WeaponTODO: Find a better way to prevent throwing an extra nade
				// when a nade blows up in your hand than just using up all nade ammo
		        Weapon.ConsumeAmmo(ThisModeNum, Weapon.AmmoAmount(ThisModeNum));
		        DoFireEffect();
				HoldTime = 0;
			}
		}
	}
}

event ModeHoldFire()
{
	if( Weapon.Role == ROLE_Authority && !ROExplosiveWeapon(Weapon).bHasReleaseLever)
	{
		ROExplosiveWeapon(Weapon).bPrimed = true;
	}

	ROPawn(Instigator).SetExplosiveHoldAnims(true);
}

function DoFireEffect()
{
    local Vector StartProj, StartTrace, X,Y,Z;
    local Rotator R, Aim;
    local Vector HitLocation, HitNormal;
    local Actor Other;
    local int projectileID;
    local int SpawnCount;
    local float theta;

    Instigator.MakeNoise(1.0);
    Weapon.GetViewAxes(X,Y,Z);

	StartTrace = Instigator.Location + Instigator.EyePosition();
	StartProj = StartTrace + X * ProjSpawnOffset.X;

	// check if projectile would spawn through a wall and adjust start location accordingly
	Other = Trace(HitLocation, HitNormal, StartProj, StartTrace, false);
	if (Other != none )
	{
   		StartProj = HitLocation;
	}


    Aim = AdjustAim(StartProj, AimError);

	//log("Weapon fire Aim = "$Aim$" Startproj = "$Startproj);
	//PlayerController(Instigator.Controller).ClientMessage("Weapon fire Aim = "$Aim$" Startproj = "$Startproj);

//    Instigator.ClearStayingDebugLines();
//    Instigator.DrawStayingDebugLine(StartProj, StartProj+65535* MuzzlePosition.XAxis, 0,0,255);
//    Instigator.DrawStayingDebugLine(StartProj, StartProj+65535* vector(Aim), 0,255,0);

    SpawnCount = Max(1, ProjPerFire * int(Load));

	CalcSpreadModifiers();

	AppliedSpread = Spread;

    switch (SpreadStyle)
    {
        case SS_Random:
           	X = Vector(Aim);
           	for (projectileID = 0; projectileID < SpawnCount; projectileID++)
           	{
              	R.Yaw = AppliedSpread * ((FRand()-0.5)/1.5);
              	R.Pitch = AppliedSpread * (FRand()-0.5);
              	R.Roll = AppliedSpread * (FRand()-0.5);
              	SpawnProjectile(StartProj, Rotator(X >> R));
           	}
           	break;

        case SS_Line:
           	for (projectileID = 0; projectileID < SpawnCount; projectileID++)
           	{
              	theta = AppliedSpread*PI/32768*(projectileID - float(SpawnCount-1)/2.0);
              	X.X = Cos(theta);
              	X.Y = Sin(theta);
              	X.Z = 0.0;
              	SpawnProjectile(StartProj, Rotator(X >> Aim));
           	}
           	break;

        default:
           	SpawnProjectile(StartProj, Aim);
    }

    // Nade blew up in hand, kill the holder if they aren't already
    if( ROExplosiveWeapon(Weapon).bAlreadyExploded )
    {
		if( ROPawn(Weapon.Instigator) != none )
			ROPawn(Weapon.Instigator).KilledSelf( ProjectileClass.default.MyDamageType );
	}
}

// Custom projectile spawning for thrown explosives
function projectile SpawnProjectile(Vector Start, Rotator Dir)
{
    local Projectile spawnedprojectile;
    local vector X, Y, Z;
    local float pawnSpeed;
    local float throwSpeed;
	local float SetFuseTime;

	Dir.Pitch += AddedPitch;			// this will increase the angle the grenade is thrown at

    // the thrower is still alive
	if( Instigator.Health > 0 )
	{
		spawnedprojectile = Spawn(ProjectileClass,Instigator.Controller,, Start, Dir); 		// we have to make owner none, otherwise we get stutter and delayed hurt on the last grenade
    }
    // the thrower is dead, so set owner to none so no one gets credit/penalty for deaths
    else
    {
    	spawnedprojectile = Spawn(ProjectileClass, none,, Start, Dir); 		// we have to make owner none, because no one will get credit for these kills
    }

	Weapon.GetViewAxes(X,Y,Z);

	if( spawnedprojectile == none )
	{
		return spawnedprojectile;
	}

	if( ROSatchelChargeProjectile(spawnedprojectile) != none && Instigator != none )
	{
		ROSatchelChargeProjectile(spawnedprojectile).InstigatorController = Instigator.Controller;
		ROSatchelChargeProjectile(spawnedprojectile).SavedInstigator = Instigator;
		ROSatchelChargeProjectile(spawnedprojectile).SavedPRI = Instigator.PlayerReplicationInfo;
	}

	// Dead man drop area
	if( Instigator.Health <= 0 )
	{
		// the grenade was active and we'll need to set the remaining fuze length
		ROThrowableExplosiveProjectile(spawnedprojectile).FuzeLengthTimer = FMax(0.1,ROExplosiveWeapon(Weapon).CurrentFuzeTime);

		// have the grenade go in the direction the instigator was going
		spawnedprojectile.Speed = VSize(Instigator.Velocity);
    	spawnedprojectile.Velocity = spawnedprojectile.Speed * Instigator.Velocity;

		return spawnedprojectile;
	}

    pawnSpeed = X dot Instigator.Velocity;

	// calculate the velocity from the hold time
	throwSpeed = HoldTime * speedFromHoldingPerSec;

	// this will determine which scalar speed to use
	spawnedprojectile.Speed = FClamp( throwSpeed, minimumThrowSpeed, maximumThrowSpeed );

    // apply the pawn's speed to the grenade
    spawnedprojectile.Speed = pawnSpeed + spawnedprojectile.Speed;
    spawnedprojectile.Velocity = spawnedprojectile.Speed * Vector(Dir);

    SetFuseTime = FMax(0.1,ROExplosiveWeapon(Weapon).CurrentFuzeTime);

    //log("Standard fuse time = "$SetFuseTime$" HoldTime = "$HoldTime);

	if( bPullAnimCompensation && HoldTime > AddedFuseTime )
	{
	 	SetFuseTime += AddedFuseTime;
	}

    //log("Final fuse time = "$SetFuseTime$" HoldTime = "$HoldTime);

    ROThrowableExplosiveProjectile(spawnedprojectile).FuzeLengthTimer = SetFuseTime;

    return spawnedprojectile;
}

function PlayPreFire()
{
    if ( Weapon.Mesh != None && Weapon.HasAnim(PreFireAnim) )
    {
        Weapon.PlayAnim(PreFireAnim, PreFireAnimRate, TweenTime);
    }
}

function ServerPlayFiring()
{
 	ROExplosiveWeapon(Weapon).InstantPrime();
 	//Weapon.PlayOwnedSound(FireSounds[Rand(FireSounds.Length)],SLOT_None,FireVolume,,,,false);
}

function PlayFiring()
{
	if ( Weapon.Mesh != None )
	{
		Weapon.PlayAnim(FireAnim, FireAnimRate, FireTweenTime);
	}

	ROExplosiveWeapon(Weapon).InstantPrime();

	//Weapon.PlayOwnedSound(FireSounds[Rand(FireSounds.Length)],SLOT_None,FireVolume,,,,false);

    ClientPlayForceFeedback(FireForce);  // jdf
}

function CalcSpreadModifiers()
{
	local float MovementPctModifier;
	local float PlayerSpeed;
	local ROPawn ROP;

    ROP = ROPawn(Instigator);

	if( ROP == none )
		return;

	PlayerSpeed = VSize(ROP.Velocity);

	/* Calc spread based on movement speed */
  	MovementPctModifier = PlayerSpeed / ROP.default.GroundSpeed;
	Spread = default.Spread + default.Spread * MovementPctModifier;

	// Make the spread crazy if your jumping
	if( Instigator.Physics == PHYS_Falling )
	{
		Spread *= 3;
	}
}

defaultproperties
{
   	// RO Vars
    minimumThrowSpeed=600.0
    maximumThrowSpeed=1000//1150.0
    speedFromHoldingPerSec=850.0
    AddedPitch=3000

    PreFireTime=0.0
    FireRate=1.0
    MaxHoldTime=0
    bModeExclusive=true
    bFireOnRelease=true

    bSplashDamage=true
    bRecommendSplashDamage=true
    BotRefireRate=0.25
    bTossed=true
}




