//==============================================================================
// M1937ATGun
//
// Red Orchestra Source - William Miller
// Copyright (C) 2007 Tripwire Interactive, LLC
//
// M-1937 45mm AT-Gun class
//==============================================================================
class M1937ATGun extends ATGun;

// new vehicle content
#exec OBJ LOAD FILE=..\Animations\allies_ahz_45mm_anm.ukx
#exec OBJ LOAD FILE=..\textures\allies_ahz_guns_tex.utx
#exec OBJ LOAD FILE=..\StaticMeshes\allies_ahz_guns_stc.usx

//==============================================================================
// defaultproperties
//==============================================================================
defaultproperties
{
    // Display
	Mesh=Mesh'allies_ahz_45mm_anm.45mm_body'
	Skins(0)=Texture'allies_ahz_guns_tex.45mm.45mm_ext'
	bUseHighDetailOverlayIndex=false

    // Hud stuff
	VehicleHudImage=Texture'InterfaceArt_ahz_tex.Tank_Hud.45mm_ATGun_body'
	VehicleHudTurret=TexRotator'InterfaceArt_ahz_tex.Tank_Hud.45mm_ATGun_gun_rot'
	VehicleHudTurretLook=TexRotator'InterfaceArt_ahz_tex.Tank_Hud.45mm_ATGun_gun_look'
    VehicleHudThreadsPosX(0)=0.16
	VehicleHudThreadsPosX(1)=0.96
	VehicleHudThreadsPosY=0.5
    VehicleHudThreadsScale=0.6
    VehicleHudEngineX=0.0
	VehicleHudEngineY=0.0
    VehicleHudEngine=none
	VehicleHudOccupantsX(1)=0.42    //gunner - horizontal axis
	VehicleHudOccupantsY(1)=0.45    //gunner - verticle axis
  	VehicleHudOccupantsX(0)=none    //gun cmdr - horizontal axis
	VehicleHudOccupantsY(0)=none    //gun cmdr - verticle axis
	VehicleHudOccupantsX(2)=none    //assitant gunner - horizontal axis
	VehicleHudOccupantsY(2)=none    //assitant gunner - verticle axis

	// Vehicle Params
	VehicleMass=8.0
    VehicleTeam=1
	Health=101
	HealthMax=101
	DisintegrationHealth=-10000
	CollisionHeight=70.000000
	CollisionRadius=90.000000
	DriverDamageMult=1.0
	MaxDesireability=1.5
    TransRatio=0.0

	// Weapon Attachments
    PassengerWeapons(0)=(WeaponPawnClass=class'M1937CannonPawn',WeaponBone=turret_placement)

	// Position Info
	DriverAttachmentBone=none //com_driver
    DriveAnim=none //crouch_idle_binoc
	BeginningIdleAnim=none
    DriverPositions=none //(PositionMesh=Mesh'allies_ahz_45mm_anm.45mm_body',DriverTransitionAnim=crouch_idle_binoc,TransitionUpAnim=stand_idlehip_binoc,ViewPitchUpLimit=0,ViewPitchDownLimit=65535,ViewPositiveYawLimit=65536,ViewNegativeYawLimit=-65536,bExposed=false,ViewFOV=85,bDrawOverlays=false)   //none

    InitialPositionIndex=0
	FPCamPos=(X=0,Y=0,Z=0)
	FPCamViewOffset=(X=0,Y=0,Z=0)
	bFPNoZFromCameraPitch=True
	TPCamLookat=(X=-50,Y=0,Z=0)
	TPCamWorldOffset=(X=0,Y=0,Z=250)
	TPCamDistance=600
	DrivePos=(X=0.0,Y=0.0,Z=0.0)

	// Driver overlay (Gun Cmdr)
    HUDOverlayClass=none
	HUDOverlayOffset=(X=0,Y=0,Z=0)
	HUDOverlayFOV=85

	ExitPositions(0)=(X=0,Y=-200,Z=100)
	EntryPosition=(X=0,Y=0,Z=0)
	EntryRadius=375.0

	VehiclePositionString="Using a M-1937 AT-Gun"
	VehicleNameString="M-1937 AT-Gun"

	PitchUpLimit=5000
	PitchDownLimit=60000

	// Special hit points -  done to over-ride the defaults in ROVehicle.
 	VehHitpoints(0)=(PointRadius=0.0,PointHeight=0.0,PointScale=1.0,PointBone=turret_attachment,PointOffset=(X=0.0,Y=0.0,Z=0.0),bPenetrationPoint=true,HitPointType=HP_Driver)
	VehHitpoints(1)=(PointRadius=0.0,PointHeight=0.0,PointScale=1.0,PointBone=turret_attachment,PointOffset=(X=0.0,Y=0.0,Z=0.0),bPenetrationPoint=true,DamageMultiplier=0.0,HitPointType=HP_Engine)
	//This prevents the area of invulnerability in the left front quarter of the shield that comes from the gunner collision box.
    VehHitpoints(2)=(PointRadius=20.0,PointHeight=0.0,PointScale=1.0,PointBone=turret_attachment,PointOffset=(X=0.0,Y=-20.0,Z=15.0),bPenetrationPoint=true,DamageMultiplier=2.0,HitPointType=HP_AmmoStore)

    // Karma params
    Begin Object Class=KarmaParamsRBFull Name=KParams0
        KInertiaTensor(0)=1.000000
        KInertiaTensor(3)=3.000000
        KInertiaTensor(5)=3.000000
        KCOMOffset=(X=0.3000,Z=-0.350000)
        KLinearDamping=0.050000
        KAngularDamping=0.050000
        KFriction=50.0         //increased to keep from sliding
        KImpactThreshold=700.000000
        KStartEnabled=True
        bKNonSphericalInertia=True
        bHighDetailOnly=False
        bClientOnly=False
        bKDoubleTickRate=True
        bDestroyOnWorldPenetrate=True
        bDoSafetime=True
        KMaxAngularSpeed=0.0
    End Object
    KParams=KarmaParamsRBFull'AHZ_ROVehicles.M1937ATGun.KParams0'

	// Destruction
	DestroyedVehicleMesh=StaticMesh'allies_ahz_guns_stc.45mm.45mm_destroyed'
	DestructionEffectClass=class'ATCannonDestroyedEmitter'
	DisintegrationEffectClass=class'ATCannonDestroyedEmitter'
	DestructionLinearMomentum=(Min=100.000000,Max=350.000000)
	DestructionAngularMomentum=(Min=50.000000,Max=150.000000)
	DamagedEffectOffset=(X=-200,Y=0,Z=0)
	DamagedEffectScale=0.85

    //Note for developers of new guns.  When the gun is partially damaged it will smoke.  While this is
    //    not totally realistic is gives the opposing team the ability to see that it is damaged.  This is for gameplay.
    //    If you do not want this effect then set uncomment the below line: DamagedEffectClass=none.  The property is
    //    created in ROVehicle.
    DamagedEffectClass=none

    GunThreatFactor=0.4

	//armor
	FrontArmorFactor=2
	SideArmorFactor=2
    RearArmorFactor=1

	TreadHitMinAngle= 1.9
	DriverHitCheckDist=30.0
}
