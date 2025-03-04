//=============================================================================
// Sdkfz251Transport
//=============================================================================
// Sdkfz251 Half Track Transport Vehicle class
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================
class Sdkfz251Transport extends ROWheeledVehicle;

#exec OBJ LOAD FILE=..\Animations\axis_halftrack_anm.ukx

var()   float                 MaxPitchSpeed;
var VariableTexPanner LeftTreadPanner, RightTreadPanner;
var() float TreadVelocityScale;

// Sound attachment actor variables
var()   	sound               LeftTreadSound;    // Sound for the left tread squeaking
var()   	sound               RightTreadSound;   // Sound for the right tread squeaking
var()   	sound               RumbleSound;       // Interior rumble sound
var     	bool                bPlayTreadSound;
var     	float               TreadSoundVolume;
var     	ROSoundAttachment   LeftTreadSoundAttach;
var     	ROSoundAttachment   RightTreadSoundAttach;
var     	ROSoundAttachment   InteriorRumbleSoundAttach;
var     	float               MotionSoundVolume;
var()   	name                LeftTrackSoundBone;
var()   	name                RightTrackSoundBone;
var()   	name                RumbleSoundBone;

// Wheel animation
var() 	array<name>		LeftWheelBones; 	// for animation only - the bone names for the wheels on the left side
var() 	array<name>		RightWheelBones; 	// for animation only - the bone names for the wheels on the right side

var 	rotator 		LeftWheelRot;       // Keep track of the left wheels rotational speed for animation
var 	rotator 		RightWheelRot;      // Keep track of the right wheels rotational speed for animation

simulated function PostBeginPlay()
{
	super.PostBeginPlay();

	if ( Level.NetMode != NM_DedicatedServer )
	{
		SetupTreads();

		if (  LeftTreadSoundAttach == none )
		{
			LeftTreadSoundAttach = Spawn(class 'ROSoundAttachment');
			LeftTreadSoundAttach.AmbientSound = LeftTreadSound;
			AttachToBone(LeftTreadSoundAttach, LeftTrackSoundBone);
		}

		if (  RightTreadSoundAttach == none )
		{
			RightTreadSoundAttach = Spawn(class 'ROSoundAttachment');
			RightTreadSoundAttach.AmbientSound = RightTreadSound;
			AttachToBone(RightTreadSoundAttach, RightTrackSoundBone );
		}

		if (  InteriorRumbleSoundAttach == none )
		{
			InteriorRumbleSoundAttach = Spawn(class 'ROSoundAttachment');
			InteriorRumbleSoundAttach.AmbientSound = RumbleSound;
			AttachToBone(InteriorRumbleSoundAttach, RumbleSoundBone );
		}
	}

/*	if( HasAnim('driver_hatch_idle_open'))
	{
	    LoopAnim('driver_hatch_idle_open');
	}*/
}

simulated function UpdateMovementSound()
{
    if (  LeftTreadSoundAttach != none)
    {
       LeftTreadSoundAttach.SoundVolume= MotionSoundVolume * 1.0;
    }

    if (  RightTreadSoundAttach != none)
    {
       RightTreadSoundAttach.SoundVolume= MotionSoundVolume * 1.0;
    }

    if (  InteriorRumbleSoundAttach != none)
    {
       InteriorRumbleSoundAttach.SoundVolume= MotionSoundVolume;
    }
}

// DriverLeft() called by KDriverLeave()
function DriverLeft()
{
    // Not moving, so no motion sound
    MotionSoundVolume=0.0;
    UpdateMovementSound();

    Super.DriverLeft();
}

simulated event DrivingStatusChanged()
{
    Super.DrivingStatusChanged();

    if (!bDriving)
    {
        if ( LeftTreadPanner != None )
            LeftTreadPanner.PanRate = 0.0;

        if ( RightTreadPanner != None )
            RightTreadPanner.PanRate = 0.0;

        // Not moving, so no motion sound
        MotionSoundVolume=0.0;
        UpdateMovementSound();
    }
}

simulated function Destroyed()
{
	DestroyTreads();

	if( LeftTreadSoundAttach != none )
	    LeftTreadSoundAttach.Destroy();
	if( RightTreadSoundAttach != none )
	    RightTreadSoundAttach.Destroy();
	if( InteriorRumbleSoundAttach != none )
	    InteriorRumbleSoundAttach.Destroy();

	super.Destroyed();
}

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

