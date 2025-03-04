//===================================================================
// TigerTank
//
// Copyright (C) 2004 John "Ramm-Jaeger"  Gibson
//
// Mighty Tiger1 Heavy tank
//===================================================================
class TigerTank extends ROTreadCraft;

#exec OBJ LOAD FILE=..\textures\axis_vehicles_tex.utx
#exec OBJ LOAD FILE=..\Animations\axis_tiger1_anm.ukx

simulated function SetupTreads()
{
	LeftTreadPanner = VariableTexPanner(Level.ObjectPool.AllocateObject(class'VariableTexPanner'));
	if ( LeftTreadPanner != None )
	{
		LeftTreadPanner.Material = Skins[1];
		LeftTreadPanner.PanDirection = rot(0, 0, 16384 );
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

    L.AddPrecacheMaterial(Material'axis_vehicles_tex.ext_vehicles.Tiger1_ext');
    L.AddPrecacheMaterial(Material'axis_vehicles_tex.int_vehicles.tiger1_int');
    L.AddPrecacheMaterial(Material'axis_vehicles_tex.Treads.Tiger1_treads');
    L.AddPrecacheMaterial(Material'axis_vehicles_tex.int_vehicles.tiger1_int_s');
}

simulated function UpdatePrecacheMaterials()
{
    Level.AddPrecacheMaterial(Material'axis_vehicles_tex.ext_vehicles.Tiger1_ext');
    Level.AddPrecacheMaterial(Material'axis_vehicles_tex.int_vehicles.tiger1_int');
    Level.AddPrecacheMaterial(Material'axis_vehicles_tex.Treads.Tiger1_treads');
    Level.AddPrecacheMaterial(Material'axis_vehicles_tex.int_vehicles.tiger1_int_s');

	Super.UpdatePrecacheMaterials();
}

defaultproperties
{
	// Display
	Mesh=Mesh'axis_tiger1_anm.tiger1_body_ext'

	DriveAnim=VTiger_driver_idle_close
	BeginningIdleAnim=driver_hatch_idle_close

	Skins(0)= Texture'axis_vehicles_tex.ext_vehicles.Tiger1_ext'
	Skins(1)=Texture'axis_vehicles_tex.Treads.Tiger1_treads'
	Skins(2)=Texture'axis_vehicles_tex.Treads.Tiger1_treads'
	Skins(3)=Texture'axis_vehicles_tex.int_vehicles.tiger1_int'

	HighDetailOverlay=Material'axis_vehicles_tex.int_vehicles.tiger1_int_s'
	bUseHighDetailOverlayIndex=true
	HighDetailOverlayIndex=3

    // Hud stuff
	VehicleHudImage=Texture'InterfaceArt_tex.Tank_Hud.Tiger_body'
	VehicleHudTurret=TexRotator'InterfaceArt_tex.Tank_Hud.Tiger_turret_rot'
	VehicleHudTurretLook=TexRotator'InterfaceArt_tex.Tank_Hud.Tiger_turret_look'
	VehicleHudThreadsPosX(0)=0.34
	VehicleHudThreadsPosX(1)=0.66
	VehicleHudThreadsPosY=0.52
	VehicleHudThreadsScale=0.68

	// Vehicle Params
	VehicleMass=15.0
	VehicleTeam=0;
	Health=800
	HealthMax=800
	DisintegrationHealth=-1000
	CollisionHeight=+60.0
	CollisionRadius=175
	DriverDamageMult=1.0
	TreadVelocityScale=100
	MaxDesireability=1.9

	GearRatios(0)=-0.200000
	GearRatios(1)=0.200000
	GearRatios(2)=0.350000
	GearRatios(3)=0.550000
	GearRatios(4)=0.720000
	TransRatio=0.09;

	// Weapon Attachments
	PassengerWeapons(0)=(WeaponPawnClass=class'TigerTankCannonPawn',WeaponBone=Turret_Placement)
	PassengerWeapons(1)=(WeaponPawnClass=class'TigerMountedMGPawn',WeaponBone=MG_Placement)

	// Position Info
	DriverPositions(0)=(PositionMesh=Mesh'axis_tiger1_anm.tiger1_body_int',DriverTransitionAnim=none,TransitionUpAnim=Overlay_Out,ViewPitchUpLimit=1,ViewPitchDownLimit=65535,ViewPositiveYawLimit=0,ViewNegativeYawLimit=0,bExposed=false,bDrawOverlays=true)
	DriverPositions(1)=(PositionMesh=Mesh'axis_tiger1_anm.tiger1_body_int',DriverTransitionAnim=VTiger_driver_close,TransitionUpAnim=driver_hatch_open,TransitionDownAnim=Overlay_in,ViewPitchUpLimit=2730,ViewPitchDownLimit=61923,ViewPositiveYawLimit=5500,ViewNegativeYawLimit=-5500,bExposed=false)
	DriverPositions(2)=(PositionMesh=Mesh'axis_tiger1_anm.tiger1_body_int',DriverTransitionAnim=VTiger_driver_open,TransitionDownAnim=driver_hatch_close,ViewPitchUpLimit=15000,ViewPitchDownLimit=65250,ViewPositiveYawLimit=16000,ViewNegativeYawLimit=-32000,bExposed=true,ViewFOV=85)
	FPCamPos=(X=120,Y=-21,Z=17)
	FPCamViewOffset=(X=0,Y=0,Z=0)
	bFPNoZFromCameraPitch=True
	TPCamLookat=(X=-50,Y=0,Z=0)
	TPCamWorldOffset=(X=0,Y=0,Z=250)
	TPCamDistance=600
	DrivePos=(X=0,Y=0,Z=0)
    DriveRot=(Pitch=0,Roll=0,Yaw=0)

	// Driver overlay
	HUDOverlayClass=class'ROVehicles.TigerDriverOverlay'
	HUDOverlayOffset=(X=3,Y=0,Z=0)
	HUDOverlayFOV=85

	ExitPositions(0)=(X=0,Y=-200,Z=100)
	ExitPositions(1)=(X=0,Y=200,Z=100)
	EntryPosition=(X=0,Y=0,Z=0)
	EntryRadius=375.0

	VehiclePositionString="in a Tiger I"
	VehicleNameString="Tiger I"

	PitchUpLimit=5000
	PitchDownLimit=60000

	// Destruction
	DestroyedVehicleMesh=StaticMesh'axis_vehicles_stc.Tiger1_Destroyed'
	DestructionLinearMomentum=(Min=100.000000,Max=350.000000)
	DestructionAngularMomentum=(Min=50.000000,Max=150.000000)
	DamagedEffectOffset=(X=-100,Y=20,Z=26)
	DamagedEffectScale=1.0

 	// effects
	ExhaustPipes(0)=(ExhaustPosition=(X=-190,Y=25,Z=65),ExhaustRotation=(pitch=18000,yaw=0,roll=0))
	ExhaustPipes(1)=(ExhaustPosition=(X=-190,Y=-25,Z=65),ExhaustRotation=(pitch=18000,yaw=0,roll=0))
	ExhaustEffectClass=class'ROEffects.ExhaustPetrolEffect'
	ExhaustEffectLowClass=class'ROEffects.ExhaustPetrolEffect_simple'

	// sound
	IdleSound=sound'Vehicle_Engines.Tiger.Tiger_engine_loop'
	StartUpSound=sound'Vehicle_Engines.Tiger.Tiger_engine_start'
	ShutDownSound=sound'Vehicle_Engines.Tiger.Tiger_engine_stop'
	MaxPitchSpeed=450

	// RO Vehicle sound vars
	LeftTreadSound=sound'Vehicle_Engines.track_squeak_L09'
	RightTreadSound=sound'Vehicle_Engines.track_squeak_R09'
	RumbleSound=sound'Vehicle_Engines.tank_inside_rumble02'
	LeftTrackSoundBone=Track_l
	RightTrackSoundBone=Track_r
	RumbleSoundBone=body

	// Steering
    SteerBoneName="Steering"
    SteeringScaleFactor=2.0

	// Wheels
	// Steering Wheels
     Begin Object Class=SVehicleWheel Name=LF_Steering
         bPoweredWheel=True
         BoneOffset=(X=25.0,Y=-10.0,Z=1.0)
         SteerType=VST_Steered
         BoneName="Steer_Wheel_LF"
         BoneRollAxis=AXIS_Y
         WheelRadius=33.000000
     End Object
     Wheels(0)=SVehicleWheel'ROVehicles.TigerTank.LF_Steering'

     Begin Object Class=SVehicleWheel Name=RF_Steering
         bPoweredWheel=True
	    BoneOffset=(X=25.0,Y=10.0,Z=1.0)
         SteerType=VST_Steered
         BoneName="Steer_Wheel_RF"
         BoneRollAxis=AXIS_Y
         WheelRadius=33.000000
     End Object
     Wheels(1)=SVehicleWheel'ROVehicles.TigerTank.RF_Steering'

     Begin Object Class=SVehicleWheel Name=LR_Steering
         bPoweredWheel=True
         BoneOffset=(X=-7.0,Y=-10.0,Z=1.0)
         SteerType=VST_Inverted
         BoneName="Steer_Wheel_LR"
         BoneRollAxis=AXIS_Y
         WheelRadius=33.000000
     End Object
     Wheels(2)=SVehicleWheel'ROVehicles.TigerTank.LR_Steering'

     Begin Object Class=SVehicleWheel Name=RR_Steering
         bPoweredWheel=True
         BoneOffset=(X=-7.0,Y=10.0,Z=1.0)
         SteerType=VST_Inverted
         BoneName="Steer_Wheel_RR"
         BoneRollAxis=AXIS_Y
         WheelRadius=33.000000
     End Object
     Wheels(3)=SVehicleWheel'ROVehicles.TigerTank.RR_Steering'
     // End Steering Wheels

     // Center Drive Wheels
     Begin Object Class=SVehicleWheel Name=Left_Drive_Wheel
         bPoweredWheel=True
         BoneOffset=(X=0.0,Y=-10.0,Z=1.0)
         BoneName="Drive_Wheel_L"
         BoneRollAxis=AXIS_Y
         WheelRadius=33.000000
     End Object
     Wheels(4)=SVehicleWheel'ROVehicles.TigerTank.Left_Drive_Wheel'

     Begin Object Class=SVehicleWheel Name=Right_Drive_Wheel
         bPoweredWheel=True
         BoneOffset=(X=0.0,Y=-10.0,Z=1.0)
         bHandbrakeWheel=True
         BoneName="Drive_Wheel_R"
         BoneRollAxis=AXIS_Y
         WheelRadius=33.000000
     End Object
     Wheels(5)=SVehicleWheel'ROVehicles.TigerTank.Right_Drive_Wheel'

	// Wheel bones for animation
     LeftWheelBones(0)="Wheel_L_1"
     LeftWheelBones(1)="Wheel_L_2"
     LeftWheelBones(2)="Wheel_L_3"
     LeftWheelBones(3)="Wheel_L_4"
     LeftWheelBones(4)="Wheel_L_5"
     LeftWheelBones(5)="Wheel_L_6"
     LeftWheelBones(6)="Wheel_L_7"
     LeftWheelBones(7)="Wheel_L_8"
     LeftWheelBones(8)="Wheel_L_9"
     LeftWheelBones(9)="Wheel_L_10"

     RightWheelBones(0)="Wheel_R_1"
	RightWheelBones(1)="Wheel_R_2"
	RightWheelBones(2)="Wheel_R_3"
	RightWheelBones(3)="Wheel_R_4"
	RightWheelBones(4)="Wheel_R_5"
	RightWheelBones(5)="Wheel_R_6"
	RightWheelBones(6)="Wheel_R_7"
     RightWheelBones(7)="Wheel_R_8"
     RightWheelBones(8)="Wheel_R_9"
     RightWheelBones(9)="Wheel_R_10"
     WheelRotationScale=600

     // Karma params
     Begin Object Class=KarmaParamsRBFull Name=KParams0
         KInertiaTensor(0)=1.000000
         KInertiaTensor(3)=3.000000
         KInertiaTensor(5)=3.000000
         KCOMOffset=(X=-0.0000,Z=-0.60000)  // Little extra negative COG
         KLinearDamping=0.050000
         KAngularDamping=0.050000
         KStartEnabled=True
         bKNonSphericalInertia=True
         bHighDetailOnly=False
         bClientOnly=False
         bKDoubleTickRate=True
         bDestroyOnWorldPenetrate=True
         bDoSafetime=True
         KFriction=0.500000
         KImpactThreshold=700.000000
         KMaxAngularSpeed=0.9			// Slow down the angular velocity so the tank feels "heavier"
     End Object
     KParams=KarmaParamsRBFull'TigerTank.KParams0'

     // Misc ONS
	FlagBone=MG_Placement// Probably not needed
	FlagRotation=(Yaw=32768)

	// debug
	//bDontUsePositionMesh = true;

	// Special hit points
	VehHitpoints(0)=(PointRadius=9.0,PointHeight=0.0,PointScale=1.0,PointBone=driver_player,PointOffset=(X=-6.0,Y=0.0,Z=0.0),bPenetrationPoint=true,HitPointType=HP_Driver)
	VehHitpoints(1)=(PointRadius=40.0,PointHeight=0.0,PointScale=1.0,PointBone=body,PointOffset=(X=-90.0,Y=0.0,Z=6.0),bPenetrationPoint=false,DamageMultiplier=1.0,HitPointType=HP_Engine)
	VehHitpoints(2)=(PointRadius=25.0,PointHeight=0.0,PointScale=1.0,PointBone=body,PointOffset=(X=60.0,Y=-25.0,Z=5.0),bPenetrationPoint=false,DamageMultiplier=5.0,HitPointType=HP_AmmoStore)
	VehHitpoints(3)=(PointRadius=25.0,PointHeight=0.0,PointScale=1.0,PointBone=body,PointOffset=(X=60.0,Y=25.0,Z=5.0),bPenetrationPoint=false,DamageMultiplier=5.0,HitPointType=HP_AmmoStore)


    // Armor
	FrontArmorFactor=14//11
	SideArmorFactor=8
	RearArmorFactor=8

	TreadHitMinAngle= 1.9

	DriverAttachmentBone=driver_attachment

	FrontLeftAngle=330.0
    FrontRightAngle=31.0
    RearRightAngle=151.0
    RearLeftAngle=209.0
}
