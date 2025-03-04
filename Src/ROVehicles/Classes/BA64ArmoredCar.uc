//=====================================================
// BA64ArmoredCar
//
// Copyright (C) 2005 Ramm-Jaeger
//
// BA64 Armored Car
//=====================================================
class BA64ArmoredCar extends ROWheeledVehicle;

#exec OBJ LOAD FILE=..\Animations\allies_ba64_anm.ukx

static function StaticPrecache(LevelInfo L)
{
    Super.StaticPrecache(L);

    L.AddPrecacheMaterial(Material'allies_vehicles_tex.ext_vehicles.BA64_ext');
    L.AddPrecacheMaterial(Material'allies_vehicles_tex.int_vehicles.BA64_int');
    L.AddPrecacheMaterial(Material'allies_vehicles_tex.int_vehicles.BA64_int_s');
}

simulated function UpdatePrecacheMaterials()
{
    Level.AddPrecacheMaterial(Material'allies_vehicles_tex.ext_vehicles.BA64_ext');
    Level.AddPrecacheMaterial(Material'allies_vehicles_tex.int_vehicles.BA64_int');
    Level.AddPrecacheMaterial(Material'allies_vehicles_tex.int_vehicles.BA64_int_s');

	Super.UpdatePrecacheMaterials();
}

