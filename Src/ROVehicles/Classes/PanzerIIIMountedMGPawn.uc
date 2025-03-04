//===================================================================
// PanzerIIIMountedMGPawn
//
// Copyright (C) 2005 John "Ramm-Jaeger"  Gibson
//
// PanzerIII tank mounted machine gun pawn
//===================================================================

class PanzerIIIMountedMGPawn extends ROMountedTankMGPawn;

defaultproperties
{
	VehiclePositionString="in a Panzer III Mounted MG"
	VehicleNameString="Panzer III Mounted MG"
	EntryPosition=(X=0,Y=0,Z=0)
	EntryRadius=130.0
	ExitPositions(0)=(X=0,Y=-200,Z=100)
	ExitPositions(1)=(X=0,Y=200,Z=100)
	GunClass=class'PanzerIIIMountedMG'
	CameraBone=MG_Yaw//MG_Ball
	FPCamPos=(X=0,Y=0,Z=0)
	FPCamViewOffset=(X=-3,Y=0,Z=3)
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

	WeaponFov=42.5
	MGOverlay=texture'Vehicle_Optic.tiger_sight_background' // Replaceme
	PitchUpLimit=3000
    PitchDownLimit=63000
}

