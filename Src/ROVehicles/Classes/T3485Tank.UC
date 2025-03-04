//===================================================================
// T3485Tank
//
// Copyright (C) 2004 John "Ramm-Jaeger"  Gibson
//
// Mighty Russian T34 tank
//===================================================================
class T3485Tank extends ROTreadCraft;

#exec OBJ LOAD FILE=..\Animations\allies_t3485_anm.ukx

simulated function SetupTreads()
{
	LeftTreadPanner = VariableTexPanner(Level.ObjectPool.AllocateObject(class'VariableTexPanner'));
	if ( LeftTreadPanner != None )
	{
		LeftTreadPanner.Material = Skins[1];
		LeftTreadPanner.PanDirection = rot(0, 0, 16384);
		LeftTreadPanner.PanRate = 0.0;
		Skins[1] = LeftTreadPanner;
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

    L.AddPrecacheMaterial(Material'allies_vehicles_tex.ext_vehicles.T3485_ext');
    L.AddPrecacheMaterial(Material'allies_vehicles_tex.Treads.T3485_treads');
    L.AddPrecacheMaterial(Material'allies_vehicles_tex.int_vehicles.T3485_int');
    L.AddPrecacheMaterial(Material'allies_vehicles_tex.int_vehicles.T3485_int_s');
}

simulated function UpdatePrecacheMaterials()
{
    Level.AddPrecacheMaterial(Material'allies_vehicles_tex.ext_vehicles.T3485_ext');
    Level.AddPrecacheMaterial(Material'allies_vehicles_tex.Treads.T3485_treads');
    Level.AddPrecacheMaterial(Material'allies_vehicles_tex.int_vehicles.T3485_int');
    Level.AddPrecacheMaterial(Material'allies_vehicles_tex.int_vehicles.T3485_int_s');

	Super.UpdatePrecacheMaterials();
}

defaultproperties
{
	// Display
	Mesh=Mesh'allies_t3485_anm.t3485_body_ext'

	DriveAnim=Vt3485_driver_idle_close
	BeginningIdleAnim=driver_hatch_idle_close

	Skins(0)=Texture'allies_vehicles_tex.ext_vehicles.T3485_ext'
	Skins(1)=Texture'allies_vehicles_tex.Treads.T3485_treads'
	Skins(2)=Texture'allies_vehicles_tex.Treads.T3485_treads'
	Skins(3)=Texture'allies_vehicles_tex.int_vehicles.T3485_int'

	HighDetailOverlay=Material'allies_vehicles_tex.int_vehicles.T3485_int_s'
	bUseHighDetailOverlayIndex=true
	HighDetailOverlayIndex=3

    // Hud stuff
	VehicleHudImage=Texture'InterfaceArt_tex.Tank_Hud.t3485_body'
	VehicleHudTurret=TexRotator'InterfaceArt_tex.Tank_Hud.t3485_turret_rot'
	VehicleHudTurretLook=TexRotator'InterfaceArt_tex.Tank_Hud.t3485_turret_rot'
	VehicleHudThreadsPosX(0)=0.37
	VehicleHudThreadsPosX(1)=0.65
	VehicleHudThreadsPosY=0.51
	VehicleHudThreadsScale=0.72
	VehicleHudEngineX=0.51
	VehicleHudOccupantsX(0)=0.44
	VehicleHudOccupantsX(1)=0.5
	VehicleHudOccupantsX(2)=0.56

	// Vehicle Params
	VehicleTeam=1;
	Health=800
	HealthMax=800
	DisintegrationHealth=-900 // -900 instead of -1000 because of high health.
	CollisionHeight=+60.0
	CollisionRadius=175
	DriverDamageMult=1.0
	TreadVelocityScale=110
	MaxDesireability=2.5

	GearRatios(0)=-0.200000
	GearRatios(1)=0.200000
	GearRatios(2)=0.350000
	GearRatios(3)=0.650000
	GearRatios(4)=0.750000
    TransRatio=0.13;

	// Weapon Attachments
	PassengerWeapons(0)=(WeaponPawnClass=class'T3485CannonPawn',WeaponBone=Turret_Placement)
	PassengerWeapons(1)=(WeaponPawnClass=class'T3485MountedTankMGPawn',WeaponBone=MG_Placement)

	// Position Info
	DriverAttachmentBone=driver_attachment
	DriverPositions(0)=(PositionMesh=Mesh'allies_t3485_anm.t3485_body_int',DriverTransitionAnim=Vt3485_driver_close,TransitionUpAnim=driver_hatch_open,ViewPitchUpLimit=0,ViewPitchDownLimit=65535,ViewPositiveYawLimit=0,ViewNegativeYawLimit=0,bExposed=false,ViewFOV=85,bDrawOverlays=true)
	DriverPositions(1)=(PositionMesh=Mesh'allies_t3485_anm.t3485_body_int',DriverTransitionAnim=Vt3485_driver_open,TransitionDownAnim=driver_hatch_close,ViewPitchUpLimit=5500,ViewPitchDownLimit=63500,ViewPositiveYawLimit=11000,ViewNegativeYawLimit=-12500,bExposed=true)

	InitialPositionIndex=0
	FPCamPos=(X=0,Y=0,Z=0)
	FPCamViewOffset=(X=0,Y=0,Z=0)
	bFPNoZFromCameraPitch=True
	TPCamLookat=(X=-50,Y=0,Z=0)
	TPCamWorldOffset=(X=0,Y=0,Z=250)
	TPCamDistance=600
	DrivePos=(X=0,Y=0,Z=0)

	// Driver overlay
	HUDOverlayClass=class'ROVehicles.T34DriverOverlay'
	HUDOverlayOffset=(X=0,Y=0,Z=0)
	HUDOverlayFOV=85

	ExitPositions(0)=(X=0,Y=-200,Z=100)
	ExitPositions(1)=(X=0,Y=200,Z=100)
	EntryPosition=(X=0,Y=0,Z=0)
	EntryRadius=375.0

	VehiclePositionString="in a T34/85"
	VehicleNameString="T34/85"

	PitchUpLimit=5000
	PitchDownLimit=60000

	// Destruction
	DestroyedVehicleMesh=StaticMesh'allies_vehicles_stc.T3485_Destroyed'
	DestructionLinearMomentum=(Min=100.000000,Max=350.000000)
	DestructionAngularMomentum=(Min=50.000000,Max=150.000000)
	DamagedEffectOffset=(X=-100,Y=20,Z=26)
	DamagedEffectScale=0.9

	// effects
	ExhaustPipes(0)=(ExhaustPosition=(X=-175,Y=30,Z=10),ExhaustRotation=(pitch=36000,yaw=0,roll=0))
	ExhaustPipes(1)=(ExhaustPosition=(X=-175,Y=-30,Z=10),ExhaustRotation=(pitch=36000,yaw=0,roll=0))
	ExhaustEffectClass=class'ROEffects.ExhaustDieselEffect'
	ExhaustEffectLowClass=class'ROEffects.ExhaustDieselEffect_simple'

	// sound
	IdleSound=sound'Vehicle_Engines.T34.t34_engine_loop'
	StartUpSound=sound'Vehicle_Engines.T34.t34_engine_start'
	ShutDownSound=sound'Vehicle_Engines.T34.t34_engine_stop'
	MaxPitchSpeed=450

	// RO Vehicle sound vars
	LeftTreadSound=sound'Vehicle_Engines.track_squeak_L07'
	RightTreadSound=sound'Vehicle_Engines.track_squeak_L07'
	RumbleSound=sound'Vehicle_Engines.tank_inside_rumble02'
	LeftTrackSoundBone=Track_l
	RightTrackSoundBone=Track_r
	RumbleSoundBone=body

	// Wheels
	// Steering Wheels
     Begin Object Class=SVehicleWheel Name=LF_Steering
         bPoweredWheel=True
         BoneOffset=(X=35.0,Y=-10.0,Z=2.0)
         SteerType=VST_Steered
         BoneName="Steer_Wheel_LF"
         BoneRollAxis=AXIS_Y
         WheelRadius=33.000000
     End Object
     Wheels(0)=SVehicleWheel'ROVehicles.T3485Tank.LF_Steering'

     Begin Object Class=SVehicleWheel Name=RF_Steering
         bPoweredWheel=True
	    BoneOffset=(X=35.0,Y=10.0,Z=2.0)
         SteerType=VST_Steered
         BoneName="Steer_Wheel_RF"
         BoneRollAxis=AXIS_Y
         WheelRadius=33.000000
     End Object
     Wheels(1)=SVehicleWheel'ROVehicles.T3485Tank.RF_Steering'

     Begin Object Class=SVehicleWheel Name=LR_Steering
         bPoweredWheel=True
         BoneOffset=(X=-12.0,Y=-10.0,Z=2.0)
         SteerType=VST_Inverted
         BoneName="Steer_Wheel_LR"
         BoneRollAxis=AXIS_Y
         WheelRadius=33.000000
     End Object
     Wheels(2)=SVehicleWheel'ROVehicles.T3485Tank.LR_Steering'

     Begin Object Class=SVehicleWheel Name=RR_Steering
         bPoweredWheel=True
         BoneOffset=(X=-12.0,Y=10.0,Z=2.0)
         SteerType=VST_Inverted
         BoneName="Steer_Wheel_RR"
         BoneRollAxis=AXIS_Y
         WheelRadius=33.000000
     End Object
     Wheels(3)=SVehicleWheel'ROVehicles.T3485Tank.RR_Steering'
     // End Steering Wheels

     // Center Drive Wheels
     Begin Object Class=SVehicleWheel Name=Left_Drive_Wheel
         bPoweredWheel=True
         BoneOffset=(X=0.0,Y=10.0,Z=2.0)
         BoneName="Drive_Wheel_L"
         BoneRollAxis=AXIS_Y
         WheelRadius=33.000000
     End Object
     Wheels(4)=SVehicleWheel'ROVehicles.T3485Tank.Left_Drive_Wheel'

     Begin Object Class=SVehicleWheel Name=Right_Drive_Wheel
         bPoweredWheel=True
         BoneOffset=(X=0.0,Y=-10.0,Z=2.0)
         BoneName="Drive_Wheel_R"
         BoneRollAxis=AXIS_Y
         WheelRadius=33.000000
     End Object
     Wheels(5)=SVehicleWheel'ROVehicles.T3485Tank.Right_Drive_Wheel'

	// Wheel bones for animation
     LeftWheelBones(0)="Wheel_L_1"
     LeftWheelBones(1)="Wheel_L_2"
     LeftWheelBones(2)="Wheel_L_3"
     LeftWheelBones(3)="Wheel_L_4"
     LeftWheelBones(4)="Wheel_L_5"
     LeftWheelBones(5)="Wheel_L_6"
     LeftWheelBones(6)="Wheel_L_7"

     RightWheelBones(0)="Wheel_R_1"
	RightWheelBones(1)="Wheel_R_2"
	RightWheelBones(2)="Wheel_R_3"
	RightWheelBones(3)="Wheel_R_4"
	RightWheelBones(4)="Wheel_R_5"
	RightWheelBones(5)="Wheel_R_6"
	RightWheelBones(6)="Wheel_R_7"

     // Misc ONS
	FlagBone=MG_Placement// Probably not needed
	FlagRotation=(Yaw=32768)

	// debug
	//bDontUsePositionMesh = true;

	// Special hit points
	VehHitpoints(0)=(PointRadius=9.0,PointHeight=0.0,PointScale=1.0,PointBone=driver_player,PointOffset=(X=17.0,Y=0.0,Z=5.0),bPenetrationPoint=true,HitPointType=HP_Driver)
	VehHitpoints(1)=(PointRadius=40.0,PointHeight=0.0,PointScale=1.0,PointBone=body,PointOffset=(X=-90.0,Y=0.0,Z=0.0),bPenetrationPoint=false,DamageMultiplier=1.0,HitPointType=HP_Engine)
	VehHitpoints(2)=(PointRadius=25.0,PointHeight=0.0,PointScale=1.0,PointBone=body,PointOffset=(X=13.0,Y=-25.0,Z=-5.0),bPenetrationPoint=false,DamageMultiplier=5.0,HitPointType=HP_AmmoStore)
	VehHitpoints(3)=(PointRadius=25.0,PointHeight=0.0,PointScale=1.0,PointBone=body,PointOffset=(X=13.0,Y=25.0,Z=-5.0),bPenetrationPoint=false,DamageMultiplier=5.0,HitPointType=HP_AmmoStore)
	// Armor
    FrontArmorFactor=11
	SideArmorFactor=6
	RearArmorFactor=5

	TreadHitMinAngle= 1.9
}
