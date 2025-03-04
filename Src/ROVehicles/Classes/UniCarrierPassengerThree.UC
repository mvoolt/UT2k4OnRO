//=============================================================================
// UniCarrierPassengerThree
//=============================================================================
// Universal Carrier passenger that rides in back
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2006 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class UniCarrierPassengerThree extends ROPassengerPawn;

defaultproperties
{
	VehiclePositionString="in a Universal Carrier transport"
	VehicleNameString="Universal Carrier passenger"
	EntryPosition=(X=0,Y=0,Z=0)
	EntryRadius=130.0
	ExitPositions(0)=(X=0,Y=-200,Z=100)
	ExitPositions(1)=(X=0,Y=200,Z=100)

	CameraBone=passenger_R_1
	FPCamPos=(X=0,Y=0,Z=45)
	FPCamViewOffset=(X=0,Y=0,Z=0)

	TPCamLookat=(X=-25,Y=0,Z=0)
	TPCamWorldOffset=(X=0,Y=0,Z=120)
	TPCamDistance=300
	DrivePos=(X=0,Y=0,Z=0)
	DriveRot=(Pitch=0,Roll=0,Yaw=0)

	DriveAnim=VUC_Rider1_idle
	PositionInArray=3
}