simulated function DestroyTreads()
{
	if ( LeftTreadPanner != None )
	{
		Level.ObjectPool.FreeObject(LeftTreadPanner);
		LeftTreadPanner = None;
	}
	if ( RightTreadPanner != None )
	{
		Level.ObjectPool.FreeObject(RightTreadPanner);
		RightTreadPanner = None;
	}
}


simulated function Tick(float DeltaTime)
{
	local float LinTurnSpeed;
	local float MotionSoundTemp;
	local KRigidBodyState BodyState;
	local float MySpeed;
	local int i;

	Super.Tick( DeltaTime );

	// Only need these effects client side
	if( Level.Netmode != NM_DedicatedServer )
	{

		// Shame on you Psyonix, for calling VSize() 3 times every tick, when it only needed to be called once.
		// VSize() is very CPU intensive - Ramm
		MySpeed = VSize(Velocity);

		// Setup sounds that are dependent on velocity
		MotionSoundTemp =  MySpeed/MaxPitchSpeed * 255;
		if ( MySpeed > 0.1 )
		{
		  	MotionSoundVolume =  FClamp(MotionSoundTemp, 0, 255);
		}
		else
		{
		  	MotionSoundVolume=0;
		}
		UpdateMovementSound();


		KGetRigidBodyState(BodyState);
		LinTurnSpeed = 0.5 * BodyState.AngVel.Z;

		if ( LeftTreadPanner != None )
		{
			LeftTreadPanner.PanRate = MySpeed / TreadVelocityScale;
			if (Velocity dot Vector(Rotation) < 0)
				LeftTreadPanner.PanRate = -1 * LeftTreadPanner.PanRate;
			LeftTreadPanner.PanRate += LinTurnSpeed;
		}

		if ( RightTreadPanner != None )
		{
			RightTreadPanner.PanRate = MySpeed / TreadVelocityScale;
			if (Velocity Dot Vector(Rotation) < 0)
				RightTreadPanner.PanRate = -1 * RightTreadPanner.PanRate;
			RightTreadPanner.PanRate -= LinTurnSpeed;
		}

		// Animate the tank wheels
		LeftWheelRot.pitch += LeftTreadPanner.PanRate * 500;
		RightWheelRot.pitch += RightTreadPanner.PanRate * 500;

		for(i=0; i<LeftWheelBones.Length; i++)
		{
			  SetBoneRotation(LeftWheelBones[i], LeftWheelRot);
		}

		for(i=0; i<RightWheelBones.Length; i++)
		{
			  SetBoneRotation(RightWheelBones[i], RightWheelRot);
		}
	}
}

static function StaticPrecache(LevelInfo L)
{
    Super.StaticPrecache(L);

 	L.AddPrecacheMaterial(Material'axis_vehicles_tex.ext_vehicles.halftrack_ext');
 	L.AddPrecacheMaterial(Material'axis_vehicles_tex.Treads.Halftrack_treads');
 	L.AddPrecacheMaterial(Material'axis_vehicles_tex.int_vehicles.halftrack_int');
 	L.AddPrecacheMaterial(Material'axis_vehicles_tex.int_vehicles.halftrack_int_s');
}

simulated function UpdatePrecacheMaterials()
{
    Level.AddPrecacheMaterial(Material'axis_vehicles_tex.ext_vehicles.halftrack_ext');
    Level.AddPrecacheMaterial(Material'axis_vehicles_tex.Treads.Halftrack_treads');
    Level.AddPrecacheMaterial(Material'axis_vehicles_tex.int_vehicles.halftrack_int');
    Level.AddPrecacheMaterial(Material'axis_vehicles_tex.int_vehicles.halftrack_int_s');

	Super.UpdatePrecacheMaterials();
}


