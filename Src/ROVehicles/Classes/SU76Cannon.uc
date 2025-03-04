//===================================================================
// SU76Cannon
//
// Copyright (C) 2005 John "Ramm-Jaeger"  Gibson
//
// SU76 tank destroyer cannon class
//===================================================================
class SU76Cannon extends ROTankCannon;

// Limit the left and right movement of the driver
simulated function int LimitYaw(int yaw)
{
    local int NewYaw;
	local ROVehicleWeaponPawn PwningPawn;

    PwningPawn = ROVehicleWeaponPawn(Owner);

    if ( !bLimitYaw )
    {
        return yaw;
    }

    NewYaw = yaw;

    if( PwningPawn != none )
    {
	   	if( yaw > PwningPawn.DriverPositions[PwningPawn.DriverPositionIndex].ViewPositiveYawLimit)
	   	{
	   		NewYaw = PwningPawn.DriverPositions[PwningPawn.DriverPositionIndex].ViewPositiveYawLimit;
	   	}
	   	else if( yaw < PwningPawn.DriverPositions[PwningPawn.DriverPositionIndex].ViewNegativeYawLimit )
	   	{
	   		NewYaw = PwningPawn.DriverPositions[PwningPawn.DriverPositionIndex].ViewNegativeYawLimit;
	  	}
  	}
  	else
  	{
	   	if( yaw > MaxPositiveYaw )
	   	{
	   		NewYaw = MaxPositiveYaw;
	   	}
	   	else if( yaw < MaxNegativeYaw )
	   	{
	   		NewYaw = MaxNegativeYaw;
	  	}
  	}

  	return NewYaw;
}

// Ovveriden for slighly different animation handling
simulated event FlashMuzzleFlash(bool bWasAltFire)
{
 	local ROVehicleWeaponPawn OwningPawn;

    if (Role == ROLE_Authority)
    {
        if (bWasAltFire)
            FiringMode = 1;
        else
            FiringMode = 0;
    	FlashCount++;
    	NetUpdateTime = Level.TimeSeconds - 1;
    }
    else
        CalcWeaponFire(bWasAltFire);

    if (bUsesTracers && (!bWasAltFire && !bAltFireTracersOnly || bWasAltFire))
		UpdateTracer();

	if( bWasAltFire )
		return;

    if (FlashEmitter != None)
        FlashEmitter.Trigger(Self, Instigator);

    if ( (EffectEmitterClass != None) && EffectIsRelevant(Location,false) )
        EffectEmitter = spawn(EffectEmitterClass, self,, WeaponFireLocation, WeaponFireRotation);

    if ( (CannonDustEmitterClass != None) && EffectIsRelevant(Location,false) )
        CannonDustEmitter = spawn(CannonDustEmitterClass, self,, Base.Location, Base.Rotation);

	OwningPawn = ROVehicleWeaponPawn(Instigator);

	if( OwningPawn != none && OwningPawn.DriverPositionIndex > 1)
	{
		if( HasAnim(TankShootOpenAnim))
			PlayAnim(TankShootOpenAnim);
	}
	else if( HasAnim(TankShootClosedAnim))
	{
		PlayAnim(TankShootClosedAnim);
	}
}

