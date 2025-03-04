//==============================================================================
// BT7Tank
//
// Red Orchestra Source - William Miller
// Copyright (C) 2007 Tripwire Interactive, LLC
//
// Stats from:
// From http://www.wwiivehicles.com/ussr/tanks_medium/bt7.html
// From http://www.tarrif.net/
//
// BT7 tank class
//==============================================================================
//==============================================================================
// Work in Progress and Defect List
//
//Done 1:  ---- Fix gun sight
//Done 2:  ---- Fix gunner position inside turret
//Done 3:  ---- Adjust cannon sight and range bar. Add a 250 range value?
//Done 4:  ---- Adjust AltFireOffset for MG.
//Done 5:  ---- Fix turret skins
//Done 6:  ---- Adjust hit points for body (driver, passengers, ammo, and engine)
//Done 7:  ---- Adjust hit points for turret (commander)
//Done 8:  ---- Update the location of ExhaustPipes(0) and (1).  Exhaust:  rotation set to 'rear' not 'right'.  Check the coordinates and swing them to the rear.  Panzer III
//Done 9:  ---- Fix flapping hatch.  This could be code.  Does BeginningIdleAnim equal what we have in the model for the default ani?
//Done 10: ---- Fix driver's hatch texture missing - Ken
//Done 11: ---- Fix location of passenger HUD dots so they line up with the players position on the vehicle
//Done 12: ---- Make sure passengers appear on the vehicle where the HUD dots are.  Same thing as #11.
//Done 13: ---- Get a better tank texture for the HUD - Ken
//Done 14: ---- Move turret forward on tank HUD and make it a little smaller - Ken
//Done 15: ---- Driver compartment issue: a, steering wheel column rotation is off; b, when driving with the hatch open there is a stick that shows.
//Done 16: ---- We need a ukx overlay file for AHZ_ROVehicles.BT7DriverOverlay - See if we can use one from another vehicle, expirement with various driver overlays.
//Done 17: ---- Passenger in #3 spot is actually in the turret. Forgot to update the one bone name in the passenger class.
//Done 18: ---- Floating:  physics wheel, offset property he thinks is "offset", adjust negative Z axis.  Email him if question.   Changed BoneOffset=(X=0.0,Y=0.0,Z=5.0)
//Done 19: ---- Scrolling tracks when driver on-board:  increase the weight until it just sinks. The moving tracks are due to karma not being complete.  Adjust TreadVelocityScale
//Done 20: ---- Driver bone/cam position:  when first getting in... fix the "reference pose"... camera/pose position. DrivePos in each pawn
//Done 21: ---- Move engine icon to the right.
//Done 22: ---- Add mapper configurable variable to allow riders.
//Done 23: ---- Create the ROTreadCraftWithRiders class to extend the TakeDamage and specific code to test for HP_Normal. Move bAllowRiders to this class.
//TEST 24: #### Figure out how to allow a rider (non-tanker) to jump across to another riding position.  Look at ServerChangeDriverPosition in VehicleWeaponPawn.
//              From looking at the code, when the intended key is pressed is executes ServerChangeDriverPosition, which then fails (line 889) the
//              intended WeaponPawn's "TryToDrive" routine because the pawn is not a tanker role.  Then it executes the current KDriverEnter function on line 891.
//              Thus the player goes right back to where they started from.
//
//              No good --- Solution 1 - Create a new class (ROTankPassengerPawn) to sit between the BT7Passenger and ROPassengerPawn.  It will not effect the turret pawn.
//              Override the "ServerChangeDriverPosition" in VehicleWeaponPawn. Change the "If" on line 889 to now be:
//              if (!VehicleBase.WeaponPawns[F].TryToDrive(OldDriver) || !WeaponPawns[X].IsA('ROPassengerPawn'))
//
//              Good, this is what I did --- Solution 2 - Set bMustBeTankCrew = false in the BT7PassengerPawn classes.
//                     4/15/2007: Well, I thought this was working, now it seems not to be.  Retest....
//
//Done 25: ---- When the driver hatch is closed, there is a gap on the left hand side. - Ken.  Expirement with various driver overlays.
//Done 26: ---- Adjust the track speed to the wheel.  The track moves faster than the wheel.  Adjust TreadVelocityScale.
//Done 27: ---- Add rider logic to BT7CannonPawn so riders can connect when a driver in the vehicle base is present.
//Done 28: ---- Vehicle speed is reduced drastcially when in water.  KMaxAngularSpeed=1.0
//Done 29: ---- Player animations.  Commander - switch to one that does not have the hands sticking out of the turret.
//Done 30: ---- Player animations.  Rider - Use the German rider ani's also.  Mix them up.
//Done 31: ---- Cmdr does not have bino ani.  Note: This effect does not exist for the Cmdr.
//Done 32: ---- TakeDamage, The driver is not being found.  Is the hit point adjusted properly?
//Done 33: ---- Show Ken the driver's compartment.  It is offset to the right.  Bring back left, this is why the driver's visor is off-center.
//Done 34: ---- In BT7CannonPawn I should be able to access the bAllowRiders value. Create a reference to the BT7Tank class.
//Done 35: ---- Redo tracks texture
//Done 36: ---- Use a different animation for cmdr when he is inside the vehicle.  So the arms do not stick up.
//Done 37: ---- Riders not taking damage. Ramm fixed.
//Done 38: ---- Lower the hit point for the driver.
//==============================================================================
class BT7Tank extends ROTreadCraftWithRiders;

