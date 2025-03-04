//===================================================================
// ROPassengerPawn
//
// Copyright (C) 2004 John "Ramm-Jaeger"  Gibson
//
// Base class for vehicle passenger pawns. Overrides
// onslaught functionality that we don't want/need
//===================================================================

class ROPassengerPawn extends ROVehicleWeaponPawn
      abstract;

var() bool bUseDriverHeadBoneCam;	// Use the driver's head bone for the camera

simulated function ClientKDriverEnter(PlayerController PC)
{
	Super.ClientKDriverEnter(PC);

	PC.SetFOV( WeaponFOV );
}

function float ModifyThreat(float current, Pawn Threat)
{
	if (Vehicle(Threat) == None)
		current += 1.0;
	else
		current -= 1.5;
	return current;
}

// Ovverridden to remove any "Gun" references from the superclass, as passengers have no gun
function KDriverEnter(Pawn P)
{
	local Controller C;
 	local rotator NewRotation;

	bDriving = True;
	StuckCount = 0;

	// We don't have pre-defined exit positions here, so we use the original player location as an exit point
	if ( !bRelativeExitPos )
	{
		PlayerEnterredRotation = P.Rotation;
		ExitPositions[0] =  P.Location + Vect(0,0,16);
	}

	// Set pawns current controller to control the vehicle pawn instead
	C = P.Controller;
	if ( !bCanCarryFlag && (C.PlayerReplicationInfo.HasFlag != None)  )
		P.DropFlag();

	Driver = P;
	Driver.StartDriving( Self );

	// Disconnect PlayerController from Driver and connect to SVehicle.
	C.bVehicleTransition = true; // to keep Bots from doing Restart()
	C.Unpossess();
	Driver.SetOwner( Self ); // This keeps the driver relevant.
	C.Possess( Self );
	C.bVehicleTransition = false;

	DrivingStatusChanged();

	if ( PlayerController(C) != None )
		VehicleLostTime = 0;

	AttachFlag(PlayerReplicationInfo.HasFlag);

	Level.Game.DriverEnteredVehicle(self, P);

	if (VehicleBase != None && VehicleBase.bTeamLocked && VehicleBase.bEnterringUnlocks)
		VehicleBase.bTeamLocked = false;


	if (!bHasOwnHealth && VehicleBase == None)
	{
		Health = Driver.Health;
		HealthMax = Driver.HealthMax;
	}

	NewRotation = Controller.Rotation;
	NewRotation.Pitch = LimitPitch(NewRotation.Pitch);
	SetRotation(NewRotation);
	Driver.bSetPCRotOnPossess = false; //so when driver gets out he'll be facing the same direction as he was inside the vehicle
}

// Ovverridden to remove any "Gun" references from the superclass, as passengers have no gun
simulated function AttachDriver(Pawn P)
{
	P.bHardAttach = True;
	P.SetLocation( VehicleBase.GetBoneCoords(CameraBone).Origin);
	P.SetPhysics(PHYS_None);

	VehicleBase.AttachToBone(P, CameraBone);

	P.SetRelativeLocation(DrivePos + P.default.PrePivot);
	P.SetRelativeRotation( DriveRot );

	P.PrePivot=vect(0,0,0);
}

simulated function DetachDriver(Pawn P)
{
	P.PrePivot=P.default.PrePivot;

    if (VehicleBase != None && CameraBone != '')
        VehicleBase.DetachFromBone(P);
}

function AttachToVehicle(ROVehicle VehiclePawn, name WeaponBone)
{
    if (Level.NetMode != NM_Client)
    {
        VehicleBase = VehiclePawn;
    }
}

static function StaticPrecache(LevelInfo L)
{
    // Take this out because we have no gunclass;
    //Default.GunClass.static.StaticPrecache(L);
    return;
}

simulated function vector GetCameraLocationStart()
{
	if (VehicleBase != None)
		return VehicleBase.GetBoneCoords(CameraBone).Origin;
	else
		return Super.GetCameraLocationStart();
}

/* PointOfView()
We don't ever want to allow behindview. It doesn't work with our system - Ramm
*/
simulated function bool PointOfView()
{
    return false;
}

