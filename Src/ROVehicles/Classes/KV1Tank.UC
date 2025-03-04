//===================================================================
// KV1Tank
//
// Copyright (C) 2004 John "Ramm-Jaeger"  Gibson
//
// KV1S tank class
//===================================================================
class KV1Tank extends ROTreadCraft;

#exec OBJ LOAD FILE=..\Animations\allies_kv1_anm.ukx

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

    L.AddPrecacheMaterial(Material'allies_vehicles_tex.ext_vehicles.KV1_ext');
    L.AddPrecacheMaterial(Material'allies_vehicles_tex.Treads.kv1_treads');
    L.AddPrecacheMaterial(Material'allies_vehicles_tex.int_vehicles.kv1_int');
    L.AddPrecacheMaterial(Material'allies_vehicles_tex.int_vehicles.kv1_int_s');
}

simulated function UpdatePrecacheMaterials()
{
    Level.AddPrecacheMaterial(Material'allies_vehicles_tex.ext_vehicles.KV1_ext');
    Level.AddPrecacheMaterial(Material'allies_vehicles_tex.Treads.kv1_treads');
    Level.AddPrecacheMaterial(Material'allies_vehicles_tex.int_vehicles.kv1_int');
    Level.AddPrecacheMaterial(Material'allies_vehicles_tex.int_vehicles.kv1_int_s');

	Super.UpdatePrecacheMaterials();
}

