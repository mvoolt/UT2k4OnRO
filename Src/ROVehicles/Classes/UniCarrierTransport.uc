//=============================================================================
// UniCarrierTransport
//=============================================================================
// Universal Carrier Transport Vehicle class
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2006 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================
class UniCarrierTransport extends ROWheeledVehicle;

#exec OBJ LOAD FILE=..\Animations\allies_carrier_anm.ukx
#exec OBJ LOAD FILE=..\textures\allies_vehicles_tex2.utx
#exec OBJ LOAD FILE=..\Sounds\Vehicle_EnginesTwo.uax

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

 	L.AddPrecacheMaterial(Material'allies_vehicles_tex2.ext_vehicles.universal_carrier');
 	L.AddPrecacheMaterial(Material'allies_vehicles_tex.Treads.T60_treads');
 	L.AddPrecacheMaterial(Material'allies_vehicles_tex2.int_vehicles.Universal_Carrier_Int');
 	L.AddPrecacheMaterial(Material'allies_vehicles_tex2.int_vehicles.Universal_Carrier_Int_S');
}

simulated function UpdatePrecacheMaterials()
{
    Level.AddPrecacheMaterial(Material'allies_vehicles_tex2.ext_vehicles.universal_carrier');
    Level.AddPrecacheMaterial(Material'allies_vehicles_tex.Treads.T60_treads');
    Level.AddPrecacheMaterial(Material'allies_vehicles_tex2.int_vehicles.Universal_Carrier_Int');
    Level.AddPrecacheMaterial(Material'allies_vehicles_tex2.int_vehicles.Universal_Carrier_Int_S');

	Super.UpdatePrecacheMaterials();
}

// Overriden to handle the special driver animations for this vehicle
simulated state ViewTransition
{
	simulated function HandleTransition()
	{
	     if( Role == ROLE_AutonomousProxy || Level.Netmode == NM_Standalone || Level.Netmode == NM_ListenServer )
	     {
	         if( DriverPositions[DriverPositionIndex].PositionMesh != none && !bDontUsePositionMesh)
	             LinkMesh(DriverPositions[DriverPositionIndex].PositionMesh);
	     }

		 if( PreviousPositionIndex < DriverPositionIndex && HasAnim(DriverPositions[PreviousPositionIndex].TransitionUpAnim))
		 {
		 	 //log("HandleTransition Player Transition Up!");
			 PlayAnim(DriverPositions[PreviousPositionIndex].TransitionUpAnim);
		 }
		 else if ( HasAnim(DriverPositions[PreviousPositionIndex].TransitionDownAnim) )
		 {
		 	 //log("HandleTransition Player Transition Down!");
			 PlayAnim(DriverPositions[PreviousPositionIndex].TransitionDownAnim);
		 }

		 if( Driver != none && PreviousPositionIndex < DriverPositionIndex && DriverPositionIndex == InitialPositionIndex)
		 {
			 Driver.PlayAnim(DriveAnim);
		 }
		 else if(Driver != none && Driver.HasAnim(DriverPositions[DriverPositionIndex].DriverTransitionAnim))
		 {
	         Driver.PlayAnim(DriverPositions[DriverPositionIndex].DriverTransitionAnim);
	     }
	}
}


