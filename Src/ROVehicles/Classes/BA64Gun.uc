//=============================================================================
// BA64Gun
//=============================================================================
// BA-64 top gun
//=============================================================================
// Red Orchestra Source - John Gibson
// Copyright (C) 2005 Tripwire Interactive LLC
//=============================================================================

class BA64Gun extends ROVehicleWeapon;

var		bool  bReloading;  // This MG is currently reloading
var		int	  NumMags;	   // Number of mags carried for this MG;
var()	float ReloadLength;// Length of the reload animation. Sorry for the literal, but the Hud Overlay isn't spawned on the server.

replication
{
	// Functions server can call.
	reliable if( Role==ROLE_Authority )
		ClientDoReload;

    reliable if (bNetDirty && bNetOwner && Role == ROLE_Authority)
        bReloading, NumMags;
}


// Limit the left and right movement of the turret based on the rotation of the vehicle
simulated function int LimitYaw(int yaw)
{
    local int NewYaw;
    local int VehYaw;

    if ( !bLimitYaw )
    {
        return yaw;
    }

    VehYaw = VehicleWeaponPawn(Owner).GetVehicleBase().Rotation.Yaw;

    NewYaw = yaw;

   	if(yaw > VehYaw + MaxPositiveYaw )
   	{
   		NewYaw = VehYaw + MaxPositiveYaw;
   	}
   	else if( yaw < VehYaw + MaxNegativeYaw )
   	{
   		NewYaw = VehYaw + MaxNegativeYaw;
  	}

  	return NewYaw;
}

// Returns true if this weapon is ready to fire
simulated function bool ReadyToFire(bool bAltFire)
{
	if( bReloading )
		return false;

	return super.ReadyToFire(bAltFire);
}

function CeaseFire(Controller C, bool bWasAltFire)
{
	super.CeaseFire(C, bWasAltFire);

	if( !bReloading && !HasAmmo(0) )
		HandleReload();
}

function HandleReload()
{
	if( NumMags > 0 && !bReloading)
	{
		bReloading = true;
		NumMags--;
		ClientDoReload();
		NetUpdateTime = Level.TimeSeconds - 1;

		//log("Reloading duration = "$VehicleWeaponPawn(Owner).HUDOverlay.GetAnimDuration('reload', 1.0));
		//SetTimer(VehicleWeaponPawn(Owner).HUDOverlay.GetAnimDuration('reload', 1.0), false);
        SetTimer(ReloadLength, false);
	}
}

// Play the reload animation on the client
simulated function ClientDoReload()
{
    if(Owner != none && VehicleWeaponPawn(Owner) != none && VehicleWeaponPawn(Owner).HUDOverlay != none )
		VehicleWeaponPawn(Owner).HUDOverlay.PlayAnim('Reload');
}

simulated function Timer()
{
   if ( bReloading )
   {
	    if( Role == ROLE_Authority )
	    {
			bReloading=false;
			MainAmmoCharge[0] = InitialPrimaryAmmo;
			NetUpdateTime = Level.TimeSeconds - 1;
        }
   }
}

event bool AttemptFire(Controller C, bool bAltFire)
{
  	if(Role != ROLE_Authority || bForceCenterAim)
		return False;

	if (FireCountdown <= 0)
	{
		CalcWeaponFire(bAltFire);
		if (bCorrectAim)
			WeaponFireRotation = AdjustAim(bAltFire);

		if( bAltFire )
		{
			if( AltFireSpread > 0 )
				WeaponFireRotation = rotator(vector(WeaponFireRotation) + VRand()*FRand()*AltFireSpread);
		}
		else if (Spread > 0)
		{
			WeaponFireRotation = rotator(vector(WeaponFireRotation) + VRand()*FRand()*Spread);
		}

        DualFireOffset *= -1;

		Instigator.MakeNoise(1.0);
		if (bAltFire)
		{
			if( !ConsumeAmmo(2) )
			{
				VehicleWeaponPawn(Owner).ClientVehicleCeaseFire(bAltFire);
				return false;
			}
			FireCountdown = AltFireInterval;
			AltFire(C);
		}
		else
		{
			if( bMultipleRoundTypes )
			{
				if (ProjectileClass == PrimaryProjectileClass)
				{
					if( !ConsumeAmmo(0) )
					{
						VehicleWeaponPawn(Owner).ClientVehicleCeaseFire(bAltFire);
						return false;
					}
			    }
			    else if (ProjectileClass == SecondaryProjectileClass)
			    {
					if( !ConsumeAmmo(1) )
					{
						VehicleWeaponPawn(Owner).ClientVehicleCeaseFire(bAltFire);
						return false;
					}
			    }
			}
			else if( !ConsumeAmmo(0) )
			{
				VehicleWeaponPawn(Owner).ClientVehicleCeaseFire(bAltFire);
				HandleReload();
				return false;
			}

			FireCountdown = FireInterval;
		    Fire(C);
		}
		AimLockReleaseTime = Level.TimeSeconds + FireCountdown * FireIntervalAimLock;

	    return True;
	}

	return False;
}

