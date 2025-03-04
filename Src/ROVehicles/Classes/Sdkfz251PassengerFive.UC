//===================================================================
// Sdkfz251PassengerFive
//
// Copyright (C) 2004 John "Ramm-Jaeger"  Gibson
//
// Sdkfz passenger that rides in back
//===================================================================

class Sdkfz251PassengerFive extends ROPassengerPawn;

defaultproperties
{
	VehiclePositionString="in a SDKFZ-251 transport"
	VehicleNameString="SDKFZ-251 passenger"
	EntryPosition=(X=0,Y=0,Z=0)
	EntryRadius=130.0
	ExitPositions(0)=(X=0,Y=-200,Z=100)
	ExitPositions(1)=(X=0,Y=200,Z=100)

	CameraBone=passenger_R_2
	FPCamPos=(X=0,Y=0,Z=45)
	FPCamViewOffset=(X=0,Y=0,Z=0)

	TPCamLookat=(X=-25,Y=0,Z=0)
	TPCamWorldOffset=(X=0,Y=0,Z=120)
	TPCamDistance=300
	DrivePos=(X=0,Y=0,Z=0)
	DriveRot=(Pitch=0,Roll=0,Yaw=0)

	DriveAnim=VHalftrack_Rider5_idle
	PositionInArray=5
}
