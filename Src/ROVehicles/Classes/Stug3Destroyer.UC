//===================================================================
// Stug3Destroyer
//
// Copyright (C) 2004 John "Ramm-Jaeger"  Gibson
//
// Stug3Destroyer tank class
//===================================================================
class Stug3Destroyer extends ROTreadCraft;

#exec OBJ LOAD FILE=..\Animations\axis_stug3_anm.ukx

simulated function SetupTreads()
{
	LeftTreadPanner = VariableTexPanner(Level.ObjectPool.AllocateObject(class'VariableTexPanner'));
	if ( LeftTreadPanner != None )
	{
		LeftTreadPanner.Material = Skins[1];//1
		LeftTreadPanner.PanDirection = rot(0, 0, 16384);
		LeftTreadPanner.PanRate = 0.0;
		Skins[1] = LeftTreadPanner;//1
	}
	RightTreadPanner = VariableTexPanner(Level.ObjectPool.AllocateObject(class'VariableTexPanner'));
	if ( RightTreadPanner != None )
	{
		RightTreadPanner.Material = Skins[2];//2
		RightTreadPanner.PanDirection = rot(0, 0, 16384);
		RightTreadPanner.PanRate = 0.0;
		Skins[2] = RightTreadPanner;//2
	}
}

static function StaticPrecache(LevelInfo L)
{
    Super.StaticPrecache(L);

    L.AddPrecacheMaterial(Material'axis_vehicles_tex.ext_vehicles.Stug3_ext');
    L.AddPrecacheMaterial(Material'axis_vehicles_tex.Treads.Stug3_treads');
    L.AddPrecacheMaterial(Material'axis_vehicles_tex.int_vehicles.Stug3_int');
    L.AddPrecacheMaterial(Material'axis_vehicles_tex.int_vehicles.stug3_int_s');
}

simulated function UpdatePrecacheMaterials()
{
    Level.AddPrecacheMaterial(Material'axis_vehicles_tex.ext_vehicles.Stug3_ext');
    Level.AddPrecacheMaterial(Material'axis_vehicles_tex.Treads.Stug3_treads');
    Level.AddPrecacheMaterial(Material'axis_vehicles_tex.int_vehicles.Stug3_int');
    Level.AddPrecacheMaterial(Material'axis_vehicles_tex.int_vehicles.stug3_int_s');

	Super.UpdatePrecacheMaterials();
}

