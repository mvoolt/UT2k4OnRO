//===================================================================
// T60Cannon
//
// Copyright (C) 2005 John "Ramm-Jaeger"  Gibson
//
// T60 tank cannon class
//===================================================================
class T60Cannon extends ROTankCannon;

var		int	  NumMags;  // Number of mags carried for the Coax MG;

//=============================================================================
// Replication
//=============================================================================

replication
{
    reliable if (bNetDirty && bNetOwner && Role == ROLE_Authority)
        NumMags;

	// Functions the server calls on the client side.
	reliable if( Role==ROLE_Authority )
		ClientDoCannonReload;
}

simulated function int PrimaryAmmoCount()
{
   	return NumMags;
}

function HandleCannonReload()
{
	if( NumMags > 0  && CannonReloadState != CR_Empty )
	{
		ClientDoCannonReload();
		NumMags--;
		MainAmmoCharge[0] = InitialPrimaryAmmo;
		NetUpdateTime = Level.TimeSeconds - 1;

	    CannonReloadState = CR_Empty;
	    SetTimer(0.01, false);
	}
}

// Set the fire countdown client side
simulated function ClientDoCannonReload()
{
    CannonReloadState = CR_Empty;
    SetTimer(0.01, false);
}

// Returns true if this weapon is ready to fire
simulated function bool ReadyToFire(bool bAltFire)
{
	local int Mode;

    if( CannonReloadState != CR_ReadyToFire )
    {
		return false;
    }

	if(	bAltFire )
		Mode = 2;
	else if (ProjectileClass == PrimaryProjectileClass)
        Mode = 0;
    else if (ProjectileClass == SecondaryProjectileClass)
        Mode = 1;

	if( HasAmmo(Mode) )
		return true;

	return false;
}


//do effects (muzzle flash, force feedback, etc) immediately for the weapon's owner (don't wait for replication)
simulated event OwnerEffects()
{
	// Stop the firing effects it we shouldn't be able to fire
	if( (Role < ROLE_Authority) && !ReadyToFire(bIsAltFire) )
	{
		VehicleWeaponPawn(Owner).ClientVehicleCeaseFire(bIsAltFire);
	}

	if (!bIsRepeatingFF)
	{
		if (bIsAltFire)
			ClientPlayForceFeedback( AltFireForce );
		else
			ClientPlayForceFeedback( FireForce );
	}
    ShakeView(bIsAltFire);

	if( Level.NetMode == NM_Standalone && bIsAltFire)
	{
		if (AmbientEffectEmitter != None)
			AmbientEffectEmitter.SetEmitterStatus(true);
	}

	if (Role < ROLE_Authority)
	{
		if (bIsAltFire)
			FireCountdown = AltFireInterval;
		else
			FireCountdown = FireInterval;

		AimLockReleaseTime = Level.TimeSeconds + FireCountdown * FireIntervalAimLock;

        FlashMuzzleFlash(bIsAltFire);

		if (AmbientEffectEmitter != none && bIsAltFire)
			AmbientEffectEmitter.SetEmitterStatus(true);

        if (bIsAltFire)
		{
            if( !bAmbientAltFireSound )
		    	PlaySound(AltFireSoundClass, SLOT_None, FireSoundVolume/255.0,, AltFireSoundRadius,, false);
		    else
		    {
			    SoundVolume = AltFireSoundVolume;
	            SoundRadius = AltFireSoundRadius;
				AmbientSoundScaling = AltFireSoundScaling;
		    }
        }
		else if (!bAmbientFireSound)
        {
            PlaySound(CannonFireSound[Rand(3)], SLOT_None, FireSoundVolume/255.0,, FireSoundRadius,, false);
        }
	}
}

simulated function ClientStartFire(Controller C, bool bAltFire)
{
    bIsAltFire = bAltFire;

	if( CannonReloadState == CR_ReadyToFire && FireCountdown <= 0 )
	{
		if (bIsRepeatingFF)
		{
			if (bIsAltFire)
				ClientPlayForceFeedback( AltFireForce );
			else
				ClientPlayForceFeedback( FireForce );
		}
		OwnerEffects();
	}
}

event bool AttemptFire(Controller C, bool bAltFire)
{
  	if(Role != ROLE_Authority || bForceCenterAim)
		return False;

	if ( CannonReloadState == CR_ReadyToFire && FireCountdown <= 0 )
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
				HandleReload();
				return false;
			}

			FireCountdown = AltFireInterval;
			AltFire(C);

			if( AltAmmoCharge < 1 )
				HandleReload();
		}
		else
		{
			if( !ConsumeAmmo(0) )
			{
				VehicleWeaponPawn(Owner).ClientVehicleCeaseFire(bAltFire);

                HandleCannonReload();
				return false;
			}
			FireCountdown = FireInterval;
		    Fire(C);

			if( MainAmmoCharge[0] < 1 )
				HandleCannonReload();
		}
		AimLockReleaseTime = Level.TimeSeconds + FireCountdown * FireIntervalAimLock;

	    return True;
	}

	return False;
}

simulated event FlashMuzzleFlash(bool bWasAltFire)
{
    if (Role == ROLE_Authority)
    {
    	FlashCount++;
    	NetUpdateTime = Level.TimeSeconds - 1;
    }
    else
        CalcWeaponFire(bWasAltFire);

    if (FlashEmitter != none && !bWasAltFire)
        FlashEmitter.Trigger(Self, Instigator);

    if ( (EffectEmitterClass != None) && EffectIsRelevant(Location,false) )
        EffectEmitter = spawn(EffectEmitterClass, self,, WeaponFireLocation, WeaponFireRotation);

    if (bUsesTracers && (!bWasAltFire && !bAltFireTracersOnly || bWasAltFire))
		UpdateTracer();
}

