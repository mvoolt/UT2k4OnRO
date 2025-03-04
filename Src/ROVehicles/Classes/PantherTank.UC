//===================================================================
// PantherTank
//
// Copyright (C) 2004 John "Ramm-Jaeger"  Gibson
//
// Mighty ROPanther tank
//===================================================================
class PantherTank extends ROTreadCraft;

#exec OBJ LOAD FILE=..\Animations\axis_pantherg_anm.ukx

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

    L.AddPrecacheMaterial(Material'axis_vehicles_tex.ext_vehicles.pantherg_ext');
    L.AddPrecacheMaterial(Material'axis_vehicles_tex.Treads.PantherG_treads');
    L.AddPrecacheMaterial(Material'axis_vehicles_tex.int_vehicles.pantherg_int');
    L.AddPrecacheMaterial(Material'axis_vehicles_tex.int_vehicles.pantherg_int_s');
}

simulated function UpdatePrecacheMaterials()
{
    Level.AddPrecacheMaterial(Material'axis_vehicles_tex.ext_vehicles.pantherg_ext');
    Level.AddPrecacheMaterial(Material'axis_vehicles_tex.Treads.PantherG_treads');
    Level.AddPrecacheMaterial(Material'axis_vehicles_tex.int_vehicles.pantherg_int');
    Level.AddPrecacheMaterial(Material'axis_vehicles_tex.int_vehicles.pantherg_int_s');

	Super.UpdatePrecacheMaterials();
}

