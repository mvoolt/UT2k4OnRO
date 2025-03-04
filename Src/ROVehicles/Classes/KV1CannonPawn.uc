//===================================================================
// KV1CannonPawn
//
// Copyright (C) 2004 John "Ramm-Jaeger"  Gibson
//
// KV1 tank cannon pawn
//==================================================================

class  KV1CannonPawn extends RussianTankCannonPawn;

defaultproperties
{
	VehiclePositionString="in a KV1S cannon"
	VehicleNameString="KV1S Cannon"
	EntryPosition=(X=0,Y=0,Z=0)
	EntryRadius=130.0
	ExitPositions(0)=(X=0,Y=-200,Z=100)
	ExitPositions(1)=(X=0,Y=200,Z=100)
	GunClass=class'ROVehicles.KV1Cannon'
	CameraBone=Turret
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
	PitchDownLimit=60000//64000

    RotateSound=Sound'Vehicle_Weapons.Turret.hydraul_turret_traverse'
    PitchSound=Sound'Vehicle_Weapons.Turret.manual_turret_elevate'
    RotateAndPitchSound=Sound'Vehicle_Weapons.Turret.hydraul_turret_traverse'
    SoundVolume=130

    CannonScopeOverlay=texture'Vehicle_Optic.kv1_sight'
	CannonScopeCenter=texture'Vehicle_Optic.T3476_sight_mover'

    DriveAnim=VKV1_com_idle_close

	// Driver head positions
	DriverPositions(0)=(ViewLocation=(X=115,Y=-12,Z=0),ViewFOV=21,PositionMesh=Mesh'allies_kv1_anm.KV1_turret_int',DriverTransitionAnim=none,ViewPitchUpLimit=6000,ViewPitchDownLimit=64500,ViewPositiveYawLimit=19000,ViewNegativeYawLimit=-20000,bDrawOverlays=true,bExposed=false)
	DriverPositions(1)=(ViewLocation=(X=0,Y=0,Z=0),ViewFOV=75,PositionMesh=Mesh'allies_kv1_anm.KV1_turret_int',DriverTransitionAnim=VKV1_com_close,TransitionUpAnim=com_open,ViewPitchUpLimit=5000,ViewPitchDownLimit=65000,ViewPositiveYawLimit=6000,ViewNegativeYawLimit=-10000,bDrawOverlays=false,bExposed=false)
	DriverPositions(2)=(ViewLocation=(X=0,Y=0,Z=0),ViewFOV=85,PositionMesh=Mesh'allies_kv1_anm.KV1_turret_int',DriverTransitionAnim=VKV1_com_open,TransitionDownAnim=com_close,ViewPitchUpLimit=5000,ViewPitchDownLimit=62000,ViewPositiveYawLimit=6000,ViewNegativeYawLimit=-10000,bDrawOverlays=false,bExposed=true)
	DriverPositions(3)=(ViewLocation=(X=0,Y=0,Z=0),ViewFOV=20,PositionMesh=Mesh'allies_kv1_anm.KV1_turret_int',DriverTransitionAnim=none,ViewPitchUpLimit=5000,ViewPitchDownLimit=62000,ViewPositiveYawLimit=6000,ViewNegativeYawLimit=-10000,bDrawOverlays=true,bExposed=true)

	bLockCameraDuringTransition=true

    AmmoShellTexture=Texture'InterfaceArt_tex.Tank_Hud.T3476_SU76_Kv1shell'
    AmmoShellReloadTexture=Texture'InterfaceArt_tex.Tank_Hud.T3476_SU76_Kv1shell_reload'
}