#exec OBJ LOAD FILE=..\textures\allies_ahz_vehicles_tex.utx
#exec OBJ LOAD FILE=..\Animations\allies_ahz_bt7_anm.ukx
#exec OBJ LOAD FILE=..\StaticMeshes\allies_ahz_vehicles_stc.usx

//==============================================================================
// Functions
//==============================================================================
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

//==============================================================================
// Default Properties
//==============================================================================
defaultproperties
{
	// Display
	Mesh=Mesh'allies_ahz_bt7_anm.bt7_body_ext'
                                                                                                                                                                                                                                                                                                                                                                                                              //teuf was here
	DriveAnim=VT60_driver_idle_close
	BeginningIdleAnim=driver_hatch_idle_close

	Skins(0)=Texture'allies_ahz_vehicles_tex.ext_vehicles.BT7_ext'
	Skins(1)=Texture'allies_ahz_vehicles_tex.Treads.bt7_treads'
	Skins(2)=Texture'allies_ahz_vehicles_tex.Treads.bt7_treads'
	Skins(3)=Texture'allies_ahz_vehicles_tex.int_vehicles.BT7_int'

	HighDetailOverlay=Material'allies_ahz_vehicles_tex.int_vehicles.BT7_Int'
	bUseHighDetailOverlayIndex=true
	HighDetailOverlayIndex=3

    // Hud stuff
	VehicleHudImage=Texture 'InterfaceArt_ahz_tex.Tank_Hud.BT7_body'
	VehicleHudTurret=TexRotator'InterfaceArt_ahz_tex.Tank_Hud.BT7_turret_rot'
	VehicleHudTurretLook=TexRotator'InterfaceArt_ahz_tex.Tank_Hud.BT7_turret_look'
	VehicleHudThreadsPosX(0)=0.38
	VehicleHudThreadsPosX(1)=0.63
	VehicleHudThreadsPosY=0.52
	VehicleHudThreadsScale=0.55     //size of tank on HUD
	VehicleHudEngineX=0.511
	VehicleHudEngineY=0.66
    VehicleHudOccupantsX(0)=0.50   //horizontal, driver            X = Left/Right
	VehicleHudOccupantsY(0)=0.26    //vertical, driver              Y = Front/Back
    VehicleHudOccupantsX(1)=0.47   //horizontal, gunner
	VehicleHudOccupantsY(1)=0.50    //vertical, gunner
    VehicleHudOccupantsX(2)=0.635   //0.34    //horizontal, passenger one
	VehicleHudOccupantsY(2)=0.65    //0.65    //vertical, passenger one
    VehicleHudOccupantsX(3)=0.635   //0.34    //horizontal, passenger two
	VehicleHudOccupantsY(3)=0.75    //0.75    //vertical, passenger two
    VehicleHudOccupantsX(4)=0.36    //0.65    //horizontal, passenger three
	VehicleHudOccupantsY(4)=0.75    //0.65    //vertical, passenger three
    VehicleHudOccupantsX(5)=0.36    //0.65    //horizontal, passenger four
	VehicleHudOccupantsY(5)=0.65    //0.75    //vertical, passenger four

	// Vehicle Params
	VehicleMass=10.0
	VehicleTeam=1;
	Health=450
	HealthMax=450
	DisintegrationHealth=-1000
	CollisionHeight=+70.0
	CollisionRadius=150.0
	DriverDamageMult=1.0
	TreadVelocityScale=400
	WheelRotationScale=1000
	MaxDesireability=1.0

    GearRatios(0)=-0.250000
	GearRatios(1)=0.250000
	GearRatios(2)=0.400000
	GearRatios(3)=0.650000
	GearRatios(4)=0.700000
    TransRatio=0.13;     //max speed is 38kph cross country

	// Weapon Attachments for turret and riders
	PassengerWeapons(0)=(WeaponPawnClass=class'BT7CannonPawn',WeaponBone=Turret_Placement)                //Turret
    PassengerWeapons(1)=(WeaponPawnClass=Class'AHZ_ROVehicles.BT7PassengerOne',WeaponBone=passenger_01)   //Rider position 1
	PassengerWeapons(2)=(WeaponPawnClass=Class'AHZ_ROVehicles.BT7PassengerTwo',WeaponBone=passenger_02)   //Rider position 2
	PassengerWeapons(3)=(WeaponPawnClass=Class'AHZ_ROVehicles.BT7PassengerThree',WeaponBone=passenger_03) //Rider position 3
	PassengerWeapons(4)=(WeaponPawnClass=Class'AHZ_ROVehicles.BT7PassengerFour',WeaponBone=passenger_04)  //Rider position 4

	// Position Info
	DriverAttachmentBone=driver_attachment
	DriverPositions(0)=(PositionMesh=Mesh'allies_ahz_bt7_anm.BT7_body_int',DriverTransitionAnim=none,TransitionUpAnim=Overlay_Out,ViewPitchUpLimit=1,ViewPitchDownLimit=65535,ViewPositiveYawLimit=0,ViewNegativeYawLimit=0,bExposed=false,bDrawOverlays=true,ViewFOV=53)
	DriverPositions(1)=(PositionMesh=Mesh'allies_ahz_bt7_anm.BT7_body_int',DriverTransitionAnim=VT60_driver_close,TransitionUpAnim=driver_hatch_open,TransitionDownAnim=Overlay_In,ViewPitchUpLimit=2730,ViewPitchDownLimit=61923,ViewPositiveYawLimit=5500,ViewNegativeYawLimit=-5500,bExposed=false,ViewFOV=85)
	DriverPositions(2)=(PositionMesh=Mesh'allies_ahz_bt7_anm.BT7_body_int',DriverTransitionAnim=VT60_driver_open,TransitionDownAnim=driver_hatch_close,ViewPitchUpLimit=2730,ViewPitchDownLimit=60000,ViewPositiveYawLimit=9500,ViewNegativeYawLimit=-9500,bExposed=true,ViewFOV=85)

    FPCamPos=(X=0,Y=0,Z=0)
	FPCamViewOffset=(X=0,Y=0,Z=0)
	bFPNoZFromCameraPitch=True
	TPCamLookat=(X=-50,Y=0,Z=0)
	TPCamWorldOffset=(X=0,Y=0,Z=250)
	TPCamDistance=600
	DrivePos=(X=35,Y=0,Z=-5)

 	// Driver overlay
	HUDOverlayClass=class'AHZ_ROVehicles.BT7DriverOverlay'
	HUDOverlayOffset=(X=-.25,Y=0.0,Z=0.75)//(X=2,Y=0.25,Z=2.5)
	HUDOverlayFOV=145//85

	ExitPositions(0)=(X=0,Y=-200,Z=100)
	ExitPositions(1)=(X=0,Y=200,Z=100)
	EntryPosition=(X=0,Y=0,Z=0)
	EntryRadius=375.0

	VehiclePositionString="in a BT7"
	VehicleNameString="BT7"

	PitchUpLimit=5000
	PitchDownLimit=60000

	// Destruction
	DestroyedVehicleMesh=StaticMesh'allies_ahz_vehicles_stc.BT7_destroyed'
	DestructionLinearMomentum=(Min=100.000000,Max=350.000000)
	DestructionAngularMomentum=(Min=50.000000,Max=150.000000)
	DamagedEffectOffset=(X=-100,Y=20,Z=26)
	DamagedEffectScale=0.80

 	// effects
	ExhaustPipes(0)=(ExhaustPosition=(X=-185,Y=23,Z=48),ExhaustRotation=(pitch=34000,yaw=0,roll=0))
	ExhaustPipes(1)=(ExhaustPosition=(X=-185,Y=-23,Z=48),ExhaustRotation=(pitch=34000,yaw=0,roll=0))
    ExhaustEffectClass=class'ROEffects.ExhaustPetrolEffect'
	ExhaustEffectLowClass=class'ROEffects.ExhaustPetrolEffect_simple'

	// sound
	IdleSound=sound'Vehicle_Engines.T34.t34_engine_loop'
	StartUpSound=sound'Vehicle_Engines.T34.t34_engine_start'
	ShutDownSound=sound'Vehicle_Engines.T34.t34_engine_stop'
	MaxPitchSpeed=350

	// RO Vehicle sound vars
	LeftTreadSound=sound'Vehicle_Engines.track_squeak_L09'
	RightTreadSound=sound'Vehicle_Engines.track_squeak_R09'
	RumbleSound=sound'Vehicle_Engines.tank_inside_rumble01'
	LeftTrackSoundBone=Track_l
	RightTrackSoundBone=Track_r
	RumbleSoundBone=body

	// Steering
	SteeringScaleFactor=4.0
	SteerBoneName="steering_wheel"
	SteerBoneAxis=AXIS_X

	// Wheels
	// Steering Wheels
     Begin Object Class=SVehicleWheel Name=LF_Steering
         bPoweredWheel=True
         BoneOffset=(X=35.0,Y=-7.0,Z=5.0)
         SteerType=VST_Steered
         BoneName="Steer_Wheel_LF"
         BoneRollAxis=AXIS_Y
         WheelRadius=33.000000
     End Object
     Wheels(0)=SVehicleWheel'AHZ_ROVehicles.BT7Tank.LF_Steering'

     Begin Object Class=SVehicleWheel Name=RF_Steering
         bPoweredWheel=True
	    BoneOffset=(X=35.0,Y=7.0,Z=5.0)
         SteerType=VST_Steered
         BoneName="Steer_Wheel_RF"
         BoneRollAxis=AXIS_Y
         WheelRadius=33.000000
     End Object
     Wheels(1)=SVehicleWheel'AHZ_ROVehicles.BT7Tank.RF_Steering'

     Begin Object Class=SVehicleWheel Name=LR_Steering
         bPoweredWheel=True
         BoneOffset=(X=-25.0,Y=-7.0,Z=5.0)
         SteerType=VST_Inverted
         BoneName="Steer_Wheel_LR"
         BoneRollAxis=AXIS_Y
         WheelRadius=33.000000
     End Object
     Wheels(2)=SVehicleWheel'AHZ_ROVehicles.BT7Tank.LR_Steering'

     Begin Object Class=SVehicleWheel Name=RR_Steering
         bPoweredWheel=True
         BoneOffset=(X=-25.0,Y=7.0,Z=5.0)
         SteerType=VST_Inverted
         BoneName="Steer_Wheel_RR"
         BoneRollAxis=AXIS_Y
         WheelRadius=33.000000
     End Object
     Wheels(3)=SVehicleWheel'AHZ_ROVehicles.BT7Tank.RR_Steering'
     // End Steering Wheels

     //-------------------------------------------------------------------------

     // Center Drive Wheels
     Begin Object Class=SVehicleWheel Name=Left_Drive_Wheel
         bPoweredWheel=True
         BoneOffset=(X=5.0,Y=7.0,Z=5.0)
         BoneName="Drive_Wheel_L"
         BoneRollAxis=AXIS_Y
         WheelRadius=33.000000
     End Object
     Wheels(4)=SVehicleWheel'AHZ_ROVehicles.BT7Tank.Left_Drive_Wheel'

     Begin Object Class=SVehicleWheel Name=Right_Drive_Wheel
         bPoweredWheel=True
         BoneOffset=(X=5.0,Y=-7.0,Z=5.0)
         BoneName="Drive_Wheel_R"
         BoneRollAxis=AXIS_Y
         WheelRadius=33.000000
     End Object
     Wheels(5)=SVehicleWheel'AHZ_ROVehicles.BT7Tank.Right_Drive_Wheel'

	// Wheel bones for animation
	LeftWheelBones(0)="Wheel_L_1"
	LeftWheelBones(1)="Wheel_L_2"
	LeftWheelBones(2)="Wheel_L_3"
	LeftWheelBones(3)="Wheel_L_4"
	LeftWheelBones(4)="Wheel_L_5"
	LeftWheelBones(5)="Wheel_L_6"

	RightWheelBones(0)="Wheel_R_1"
	RightWheelBones(1)="Wheel_R_2"
	RightWheelBones(2)="Wheel_R_3"
	RightWheelBones(3)="Wheel_R_4"
	RightWheelBones(4)="Wheel_R_5"
	RightWheelBones(5)="Wheel_R_6"

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
         KMaxAngularSpeed=1.0
     End Object
     KParams=KarmaParamsRBFull'AHZ_ROVehicles.BT7Tank.KParams0'

     // Misc ONS
	FlagBone=MG_Placement// Probably not needed
	FlagRotation=(Yaw=32768)

	// Special hit points
	VehHitpoints(0)=(PointRadius=9.0,PointHeight=0.0,PointScale=1.0,PointBone=driver_player,PointOffset=(X=36.0,Y=-1.0,Z=-1.0),bPenetrationPoint=true,HitPointType=HP_Driver)
	VehHitpoints(1)=(PointRadius=30.0,PointHeight=0.0,PointScale=1.0,PointBone=body,PointOffset=(X=-60.0,Y=0.0,Z=-5.0),bPenetrationPoint=false,DamageMultiplier=1.0,HitPointType=HP_Engine)
	VehHitpoints(2)=(PointRadius=15.0,PointHeight=0.0,PointScale=1.0,PointBone=body,PointOffset=(X=55.0,Y=30.0,Z=10.0),bPenetrationPoint=false,DamageMultiplier=5.0,HitPointType=HP_AmmoStore)
	VehHitpoints(3)=(PointRadius=15.0,PointHeight=0.0,PointScale=1.0,PointBone=body,PointOffset=(X=55.0,Y=-30.0,Z=10.0),bPenetrationPoint=false,DamageMultiplier=5.0,HitPointType=HP_AmmoStore)

    // Armor
    FrontArmorFactor=3
	SideArmorFactor=2
	RearArmorFactor=2

	TreadHitMinAngle= 1.9

 	//bMultiPosition=true//false
 	//bIsApc = true
}
