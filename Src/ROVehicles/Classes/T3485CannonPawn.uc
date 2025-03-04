//===================================================================
// T3485CannonPawn
//
// Copyright (C) 2004 John "Ramm-Jaeger"  Gibson
//
// Russian T34 tank cannon pawn
//===================================================================
class T3485CannonPawn extends RussianTankCannonPawn;

defaultproperties
{
	VehiclePositionString="in a T34 cannon"
	VehicleNameString="T34 Cannon"
	EntryPosition=(X=0,Y=0,Z=0)
	EntryRadius=130.0
	ExitPositions(0)=(X=0,Y=-200,Z=100)
	ExitPositions(1)=(X=0,Y=200,Z=100)
	GunClass=class'ROVehicles.T3485Cannon'
	CameraBone=turret
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

	WeaponFov=21 // 4X
	PitchUpLimit=6000
    PitchDownLimit=64000

    RotateSound=Sound'Vehicle_Weapons.Turret.hydraul_turret_traverse'
    PitchSound=Sound'Vehicle_Weapons.Turret.manual_turret_elevate'
    RotateAndPitchSound=Sound'Vehicle_Weapons.Turret.hydraul_turret_traverse'
    SoundVolume=130

	CannonScopeOverlay=texture'Vehicle_Optic.t3485_sight'
	CannonScopeCenter=texture'Vehicle_Optic.T3476_sight_mover'
	ScopePositionX=0.075
	ScopeCenterScaleX=2.0

    DriveAnim=VT3485_com_idle_close

	// Driver head positions
	DriverPositions(0)=(ViewLocation=(X=115,Y=-15,Z=0),ViewFOV=21,PositionMesh=Mesh'allies_t3485_anm.t3485_turret_int',DriverTransitionAnim=none,ViewPitchUpLimit=6000,ViewPitchDownLimit=64500,ViewPositiveYawLimit=19000,ViewNegativeYawLimit=-20000,bDrawOverlays=true,bExposed=false)
	DriverPositions(1)=(ViewLocation=(X=0,Y=0,Z=0),ViewFOV=45,PositionMesh=Mesh'allies_t3485_anm.t3485_turret_int',DriverTransitionAnim=VT3485_com_close,TransitionUpAnim=com_open,ViewPitchUpLimit=5000,ViewPitchDownLimit=62000,ViewPositiveYawLimit=6000,ViewNegativeYawLimit=-10000,bDrawOverlays=false,bExposed=false)
	DriverPositions(2)=(ViewLocation=(X=0,Y=0,Z=0),ViewFOV=85,PositionMesh=Mesh'allies_t3485_anm.t3485_turret_int',DriverTransitionAnim=VT3485_com_open,TransitionDownAnim=com_close,ViewPitchUpLimit=5000,ViewPitchDownLimit=62000,ViewPositiveYawLimit=6000,ViewNegativeYawLimit=-10000,bDrawOverlays=false,bExposed=true)
	DriverPositions(3)=(ViewLocation=(X=0,Y=0,Z=0),ViewFOV=20,PositionMesh=Mesh'allies_t3485_anm.t3485_turret_int',DriverTransitionAnim=none,ViewPitchUpLimit=5000,ViewPitchDownLimit=62000,ViewPositiveYawLimit=6000,ViewNegativeYawLimit=-10000,bDrawOverlays=true,bExposed=true)

	AmmoShellTexture=Texture'InterfaceArt_tex.Tank_Hud.T3485shell'
	AmmoShellReloadTexture=Texture'InterfaceArt_tex.Tank_Hud.T3485shell_reload'
}

