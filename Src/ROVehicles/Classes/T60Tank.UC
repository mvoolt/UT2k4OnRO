//===================================================================
// T60Tank
//
// Copyright (C) 2005 John "Ramm-Jaeger"  Gibson
//
// Russian T60 light tank
//===================================================================
class T60Tank extends ROTreadCraft;

#exec OBJ LOAD FILE=..\Animations\allies_t60_anm.ukx

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

    L.AddPrecacheMaterial(Material'allies_vehicles_tex.ext_vehicles.T60_ext');
    L.AddPrecacheMaterial(Material'allies_vehicles_tex.int_vehicles.T60_int');
    L.AddPrecacheMaterial(Material'allies_vehicles_tex.Treads.T60_treads');
    L.AddPrecacheMaterial(Material'allies_vehicles_tex.int_vehicles.T60_int_s');
}

simulated function UpdatePrecacheMaterials()
{
    Level.AddPrecacheMaterial(Material'allies_vehicles_tex.ext_vehicles.T60_ext');
    Level.AddPrecacheMaterial(Material'allies_vehicles_tex.int_vehicles.T60_int');
    Level.AddPrecacheMaterial(Material'allies_vehicles_tex.Treads.T60_treads');
    Level.AddPrecacheMaterial(Material'allies_vehicles_tex.int_vehicles.T60_int_s');

	Super.UpdatePrecacheMaterials();
}

