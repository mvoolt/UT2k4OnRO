//=============================================================================
// NebelGranate39TossFire
//=============================================================================
// grenade toss firing class for the German NebelHandGranate 39 smoke grenade
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2006 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class NebelGranate39TossFire extends StielGranateTossFire;

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
			}
		}
	}
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
}


defaultproperties
{
	//** Ammo properties **//
    AmmoClass=class'NebelGranate39Ammo'
    AmmoPerFire=1

    //** Projectile firing **//
    ProjectileClass = class'NebelGranate39Projectile'
    MaxHoldTime=4.95

    //** Effects **//
    //FlashEmitterClass=class'ROMuzzleFlash1st'
    //SmokeEmitterClass = class'ROEffects.ROMuzzleSmoke'

    //** Bot/AI **//
    bSplashDamage=false
    bRecommendSplashDamage=false
    bSplashJump=false
    BotRefireRate=0.5
	WarnTargetPct=+0.9
	AimError=200
    bTossed=true
}