simulated function SpecialCalcFirstPersonView(PlayerController PC, out actor ViewActor, out vector CameraLocation, out rotator CameraRotation )
{
	local vector x, y, z;
	local vector VehicleZ, CamViewOffsetWorld;
	local float CamViewOffsetZAmount;
	local quat AQuat, BQuat, CQuat;

    	GetAxes(CameraRotation, x, y, z);
	ViewActor = self;

    if ( bPCRelativeFPRotation )
	{
        //__________________________________________
        // First, Rotate the headbob by the player
        // controllers rotation (looking around) ---
        AQuat = QuatFromRotator(PC.Rotation);
        BQuat = QuatFromRotator(HeadRotationOffset - ShiftHalf);
        CQuat = QuatProduct(AQuat,BQuat);
        //__________________________________________
        // Then, rotate that by the vehicles rotation
        // to get the final rotation ---------------
        AQuat = QuatFromRotator(GetVehicleBase().Rotation);
        BQuat = QuatProduct(CQuat,AQuat);
        //__________________________________________
        // Make it back into a rotator!
        CameraRotation = QuatToRotator(BQuat);
	}
    else
        CameraRotation = PC.Rotation;

   	CamViewOffsetWorld = FPCamViewOffset >> CameraRotation;

	if(Driver != none && bUseDriverHeadBoneCam)
	{
		CameraLocation = Driver.GetBoneCoords('head').Origin;
	}
	else
	{
		CameraLocation = GetCameraLocationStart() + (FPCamPos >> Rotation) + CamViewOffsetWorld;

		if(bFPNoZFromCameraPitch)
		{
			VehicleZ = vect(0,0,1) >> Rotation;
			CamViewOffsetZAmount = CamViewOffsetWorld Dot VehicleZ;
			CameraLocation -= CamViewOffsetZAmount * VehicleZ;
		}
	}

    CameraRotation = Normalize(CameraRotation + PC.ShakeRot);
	CameraLocation = CameraLocation + PC.ShakeOffset.X * x + PC.ShakeOffset.Y * y + PC.ShakeOffset.Z * z;
}

simulated function DrawHUD(Canvas Canvas)
{
    local PlayerController PC;
    local vector CameraLocation;
    local rotator CameraRotation;
    local Actor ViewActor;

    PC = PlayerController(Controller);

     // Zap the lame crosshair - Ramm
/*	if (IsLocallyControlled() && Gun != None && Gun.bCorrectAim)
	{
		Canvas.DrawColor = CrosshairColor;
		Canvas.DrawColor.A = 255;
		Canvas.Style = ERenderStyle.STY_Alpha;
		Canvas.SetPos(Canvas.SizeX*0.5-CrosshairX, Canvas.SizeY*0.5-CrosshairY);
		Canvas.DrawTile(CrosshairTexture, CrosshairX*2.0, CrosshairY*2.0, 0.0, 0.0, CrosshairTexture.USize, CrosshairTexture.VSize);
	}  */


	if (PC != None && !PC.bBehindView && HUDOverlay != None)
	{
        if (!Level.IsSoftwareRendering())
        {
    		CameraRotation = PC.Rotation;
    		SpecialCalcFirstPersonView(PC, ViewActor, CameraLocation, CameraRotation);
    		HUDOverlay.SetLocation(CameraLocation + (HUDOverlayOffset >> CameraRotation));
    		HUDOverlay.SetRotation(CameraRotation);
    		Canvas.DrawActor(HUDOverlay, false, false, FClamp(HUDOverlayFOV * (PC.DesiredFOV / PC.DefaultFOV), 1, 170));
    	}
	}
	else
        ActivateOverlay(False);


	if (PC != none)
	    // Draw tank, turret, ammo count, passenger list
	    if (ROHud(PC.myHUD) != none && ROVehicle(GetVehicleBase()) != none)
            ROHud(PC.myHUD).DrawVehicleIcon(Canvas, ROVehicle(GetVehicleBase()), self);
}

defaultproperties
{
    HudName="Rider"

	bAllowViewChange=true//false // Don't allow behindview

	VehiclePositionString="in a vehicle"
	VehicleNameString="passenger"
	EntryPosition=(X=0,Y=0,Z=0)
	EntryRadius=130.0
	ExitPositions(0)=(X=0,Y=-200,Z=100)
	ExitPositions(1)=(X=0,Y=200,Z=100)

	FPCamPos=(X=0,Y=0,Z=45)
	FPCamViewOffset=(X=5,Y=0,Z=10)
	bFPNoZFromCameraPitch=False
	TPCamLookat=(X=-25,Y=0,Z=0)
	TPCamWorldOffset=(X=0,Y=0,Z=120)
	TPCamDistance=300
	DrivePos=(X=-15,Y=-45,Z=55)
	DriveRot=(Pitch=0,Roll=0,Yaw=0)
	bDrawDriverInTP=true//False
	bDrawMeshInFP=True
	DriverDamageMult=0.0
	bHasAltFire=False
	bPCRelativeFPRotation=true

	//DriveAnim=V_Sdkfz_transport_idle

	bUseDriverHeadBoneCam=true
	bPassengerOnly=true
}
