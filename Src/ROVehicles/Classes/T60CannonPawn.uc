//===================================================================
// T60CannonPawn
//
// Copyright (C) 2005 John "Ramm-Jaeger"  Gibson
//
// T60 tank cannon pawn
//===================================================================
class  T60CannonPawn extends RussianTankCannonPawn;

defaultproperties
{
	VehiclePositionString="in a T60 cannon"
	VehicleNameString="T60 Cannon"
	EntryPosition=(X=0,Y=0,Z=0)
	EntryRadius=130.0
	ExitPositions(0)=(X=0,Y=-200,Z=100)
	ExitPositions(1)=(X=0,Y=200,Z=100)
	GunClass=class'ROVehicles.T60Cannon'
	CameraBone=turret_placement1
	FPCamPos=(X=0,Y=0,Z=0)
	FPCamViewOffset=(X=0,Y=0,Z=0)
	bFPNoZFromCameraPitch=False
	TPCamLookat=(X=-25,Y=0,Z=0)
	TPCamWorldOffset=(X=0,Y=0,Z=120)
	TPCamDistance=300
	DrivePos=(X=0.0,Y=0.0,Z=0.0)
	bDrawDriverInTP=true//False
	bDrawMeshInFP=True
	DriverDamageMult=1.0
	bPCRelativeFPRotation=true

	WeaponFov=34 // 2.5x
	PitchUpLimit=6000
	PitchDownLimit=64000

    RotateSound=Sound'Vehicle_Weapons.Turret.manual_turret_traverse'
    PitchSound=Sound'Vehicle_Weapons.Turret.manual_turret_elevate'
    RotateAndPitchSound=Sound'Vehicle_Weapons.Turret.manual_turret_traverse'

    CannonScopeOverlay=texture'Vehicle_Optic.T60_sight'
	CannonScopeCenter=texture'Vehicle_Optic.T3476_sight_mover'
	ScopePositionX=0.075
	ScopeCenterScaleX=2.0

    DriveAnim=VT60_com_idle_close

 	bHasFireImpulse=True
	FireImpulse=(X=-10000,Y=0.0,Z=0.0)

	// Driver head positions
	DriverPositions(0)=(ViewLocation=(X=85,Y=2,Z=0),ViewFOV=34,PositionMesh=Mesh'allies_t60_anm.T60_turret_int',DriverTransitionAnim=none,ViewPitchUpLimit=6000,ViewPitchDownLimit=64500,ViewPositiveYawLimit=19000,ViewNegativeYawLimit=-20000,bDrawOverlays=true,bExposed=false)
	DriverPositions(1)=(ViewLocation=(X=0,Y=0,Z=0),ViewFOV=85,PositionMesh=Mesh'allies_t60_anm.T60_turret_int',DriverTransitionAnim=VT60_com_close,TransitionUpAnim=com_open,ViewPitchUpLimit=5000,ViewPitchDownLimit=65535,ViewPositiveYawLimit=6000,ViewNegativeYawLimit=-10000,bDrawOverlays=false,bExposed=false)
	DriverPositions(2)=(ViewLocation=(X=0,Y=0,Z=0),ViewFOV=85,PositionMesh=Mesh'allies_t60_anm.T60_turret_int',DriverTransitionAnim=VT60_com_open,TransitionDownAnim=com_close,ViewPitchUpLimit=5000,ViewPitchDownLimit=62000,ViewPositiveYawLimit=6000,ViewNegativeYawLimit=-10000,bDrawOverlays=false,bExposed=true)
	DriverPositions(3)=(ViewLocation=(X=0,Y=0,Z=0),ViewFOV=20,PositionMesh=Mesh'allies_t60_anm.T60_turret_int',DriverTransitionAnim=none,ViewPitchUpLimit=5000,ViewPitchDownLimit=62000,ViewPositiveYawLimit=6000,ViewNegativeYawLimit=-10000,bDrawOverlays=true,bExposed=true)

	AmmoShellTexture=Texture'InterfaceArt_tex.Tank_Hud.t60shell'
	AmmoShellReloadTexture=Texture'InterfaceArt_tex.Tank_Hud.t60_reload'
}