defaultproperties
{
	// Display
	Mesh=Mesh'allies_kv1_anm.KV1_body_ext'

	DriveAnim=VKV1_driver_idle_close
	BeginningIdleAnim=driver_hatch_idle_close

	Skins(0)=Texture'allies_vehicles_tex.ext_vehicles.KV1_ext'
	Skins(1)=Texture'allies_vehicles_tex.Treads.kv1_treads'
	Skins(2)=Texture'allies_vehicles_tex.Treads.kv1_treads'
	Skins(3)=Texture'allies_vehicles_tex.int_vehicles.kv1_int'

	HighDetailOverlay=Material'allies_vehicles_tex.int_vehicles.kv1_int_s'
	bUseHighDetailOverlayIndex=true
	HighDetailOverlayIndex=3

    // Hud stuff
	VehicleHudImage=Texture'InterfaceArt_tex.Tank_Hud.kv1s_body'
	VehicleHudTurret=TexRotator'InterfaceArt_tex.Tank_Hud.kv1s_turret_rot'
	VehicleHudTurretLook=TexRotator'InterfaceArt_tex.Tank_Hud.kv1s_turret_look'
	VehicleHudThreadsPosX(0)=0.37
	VehicleHudThreadsPosX(1)=0.64
	VehicleHudThreadsPosY=0.5
	VehicleHudThreadsScale=0.73
	VehicleHudOccupantsX(0)=0.5
	VehicleHudOccupantsX(1)=0.5
	VehicleHudOccupantsX(2)=0.45
	VehicleHudOccupantsY(0)=0.25
	VehicleHudOccupantsY(1)=0.45
	VehicleHudOccupantsY(2)=0.35

	// Vehicle Params
	VehicleTeam=1
	Health=600
	HealthMax=600
	DisintegrationHealth=-1000
	CollisionHeight=+60.0
	CollisionRadius=175
	DriverDamageMult=1.0
	TreadVelocityScale=115
	MaxDesireability=1.8

 	GearRatios(0)=-0.200000
	GearRatios(1)=0.200000
	GearRatios(2)=0.350000
	GearRatios(3)=0.550000
	GearRatios(4)=0.750000
    TransRatio=0.09

     // Weapon Attachments
	PassengerWeapons(0)=(WeaponPawnClass=class'KV1CannonPawn',WeaponBone=Turret_Placement)
	PassengerWeapons(1)=(WeaponPawnClass=class'KV1MountedMGPawn',WeaponBone=MG_Placement)

	// Position Info
	DriverAttachmentBone=driver_attachment
	DriverPositions(0)=(PositionMesh=Mesh'allies_kv1_anm.KV1_body_int',DriverTransitionAnim=VKV1_driver_close,TransitionUpAnim=driver_hatch_open,ViewPitchUpLimit=1,ViewPitchDownLimit=65535,ViewPositiveYawLimit=0,ViewNegativeYawLimit=0,bExposed=false,ViewFOV=85,bDrawOverlays=true)
	DriverPositions(1)=(PositionMesh=Mesh'allies_kv1_anm.KV1_body_int',DriverTransitionAnim=VKV1_driver_open,TransitionDownAnim=driver_hatch_close,ViewPitchUpLimit=6000,ViewPitchDownLimit=63000,ViewPositiveYawLimit=11000,ViewNegativeYawLimit=-11000,bExposed=true)
	InitialPositionIndex=0
	FPCamPos=(X=0,Y=0.0,Z=0)
	FPCamViewOffset=(X=0,Y=0,Z=0)
	bFPNoZFromCameraPitch=True
	TPCamLookat=(X=-50,Y=0,Z=0)
	TPCamWorldOffset=(X=0,Y=0,Z=250)
	TPCamDistance=600
	DrivePos=(X=0,Y=0,Z=0)

	// Driver overlay
	HUDOverlayClass=class'ROVehicles.KV1DriverOverlay'
	HUDOverlayOffset=(X=0,Y=0,Z=0)
	HUDOverlayFOV=85

	ExitPositions(0)=(X=0,Y=-200,Z=100)
	ExitPositions(1)=(X=0,Y=200,Z=100)
	EntryPosition=(X=0,Y=0,Z=0)
	EntryRadius=375.0

	VehiclePositionString="in a KV1S"
	VehicleNameString="KV1S"

	PitchUpLimit=5000
	PitchDownLimit=60000

     // Destruction
	DestroyedVehicleMesh=StaticMesh'allies_vehicles_stc.Kv1_Destroyed'
	DestructionLinearMomentum=(Min=100.000000,Max=350.000000)
	DestructionAngularMomentum=(Min=50.000000,Max=150.000000)
	DamagedEffectOffset=(X=-100,Y=20,Z=26)
	DamagedEffectScale=1.0

 	// effects
	ExhaustPipes(0)=(ExhaustPosition=(X=-110,Y=60,Z=50),ExhaustRotation=(pitch=31000,yaw=-16384,roll=0))
	ExhaustPipes(1)=(ExhaustPosition=(X=-110,Y=-60,Z=50),ExhaustRotation=(pitch=31000,yaw=16384,roll=0))
	ExhaustEffectClass=class'ROEffects.ExhaustDieselEffect'
	ExhaustEffectLowClass=class'ROEffects.ExhaustDieselEffect_simple'

	// sound
	IdleSound=sound'Vehicle_Engines.Kv1s.KV1s_engine_loop'
	StartUpSound=sound'Vehicle_Engines.Kv1s.KV1s_engine_start'
	ShutDownSound=sound'Vehicle_Engines.Kv1s.KV1s_engine_stop'
	MaxPitchSpeed=450

	// RO Vehicle sound vars
	LeftTreadSound=sound'Vehicle_Engines.track_squeak_L04'
	RightTreadSound=sound'Vehicle_Engines.track_squeak_R04'
	RumbleSound=sound'Vehicle_Engines.tank_inside_rumble02'
	LeftTrackSoundBone=Track_l
	RightTrackSoundBone=Track_r
	RumbleSoundBone=body

	// Wheels
	// Steering Wheels
     Begin Object Class=SVehicleWheel Name=LF_Steering
         bPoweredWheel=True
         BoneOffset=(X=30.0,Y=-10.0,Z=5.0)
         SteerType=VST_Steered
         BoneName="Steer_Wheel_LF"
         BoneRollAxis=AXIS_Y
         WheelRadius=30.000000
     End Object
     Wheels(0)=SVehicleWheel'ROVehicles.KV1Tank.LF_Steering'

     Begin Object Class=SVehicleWheel Name=RF_Steering
         bPoweredWheel=True
	    BoneOffset=(X=30.0,Y=10.0,Z=5.0)
         SteerType=VST_Steered
         BoneName="Steer_Wheel_RF"
         BoneRollAxis=AXIS_Y
         WheelRadius=30.000000
     End Object
     Wheels(1)=SVehicleWheel'ROVehicles.KV1Tank.RF_Steering'

     Begin Object Class=SVehicleWheel Name=LR_Steering
         bPoweredWheel=True
         BoneOffset=(X=-12.0,Y=-10.0,Z=5.0)
         SteerType=VST_Inverted
         BoneName="Steer_Wheel_LR"
         BoneRollAxis=AXIS_Y
         WheelRadius=30.000000
     End Object
     Wheels(2)=SVehicleWheel'ROVehicles.KV1Tank.LR_Steering'

     Begin Object Class=SVehicleWheel Name=RR_Steering
         bPoweredWheel=True
         BoneOffset=(X=-12.0,Y=10.0,Z=5.0)
         SteerType=VST_Inverted
         BoneName="Steer_Wheel_RR"
         BoneRollAxis=AXIS_Y
         WheelRadius=30.000000
     End Object
     Wheels(3)=SVehicleWheel'ROVehicles.KV1Tank.RR_Steering'
     // End Steering Wheels

     // Center Drive Wheels
     Begin Object Class=SVehicleWheel Name=Left_Drive_Wheel
         bPoweredWheel=True
         BoneOffset=(X=0.0,Y=10.0,Z=5.0)
         BoneName="Drive_Wheel_L"
         BoneRollAxis=AXIS_Y
         WheelRadius=30.000000
     End Object
     Wheels(4)=SVehicleWheel'ROVehicles.KV1Tank.Left_Drive_Wheel'

     Begin Object Class=SVehicleWheel Name=Right_Drive_Wheel
         bPoweredWheel=True
         BoneOffset=(X=0.0,Y=-10.0,Z=5.0)
         BoneName="Drive_Wheel_R"
         BoneRollAxis=AXIS_Y
         WheelRadius=30.000000
     End Object
     Wheels(5)=SVehicleWheel'ROVehicles.KV1Tank.Right_Drive_Wheel'

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
    WheelRotationScale=600

	// Misc ONS
     FlagBone=MG_Placement// Probably not needed
	FlagRotation=(Yaw=32768)

	// Special hit points
	VehHitpoints(0)=(PointRadius=9.0,PointHeight=0.0,PointScale=1.0,PointBone=driver_player,PointOffset=(X=-22.0,Y=0.0,Z=-7.0),bPenetrationPoint=true,HitPointType=HP_Driver)
	VehHitpoints(1)=(PointRadius=40.0,PointHeight=0.0,PointScale=1.0,PointBone=body,PointOffset=(X=-100.0,Y=0.0,Z=0.0),bPenetrationPoint=false,DamageMultiplier=1.0,HitPointType=HP_Engine)
	VehHitpoints(2)=(PointRadius=25.0,PointHeight=0.0,PointScale=1.0,PointBone=body,PointOffset=(X=13.0,Y=-25.0,Z=-5.0),bPenetrationPoint=false,DamageMultiplier=5.0,HitPointType=HP_AmmoStore)
	VehHitpoints(3)=(PointRadius=25.0,PointHeight=0.0,PointScale=1.0,PointBone=body,PointOffset=(X=13.0,Y=25.0,Z=-5.0),bPenetrationPoint=false,DamageMultiplier=5.0,HitPointType=HP_AmmoStore)

	// Armor
	FrontArmorFactor=8
	SideArmorFactor=6
	RearArmorFactor=5

	TreadHitMinAngle= 1.9

	FrontLeftAngle=335.0
    FrontRightAngle=25.0
    RearRightAngle=155.0
    RearLeftAngle=205.0
}
