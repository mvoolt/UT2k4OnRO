//===================================================================
// SU76Destroyer
//
// Copyright (C) 2005 John "Ramm-Jaeger"  Gibson
//
// SU76 Tank destroyer class
//===================================================================
class SU76Destroyer extends ROTreadCraft;

// new vehicle content
#exec OBJ LOAD FILE=..\Animations\allies_su76_anm.ukx
#exec OBJ LOAD FILE=..\textures\allies_vehicles_tex.utx
#exec OBJ LOAD FILE=..\StaticMeshes\allies_vehicles_stc.usx

simulated function SetupTreads()
{
	LeftTreadPanner = VariableTexPanner(Level.ObjectPool.AllocateObject(class'VariableTexPanner'));
	if ( LeftTreadPanner != None )
	{
		LeftTreadPanner.Material = Skins[1];
		LeftTreadPanner.PanDirection = rot(0, 0, 16384);
		LeftTreadPanner.PanRate = 0.0;
		Skins[1] = LeftTreadPanner;//1
	}
	RightTreadPanner = VariableTexPanner(Level.ObjectPool.AllocateObject(class'VariableTexPanner'));
	if ( RightTreadPanner != None )
	{
		RightTreadPanner.Material = Skins[2];
		RightTreadPanner.PanDirection = rot(0, 0, 16384);
		RightTreadPanner.PanRate = 0.0;
		Skins[2] = RightTreadPanner;
	}
}

static function StaticPrecache(LevelInfo L)
{
    Super.StaticPrecache(L);

    L.AddPrecacheMaterial(Material'allies_vehicles_tex.ext_vehicles.SU76_ext');
    L.AddPrecacheMaterial(Material'allies_vehicles_tex.int_vehicles.SU76_int');
    L.AddPrecacheMaterial(Material'allies_vehicles_tex.Treads.SU76_treads');
    L.AddPrecacheMaterial(Material'allies_vehicles_tex.int_vehicles.SU76_int_s');
}

simulated function UpdatePrecacheMaterials()
{
    Level.AddPrecacheMaterial(Material'allies_vehicles_tex.ext_vehicles.SU76_ext');
    Level.AddPrecacheMaterial(Material'allies_vehicles_tex.int_vehicles.SU76_int');
    Level.AddPrecacheMaterial(Material'allies_vehicles_tex.Treads.SU76_treads');
    Level.AddPrecacheMaterial(Material'allies_vehicles_tex.int_vehicles.SU76_int_s');

	Super.UpdatePrecacheMaterials();
}

// Overridden to fix the "invulnerable" front mantlet issue
simulated function bool ShouldPenetrate(vector HitLocation, vector HitRotation, int PenetrationNumber, optional class<DamageType> DamageType)
{
    local vector X,Y,Z;
    local float AngleFromZ;

	if (HitPenetrationPoint(HitLocation, HitRotation))
	{
		return true;
	}

    GetAxes(Rotation,X,Y,Z);
    AngleFromZ = Acos(Normal(Hitlocation - Location) dot Normal(Z)) * 57.2957795131;

    if( bDebugPenetration )
    {
        log("AngleFromZ "$AngleFromZ);
    }

    // Check to see if we hit the upper part of the tank which has very weak armor.
    if( AngleFromZ < 80 )
    {
    	if( (1 - PenetrationNumber) >= 0.01 )
			return false;
		else
		    return true;
    }
    else
    {
        return super.ShouldPenetrate(HitLocation, HitRotation, PenetrationNumber, DamageType);
    }
}