defaultproperties
{
	// Display
	Mesh=SkeletalMesh'axis_halftrack_anm.Halftrack_body_ext'

	DriveAnim=Vhalftrack_driver_idle
	BeginningIdleAnim = driver_hatch_idle_close

	Skins(0)=Texture'axis_vehicles_tex.ext_vehicles.Halftrack_ext'
	Skins(1)=Texture'axis_vehicles_tex.Treads.Halftrack_treads'
	Skins(2)=Texture'axis_vehicles_tex.Treads.Halftrack_treads'
	Skins(3)=Texture'axis_vehicles_tex.int_vehicles.halftrack_int'

	HighDetailOverlay=Material'axis_vehicles_tex.int_vehicles.halftrack_int_s'
	bUseHighDetailOverlayIndex=true
	HighDetailOverlayIndex=3

    // Hud stuff
	VehicleHudImage=Texture'InterfaceArt_tex.Tank_Hud.halftrack_body'
	VehicleHudEngineX=0.5
	VehicleHudEngineY=0.25
	VehicleHudOccupantsX(0)=0.45
	VehicleHudOccupantsX(1)=0.5
	VehicleHudOccupantsX(2)=0.45
	VehicleHudOccupantsX(3)=0.45
	VehicleHudOccupantsX(4)=0.45
	VehicleHudOccupantsX(5)=0.55
	VehicleHudOccupantsX(6)=0.55
	VehicleHudOccupantsX(7)=0.55
	VehicleHudOccupantsY(0)=0.45
	VehicleHudOccupantsY(1)=0.525
	VehicleHudOccupantsY(2)=0.6
	VehicleHudOccupantsY(3)=0.7
	VehicleHudOccupantsY(4)=0.8
	VehicleHudOccupantsY(5)=0.6
	VehicleHudOccupantsY(6)=0.7
	VehicleHudOccupantsY(7)=0.8

    // Vehicle Params
	VehicleMass=8.5
	VehicleTeam=0;
    Health=300
    HealthMax=300.000000
	DisintegrationHealth=-10000 // No ammo supply so don't disintegrate!
	CollisionHeight=+40.0
	CollisionRadius=175
	DriverDamageMult=1.000000
	TreadVelocityScale=80.000000
	MaxDesireability=0.100000

	//TransRatio=0.09;

    // Weapon Attachments
	PassengerWeapons(0)=(WeaponPawnClass=Class'ROVehicles.Sdkfz251GunPawn',WeaponBone=mg_base)

	PassengerWeapons(1)=(WeaponPawnClass=Class'ROVehicles.Sdkfz251PassengerOne',WeaponBone=passenger_L_1)
	PassengerWeapons(2)=(WeaponPawnClass=Class'ROVehicles.Sdkfz251PassengerTwo',WeaponBone=passenger_L_2)
	PassengerWeapons(3)=(WeaponPawnClass=Class'ROVehicles.Sdkfz251PassengerThree',WeaponBone=passenger_L_3)
	PassengerWeapons(4)=(WeaponPawnClass=Class'ROVehicles.Sdkfz251PassengerFour',WeaponBone=passenger_R_1)
	PassengerWeapons(5)=(WeaponPawnClass=Class'ROVehicles.Sdkfz251PassengerFive',WeaponBone=passenger_R_2)
	PassengerWeapons(6)=(WeaponPawnClass=Class'ROVehicles.Sdkfz251PassengerSix',WeaponBone=passenger_R_3)

    // Position Info
    DriverAttachmentBone=driver_player
	DriverPositions(0)=(PositionMesh=Mesh'axis_halftrack_anm.Halftrack_body_int',DriverTransitionAnim=none,TransitionUpAnim=Overlay_Out,ViewPitchUpLimit=1,ViewPitchDownLimit=65535,ViewPositiveYawLimit=0,ViewNegativeYawLimit=0,bExposed=false,bDrawOverlays=true)
	DriverPositions(1)=(PositionMesh=Mesh'axis_halftrack_anm.Halftrack_body_int',DriverTransitionAnim=Vhalftrack_driver_idle,TransitionUpAnim=driver_hatch_open,TransitionDownAnim=Overlay_in,ViewPitchUpLimit=500,ViewPitchDownLimit=49000,ViewPositiveYawLimit=27000,ViewNegativeYawLimit=-27000,bExposed=false)
	DriverPositions(2)=(PositionMesh=Mesh'axis_halftrack_anm.Halftrack_body_int',DriverTransitionAnim=Vhalftrack_driver_idle,TransitionDownAnim=driver_hatch_close,ViewPitchUpLimit=500,ViewPitchDownLimit=49000,ViewPositiveYawLimit=27000,ViewNegativeYawLimit=-27000,bExposed=true,ViewFOV=85)
	FPCamPos=(X=0.0,Y=0.0,Z=0.0)
	FPCamViewOffset=(X=0,Y=0,Z=0)
	TPCamLookat=(X=0.000000,Z=0.000000)
	TPCamWorldOffset=(X=0,Y=0,Z=50)
	TPCamDistance=1000.000000
	DrivePos=(X=0,Y=0,Z=0)
	DriveRot=(Pitch=0,Roll=0,Yaw=0)
	ExitPositions(0)=(Y=-165.000000,Z=40.000000)
	ExitPositions(1)=(Y=165.000000,Z=40.000000)
	ExitPositions(2)=(Y=-165.000000,Z=-40.000000)
	ExitPositions(3)=(Y=165.000000,Z=-40.000000)
	EntryRadius=375.0

	// Driver overlay
	HUDOverlayClass=class'ROVehicles.Sdkfz251DriverOverlay'
	HUDOverlayOffset=(X=0,Y=0,Z=0.8)
	HUDOverlayFOV=100

	VehiclePositionString="in a SDKFZ-251"
	VehicleNameString="SDKFZ-251"

     // Camera parameters
	PitchUpLimit=500
	PitchDownLimit=49000

	// Destruction
	DestroyedVehicleMesh=StaticMesh'axis_vehicles_stc.Halftrack_Destoyed'
	DestructionLinearMomentum=(Min=100.000000,Max=350.000000)
	DestructionAngularMomentum=(Min=50.000000,Max=150.000000)
	DamagedEffectOffset=(X=-40.000000,Y=10.000000,Z=10.000000)
	DamagedEffectScale=0.75

    // Exhaust effects
	ExhaustPipes(0)=(ExhaustPosition=(X=105,Y=-70,Z=-15),ExhaustRotation=(pitch=36000,yaw=5000,roll=0))
	ExhaustEffectClass=class'ROEffects.ExhaustPetrolEffect'
	ExhaustEffectLowClass=class'ROEffects.ExhaustPetrolEffect_simple'

	// sound
	IdleSound=sound'Vehicle_Engines.sdkfz251.sdkfz251_engine_loop'
	StartUpSound=sound'Vehicle_Engines.sdkfz251.sdkfz251_engine_start'
	ShutDownSound=sound'Vehicle_Engines.sdkfz251.sdkfz251_engine_stop'
	MaxPitchSpeed=350

	// RO Vehicle sound vars
	LeftTreadSound=sound'Vehicle_Engines.track_squeak_L02'
	RightTreadSound=sound'Vehicle_Engines.track_squeak_R02'
	RumbleSound=sound'Vehicle_Engines.tank_inside_rumble03'
	LeftTrackSoundBone=Steer_Wheel_LF
	RightTrackSoundBone=Steer_Wheel_RF
	RumbleSoundBone=body

	//Steering
	SteeringScaleFactor=4.0
	SteerBoneName="Steering"
	SteerBoneAxis=AXIS_X

	// Wheels
	// Steering Wheels
    Begin Object Class=SVehicleWheel Name=RFWheel
		bPoweredWheel=False
		SteerType=VST_Steered
		BoneName="Wheel_F_L"
		BoneRollAxis=AXIS_Y
		WheelRadius=27.500000
		SupportBoneName="Axle_LF"
		SupportBoneAxis=AXIS_X
    End Object
    Wheels(0)=SVehicleWheel'ROVehicles.Sdkfz251Transport.RFWheel'

    Begin Object Class=SVehicleWheel Name=LFWheel
		bPoweredWheel=False
		SteerType=VST_Steered
		BoneName="Wheel_F_R"
		BoneRollAxis=AXIS_Y
		WheelRadius=27.500000
		SupportBoneName="Axle_RF"
		SupportBoneAxis=AXIS_X
    End Object
    Wheels(1)=SVehicleWheel'ROVehicles.Sdkfz251Transport.LFWheel'

     // Track Wheels
    Begin Object Class=SVehicleWheel Name=FLeft_Drive_Wheel
		bPoweredWheel=True
		BoneOffset=(X=0.0,Y=0.0,Z=7.0)
		BoneName="Steer_Wheel_LF"
		BoneRollAxis=AXIS_Y
		WheelRadius=30.000000
    End Object
	Wheels(2)=SVehicleWheel'ROVehicles.Sdkfz251Transport.FLeft_Drive_Wheel'

    Begin Object Class=SVehicleWheel Name=FRight_Drive_Wheel
		bPoweredWheel=True
		BoneOffset=(X=0.0,Y=0.0,Z=7.0)
		BoneName="Steer_Wheel_RF"
		BoneRollAxis=AXIS_Y
		WheelRadius=30.000000
    End Object
    Wheels(3)=SVehicleWheel'ROVehicles.Sdkfz251Transport.FRight_Drive_Wheel'

    Begin Object Class=SVehicleWheel Name=RLeft_Drive_Wheel
		bPoweredWheel=True
		BoneOffset=(X=0.0,Y=0.0,Z=-2.0)
		BoneName="Steer_Wheel_LR"
		BoneRollAxis=AXIS_Y
		WheelRadius=30.000000
    End Object
    Wheels(4)=SVehicleWheel'ROVehicles.Sdkfz251Transport.RLeft_Drive_Wheel'

    Begin Object Class=SVehicleWheel Name=RRight_Drive_Wheel
		bPoweredWheel=True
		BoneOffset=(X=0.0,Y=0.0,Z=-2.0)
		BoneName="Steer_Wheel_RR"
		BoneRollAxis=AXIS_Y
		WheelRadius=30.000000
    End Object
    Wheels(5)=SVehicleWheel'ROVehicles.Sdkfz251Transport.RRight_Drive_Wheel'

	// Wheel bones for animation
	LeftWheelBones(0)="Wheel_T_L_1"
	LeftWheelBones(1)="Wheel_T_L_2"
	LeftWheelBones(2)="Wheel_T_L_3"
	LeftWheelBones(3)="Wheel_T_L_4"
	LeftWheelBones(4)="Wheel_T_L_5"
	LeftWheelBones(5)="Wheel_T_L_6"
	LeftWheelBones(6)="Wheel_T_L_7"
	LeftWheelBones(7)="Wheel_T_L_8"

	RightWheelBones(0)="Wheel_T_R_1"
	RightWheelBones(1)="Wheel_T_R_2"
	RightWheelBones(2)="Wheel_T_R_3"
	RightWheelBones(3)="Wheel_T_R_4"
	RightWheelBones(4)="Wheel_T_R_5"
	RightWheelBones(5)="Wheel_T_R_6"
	RightWheelBones(6)="Wheel_T_R_7"
	RightWheelBones(7)="Wheel_T_R_8"

	// Karma
    Begin Object Class=KarmaParamsRBFull Name=KParams0
		KInertiaTensor(0)=1.000000
		KInertiaTensor(3)=3.000000
		KInertiaTensor(5)=3.000000
		KCOMOffset=(X=-0.0000,Z=0.00000)
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
    KParams=KarmaParamsRBFull'ROVehicles.Sdkfz251Transport.KParams0'

    // Special hit points
	VehHitpoints(0)=(PointRadius=9.0,PointHeight=0.0,PointScale=1.0,PointBone=camera_driver,PointOffset=(X=0.0,Y=0.0,Z=0.0),bPenetrationPoint=false,DamageMultiplier=0.0,HitPointType=HP_Driver)
	VehHitpoints(1)=(PointRadius=30.0,PointHeight=0.0,PointScale=1.0,PointBone=Engine,PointOffset=(X=15.0,Y=0.0,Z=-15.0),bPenetrationPoint=false,DamageMultiplier=5.0,HitPointType=HP_Engine)

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
	WheelLatFrictionScale=1.350000
	WheelHandbrakeSlip=0.010000
	WheelHandbrakeFriction=0.100000
	WheelSuspensionTravel=15.000000
	WheelSuspensionMaxRenderTravel=15.000000
	FTScale=0.030000
	ChassisTorqueScale=0.400000
	MinBrakeFriction=4.000000
	MaxSteerAngleCurve=(Points=((OutVal=35.000000),(InVal=1500.000000,OutVal=20.000000),(InVal=1000000000.000000,OutVal=15.000000)))
	SteerSpeed=160.000000
	TurnDamping=35.000000
	StopThreshold=100.000000
	HandbrakeThresh=200.000000
	LSDFactor=1.000000
	CenterSpringForce="SpringONSSRV"

	// Engine/Transmission
	TorqueCurve=(Points=((InVal=0,OutVal=10.0),(InVal=200,OutVal=1.0),(InVal=1500,OutVal=2.5),(InVal=2200,OutVal=0.0)))
	GearRatios(0)=-0.200000
	GearRatios(1)=0.200000
	GearRatios(2)=0.350000
	GearRatios(3)=0.550000
	GearRatios(4)=0.750000
	TransRatio=0.12
	ChangeUpPoint=2000.000000
	ChangeDownPoint=1000.000000

	EngineBrakeFactor=0.000100
	EngineBrakeRPMScale=0.100000
	MaxBrakeTorque=20.000000
	EngineInertia=0.100000
	IdleRPM=500.000000
	EngineRPMSoundRange=5000
	RevMeterScale=4000.000000
	GroundSpeed=325.000000

	// misc
    ObjectiveGetOutDist=1500.000000
//	bDontUsePositionMesh=true
 	bMultiPosition=true//false
 	bIsApc = true
}
