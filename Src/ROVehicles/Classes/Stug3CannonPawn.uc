//===================================================================
// Stug3CannonPawn
//
// Copyright (C) 2005 John "Ramm-Jaeger"  Gibson
//
// Stug III tank destroyer cannon pawn
//==================================================================

class  Stug3CannonPawn extends AssaultGunCannonPawn;

defaultproperties
{
	VehiclePositionString="in a Stug III cannon"
	VehicleNameString="Stug III Cannon"
	EntryPosition=(X=0,Y=0,Z=0)
	EntryRadius=130.0
	ExitPositions(0)=(X=0,Y=-200,Z=100)
	ExitPositions(1)=(X=0,Y=200,Z=100)
	GunClass=class'ROVehicles.Stug3Cannon'
	CannonScopeOverlay=texture'Vehicle_Optic.stug3_sight'
	CameraBone=Turret
	FPCamPos=(X=50,Y=-30,Z=11)//(X=0,Y=0,Z=0)
	FPCamViewOffset=(X=0,Y=0,Z=0)
	bFPNoZFromCameraPitch=true//False
	TPCamLookat=(X=-25,Y=0,Z=0)
	TPCamWorldOffset=(X=0,Y=0,Z=120)
	TPCamDistance=300
	DrivePos=(X=0.0,Y=0.0,Z=0.0)
	bDrawDriverInTP=true//False
	bDrawMeshInFP=True
	DriverDamageMult=1.0
	bHasAltFire=False
	bPCRelativeFPRotation=true

	WeaponFov=17 // 5X
    PitchUpLimit=6000
    PitchDownLimit=64000

    DriveAnim=VStug3_com_idle_close

    RotateSound=Sound'Vehicle_Weapons.Turret.manual_gun_traverse'
    PitchSound=Sound'Vehicle_Weapons.Turret.manual_turret_elevate'
    RotateAndPitchSound=Sound'Vehicle_Weapons.Turret.manual_gun_traverse'

	// Driver head positions
	DriverPositions(0)=(ViewLocation=(X=50,Y=-15.0,Z=11.0),ViewFOV=17,PositionMesh=Mesh'axis_stug3_anm.Stug3_turret_int',DriverTransitionAnim=VStug3_com_close,TransitionUpAnim=com_open,ViewPitchUpLimit=6000,ViewPitchDownLimit=63500,ViewPositiveYawLimit=2000,ViewNegativeYawLimit=-2000,bDrawOverlays=true,bExposed=false)
	DriverPositions(1)=(ViewLocation=(X=0,Y=0,Z=0),ViewFOV=85,PositionMesh=Mesh'axis_stug3_anm.Stug3_turret_int',DriverTransitionAnim=VStug3_com_open,TransitionDownAnim=com_close,ViewPitchUpLimit=5000,ViewPitchDownLimit=63500,ViewPositiveYawLimit=65535,ViewNegativeYawLimit=-65535,bDrawOverlays=false,bExposed=true)
	DriverPositions(2)=(ViewLocation=(X=0,Y=0,Z=0),ViewFOV=20,PositionMesh=Mesh'axis_stug3_anm.Stug3_turret_int',DriverTransitionAnim=none,ViewPitchUpLimit=5000,ViewPitchDownLimit=63500,ViewPositiveYawLimit=65535,ViewNegativeYawLimit=-65535,bDrawOverlays=True,bExposed=true)

   	bLockCameraDuringTransition=true

   	AmmoShellTexture=Texture'InterfaceArt_tex.Tank_Hud.panzer4F2shell'
   	AmmoShellReloadTexture=Texture'InterfaceArt_tex.Tank_Hud.panzer4F2shell_reload'

   	BinocPositionIndex=2
}

