//===================================================================
// T3485MountedTankMGPawn
//
// Copyright (C) 2004 John "Ramm-Jaeger"  Gibson
//
// Russian T34 tank mounted machine gun pawn
//===================================================================

class T3485MountedTankMGPawn extends ROMountedTankMGPawn;

defaultproperties
{
	VehiclePositionString="in a T34 Mounted MG"
	VehicleNameString="T32 Mounted MG"
	EntryPosition=(X=0,Y=0,Z=0)
	EntryRadius=130.0
	ExitPositions(0)=(X=0,Y=-200,Z=100)
	ExitPositions(1)=(X=0,Y=200,Z=100)
	GunClass=class'T3485MountedMG'
	CameraBone=T34_mg
	FPCamPos=(X=0,Y=0,Z=0)
	FPCamViewOffset=(X=5,Y=0,Z=10)
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
   	PitchDownLimit=64000

	HUDOverlayClass=class'ROVehicles.ROVehDTOverlay'
	HUDOverlayOffset=(X=-40,Y=0,Z=0)
	HUDOverlayFOV=45
}