defaultproperties
{
	// Display
	Mesh=SkeletalMesh'allies_carrier_anm.carrier_body_ext'

	DriveAnim=VUC_driver_idle_close
	BeginningIdleAnim = driver_hatch_idle_close

	Skins(0)=Texture'allies_vehicles_tex2.ext_vehicles.universal_carrier'
	Skins(1)=Texture'allies_vehicles_tex.Treads.T60_treads'
	Skins(2)=Texture'allies_vehicles_tex.Treads.T60_treads'
	Skins(3)=Texture'allies_vehicles_tex2.int_vehicles.Universal_Carrier_Int'

	HighDetailOverlay=Material'allies_vehicles_tex2.int_vehicles.Universal_Carrier_Int_S'
	bUseHighDetailOverlayIndex=true
	HighDetailOverlayIndex=3

    // Hud stuff
	VehicleHudImage=Texture'InterfaceArt2_tex.Tank_Hud.Carrier_body'
	VehicleHudEngineX=0.5
	VehicleHudEngineY=0.75
	VehicleHudOccupantsX(0)=0.58
	VehicleHudOccupantsX(1)=0.46
	VehicleHudOccupantsX(2)=0.39
	VehicleHudOccupantsX(3)=0.39
	VehicleHudOccupantsX(4)=0.62
	VehicleHudOccupantsX(5)=0.62
	VehicleHudOccupantsY(0)=0.35
	VehicleHudOccupantsY(1)=0.3
	VehicleHudOccupantsY(2)=0.5
	VehicleHudOccupantsY(3)=0.65
	VehicleHudOccupantsY(4)=0.65
	VehicleHudOccupantsY(5)=0.5

    // Vehicle Params
	VehicleMass=5.0
	VehicleTeam=1;
    Health=300
    HealthMax=300.000000
	DisintegrationHealth=-10000//No ammo supply so don't disintegrate!!
	CollisionHeight=+40.0
	CollisionRadius=175
	DriverDamageMult=1.000000
	TreadVelocityScale=80.000000
	MaxDesireability=0.100000

	//TransRatio=0.09;

    // Weapon Attachments
	PassengerWeapons(0)=(WeaponPawnClass=Class'ROVehicles.UniCarrierGunPawn',WeaponBone=mg_base)
	PassengerWeapons(1)=(WeaponPawnClass=Class'ROVehicles.UniCarrierPassengerOne',WeaponBone=passenger_L_1)
	PassengerWeapons(2)=(WeaponPawnClass=Class'ROVehicles.UniCarrierPassengerTwo',WeaponBone=passenger_L_2)
	PassengerWeapons(3)=(WeaponPawnClass=Class'ROVehicles.UniCarrierPassengerThree',WeaponBone=passenger_R_1)
	PassengerWeapons(4)=(WeaponPawnClass=Class'ROVehicles.UniCarrierPassengerFour',WeaponBone=passenger_R_2)


    // Position Info
    DriverAttachmentBone=driver_player
	DriverPositions(0)=(PositionMesh=Mesh'allies_carrier_anm.carrier_body_int',DriverTransitionAnim=none,TransitionUpAnim=Overlay_Out,ViewPitchUpLimit=1,ViewPitchDownLimit=65535,ViewPositiveYawLimit=0,ViewNegativeYawLimit=0,bExposed=false,bDrawOverlays=true)
	DriverPositions(1)=(PositionMesh=Mesh'allies_carrier_anm.carrier_body_int',DriverTransitionAnim=VUC_driver_close,TransitionUpAnim=driver_hatch_open,TransitionDownAnim=Overlay_in,ViewPitchUpLimit=14000,ViewPitchDownLimit=58000,ViewPositiveYawLimit=27000,ViewNegativeYawLimit=-27000,bExposed=false)
	DriverPositions(2)=(PositionMesh=Mesh'allies_carrier_anm.carrier_body_int',DriverTransitionAnim=VUC_driver_open,TransitionDownAnim=driver_hatch_close,ViewPitchUpLimit=14000,ViewPitchDownLimit=62500,ViewPositiveYawLimit=27000,ViewNegativeYawLimit=-27000,bExposed=true,ViewFOV=85)
	FPCamPos=(X=0.0,Y=0.0,Z=0.0)
	FPCamViewOffset=(X=0,Y=0,Z=0)
	TPCamLookat=(X=0.000000,Z=0.000000)
	TPCamWorldOffset=(X=0,Y=0,Z=50)
	TPCamDistance=200.000000
	DrivePos=(X=0,Y=0,Z=0)
	DriveRot=(Pitch=0,Roll=0,Yaw=0)
	ExitPositions(0)=(Y=-165.000000,Z=40.000000)
	ExitPositions(1)=(Y=165.000000,Z=40.000000)
	ExitPositions(2)=(Y=-165.000000,Z=-40.000000)
	ExitPositions(3)=(Y=165.000000,Z=-40.000000)
	EntryRadius=375.0

	// Driver overlay
	HUDOverlayClass=class'ROVehicles.UniCarrierDriverOverlay'
	HUDOverlayOffset=(X=0,Y=-0.8,Z=1.99)
	HUDOverlayFOV=81

	VehiclePositionString="in a Universal Carrier"
	VehicleNameString="Universal Carrier"

     // Camera parameters
	PitchUpLimit=500
	PitchDownLimit=49000

	// Destruction
	DestroyedVehicleMesh=StaticMesh'allies_vehicles_stc.Carrier.Carrier_destroyed'
	DestructionLinearMomentum=(Min=100.000000,Max=350.000000)
	DestructionAngularMomentum=(Min=50.000000,Max=150.000000)
	DamagedEffectOffset=(X=-40.000000,Y=10.000000,Z=10.000000)
	DamagedEffectScale=0.75

    // Exhaust effects
	ExhaustPipes(0)=(ExhaustPosition=(X=-105,Y=33,Z=13),ExhaustRotation=(pitch=36000,yaw=0,roll=0))
	ExhaustPipes(1)=(ExhaustPosition=(X=-105,Y=-33,Z=13),ExhaustRotation=(pitch=36000,yaw=0,roll=0))
	ExhaustEffectClass=class'ROEffects.ExhaustPetrolEffect'
	ExhaustEffectLowClass=class'ROEffects.ExhaustPetrolEffect_simple'

	// sound
	IdleSound=sound'Vehicle_EnginesTwo.UC.UC_engine_loop'
	StartUpSound=sound'Vehicle_EnginesTwo.UC.UC_engine_start'
	ShutDownSound=sound'Vehicle_EnginesTwo.UC.UC_engine_stop'
	MaxPitchSpeed=350

	// RO Vehicle sound vars
	LeftTreadSound=sound'Vehicle_EnginesTwo.UC.UC_tread_L'
	RightTreadSound=sound'Vehicle_EnginesTwo.UC.UC_tread_R'
	RumbleSound=sound'Vehicle_Engines.tank_inside_rumble03'
	LeftTrackSoundBone=Wheel_T_L_3
	RightTrackSoundBone=Wheel_T_R_3
	RumbleSoundBone=body

	//Steering
	SteeringScaleFactor=4.0
	SteerBoneName="Steering"
	SteerBoneAxis=AXIS_X

	// Wheels
	// Steering Wheels
     Begin Object Class=SVehicleWheel Name=LF_Steering
         bPoweredWheel=True
         BoneOffset=(X=0.0,Y=0.0,Z=10.0)
         SteerType=VST_Steered
         BoneName="Steer_Wheel_LF"
         BoneRollAxis=AXIS_Y
         WheelRadius=33.000000
     End Object
     Wheels(0)=SVehicleWheel'ROVehicles.UniCarrierTransport.LF_Steering'

     Begin Object Class=SVehicleWheel Name=RF_Steering
         bPoweredWheel=True
	    BoneOffset=(X=0.0,Y=0.0,Z=10.0)
         SteerType=VST_Steered
         BoneName="Steer_Wheel_RF"
         BoneRollAxis=AXIS_Y
         WheelRadius=33.000000
     End Object
     Wheels(1)=SVehicleWheel'ROVehicles.UniCarrierTransport.RF_Steering'

     Begin Object Class=SVehicleWheel Name=LR_Steering
         bPoweredWheel=True
         BoneOffset=(X=0.0,Y=0.0,Z=10.0)
         SteerType=VST_Inverted
         BoneName="Steer_Wheel_LR"
         BoneRollAxis=AXIS_Y
         WheelRadius=33.000000
     End Object
     Wheels(2)=SVehicleWheel'ROVehicles.UniCarrierTransport.LR_Steering'

     Begin Object Class=SVehicleWheel Name=RR_Steering
         bPoweredWheel=True
         BoneOffset=(X=0.0,Y=0.0,Z=10.0)
         SteerType=VST_Inverted
         BoneName="Steer_Wheel_RR"
         BoneRollAxis=AXIS_Y
         WheelRadius=33.000000
     End Object
     Wheels(3)=SVehicleWheel'ROVehicles.UniCarrierTransport.RR_Steering'
     // End Steering Wheels

     // Center Drive Wheels
     Begin Object Class=SVehicleWheel Name=Left_Drive_Wheel
         bPoweredWheel=True
         BoneOffset=(X=0.0,Y=0.0,Z=10.0)
         BoneName="Wheel_T_L_3"
         BoneRollAxis=AXIS_Y
         WheelRadius=33.000000
     End Object
     Wheels(4)=SVehicleWheel'ROVehicles.UniCarrierTransport.Left_Drive_Wheel'

     Begin Object Class=SVehicleWheel Name=Right_Drive_Wheel
         bPoweredWheel=True
         BoneOffset=(X=0.0,Y=0.0,Z=10.0)
         BoneName="Wheel_T_R_3"
         BoneRollAxis=AXIS_Y
         WheelRadius=33.000000
     End Object
     Wheels(5)=SVehicleWheel'ROVehicles.UniCarrierTransport.Right_Drive_Wheel'

	// Wheel bones for animation
     LeftWheelBones(0)="Wheel_T_L_1"
     LeftWheelBones(1)="Wheel_T_L_2"
     LeftWheelBones(2)="Wheel_T_L_3"
     LeftWheelBones(3)="Wheel_T_L_4"
     LeftWheelBones(4)="Wheel_T_L_5"

     RightWheelBones(0)="Wheel_T_R_1"
     RightWheelBones(1)="Wheel_T_R_2"
     RightWheelBones(2)="Wheel_T_R_3"
     RightWheelBones(3)="Wheel_T_R_4"
     RightWheelBones(4)="Wheel_T_R_5"

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
         KMaxAngularSpeed=2.0//3.0			// Slow down the angular velocity so the tank feels "heavier"
     End Object
    KParams=KarmaParamsRBFull'ROVehicles.UniCarrierTransport.KParams0'

	// Physics and movement
    bHasHandbrake=True
	WheelSoftness=0.025000
	WheelPenScale=2.0//1.200000
	WheelPenOffset=0.010000
	WheelRestitution=0.100000
	WheelInertia=0.100000
	WheelLongFrictionFunc=(Points=(,(InVal=100.000000,OutVal=1.000000),(InVal=200.000000,OutVal=0.900000),(InVal=10000000000.000000,OutVal=0.900000)))
	WheelLongSlip=0.001000
	WheelLatSlipFunc=(Points=((InVal=0.0,OutVal=0.0),(InVal=30.0,OutVal=0.009),(InVal=10000000000.0,OutVal=0.00)))
	WheelLongFrictionScale=1.5
	WheelLatFrictionScale=3.0
	WheelHandbrakeSlip=0.010000
	WheelHandbrakeFriction=0.100000
	WheelSuspensionTravel=15.000000
	WheelSuspensionMaxRenderTravel=0.000000
	FTScale=0.030000
	ChassisTorqueScale=0.25
	MinBrakeFriction=4.000000
	MaxSteerAngleCurve=(Points=((OutVal=35.000000),(InVal=1500.000000,OutVal=20.000000),(InVal=1000000000.000000,OutVal=15.000000)))
	TorqueCurve=(Points=((InVal=0,OutVal=11.0),(InVal=200,OutVal=1.25),(InVal=1500,OutVal=2.5),(InVal=2200,OutVal=0.0)))
	GearRatios(0)=-0.200000
	GearRatios(1)=0.200000
	GearRatios(2)=0.350000
	GearRatios(3)=0.550000
	GearRatios(4)=0.600000
	TransRatio=0.12
	ChangeUpPoint=2000.000000
	ChangeDownPoint=1000.000000
	LSDFactor=1.000000
	EngineBrakeFactor=0.000100
	EngineBrakeRPMScale=0.100000
	MaxBrakeTorque=20.000000
	SteerSpeed=160.000000
	TurnDamping=50
	StopThreshold=100.000000
	HandbrakeThresh=200.000000
	EngineInertia=0.100000
	IdleRPM=500.000000
	EngineRPMSoundRange=5000
    RevMeterScale=4000.000000
    bMakeBrakeLights=False

    // Special hit points
	VehHitpoints(0)=(PointRadius=9.0,PointHeight=0.0,PointScale=1.0,PointBone=driver_player,PointOffset=(X=-9.0,Y=3.0,Z=51.0),bPenetrationPoint=false,DamageMultiplier=0.0,HitPointType=HP_Driver)
    VehHitpoints(1)=(PointRadius=17.0,PointHeight=0.0,PointScale=1.0,PointBone=driver_player,PointOffset=(X=-10.0,Y=2.0,Z=27.0),bPenetrationPoint=false,DamageMultiplier=0.0,HitPointType=HP_Driver)
	VehHitpoints(2)=(PointRadius=20.0,PointHeight=0.0,PointScale=1.0,PointBone=Engine,PointOffset=(X=-15.0,Y=0.0,Z=0.0),bPenetrationPoint=false,DamageMultiplier=5.0,HitPointType=HP_Engine)
	VehHitpoints(3)=(PointRadius=20.0,PointHeight=0.0,PointScale=1.0,PointBone=Engine,PointOffset=(X=22.0,Y=0.0,Z=0.0),bPenetrationPoint=false,DamageMultiplier=5.0,HitPointType=HP_Engine)
	VehHitpoints(4)=(PointRadius=15.0,PointHeight=0.0,PointScale=1.0,PointBone=Engine,PointOffset=(X=0.0,Y=0.0,Z=30.0),bPenetrationPoint=false,DamageMultiplier=5.0,HitPointType=HP_Engine)
	VehHitpoints(5)=(PointRadius=15.0,PointHeight=0.0,PointScale=1.0,PointBone=Engine,PointOffset=(X=27.0,Y=0.0,Z=30.0),bPenetrationPoint=false,DamageMultiplier=5.0,HitPointType=HP_Engine)
	// misc
    ObjectiveGetOutDist=1500.000000
//	bDontUsePositionMesh=true
 	bMultiPosition=true//false
 	bIsApc = true
 	bSpecialTankTurning=true
}