defaultproperties
{
	// Display
	Mesh=SkeletalMesh'allies_ba64_anm.BA64_body_ext'

	Skins(0)=Texture'allies_vehicles_tex.ext_vehicles.BA64_ext'
	Skins(1)=Texture'allies_vehicles_tex.int_vehicles.BA64_int'

	HighDetailOverlay=Material'allies_vehicles_tex.int_vehicles.BA64_int_s'
	bUseHighDetailOverlayIndex=true
	HighDetailOverlayIndex=1

	DriveAnim=VBA64_driver_idle_close
	BeginningIdleAnim=driver_hatch_idle_close

	// Hud stuff
	VehicleHudImage=Texture'InterfaceArt_tex.Tank_Hud.BA64_body'
	VehicleHudEngineX=0.5
	VehicleHudEngineY=0.3
	VehicleHudOccupantsX(0)=0.5
	VehicleHudOccupantsX(1)=0.5
	VehicleHudOccupantsX(2)=none
	VehicleHudOccupantsY(0)=0.5
	VehicleHudOccupantsY(1)=0.665
	VehicleHudOccupantsY(2)=none

	// Vehicle Params
	VehicleMass=3.0
	VehicleTeam=1
	Health=250
	HealthMax=250.000000
	DisintegrationHealth=-10000 // It has no (large round) ammo supply so it can't disintegrate!
	CollisionHeight=40.000000
	CollisionRadius=175.0
	DriverDamageMult=1.0
	MaxDesireability=0.100000

	// Weapon Attachments
	PassengerWeapons(0)=(WeaponPawnClass=Class'ROVehicles.BA64GunPawn',WeaponBone=turret_placement)

	// Position Info
	DriverAttachmentBone=driver_attachment
	bMultiPosition=true
	DriverPositions(0)=(PositionMesh=Mesh'allies_ba64_anm.BA64_body_int',DriverTransitionAnim=none,TransitionUpAnim=Overlay_Out,ViewPitchUpLimit=1,ViewPitchDownLimit=65535,ViewPositiveYawLimit=0,ViewNegativeYawLimit=0,bExposed=false,bDrawOverlays=true)
	DriverPositions(1)=(PositionMesh=Mesh'allies_ba64_anm.BA64_body_int',DriverTransitionAnim=VBA64_driver_close,TransitionUpAnim=driver_hatch_open,TransitionDownAnim=Overlay_in,ViewPitchUpLimit=2730,ViewPitchDownLimit=60065,ViewPositiveYawLimit=5500,ViewNegativeYawLimit=-5500,bExposed=false)
	DriverPositions(2)=(PositionMesh=Mesh'allies_ba64_anm.BA64_body_int',DriverTransitionAnim=VBA64_driver_open,TransitionDownAnim=driver_hatch_close,ViewPitchUpLimit=9500,ViewPitchDownLimit=62835,ViewPositiveYawLimit=9500,ViewNegativeYawLimit=-9500,bExposed=true,ViewFOV=85)
	FPCamPos=(X=42.000000,Y=-18.000000,Z=33.000000)
	TPCamLookat=(X=0.000000,Z=0.000000)
	TPCamWorldOffset=(Z=100.000000)
	TPCamDistance=375.000000
	DrivePos=(X=0,Y=0,Z=0)
	ExitPositions(0)=(Y=-200.000000,Z=100.000000)
	ExitPositions(1)=(Y=200.000000,Z=100.000000)
	ExitPositions(2)=(Y=-200.000000,Z=100.000000)
	ExitPositions(3)=(Y=200.000000,Z=100.000000)
	EntryRadius=160.000000

	// Driver overlay
	HUDOverlayClass=class'ROVehicles.BA64DriverOverlay'
	HUDOverlayOffset=(X=2,Y=0,Z=0)
	HUDOverlayFOV=85

	VehiclePositionString="in a BA-64 armored car"
	VehicleNameString="BA-64"

	// Camera parameters
	PitchUpLimit=500
	PitchDownLimit=58000

	// Destruction
	DestroyedVehicleMesh=StaticMesh'allies_vehicles_stc.Ba64_destoyed'
	DestructionLinearMomentum=(Min=100.000000,Max=350.000000)
	DestructionAngularMomentum=(Min=50.000000,Max=150.000000)
	DamagedEffectOffset=(X=-40.000000,Y=10.000000,Z=10.000000)
	DamagedEffectScale=0.75

	// Exhaust effects
	ExhaustPipes(0)=(ExhaustPosition=(X=-20,Y=30,Z=-35),ExhaustRotation=(pitch=34000,yaw=-5000,roll=0))
	ExhaustEffectClass=class'ROEffects.ExhaustPetrolEffect'
	ExhaustEffectLowClass=class'ROEffects.ExhaustPetrolEffect_simple'

	// sound
	IdleSound=sound'Vehicle_Engines.BA64.ba64_engine_loop'
	StartUpSound=sound'Vehicle_Engines.BA64.ba64_engine_start'
	ShutDownSound=sound'Vehicle_Engines.BA64.ba64_engine_stop'

//Steering
	SteerBoneName="Steering"
    SteerBoneAxis=AXIS_X
	SteeringScaleFactor=4.0

	// Wheels
     Begin Object Class=SVehicleWheel Name=LFWheel
         bPoweredWheel=False
         SteerType=VST_Steered
         BoneName="steer_wheel_RF"
         BoneRollAxis=AXIS_Y
          BoneOffset=(Y=-9.000000,Z=2.0)
         WheelRadius=26.000000
         SupportBoneName="Axle_RF"
         SupportBoneAxis=AXIS_X
     End Object
     Wheels(0)=SVehicleWheel'ROVehicles.BA64ArmoredCar.LFWheel'

     Begin Object Class=SVehicleWheel Name=RFWheel
         bPoweredWheel=False
         SteerType=VST_Steered
         BoneName="steer_wheel_LF"
         BoneRollAxis=AXIS_Y
         BoneOffset=(Y=9.000000,Z=2.0)
         WheelRadius=26.000000
         SupportBoneName="Axle_LF"
         SupportBoneAxis=AXIS_X
     End Object
     Wheels(1)=SVehicleWheel'ROVehicles.BA64ArmoredCar.RFWheel'

     Begin Object Class=SVehicleWheel Name=LRWheel
         bPoweredWheel=True
         bHandbrakeWheel=True
         BoneName="steer_wheel_LR"
         BoneRollAxis=AXIS_Y
         BoneOffset=(X=0.0,Y=-9.000000,Z=2.0)
         WheelRadius=26.000000
         SupportBoneName="Axle_LR"
         SupportBoneAxis=AXIS_X
     End Object
     Wheels(2)=SVehicleWheel'ROVehicles.BA64ArmoredCar.LRWheel'

     Begin Object Class=SVehicleWheel Name=RRWheel
         bPoweredWheel=True
         bHandbrakeWheel=True
         BoneName="steer_wheel_RR"
         BoneRollAxis=AXIS_Y
         BoneOffset=(X=0.0,Y=9.000000,Z=2.0)
         WheelRadius=26.000000
         SupportBoneName="Axle_RR"
         SupportBoneAxis=AXIS_X
     End Object
     Wheels(3)=SVehicleWheel'ROVehicles.BA64ArmoredCar.RRWheel'

// Karma
     Begin Object Class=KarmaParamsRBFull Name=KParams0
         KInertiaTensor(0)=1.300000
         KInertiaTensor(3)=3.000000
         KInertiaTensor(5)=3.000000
         KCOMOffset=(X=0.30000,Z=-0.5250)
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
     End Object
     KParams=KarmaParamsRBFull'ROVehicles.BA64ArmoredCar.KParams0'

	// Special hit points
	VehHitpoints(0)=(PointRadius=7.0,PointHeight=0.0,PointScale=1.0,PointBone=driver_player,PointOffset=(X=-10.0,Y=0.0,Z=-7.0),bPenetrationPoint=false,DamageMultiplier=0.0,HitPointType=HP_Driver)
	VehHitpoints(1)=(PointRadius=22.0,PointHeight=0.0,PointScale=1.0,PointBone=engine,PointOffset=(X=60.0,Y=0.0,Z=-10.0),bPenetrationPoint=false,DamageMultiplier=5.0,HitPointType=HP_Engine)

	// Vehicle properties
	WheelSoftness=0.025000
	WheelPenScale=1.200000
	WheelPenOffset=0.010000
	WheelRestitution=0.100000
	WheelInertia=0.100000
	WheelLongFrictionFunc=(Points=(,(InVal=100.000000,OutVal=1.000000),(InVal=200.000000,OutVal=0.900000),(InVal=10000000000.000000,OutVal=0.900000)))
	WheelLongSlip=0.001000
	WheelLatSlipFunc=(Points=(,(InVal=30.000000,OutVal=0.009000),(InVal=45.000000),(InVal=10000000000.000000)))
	WheelLongFrictionScale=1.100000
	WheelLatFrictionScale=1.55
	WheelHandbrakeSlip=0.010000
	WheelHandbrakeFriction=0.100000
	WheelSuspensionTravel=10.000000
	WheelSuspensionMaxRenderTravel=5.000000
	FTScale=0.030000
	ChassisTorqueScale=0.095
	MinBrakeFriction=4.000000
	MaxSteerAngleCurve=(Points=((OutVal=45.000000),(InVal=300.000000,OutVal=30.000000),(InVal=500.000000,OutVal=20.000000),(InVal=600.000000,OutVal=15.000000),(InVal=1000000000.000000,OutVal=10.000000)))
	SteerSpeed=160.000000
	TurnDamping=35.000000
	StopThreshold=100.000000
	HandbrakeThresh=200.000000
	LSDFactor=1.000000
	CenterSpringForce="SpringONSSRV"

	// Engine/Transmission
	TorqueCurve=(Points=((InVal=0,OutVal=1.0),(InVal=200,OutVal=0.75),(InVal=1500,OutVal=2.0),(InVal=2200,OutVal=0.0)))
	GearRatios(0)=-0.200000
	GearRatios(1)=0.200000
	GearRatios(2)=0.350000
	GearRatios(3)=0.60
	GearRatios(4)=0.85
	TransRatio=0.16
	ChangeUpPoint=1990.000000
	ChangeDownPoint=1000.000000

	EngineBrakeFactor=0.000100
	EngineBrakeRPMScale=0.100000
	MaxBrakeTorque=20.000000
	EngineInertia=0.100000
	IdleRPM=500.000000
	EngineRPMSoundRange=5000.000000
	RevMeterScale=4000.000000
	GroundSpeed=325.000000

	// misc
	ObjectiveGetOutDist=1500.000000
	bHasHandbrake=True
	bIsApc=true
}