defaultproperties
{
	// Display
	Mesh=Mesh'axis_pantherg_anm.PantherG_body_ext'

	DriveAnim=VPanther_driver_idle_close
	BeginningIdleAnim=driver_hatch_idle_close

	Skins(0)=Texture'axis_vehicles_tex.ext_vehicles.pantherg_ext'
	Skins(1)=Texture'axis_vehicles_tex.Treads.PantherG_treads'
	Skins(2)=Texture'axis_vehicles_tex.Treads.PantherG_treads'
	Skins(3)=Texture'axis_vehicles_tex.int_vehicles.pantherg_int'

	HighDetailOverlay=Material'axis_vehicles_tex.int_vehicles.pantherg_int_s'
	bUseHighDetailOverlayIndex=true
	HighDetailOverlayIndex=3

    // Hud stuff
	VehicleHudImage=Texture'InterfaceArt_tex.Tank_Hud.panther_body'
	VehicleHudTurret=TexRotator'InterfaceArt_tex.Tank_Hud.panther_turret_rot'
	VehicleHudTurretLook=TexRotator'InterfaceArt_tex.Tank_Hud.panther_turret_look'
    VehicleHudThreadsPosX(0)=0.38
	VehicleHudThreadsPosX(1)=0.63
	VehicleHudThreadsPosY=0.49
	VehicleHudThreadsScale=0.61
	VehicleHudOccupantsX(0)=0.45
	VehicleHudOccupantsX(1)=0.50
	VehicleHudOccupantsX(2)=0.55

	// Vehicle Params
	VehicleTeam=0;
	Health=800
	HealthMax=800
	DisintegrationHealth=-900 // -900 instead of -1000 for correct disintegration threshold because of high health.
	CollisionHeight=+60.0
	CollisionRadius=175
	DriverDamageMult=1.0
	TreadVelocityScale=225
	MaxDesireability=3.0

 	GearRatios(0)=-0.200000
	GearRatios(1)=0.200000
	GearRatios(2)=0.40000
	GearRatios(3)=0.60000
	GearRatios(4)=0.760000
	TransRatio=0.09;

	// Weapon Attachments
	PassengerWeapons(0)=(WeaponPawnClass=class'PantherCannonPawn',WeaponBone=Turret_Placement)
	PassengerWeapons(1)=(WeaponPawnClass=class'PantherMountedMGPawn',WeaponBone=MG_Placement)

	// Position Info
	DriverPositions(0)=(PositionMesh=Mesh'axis_pantherg_anm.PantherG_body_int',DriverTransitionAnim=VPanther_driver_close,TransitionUpAnim=driver_hatch_open,ViewPitchUpLimit=1,ViewPitchDownLimit=65535,ViewPositiveYawLimit=6000,ViewNegativeYawLimit=-6000,bExposed=false,ViewFOV=85,bDrawOverlays=true)
	DriverPositions(1)=(PositionMesh=Mesh'axis_pantherg_anm.PantherG_body_int',DriverTransitionAnim=VPanther_driver_open,TransitionDownAnim=driver_hatch_close,ViewPitchUpLimit=15000,ViewPitchDownLimit=64000,ViewPositiveYawLimit=16000,ViewNegativeYawLimit=-20000,bExposed=true)
	InitialPositionIndex=0

	FPCamPos=(X=120,Y=-21,Z=17)//(X=97,Y=-25,Z=60)
	FPCamViewOffset=(X=0,Y=0,Z=0)
	bFPNoZFromCameraPitch=True
	TPCamLookat=(X=-50,Y=0,Z=0)
	TPCamWorldOffset=(X=0,Y=0,Z=250)
	TPCamDistance=600
	DrivePos=(X=0,Y=0,Z=0)

	// Driver overlay
	HUDOverlayClass=class'ROVehicles.PantherDriverOverlay'
	HUDOverlayOffset=(X=3,Y=0,Z=0)
	HUDOverlayFOV=85

	ExitPositions(0)=(X=0,Y=-200,Z=100)
	ExitPositions(1)=(X=0,Y=200,Z=100)
	EntryPosition=(X=0,Y=0,Z=0)
	EntryRadius=375.0

	VehiclePositionString="in a Panther"
	VehicleNameString="Panther"

	PitchUpLimit=5000
	PitchDownLimit=60000

	// Destruction
	DriverAttachmentBone=driver_attachment
	DestroyedVehicleMesh=StaticMesh'axis_vehicles_stc.PantherG_Destoyed'
	DestructionLinearMomentum=(Min=100.000000,Max=350.000000)
	DestructionAngularMomentum=(Min=50.000000,Max=150.000000)
	DamagedEffectOffset=(X=-100,Y=20,Z=26)
	DamagedEffectScale=1.0

 	// effects
	ExhaustPipes(0)=(ExhaustPosition=(X=-230,Y=20,Z=65),ExhaustRotation=(pitch=22000,yaw=0,roll=0))
	ExhaustPipes(1)=(ExhaustPosition=(X=-230,Y=-20,Z=65),ExhaustRotation=(pitch=22000,yaw=0,roll=0))
	ExhaustEffectClass=class'ROEffects.ExhaustPetrolEffect'
	ExhaustEffectLowClass=class'ROEffects.ExhaustPetrolEffect_simple'

	// sound
	IdleSound=sound'Vehicle_Engines.Panther.panther_engine_loop'
	StartUpSound=sound'Vehicle_Engines.Panther.panther_engine_start'
	ShutDownSound=sound'Vehicle_Engines.Panther.panther_engine_stop'
	MaxPitchSpeed=450

	// RO Vehicle sound vars
	LeftTreadSound=sound'Vehicle_Engines.track_squeak_L05'
	RightTreadSound=sound'Vehicle_Engines.track_squeak_R05'
	RumbleSound=sound'Vehicle_Engines.tank_inside_rumble02'
	LeftTrackSoundBone=Track_l
	RightTrackSoundBone=Track_r
	RumbleSoundBone=body

	// Wheels
	// Steering Wheels
     Begin Object Class=SVehicleWheel Name=LF_Steering
         bPoweredWheel=True
         BoneOffset=(X=32.0,Y=-15.0,Z=-1.0)
         SteerType=VST_Steered
         BoneName="Steer_Wheel_LF"
         BoneRollAxis=AXIS_Y
         WheelRadius=33.000000
     End Object
     Wheels(0)=SVehicleWheel'ROVehicles.PantherTank.LF_Steering'

     Begin Object Class=SVehicleWheel Name=RF_Steering
         bPoweredWheel=True
	    BoneOffset=(X=32.0,Y=15.0,Z=-1.0)
         SteerType=VST_Steered
         BoneName="Steer_Wheel_RF"
         BoneRollAxis=AXIS_Y
         WheelRadius=33.000000
     End Object
     Wheels(1)=SVehicleWheel'ROVehicles.PantherTank.RF_Steering'

     Begin Object Class=SVehicleWheel Name=LR_Steering
         bPoweredWheel=True
         BoneOffset=(X=-14.0,Y=-15.0,Z=-1.0)
         SteerType=VST_Inverted
         BoneName="Steer_Wheel_LR"
         BoneRollAxis=AXIS_Y
         WheelRadius=33.000000
     End Object
     Wheels(2)=SVehicleWheel'ROVehicles.PantherTank.LR_Steering'

     Begin Object Class=SVehicleWheel Name=RR_Steering
         bPoweredWheel=True
         BoneOffset=(X=-14.0,Y=15.0,Z=-1.0)
         SteerType=VST_Inverted
         BoneName="Steer_Wheel_RR"
         BoneRollAxis=AXIS_Y
         WheelRadius=33.000000
     End Object
     Wheels(3)=SVehicleWheel'ROVehicles.PantherTank.RR_Steering'
     // End Steering Wheels

     // Center Drive Wheels
     Begin Object Class=SVehicleWheel Name=Left_Drive_Wheel
         bPoweredWheel=True
         BoneOffset=(X=0.0,Y=-15.0,Z=-1.0)
         BoneName="Drive_Wheel_L"
         BoneRollAxis=AXIS_Y
         WheelRadius=33.000000
     End Object
     Wheels(4)=SVehicleWheel'ROVehicles.PantherTank.Left_Drive_Wheel'

     Begin Object Class=SVehicleWheel Name=Right_Drive_Wheel
         bPoweredWheel=True
         BoneOffset=(X=0.0,Y=15.0,Z=-1.0)
         bHandbrakeWheel=True
         BoneName="Drive_Wheel_R"
         BoneRollAxis=AXIS_Y
         WheelRadius=33.000000
     End Object
     Wheels(5)=SVehicleWheel'ROVehicles.PantherTank.Right_Drive_Wheel'

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

     WheelRotationScale=1500

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
         KMaxAngularSpeed=1.0			// Slow down the angular velocity so the tank feels "heavier"
     End Object
     KParams=KarmaParamsRBFull'PantherTank.KParams0'

     // Misc ONS
	FlagBone=MG_Placement// Probably not needed
	FlagRotation=(Yaw=32768)

	// debug
	//bDontUsePositionMesh = true;

	// Special hit points
	VehHitpoints(0)=(PointRadius=9.0,PointHeight=0.0,PointScale=1.0,PointBone=driver_player,PointOffset=(X=-3.0,Y=0.0,Z=-2.0),bPenetrationPoint=true,HitPointType=HP_Driver)
	VehHitpoints(1)=(PointRadius=40.0,PointHeight=0.0,PointScale=1.0,PointBone=body,PointOffset=(X=-90.0,Y=0.0,Z=6.0),bPenetrationPoint=false,DamageMultiplier=1.0,HitPointType=HP_Engine)
	VehHitpoints(2)=(PointRadius=25.0,PointHeight=0.0,PointScale=1.0,PointBone=body,PointOffset=(X=60.0,Y=-25.0,Z=5.0),bPenetrationPoint=false,DamageMultiplier=5.0,HitPointType=HP_AmmoStore)
	VehHitpoints(3)=(PointRadius=25.0,PointHeight=0.0,PointScale=1.0,PointBone=body,PointOffset=(X=60.0,Y=25.0,Z=5.0),bPenetrationPoint=false,DamageMultiplier=5.0,HitPointType=HP_AmmoStore)


    // Armor
	FrontArmorFactor=18
	SideArmorFactor=6
	RearArmorFactor=5

	TreadHitMinAngle= 1.9

	FrontLeftAngle=335.0
    FrontRightAngle=25.0
    RearRightAngle=154.0
    RearLeftAngle=204.0
}