simulated function Tick(float Delta)
{
    Super(ROVehicleWeapon).Tick(Delta);
}

defaultproperties
{
    Mesh=Mesh'allies_t60_anm.T60_turret_ext'
    skins(0)=Texture'allies_vehicles_tex.ext_vehicles.T60_ext'
    skins(1)=Texture'allies_vehicles_tex.int_vehicles.T60_int'
	HighDetailOverlay=Material'allies_vehicles_tex.int_vehicles.T60_int_s'
	bUseHighDetailOverlayIndex=true
	HighDetailOverlayIndex=1
    BeginningIdleAnim=com_idle_close
    YawBone=turret//_placement1
    YawStartConstraint=0
    YawEndConstraint=65535
    PitchBone=gun
    PitchUpLimit=15000
    PitchDownLimit=45000
	CustomPitchUpLimit=6000
	CustomPitchDownLimit=64500
	CannonFireSound(0)=sound'Vehicle_Weapons.T60.tnshk20_fire01'
	CannonFireSound(1)=sound'Vehicle_Weapons.T60.tnshk20_fire02'
	CannonFireSound(2)=sound'Vehicle_Weapons.T60.tnshk20_fire03'

    FireForce="Explosion05"
    ProjectileClass=class'ROVehicles.T60CannonShell'
    // TODO: Replace this with a proper effect emitter
	FlashEmitterClass=class'ROEffects.MuzzleFlash3rdKar'
    FireInterval=0.3
    FireSoundVolume=512
    AltFireProjectileClass=class'ROInventory.DP28Bullet'
    AltFireInterval=0.1
    AmbientEffectEmitterClass=class'TankMGEmitter'
    bAmbientEmitterAltFireOnly=true
    AltFireOffset=(X=-30.0,Y=-20.0,Z=0.0)
	AltFireSoundClass=sound'Inf_Weapons.dt_fire_loop'
	AltFireSoundScaling=3.0
	AltFireEndSound=sound'Inf_Weapons.dt.dt_fire_end'
	bAmbientAltFireSound=true
	bAltFireTracersOnly=true
	bUsesTracers=true
	mTracerInterval=0.3
	DummyTracerClass=class'ROInventory.DP28ClientTracer'
    AltShakeOffsetMag=(X=1.0,Y=1.0,Z=1.0)
    AltShakeOffsetRate=(X=1000.0,Y=1000.0,Z=1000.0)
    AltShakeOffsetTime=2
    AltShakeRotMag=(X=50.0,Y=50.0,Z=50.0)
    AltShakeRotRate=(X=10000.0,Y=10000.0,Z=10000.0)
    AltShakeRotTime=2
    ShakeRotMag=(X=75.0,Y=75.0,Z=75.0)
    ShakeRotRate=(X=10000.0,Y=10000.0,Z=10000.0)
    ShakeRotTime=3
    ShakeOffsetMag=(X=2.0,Y=2.0,Z=2.0)
    ShakeOffsetRate=(X=1000.0,Y=1000.0,Z=1000.0)
    ShakeOffsetTime=4
    WeaponFireAttachmentBone=barrel//gun
    WeaponFireOffset=65.0
    bAimable=True
    RotationsPerSecond=0.07 // 14 seconds to rotate 360
    AIInfo(0)=(bLeadTarget=true,bTrySplash=False,WarnTargetPct=0.75,RefireRate=0.5)
	AIInfo(1)=(bLeadTarget=true,bTrySplash=False,AimError=600,WarnTargetPct=0.75,RefireRate=0.015)
    //Spread=0.015
    Spread=0.0

    MaxDriverHitAngle=2.8

    // RO Vehicle sound vars
    ReloadSoundOne=Sound'Vehicle_reloads.Reloads.T60_reload_01'
    ReloadSoundTwo=sound'Vehicle_reloads.Reloads.T60_reload_02'
    ReloadSoundThree=sound'Vehicle_reloads.Reloads.T60_reload_03'
    ReloadSoundFour=sound'Vehicle_reloads.Reloads.T60_reload_04'
    RotateSound=Sound'Vehicle_Weapons.Turret.manual_turret_traverse'

    bMultipleRoundTypes=false


	VehHitpoints(0)=(PointRadius=8.0,PointHeight=0.0,PointScale=1.0,PointBone=com_player,PointOffset=(X=0.0,Y=0.0,Z=17.0))
	VehHitpoints(1)=(PointRadius=15.0,PointHeight=0.0,PointScale=1.0,PointBone=com_player,PointOffset=(X=0.0,Y=0.0,Z=-5.0))

	GunnerAttachmentBone=com_attachment

	RangeSettings(0)=0
	RangeSettings(1)=400
	RangeSettings(2)=600
	RangeSettings(3)=800
	RangeSettings(4)=1000

	// Ammo
	InitialPrimaryAmmo=58
	InitialAltAmmo=60
	ReloadSound=sound'Vehicle_reloads.DT_ReloadHidden'
	NumMags=13
	NumAltMags=15

	bPrimaryIgnoreFireCountdown=false
}
