//===================================================================
// PanzerIIICannonPawn
//
// Copyright (C) 2005 John "Ramm-Jaeger"  Gibson
//
// PanzerIII tank cannon pawn
//==================================================================

class  PanzerIIICannonPawn extends GermanTankCannonPawn;

defaultproperties
{
	VehiclePositionString="in a Panzer III cannon"
	VehicleNameString="Panzer III Cannon"
	EntryPosition=(X=0,Y=0,Z=0)
	EntryRadius=130.0
	ExitPositions(0)=(X=0,Y=-200,Z=100)
	ExitPositions(1)=(X=0,Y=200,Z=100)
	GunClass=class'ROVehicles.PanzerIIICannon'
	CannonScopeOverlay=texture'Vehicle_Optic.PZ3_sight_background'
	ScopeCenterRotator=TexRotator'Vehicle_Optic.PZ3_Sight_Center'
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

    RotateSound=Sound'Vehicle_Weapons.Turret.manual_turret_traverse'
    PitchSound=Sound'Vehicle_Weapons.Turret.manual_turret_elevate'
    RotateAndPitchSound=Sound'Vehicle_Weapons.Turret.manual_turret_traverse'

    DriveAnim=VPanzer3_com_idle_close

	// Driver head positions
	DriverPositions(0)=(ViewLocation=(X=75,Y=-15.0,Z=2.0),ViewFOV=35,PositionMesh=Mesh'axis_panzer3_anm.panzer3_turret_int',DriverTransitionAnim=none,ViewPitchUpLimit=6000,ViewPitchDownLimit=63500,ViewPositiveYawLimit=19000,ViewNegativeYawLimit=-20000,bDrawOverlays=true,bExposed=false)
	DriverPositions(1)=(ViewLocation=(X=0,Y=0,Z=0),ViewFOV=70,PositionMesh=Mesh'axis_panzer3_anm.panzer3_turret_int',DriverTransitionAnim=VPanzer3_com_close,TransitionUpAnim=com_open,ViewPitchUpLimit=5000,ViewPitchDownLimit=63500,ViewPositiveYawLimit=6000,ViewNegativeYawLimit=-10000,bDrawOverlays=false,bExposed=false)
	DriverPositions(2)=(ViewLocation=(X=0,Y=0,Z=0),ViewFOV=85,PositionMesh=Mesh'axis_panzer3_anm.panzer3_turret_int',DriverTransitionAnim=VPanzer3_com_open,TransitionDownAnim=com_close,ViewPitchUpLimit=5000,ViewPitchDownLimit=60000,ViewPositiveYawLimit=10000,ViewNegativeYawLimit=-10000,bDrawOverlays=false,bExposed=true)
	DriverPositions(3)=(ViewLocation=(X=0,Y=0,Z=0),ViewFOV=20,PositionMesh=Mesh'axis_panzer3_anm.panzer3_turret_int',DriverTransitionAnim=none,ViewPitchUpLimit=5000,ViewPitchDownLimit=63500,ViewPositiveYawLimit=10000,ViewNegativeYawLimit=-10000,bDrawOverlays=True,bExposed=true)

    AmmoShellTexture=Texture'InterfaceArt_tex.Tank_Hud.Panzer3shell'
    AmmoShellReloadTexture=Texture'InterfaceArt_tex.Tank_Hud.Panzer3shell_reload'
}

