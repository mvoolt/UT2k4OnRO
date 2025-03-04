//===================================================================
// KV1MountedMGPawn
//
// Copyright (C) 2004 John "Ramm-Jaeger"  Gibson
//
// KV1 tank mounted machine gun pawn
//===================================================================

class KV1MountedMGPawn extends ROMountedTankMGPawn;

defaultproperties
{
	VehiclePositionString="in a KV1S Mounted MG"
	VehicleNameString="KV1S Mounted MG"
	EntryPosition=(X=0,Y=0,Z=0)
	EntryRadius=130.0
	ExitPositions(0)=(X=0,Y=-200,Z=100)
	ExitPositions(1)=(X=0,Y=200,Z=100)
	GunClass=class'KV1MountedMG'
	CameraBone=MG_Yaw//MG_Ball
	FPCamPos=(X=0,Y=0,Z=0)
	FPCamViewOffset=(X=10,Y=0,Z=5)
	bFPNoZFromCameraPitch=False
	TPCamLookat=(X=-25,Y=0,Z=0)
	TPCamWorldOffset=(X=0,Y=0,Z=120)
	TPCamDistance=300
	DrivePos=(X=0.0,Y=0.0,Z=130.0)
	bDrawDriverInTP=False
	bDrawMeshInFP=True
	DriverDamageMult=0.0
	bHasAltFire=False
	//bPCRelativeFPRotation=true

	WeaponFov=85
	MGOverlay= texture'Vehicle_Optic.MG_sight'
	PitchUpLimit=3000
    PitchDownLimit=63000

	HUDOverlayClass=class'ROVehicles.ROVehDTOverlay'
	HUDOverlayOffset=(X=-40,Y=0,Z=0)
	HUDOverlayFOV=45
}

