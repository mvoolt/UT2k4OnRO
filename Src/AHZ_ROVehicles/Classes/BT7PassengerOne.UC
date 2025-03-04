//===================================================================
// BT7PassengerOne
//
// Red Orchestra Source - William Miller
// Copyright (C) 2007 Tripwire Interactive, LLC
//
// BT7 Passenger class
//===================================================================
class BT7PassengerOne extends ROTankPassengerPawn;

defaultproperties
{
	VehiclePositionString="on a BT-7 Tank"
	VehicleNameString="BT-7 Passenger"
	EntryPosition=(X=0,Y=0,Z=0)
	EntryRadius=130.0
	ExitPositions(0)=(X=0,Y=-200,Z=100)
	ExitPositions(1)=(X=0,Y=200,Z=100)

	CameraBone=passenger_01
	FPCamPos=(X=0,Y=0,Z=45)
	FPCamViewOffset=(X=0,Y=0,Z=0)

	TPCamLookat=(X=-25,Y=0,Z=0)
	TPCamWorldOffset=(X=0,Y=0,Z=120)
	TPCamDistance=300
	DrivePos=(X=0,Y=0,Z=0)
	DriveRot=(Pitch=0,Roll=0,Yaw=0)

	DriveAnim=VHalftrack_Rider5_idle
	PositionInArray=1

	bMustBeTankCrew = false

	// Rider Hit Points
    //VehHitpoints(0)=(PointRadius=9.0,PointHeight=0.0,PointScale=1.0,PointBone=passenger_01,PointOffset=(X=0.0,Y=0.0,Z=31.0))    //head
 	//VehHitpoints(1)=(PointRadius=15.0,PointHeight=0.0,PointScale=1.0,PointBone=passenger_01,PointOffset=(X=0.0,Y=0.0,Z=10.0))   //body
}