defaultproperties
{
	// Display
	Mesh=Mesh'allies_su76_anm.SU76_body_ext'

	DriveAnim=VSU76_driver_idle_close
	BeginningIdleAnim=driver_hatch_idle_close

	Skins(0)=Texture'allies_vehicles_tex.ext_vehicles.SU76_ext'
	Skins(1)=Texture'allies_vehicles_tex.Treads.SU76_treads'
	Skins(2)=Texture'allies_vehicles_tex.Treads.SU76_treads'
	Skins(3)=Texture'allies_vehicles_tex.int_vehicles.SU76_int'

	HighDetailOverlay=Material'allies_vehicles_tex.int_vehicles.SU76_int_s'
	bUseHighDetailOverlayIndex=true
	HighDetailOverlayIndex=3

    // Hud stuff
	VehicleHudImage=Texture'InterfaceArt_tex.Tank_Hud.SU76_body'
	VehicleHudTurret=TexRotator'InterfaceArt_tex.Tank_Hud.SU76_turret_rot'
	VehicleHudTurretLook=TexRotator'InterfaceArt_tex.Tank_Hud.SU76_turret_look'
	VehicleHudThreadsPosX(0)=0.36
	VehicleHudThreadsPosX(1)=0.66
	VehicleHudThreadsPosY=0.5
	VehicleHudThreadsScale=0.6
	VehicleHudEngineX=0.45
	VehicleHudEngineY=0.67
	VehicleHudOccupantsX(0)=0.5
	VehicleHudOccupantsX(1)=0.57
	VehicleHudOccupantsX(2)=none
	VehicleHudOccupantsY(0)=0.35
	VehicleHudOccupantsY(1)=0.5
	VehicleHudOccupantsY(2)=none

	// Vehicle Params
	VehicleMass=9.0
	VehicleTeam=1;
	Health=500
	HealthMax=500
	DisintegrationHealth=-1000//-125 Make this not happen for now - Ramm
	CollisionHeight=+60.0
	CollisionRadius=175.0//+60.0
	DriverDamageMult=1.0
	TreadVelocityScale=85
	MaxDesireability=1.8

	// Weapon Attachments
	PassengerWeapons(0)=(WeaponPawnClass=class'SU76CannonPawn',WeaponBone=Turret_Placement)

	// Position Info
	DriverAttachmentBone=driver_attachment
	DriverPositions(0)=(PositionMesh=Mesh'allies_su76_anm.SU76_body_int',DriverTransitionAnim=VSU76_driver_close,TransitionUpAnim=driver_hatch_open,ViewPitchUpLimit=0,ViewPitchDownLimit=65535,ViewPositiveYawLimit=0,ViewNegativeYawLimit=0,bExposed=false,ViewFOV=85,bDrawOverlays=true)
	DriverPositions(1)=(PositionMesh=Mesh'allies_su76_anm.SU76_body_int',DriverTransitionAnim=VSU76_driver_open,TransitionDownAnim=driver_hatch_close,ViewPitchUpLimit=5000,ViewPitchDownLimit=65536,ViewPositiveYawLimit=10000,ViewNegativeYawLimit=-12000,bExposed=true)
	InitialPositionIndex=0
	FPCamPos=(X=0,Y=0,Z=0)
	FPCamViewOffset=(X=0,Y=0,Z=0)
	bFPNoZFromCameraPitch=True
	TPCamLookat=(X=-50,Y=0,Z=0)
	TPCamWorldOffset=(X=0,Y=0,Z=250)
	TPCamDistance=600
	DrivePos=(X=0.0,Y=0.0,Z=0.0)

	// Driver overlay
	HUDOverlayClass=class'ROVehicles.SU76DriverOverlay'
	HUDOverlayOffset=(X=0,Y=0,Z=0)
	HUDOverlayFOV=85

	ExitPositions(0)=(X=0,Y=-200,Z=100)
	ExitPositions(1)=(X=0,Y=200,Z=100)
	EntryPosition=(X=0,Y=0,Z=0)
	EntryRadius=375.0

	VehiclePositionString="in a SU76"
	VehicleNameString="SU76"

	PitchUpLimit=5000
	PitchDownLimit=60000

	// Destruction
	DestroyedVehicleMesh=StaticMesh'allies_vehicles_stc.SU76_Destroyed'
	DestructionLinearMomentum=(Min=100.000000,Max=350.000000)
	DestructionAngularMomentum=(Min=50.000000,Max=150.000000)
	DamagedEffectOffset=(X=-100,Y=20,Z=26)
	DamagedEffectScale=0.85

 	// effects
	ExhaustPipes(0)=(ExhaustPosition=(X=-130,Y=75,Z=25),ExhaustRotation=(pitch=34000,yaw=-3000,roll=0))
	ExhaustPipes(1)=(ExhaustPosition=(X=-130,Y=85,Z=25),ExhaustRotation=(pitch=34000,yaw=-3000,roll=0))
	ExhaustEffectClass=class'ROEffects.ExhaustPetrolEffect'
	ExhaustEffectLowClass=class'ROEffects.ExhaustPetrolEffect_simple'

	// sound
	IdleSound=sound'Vehicle_Engines.SU76.SU76_engine_loop'
	StartUpSound=sound'Vehicle_Engines.SU76.SU76_engine_start'
	ShutDownSound=sound'Vehicle_Engines.SU76.SU76_engine_stop'
	MaxPitchSpeed=450

	// RO Vehicle sound vars
	LeftTreadSound=sound'Vehicle_Engines.track_squeak_L09'
	RightTreadSound=sound'Vehicle_Engines.track_squeak_R09'
	RumbleSound=sound'Vehicle_Engines.tank_inside_rumble01'
	LeftTrackSoundBone=Track_l
	RightTrackSoundBone=Track_r
	RumbleSoundBone=body

	// Wheels
	// Steering Wheels
     Begin Object Class=SVehicleWheel Name=LF_Steering
         bPoweredWheel=True
         BoneOffset=(X=35.0,Y=-5.0,Z=10.0)
         SteerType=VST_Steered
         BoneName="Steer_Wheel_LF"
         BoneRollAxis=AXIS_Y
         WheelRadius=30.000000
     End Object
     Wheels(0)=SVehicleWheel'ROVehicles.SU76Destroyer.LF_Steering'

     Begin Object Class=SVehicleWheel Name=RF_Steering
         bPoweredWheel=True
	    BoneOffset=(X=35.0,Y=5.0,Z=10.0)
         SteerType=VST_Steered
         BoneName="Steer_Wheel_RF"
         BoneRollAxis=AXIS_Y
         WheelRadius=30.000000
     End Object
     Wheels(1)=SVehicleWheel'ROVehicles.SU76Destroyer.RF_Steering'

     Begin Object Class=SVehicleWheel Name=LR_Steering
         bPoweredWheel=True
         BoneOffset=(X=-7.0,Y=-5.0,Z=10.0)
         SteerType=VST_Inverted
         BoneName="Steer_Wheel_LR"
         BoneRollAxis=AXIS_Y
         WheelRadius=30.000000
     End Object
     Wheels(2)=SVehicleWheel'ROVehicles.SU76Destroyer.LR_Steering'

     Begin Object Class=SVehicleWheel Name=RR_Steering
         bPoweredWheel=True
         BoneOffset=(X=-7.0,Y=5.0,Z=10.0)
         SteerType=VST_Inverted
         BoneName="Steer_Wheel_RR"
         BoneRollAxis=AXIS_Y
         WheelRadius=30.000000
     End Object
     Wheels(3)=SVehicleWheel'ROVehicles.SU76Destroyer.RR_Steering'
     // End Steering Wheels

     // Center Drive Wheels
     Begin Object Class=SVehicleWheel Name=Left_Drive_Wheel
         bPoweredWheel=True
         BoneOffset=(X=0.0,Y=0.0,Z=10.0)
         BoneName="Drive_Wheel_L"
         BoneRollAxis=AXIS_Y
         WheelRadius=30.000000
     End Object
     Wheels(4)=SVehicleWheel'ROVehicles.SU76Destroyer.Left_Drive_Wheel'

     Begin Object Class=SVehicleWheel Name=Right_Drive_Wheel
         bPoweredWheel=True
         BoneOffset=(X=0.0,Y=0.0,Z=10.0)
         BoneName="Drive_Wheel_R"
         BoneRollAxis=AXIS_Y
         WheelRadius=30.000000
     End Object
     Wheels(5)=SVehicleWheel'ROVehicles.SU76Destroyer.Right_Drive_Wheel'

	// Wheel bones for animation
	LeftWheelBones(0)="Wheel_L_1"
	LeftWheelBones(1)="Wheel_L_2"
	LeftWheelBones(2)="Wheel_L_3"
	LeftWheelBones(3)="Wheel_L_4"
	LeftWheelBones(4)="Wheel_L_5"
	LeftWheelBones(5)="Wheel_L_6"
	LeftWheelBones(6)="Wheel_L_7"
	LeftWheelBones(7)="Wheel_L_8"
	// Track Return wheels
	LeftWheelBones(8)="Wheel_L_9"
	LeftWheelBones(9)="Wheel_L_10"
	LeftWheelBones(10)="Wheel_L_11"

	RightWheelBones(0)="Wheel_R_1"
	RightWheelBones(1)="Wheel_R_2"
	RightWheelBones(2)="Wheel_R_3"
	RightWheelBones(3)="Wheel_R_4"
	RightWheelBones(4)="Wheel_R_5"
	RightWheelBones(5)="Wheel_R_6"
	RightWheelBones(6)="Wheel_R_7"
	RightWheelBones(7)="Wheel_R_8"
     // Track Return wheels
	RightWheelBones(8)="Wheel_R_9"
	RightWheelBones(9)="Wheel_R_10"
    RightWheelBones(10)="Wheel_R_11"
    WheelRotationScale=750


     // Misc ONS
	FlagBone=MG_Placement// Probably not needed
	FlagRotation=(Yaw=32768)

	// Special hit points
	VehHitpoints(0)=(PointRadius=9.0,PointHeight=0.0,PointScale=1.0,PointBone=driver_player,PointOffset=(X=-13.0,Y=-3.0,Z=-8.0),bPenetrationPoint=true,HitPointType=HP_Driver)
	VehHitpoints(1)=(PointRadius=35.0,PointHeight=0.0,PointScale=1.0,PointBone=body,PointOffset=(X=25.0,Y=45.0,Z=-10.0),bPenetrationPoint=false,DamageMultiplier=1.0,HitPointType=HP_Engine)
	VehHitpoints(2)=(PointRadius=25.0,PointHeight=0.0,PointScale=1.0,PointBone=body,PointOffset=(X=-80.0,Y=-40.0,Z=5.0),bPenetrationPoint=false,DamageMultiplier=5.0,HitPointType=HP_AmmoStore)

	// Armor
    FrontArmorFactor=3//4
	SideArmorFactor=1
	RearArmorFactor=0

	TreadHitMinAngle= 1.9
}
