//===================================================================
// TigerTankCannonPawn
//
// Copyright (C) 2004 John "Ramm-Jaeger"  Gibson
//
// Tiger 1 tank cannon pawn
//==================================================================

class  TigerTankCannonPawn extends GermanTankCannonPawn;

defaultproperties
{
	VehiclePositionString="in a Tiger 1 cannon"
	VehicleNameString="Tiger 1 Cannon"
	EntryPosition=(X=0,Y=0,Z=0)
	EntryRadius=130.0
	ExitPositions(0)=(X=0,Y=-200,Z=100)
	ExitPositions(1)=(X=0,Y=200,Z=100)
	GunClass=class'ROVehicles.TigerCannon'
	CannonScopeOverlay=texture'Vehicle_Optic.tiger_sight_background'
	ScopeCenterRotator=TexRotator'Vehicle_Optic.tiger_sight_center'
	ScopePositionX=0.237
	ScopePositionY=0.15
	ScopeCenterScale=0.68
	CenterRotationFactor=820
	CameraBone=Turret
	FPCamPos=(X=50,Y=-30,Z=11)
	FPCamViewOffset=(X=0,Y=0,Z=0)
	bFPNoZFromCameraPitch=true
	TPCamLookat=(X=-25,Y=0,Z=0)
	TPCamWorldOffset=(X=0,Y=0,Z=120)
	TPCamDistance=300
	DrivePos=(X=0.0,Y=0.0,Z=0.0)
	bDrawDriverInTP=true//False
	bDrawMeshInFP=True
	DriverDamageMult=1.0
	bPCRelativeFPRotation=true

	WeaponFov=34 // 2.5X
	PitchUpLimit=6000
	PitchDownLimit=64000

    DriveAnim=VTiger_com_idle_close

    RotateSound=Sound'Vehicle_Weapons.Turret.hydraul_turret_traverse'
    PitchSound=Sound'Vehicle_Weapons.Turret.manual_turret_elevate'
    RotateAndPitchSound=Sound'Vehicle_Weapons.Turret.hydraul_turret_traverse'
    SoundVolume=130

 	bHasFireImpulse=True
	FireImpulse=(X=-110000,Y=0.0,Z=0.0)

	// Driver head positions
	DriverPositions(0)=(ViewLocation=(X=100,Y=-30,Z=0),ViewFOV=34,PositionMesh=Mesh'axis_tiger1_anm.tiger1_turret_int',DriverTransitionAnim=none,ViewPitchUpLimit=6000,ViewPitchDownLimit=64000,ViewPositiveYawLimit=19000,ViewNegativeYawLimit=-20000,bDrawOverlays=true,bExposed=false)
	DriverPositions(1)=(ViewLocation=(X=0,Y=0,Z=0),ViewFOV=75,PositionMesh=Mesh'axis_tiger1_anm.tiger1_turret_int',DriverTransitionAnim=VTiger_com_close,TransitionUpAnim=com_open,ViewPitchUpLimit=5000,ViewPitchDownLimit=64000,ViewPositiveYawLimit=6000,ViewNegativeYawLimit=-10000,bDrawOverlays=false,bExposed=false)
	DriverPositions(2)=(ViewLocation=(X=0,Y=0,Z=0),ViewFOV=85,PositionMesh=Mesh'axis_tiger1_anm.tiger1_turret_int',DriverTransitionAnim=VTiger_com_open,TransitionDownAnim=com_close,ViewPitchUpLimit=10000,ViewPitchDownLimit=64000,ViewPositiveYawLimit=6000,ViewNegativeYawLimit=-10000,bDrawOverlays=false,bExposed=true)
	DriverPositions(3)=(ViewLocation=(X=0,Y=0,Z=0),ViewFOV=20,PositionMesh=Mesh'axis_tiger1_anm.tiger1_turret_int',DriverTransitionAnim=none,ViewPitchUpLimit=10000,ViewPitchDownLimit=64000,ViewPositiveYawLimit=6000,ViewNegativeYawLimit=-10000,bDrawOverlays=true,bExposed=true)

    AmmoShellTexture=Texture'InterfaceArt_tex.Tank_Hud.Tigershell'
    AmmoShellReloadTexture=Texture'InterfaceArt_tex.Tank_Hud.Tigershell_reload'
}

