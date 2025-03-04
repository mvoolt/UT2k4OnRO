//===================================================================
// PanzerIVCannonPawn
//
// Copyright (C) 2004 John "Ramm-Jaeger"  Gibson
//
// Panzer 4 tank cannon pawn
//==================================================================

class  PanzerIVF2CannonPawn extends GermanTankCannonPawn;

defaultproperties
{
	VehiclePositionString="in a Panzer IV cannon"
	VehicleNameString="Panzer IV Cannon"
	EntryPosition=(X=0,Y=0,Z=0)
	EntryRadius=130.0
	ExitPositions(0)=(X=0,Y=-200,Z=100)
	ExitPositions(1)=(X=0,Y=200,Z=100)
	GunClass=class'ROVehicles.PanzerIVF2Cannon'
	CannonScopeOverlay=texture'Vehicle_Optic.PZ3_sight_background'
	ScopeCenterRotator=TexRotator'Vehicle_Optic.PZ4_sight_Center'
	ScopePositionX=0.237
	ScopePositionY=0.15
	ScopeCenterScale=0.75
	CenterRotationFactor=985
	CameraBone=Turret
	FPCamPos=(X=50,Y=-30,Z=11)//(X=0,Y=0,Z=0)
	FPCamViewOffset=(X=0,Y=0,Z=0)//(X=50,Y=-25,Z=35)
	bFPNoZFromCameraPitch=true//False
	TPCamLookat=(X=-25,Y=0,Z=0)
	TPCamWorldOffset=(X=0,Y=0,Z=120)
	TPCamDistance=300
	DrivePos=(X=0.0,Y=0.0,Z=0.0)
	bDrawDriverInTP=true//False
	bDrawMeshInFP=True
	DriverDamageMult=1.0
	bPCRelativeFPRotation=true

	WeaponFov=35 // 2.4X
	PitchUpLimit=6000
	PitchDownLimit=64000

    RotateSound=Sound'Vehicle_Weapons.Turret.electric_turret_traverse'
    PitchSound=Sound'Vehicle_Weapons.Turret.manual_turret_elevate'
    RotateAndPitchSound=Sound'Vehicle_Weapons.Turret.electric_turret_traverse'
    SoundVolume=200

    DriveAnim=VPanzer4_com_idle_close

 	bHasFireImpulse=True
	FireImpulse=(X=-90000,Y=0.0,Z=0.0)

	// Driver head positions
	DriverPositions(0)=(ViewLocation=(X=110,Y=-15.0,Z=1.0),ViewFOV=35,PositionMesh=Mesh'axis_panzer4F2_anm.panzer4F2_turret_int',DriverTransitionAnim=none,ViewPitchUpLimit=6000,ViewPitchDownLimit=63500,ViewPositiveYawLimit=19000,ViewNegativeYawLimit=-20000,bDrawOverlays=true,bExposed=false)
	DriverPositions(1)=(ViewLocation=(X=0,Y=0,Z=0),ViewFOV=85,PositionMesh=Mesh'axis_panzer4F2_anm.panzer4F2_turret_int',DriverTransitionAnim=VPanzer4_com_close,TransitionUpAnim=com_open,ViewPitchUpLimit=5000,ViewPitchDownLimit=63500,ViewPositiveYawLimit=6000,ViewNegativeYawLimit=-10000,bDrawOverlays=false,bExposed=false)
	DriverPositions(2)=(ViewLocation=(X=0,Y=0,Z=0),ViewFOV=85,PositionMesh=Mesh'axis_panzer4F2_anm.panzer4F2_turret_int',DriverTransitionAnim=VPanzer4_com_open,TransitionDownAnim=com_close,ViewPitchUpLimit=5000,ViewPitchDownLimit=63500,ViewPositiveYawLimit=10000,ViewNegativeYawLimit=-10000,bDrawOverlays=false,bExposed=true)
	DriverPositions(3)=(ViewLocation=(X=0,Y=0,Z=0),ViewFOV=20,PositionMesh=Mesh'axis_panzer4F2_anm.panzer4F2_turret_int',DriverTransitionAnim=none,ViewPitchUpLimit=5000,ViewPitchDownLimit=63500,ViewPositiveYawLimit=10000,ViewNegativeYawLimit=-10000,bDrawOverlays=True,bExposed=true)

    AmmoShellTexture=Texture'InterfaceArt_tex.Tank_Hud.panzer4F2shell'
    AmmoShellReloadTexture=Texture'InterfaceArt_tex.Tank_Hud.panzer4F2shell_reload'
}