// Fill the ammo up to the initial ammount
function bool GiveInitialAmmo()
{
	local bool bDidResupply;

	if( NumMags != default.NumMags )
	{
		bDidResupply = true;
	}

	MainAmmoCharge[0] = InitialPrimaryAmmo;
	MainAmmoCharge[1] = InitialSecondaryAmmo;
	AltAmmoCharge = InitialAltAmmo;
	NumMags = default.NumMags;

	return bDidResupply;
}

simulated function int getNumMags()
{
    return NumMags;
}

defaultproperties
{
	Mesh=SkeletalMesh'allies_ba64_anm.BA64_turret_ext'
	BeginningIdleAnim=com_idle_close
	YawBone=turret
	YawStartConstraint=0
	YawEndConstraint=65535
	PitchUpLimit=10000
	PitchDownLimit=50000/
	PitchBone=mg_base
	GunnerAttachmentBone=com_attachment
	ProjectileClass = class'ROInventory.DP28Bullet'
	AmbientEffectEmitterClass=class'VehicleMGEmitterBA'
    FireInterval=0.1 // 600 rpm
	AltFireInterval=0.1 // 600 rpm
	FireSoundClass=sound'Inf_Weapons.dt_fire_loop'
	SoundVolume=255
	AmbientSoundScaling=3.0//1.3
	FireEndSound=sound'Inf_Weapons.dt.dt_fire_end'
	// Shake shake shake - Ramm
	ShakeOffsetMag=(X=0.5,Y=0.0,Z=0.2)
	ShakeOffsetRate=(X=500.0,Y=500.0,Z=500.0)
	ShakeOffsetTime=2
	ShakeRotMag=(X=25.0,Y=0.0,Z=10.0)
	ShakeRotRate=(X=5000.0,Y=5000.0,Z=5000.0)
	ShakeRotTime=2
	FireForce="minifireb"
	bIsRepeatingFF=True
	bAmbientFireSound=True
	WeaponFireAttachmentBone=Tip
	WeaponFireOffset=10//40//25.0
	bAimable=True
	DamageType=class'ROVehMountedMGDamType'
	DamageMin=25
	DamageMax=25
	Spread=0.03//0.01
	RotationsPerSecond=2.0
	bInstantRotation=true
	bDoOffsetTrace=true
	TraceRange=15000

 	AIInfo[0]=(bLeadTarget=true,bFireOnRelease=true,AimError=800,RefireRate=0.07058)
	//AIInfo(0)=(bInstantHit=true,AimError=750)
	CullDistance=8000.0

	bUsesTracers=true
	mTracerInterval=0.3
	DummyTracerClass=class'ROInventory.DP28ClientTracer'

	// ROVehicleWeapon Vars
	bLimitYaw = false

	// Collision settings we need to do driver hit detection
	bCollideActors=True
	bCollideWorld=False
    bProjTarget=True
	bBlockActors=True
	bBlockNonZeroExtentTraces=True
	bBlockZeroExtentTraces=True
	bWorldGeometry=False

	VehHitpoints(0)=(PointRadius=10.0,PointHeight=0.0,PointScale=1.0,PointBone=Turret_Placement1,PointOffset=(X=3.0,Y=0.0,Z=20.0))

	// Ammo
	InitialPrimaryAmmo=60
	NumMags=15
	ReloadLength=9.6

	bIsMountedTankMG=true
	hudAltAmmoIcon=Texture'InterfaceArt_tex.HUD.dp27_ammo'

	CustomPitchUpLimit=3500
	CustomPitchDownLimit=63500
}