defaultproperties
{
	// Display
	Mesh=Mesh'allies_t60_anm.T60_body_ext'

	DriveAnim=VT60_driver_idle_close
	BeginningIdleAnim=driver_hatch_idle_close

	Skins(0)=Texture'allies_vehicles_tex.ext_vehicles.T60_ext'
	Skins(1)=Texture'allies_vehicles_tex.Treads.T60_treads'
	Skins(2)=Texture'allies_vehicles_tex.Treads.T60_treads'
	Skins(3)=Texture'allies_vehicles_tex.int_vehicles.T60_int'

	HighDetailOverlay=Material'allies_vehicles_tex.int_vehicles.T60_int_s'
	bUseHighDetailOverlayIndex=true
	HighDetailOverlayIndex=3

    // Hud stuff
	VehicleHudImage=Texture'InterfaceArt_tex.Tank_Hud.T60_body'
	VehicleHudTurret=TexRotator'InterfaceArt_tex.Tank_Hud.T60_turret_rot'
	VehicleHudTurretLook=TexRotator'InterfaceArt_tex.Tank_Hud.T60_turret_look'
	VehicleHudThreadsPosX(0)=0.35
	VehicleHudThreadsPosX(1)=0.66
	VehicleHudThreadsPosY=0.51
	VehicleHudThreadsScale=0.65
	VehicleHudOccupantsX(0)=0.5
	VehicleHudOccupantsX(1)=0.465
	VehicleHudOccupantsX(2)=none
	VehicleHudOccupantsY(0)=0.39
	VehicleHudOccupantsY(1)=0.55
	VehicleHudOccupantsY(2)=none

	// Vehicle Params
	VehicleMass=6.5
	VehicleTeam=1;
	Health=400
	HealthMax=400
	DisintegrationHealth=-1000
	CollisionHeight=+100.0
	CollisionRadius=+100.0
	DriverDamageMult=1.0
	TreadVelocityScale=80
	MaxDesireability=1.8

    TransRatio=0.13;

	// Weapon Attachments
	PassengerWeapons(0)=(WeaponPawnClass=class'T60CannonPawn',WeaponBone=Turret_Placement)

	// Position Info
	DriverAttachmentBone=driver_attachment
	DriverPositions(0)=(PositionMesh=Mesh'allies_t60_anm.T60_body_int',DriverTransitionAnim=none,TransitionUpAnim=Overlay_Out,ViewPitchUpLimit=1,ViewPitchDownLimit=65535,ViewPositiveYawLimit=0,ViewNegativeYawLimit=0,bExposed=false,bDrawOverlays=true)
	DriverPositions(1)=(PositionMesh=Mesh'allies_t60_anm.T60_body_int',DriverTransitionAnim=VT60_driver_close,TransitionUpAnim=driver_hatch_open,TransitionDownAnim=Overlay_in,ViewPitchUpLimit=2730,ViewPitchDownLimit=61923,ViewPositiveYawLimit=5500,ViewNegativeYawLimit=-5500,bExposed=false)
	DriverPositions(2)=(PositionMesh=Mesh'allies_t60_anm.T60_body_int',DriverTransitionAnim=VT60_driver_open,TransitionDownAnim=driver_hatch_close,ViewPitchUpLimit=2730,ViewPitchDownLimit=60000,ViewPositiveYawLimit=9500,ViewNegativeYawLimit=-9500,bExposed=true,ViewFOV=85)
	FPCamPos=(X=0,Y=0,Z=0)
	FPCamViewOffset=(X=0,Y=0,Z=0)
	bFPNoZFromCameraPitch=True
	TPCamLookat=(X=-50,Y=0,Z=0)
	TPCamWorldOffset=(X=0,Y=0,Z=250)
	TPCamDistance=600
	DrivePos=(X=0,Y=0,Z=0)

 	// Driver overlay
	HUDOverlayClass=class'ROVehicles.T60DriverOverlay'
	HUDOverlayOffset=(X=2,Y=0,Z=0)
	HUDOverlayFOV=85

	ExitPositions(0)=(X=0,Y=-200,Z=100)
	ExitPositions(1)=(X=0,Y=200,Z=100)
	EntryPosition=(X=0,Y=0,Z=0)
	EntryRadius=375.0

	VehiclePositionString="in a T60"
	VehicleNameString="T60"

	PitchUpLimit=5000
	PitchDownLimit=60000

	// Destruction
	DestroyedVehicleMesh=StaticMesh'allies_vehicles_stc.T60_Destroyed'
	DestructionLinearMomentum=(Min=100.000000,Max=350.000000)
	DestructionAngularMomentum=(Min=50.000000,Max=150.000000)
	DamagedEffectOffset=(X=-100,Y=20,Z=26)
	DamagedEffectScale=0.75

 	// effects
	ExhaustPipes(0)=(ExhaustPosition=(X=-135,Y=70,Z=15),ExhaustRotation=(pitch=34000,yaw=-16384,roll=0))
	ExhaustEffectClass=class'ROEffects.ExhaustPetrolEffect'
	ExhaustEffectLowClass=class'ROEffects.ExhaustPetrolEffect_simple'

	// sound
	IdleSound=sound'Vehicle_Engines.T60.T60_engine_loop'
	StartUpSound=sound'Vehicle_Engines.T60.T60_engine_start'
	ShutDownSound=sound'Vehicle_Engines.T60.T60_engine_stop'
	MaxPitchSpeed=450

	// RO Vehicle sound vars
	LeftTreadSound=sound'Vehicle_Engines.track_squeak_L09'
	RightTreadSound=sound'Vehicle_Engines.track_squeak_R09'
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
         BoneOffset=(X=25.0,Y=-3.0,Z=11.0)
         SteerType=VST_Steered
         BoneName="Steer_Wheel_LF"
         BoneRollAxis=AXIS_Y
         WheelRadius=33.000000
     End Object
     Wheels(0)=SVehicleWheel'ROVehicles.T60Tank.LF_Steering'

     Begin Object Class=SVehicleWheel Name=RF_Steering
         bPoweredWheel=True
	    BoneOffset=(X=25.0,Y=3.0,Z=11.0)
         SteerType=VST_Steered
         BoneName="Steer_Wheel_RF"
         BoneRollAxis=AXIS_Y
         WheelRadius=33.000000
     End Object
     Wheels(1)=SVehicleWheel'ROVehicles.T60Tank.RF_Steering'

     Begin Object Class=SVehicleWheel Name=LR_Steering
         bPoweredWheel=True
         BoneOffset=(X=-7.0,Y=-3.0,Z=11.0)
         SteerType=VST_Inverted
         BoneName="Steer_Wheel_RL"//"Steer_Wheel_LR"
         BoneRollAxis=AXIS_Y
         WheelRadius=33.000000
     End Object
     Wheels(2)=SVehicleWheel'ROVehicles.T60Tank.LR_Steering'

     Begin Object Class=SVehicleWheel Name=RR_Steering
         bPoweredWheel=True
         BoneOffset=(X=-7.0,Y=3.0,Z=11.0)
         SteerType=VST_Inverted
         BoneName="Steer_Wheel_RR"
         BoneRollAxis=AXIS_Y
         WheelRadius=33.000000
     End Object
     Wheels(3)=SVehicleWheel'ROVehicles.T60Tank.RR_Steering'
     // End Steering Wheels

     // Center Drive Wheels
     Begin Object Class=SVehicleWheel Name=Left_Drive_Wheel
         bPoweredWheel=True
         BoneOffset=(X=0.0,Y=-3.0,Z=11.0)
         BoneName="Drive_Wheel_L"
         BoneRollAxis=AXIS_Y
         WheelRadius=33.000000
     End Object
     Wheels(4)=SVehicleWheel'ROVehicles.T60Tank.Left_Drive_Wheel'

     Begin Object Class=SVehicleWheel Name=Right_Drive_Wheel
         bPoweredWheel=True
         BoneOffset=(X=0.0,Y=-3.0,Z=11.0)
         BoneName="Drive_Wheel_R"
         BoneRollAxis=AXIS_Y
         WheelRadius=33.000000
     End Object
     Wheels(5)=SVehicleWheel'ROVehicles.T60Tank.Right_Drive_Wheel'

	// Wheel bones for animation
	LeftWheelBones(0)="Wheel_L_1"
	LeftWheelBones(1)="Wheel_L_2"
	LeftWheelBones(2)="Wheel_L_3"
	LeftWheelBones(3)="Wheel_L_4"
	LeftWheelBones(4)="Wheel_L_5"
	LeftWheelBones(5)="Wheel_L_6"
	// Track return wheels
	LeftWheelBones(6)="Wheel_L_7"
	LeftWheelBones(7)="Wheel_L_8"
	LeftWheelBones(8)="Wheel_L_9"

	RightWheelBones(0)="Wheel_R_1"
	RightWheelBones(1)="Wheel_R_2"
	RightWheelBones(2)="Wheel_R_3"
	RightWheelBones(3)="Wheel_R_4"
	RightWheelBones(4)="Wheel_R_5"
	RightWheelBones(5)="Wheel_R_6"
	// Track return wheels
	RightWheelBones(6)="Wheel_R_7"
	RightWheelBones(7)="Wheel_R_8"
	RightWheelBones(8)="Wheel_R_9"

     // Karma params
     Begin Object Class=KarmaParamsRBFull Name=KParams0
         KInertiaTensor(0)=1.000000
         KInertiaTensor(3)=3.000000
         KInertiaTensor(5)=3.000000
         KCOMOffset=(X=-0.0000,Z=-0.50000)
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
         KMaxAngularSpeed=3.0			// Slow down the angular velocity so the tank feels "heavier"
     End Object
     KParams=KarmaParamsRBFull'ROEngine.ROTreadCraft.KParams0'

     // Misc ONS
	FlagBone=MG_Placement// Probably not needed
	FlagRotation=(Yaw=32768)

	// Special hit points
	VehHitpoints(0)=(PointRadius=9.0,PointHeight=0.0,PointScale=1.0,PointBone=driver_player,PointOffset=(X=-11.0,Y=0.0,Z=-30.0),bPenetrationPoint=true,HitPointType=HP_Driver)
	VehHitpoints(1)=(PointRadius=40.0,PointHeight=0.0,PointScale=1.0,PointBone=body,PointOffset=(X=-90.0,Y=0.0,Z=0.0),bPenetrationPoint=false,DamageMultiplier=1.0,HitPointType=HP_Engine)
	VehHitpoints(2)=(PointRadius=25.0,PointHeight=0.0,PointScale=1.0,PointBone=body,PointOffset=(X=13.0,Y=-25.0,Z=-5.0),bPenetrationPoint=false,DamageMultiplier=5.0,HitPointType=HP_AmmoStore)
	VehHitpoints(3)=(PointRadius=25.0,PointHeight=0.0,PointScale=1.0,PointBone=body,PointOffset=(X=13.0,Y=25.0,Z=-5.0),bPenetrationPoint=false,DamageMultiplier=5.0,HitPointType=HP_AmmoStore)
	// Armor
    FrontArmorFactor=5//6
	SideArmorFactor=2//3
	RearArmorFactor=1//2

	TreadHitMinAngle= 1.9
	DriverHitCheckDist=30.0
}