defaultproperties
{
    Mesh=Mesh'allies_su76_anm.SU76_turret_ext'
    skins(0)=Texture'allies_vehicles_tex.ext_vehicles.SU76_ext'
    skins(1)=Texture'allies_vehicles_tex.int_vehicles.SU76_int'
	HighDetailOverlay=Material'allies_vehicles_tex.int_vehicles.SU76_int_s'
	bUseHighDetailOverlayIndex=true
	HighDetailOverlayIndex=1
    BeginningIdleAnim=com_idle_close
    YawBone=turret
    YawStartConstraint=-4000// -3000  - needed to make this slightly bigger than the ViewPositive/Negative Yaw limits of the pawn due discrepencies on a network server that would cause the "stug bug" of the gun not shooting where aimed
    YawEndConstraint=4000//3000
    PitchBone=gun
    PitchUpLimit=15000
    PitchDownLimit=45000
	CustomPitchUpLimit=6000
	CustomPitchDownLimit=63500
	CannonFireSound(0)=sound'Vehicle_Weapons.SU_76.76mm_fire01'
	CannonFireSound(1)=sound'Vehicle_Weapons.SU_76.76mm_fire02'
	CannonFireSound(2)=sound'Vehicle_Weapons.SU_76.76mm_fire03'
    FireForce="Explosion05"
    ProjectileClass=class'ROVehicles.SU76CannonShell'
    PrimaryProjectileClass=class'ROVehicles.SU76CannonShell'
    SecondaryProjectileClass=class'ROVehicles.SU76CannonShellHE'
	EffectEmitterClass=class'ROEffects.TankCannonFireEffect'
    FireInterval=6
    FireSoundVolume=512
    ShakeRotMag=(Z=250)
    ShakeRotRate=(Z=2500)
    ShakeRotTime=6
    ShakeOffsetMag=(Z=10)
    ShakeOffsetRate=(Z=200)
    ShakeOffsetTime=10
    WeaponFireAttachmentBone=gun
    WeaponFireOffset=200.0
    bAimable=True
    RotationsPerSecond=0.05 // 20 seconds to rotate 360
    AIInfo(0)=(bLeadTarget=true,bTrySplash=False,WarnTargetPct=0.75,RefireRate=0.5)
	AIInfo(1)=(bLeadTarget=true,bTrySplash=False,AimError=600,WarnTargetPct=0.75,RefireRate=0.015)
    //Spread=0.015
    Spread=0.0

	// ROVehicleWeapon Vars
	MaxPositiveYaw = 3000
	MaxNegativeYaw = -3000
	bLimitYaw = true

    // RO Vehicle sound vars
    ReloadSoundOne=Sound'Vehicle_reloads.Reloads.SU_76_Reload_01'
    ReloadSoundTwo=Sound'Vehicle_reloads.Reloads.SU_76_Reload_02'
    ReloadSoundThree=Sound'Vehicle_reloads.Reloads.SU_76_Reload_03'
    ReloadSoundFour=Sound'Vehicle_reloads.Reloads.SU_76_Reload_04'
    RotateSound=Sound'Vehicle_Weapons.Turret.manual_gun_traverse'

	VehHitpoints(0)=(PointRadius=10.0,PointHeight=0.0,PointScale=1.0,PointBone=com_attachment,PointOffset=(X=-3.0,Y=0.0,Z=42.0))
	VehHitpoints(1)=(PointRadius=20.0,PointHeight=0.0,PointScale=1.0,PointBone=com_attachment,PointOffset=(X=-4.0,Y=0.0,Z=17.0))

	GunnerAttachmentBone=com_attachment

	RangeSettings(0)=0
	RangeSettings(1)=100
	RangeSettings(2)=200
	RangeSettings(3)=300
	RangeSettings(4)=400
	RangeSettings(5)=500
	RangeSettings(6)=600
	RangeSettings(7)=700
	RangeSettings(8)=800
	RangeSettings(9)=900
	RangeSettings(10)=1000
	RangeSettings(11)=1200
	RangeSettings(12)=1400
	RangeSettings(13)=1600
	RangeSettings(14)=1800
	RangeSettings(15)=2000
	RangeSettings(16)=2200
	RangeSettings(17)=2400
	RangeSettings(18)=2600
	RangeSettings(19)=2800
	RangeSettings(20)=3000
	RangeSettings(21)=3200
	RangeSettings(22)=3400
	RangeSettings(23)=3600
	RangeSettings(24)=3800
	RangeSettings(25)=4000

	// Ammo
	InitialPrimaryAmmo=30
	InitialSecondaryAmmo=30
}