defaultproperties
{
	// Display
	Mesh=Mesh'axis_stug3_anm.Stug3_body_ext'

	DriveAnim=VStug3_driver_idle_close
	BeginningIdleAnim=driver_hatch_idle_close

	Skins(0)=Texture'axis_vehicles_tex.ext_vehicles.Stug3_ext'
	Skins(1)=Texture'axis_vehicles_tex.Treads.Stug3_treads'
	Skins(2)=Texture'axis_vehicles_tex.Treads.Stug3_treads'
	Skins(3)=Texture'axis_vehicles_tex.int_vehicles.Stug3_int'

	HighDetailOverlay=Material'axis_vehicles_tex.int_vehicles.stug3_int_s'
	bUseHighDetailOverlayIndex=true
	HighDetailOverlayIndex=3

    // Hud stuff
	VehicleHudImage=Texture'InterfaceArt_tex.Tank_Hud.Stug3_body'
	VehicleHudTurret=TexRotator'InterfaceArt_tex.Tank_Hud.Stug3_turret_rot'
	VehicleHudTurretLook=TexRotator'InterfaceArt_tex.Tank_Hud.Stug3_turret_look'
    VehicleHudThreadsPosX(0)=0.37
	VehicleHudThreadsPosX(1)=0.65
	VehicleHudThreadsPosY=0.51
	VehicleHudThreadsScale=0.66
	VehicleHudEngineX=0.45
	VehicleHudOccupantsX(0)=0.45
	VehicleHudOccupantsX(1)=0.51
	VehicleHudOccupantsX(2)=none
	VehicleHudOccupantsY(0)=0.3
	VehicleHudOccupantsY(1)=0.5
	VehicleHudOccupantsY(2)=none

	// Vehicle Params
	VehicleTeam=0;
	Health=600
	HealthMax=600
	DisintegrationHealth=-1000
	CollisionHeight=+60.0
	CollisionRadius=175.0//+60.0
	DriverDamageMult=1.0
	TreadVelocityScale=55
	MaxDesireability=1.8

	// Weapon Attachments
	PassengerWeapons(0)=(WeaponPawnClass=class'Stug3CannonPawn',WeaponBone=Turret_Placement)
	//PassengerWeapons(1)=(WeaponPawnClass=class'ROPanzerIVMountedMGPawn',WeaponBone=MG_Placement)

	// Position Info
	DriverAttachmentBone=driver_attachment

	DriverPositions(0)=(PositionMesh=Mesh'axis_stug3_anm.Stug3_body_int',DriverTransitionAnim=none,TransitionUpAnim=Overlay_Out,ViewPitchUpLimit=1,ViewPitchDownLimit=65535,ViewPositiveYawLimit=0,ViewNegativeYawLimit=0,bExposed=false,bDrawOverlays=true)
	DriverPositions(1)=(PositionMesh=Mesh'axis_stug3_anm.Stug3_body_int',DriverTransitionAnim=VStug3_driver_close,TransitionUpAnim=driver_hatch_open,TransitionDownAnim=Overlay_in,ViewPitchUpLimit=2730,ViewPitchDownLimit=61900,ViewPositiveYawLimit=5500,ViewNegativeYawLimit=-5500,bExposed=false)
	DriverPositions(2)=(PositionMesh=Mesh'axis_stug3_anm.Stug3_body_int',DriverTransitionAnim=VStug3_driver_open,TransitionDownAnim=driver_hatch_close,ViewPitchUpLimit=12000,ViewPitchDownLimit=62500,ViewPositiveYawLimit=18000,ViewNegativeYawLimit=-19500,bExposed=true,ViewFOV=85)
	FPCamPos=(X=0,Y=0,Z=0)
	FPCamViewOffset=(X=0,Y=0,Z=0)
	bFPNoZFromCameraPitch=True
	TPCamLookat=(X=-50,Y=0,Z=0)
	TPCamWorldOffset=(X=0,Y=0,Z=250)
	TPCamDistance=600
	DrivePos=(X=0.0,Y=0.0,Z=0.0)

	// Driver overlay
	HUDOverlayClass=class'ROVehicles.StugIIIDriverOverlay'
	HUDOverlayOffset=(X=0,Y=0,Z=0)
	HUDOverlayFOV=85

	ExitPositions(0)=(X=0,Y=-200,Z=100)
	ExitPositions(1)=(X=0,Y=200,Z=100)
	EntryPosition=(X=0,Y=0,Z=0)
	EntryRadius=375.0

	VehiclePositionString="in a Stug III"
	VehicleNameString="Stug III"

	PitchUpLimit=5000
	PitchDownLimit=60000

	// Destruction
	DestroyedVehicleMesh=StaticMesh'axis_vehicles_stc.Stug3_Destoyed'
	DestructionLinearMomentum=(Min=100.000000,Max=350.000000)
	DestructionAngularMomentum=(Min=50.000000,Max=150.000000)
	DamagedEffectOffset=(X=-100,Y=20,Z=26)
	DamagedEffectScale=0.9

    // effects
	ExhaustPipes(0)=(ExhaustPosition=(X=-175,Y=40,Z=-25),ExhaustRotation=(pitch=34000,yaw=0,roll=0))
	ExhaustPipes(1)=(ExhaustPosition=(X=-175,Y=-40,Z=-25),ExhaustRotation=(pitch=34000,yaw=0,roll=0))
	ExhaustEffectClass=class'ROEffects.ExhaustPetrolEffect'
	ExhaustEffectLowClass=class'ROEffects.ExhaustPetrolEffect_simple'

	// sound
	IdleSound=sound'Vehicle_Engines.STUGiii.stugiii_engine_loop'
	StartUpSound=sound'Vehicle_Engines.STUGiii.stugiii_engine_start'
	ShutDownSound=sound'Vehicle_Engines.STUGiii.stugiii_engine_stop'
	MaxPitchSpeed=450

	// RO Vehicle sound vars
	LeftTreadSound=sound'Vehicle_Engines.track_squeak_L08'
	RightTreadSound=sound'Vehicle_Engines.track_squeak_R08'
	RumbleSound=sound'Vehicle_Engines.tank_inside_rumble01'
	LeftTrackSoundBone=Track_l
	RightTrackSoundBone=Track_r
	RumbleSoundBone=body

	// Steering
    LeftLeverBoneName="Lever_L"
    LeftLeverAxis=AXIS_Z
    RightLeverBoneName="Lever_R"
    RightLeverAxis=AXIS_Z
    SteeringScaleFactor=0.75

	// Wheels
	// Steering Wheels
     Begin Object Class=SVehicleWheel Name=LF_Steering
         bPoweredWheel=True
         BoneOffset=(X=35.0,Y=-5.0,Z=6.0)
         SteerType=VST_Steered
         BoneName="Steer_Wheel_LF"
         BoneRollAxis=AXIS_Y
         WheelRadius=30.000000
     End Object
     Wheels(0)=SVehicleWheel'ROVehicles.Stug3Destroyer.LF_Steering'

     Begin Object Class=SVehicleWheel Name=RF_Steering
         bPoweredWheel=True
	    BoneOffset=(X=35.0,Y=5.0,Z=6.0)
         SteerType=VST_Steered
         BoneName="Steer_Wheel_RF"
         BoneRollAxis=AXIS_Y
         WheelRadius=30.000000
     End Object
     Wheels(1)=SVehicleWheel'ROVehicles.Stug3Destroyer.RF_Steering'

     Begin Object Class=SVehicleWheel Name=LR_Steering
         bPoweredWheel=True
         BoneOffset=(X=-7.0,Y=-5.0,Z=6.0)
         SteerType=VST_Inverted
         BoneName="Steer_Wheel_LR"
         BoneRollAxis=AXIS_Y
         WheelRadius=30.000000
     End Object
     Wheels(2)=SVehicleWheel'ROVehicles.Stug3Destroyer.LR_Steering'

     Begin Object Class=SVehicleWheel Name=RR_Steering
         bPoweredWheel=True
         BoneOffset=(X=-7.0,Y=5.0,Z=6.0)
         SteerType=VST_Inverted
         BoneName="Steer_Wheel_RR"
         BoneRollAxis=AXIS_Y
         WheelRadius=30.000000
     End Object
     Wheels(3)=SVehicleWheel'ROVehicles.Stug3Destroyer.RR_Steering'
     // End Steering Wheels

     // Center Drive Wheels
     Begin Object Class=SVehicleWheel Name=Left_Drive_Wheel
         bPoweredWheel=True
         BoneOffset=(X=0.0,Y=0.0,Z=6.0)
         BoneName="Drive_Wheel_L"
         BoneRollAxis=AXIS_Y
         WheelRadius=30.000000
     End Object
     Wheels(4)=SVehicleWheel'ROVehicles.Stug3Destroyer.Left_Drive_Wheel'

     Begin Object Class=SVehicleWheel Name=Right_Drive_Wheel
         bPoweredWheel=True
         BoneOffset=(X=0.0,Y=0.0,Z=6.0)
         BoneName="Drive_Wheel_R"
         BoneRollAxis=AXIS_Y
         WheelRadius=30.000000
     End Object
     Wheels(5)=SVehicleWheel'ROVehicles.Stug3Destroyer.Right_Drive_Wheel'

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
	WheelRotationScale=300


     // Misc ONS
	FlagBone=MG_Placement// Probably not needed
	FlagRotation=(Yaw=32768)

	// Special hit points
	VehHitpoints(0)=(PointRadius=9.0,PointHeight=0.0,PointScale=1.0,PointBone=driver_player,PointOffset=(X=0.0,Y=0.0,Z=-5.0),bPenetrationPoint=false,HitPointType=HP_Driver)
	VehHitpoints(1)=(PointRadius=35.0,PointHeight=0.0,PointScale=1.0,PointBone=body,PointOffset=(X=-85.0,Y=0.0,Z=0.0),bPenetrationPoint=false,DamageMultiplier=1.0,HitPointType=HP_Engine)
	VehHitpoints(2)=(PointRadius=20.0,PointHeight=0.0,PointScale=1.0,PointBone=body,PointOffset=(X=35.0,Y=-25.0,Z=5.0),bPenetrationPoint=false,DamageMultiplier=5.0,HitPointType=HP_AmmoStore)
	VehHitpoints(3)=(PointRadius=15.0,PointHeight=0.0,PointScale=1.0,PointBone=body,PointOffset=(X=14.0,Y=45.0,Z=30.0),bPenetrationPoint=false,DamageMultiplier=5.0,HitPointType=HP_AmmoStore)
	VehHitpoints(4)=(PointRadius=15.0,PointHeight=0.0,PointScale=1.0,PointBone=body,PointOffset=(X=-14.0,Y=45.0,Z=30.0),bPenetrationPoint=false,DamageMultiplier=5.0,HitPointType=HP_AmmoStore)

	// Armor
    FrontArmorFactor=8
	SideArmorFactor=3
	RearArmorFactor=4

	TreadHitMinAngle= 1.9
}
