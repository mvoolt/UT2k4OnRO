//=============================================================================
// BA64GunPawn
//=============================================================================
// Player that mans the BA-64 top gun
//=============================================================================
// Red Orchestra Source - John Gibson
// Copyright (C) 2005 Tripwire Interactive LLC
//=============================================================================

class BA64GunPawn extends ROMountedTankMGPawn;

/* PointOfView()
We don't ever want to allow behindview. It doesn't work with our system - Ramm
*/
simulated function bool PointOfView()
{
    return false;
}


simulated function ClientKDriverEnter(PlayerController PC)
{
    Super.ClientKDriverEnter(PC);

    HUDOverlayOffset=default.HUDOverlayOffset;
}

simulated function SpecialCalcFirstPersonView(PlayerController PC, out actor ViewActor, out vector CameraLocation, out rotator CameraRotation )
{
    local vector x, y, z;
	local vector VehicleZ, CamViewOffsetWorld;
	local float CamViewOffsetZAmount;
	local rotator WeaponAimRot;

    GetAxes(CameraRotation, x, y, z);
	ViewActor = self;

    WeaponAimRot = Gun.GetBoneRotation(CameraBone);

	if( ROPlayer(Controller) != none )
	{
		 ROPlayer(Controller).WeaponBufferRotation.Yaw = WeaponAimRot.Yaw;
		 ROPlayer(Controller).WeaponBufferRotation.Pitch = WeaponAimRot.Pitch;
	}

	CameraRotation =  WeaponAimRot;

	CamViewOffsetWorld = FPCamViewOffset >> CameraRotation;

	if(CameraBone != '' && Gun != None)
	{
		CameraLocation = Gun.GetBoneCoords('Camera_com').Origin;

		if(bFPNoZFromCameraPitch)
		{
			VehicleZ = vect(0,0,1) >> WeaponAimRot;

			CamViewOffsetZAmount = CamViewOffsetWorld dot VehicleZ;
			CameraLocation -= CamViewOffsetZAmount * VehicleZ;
		}
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

function UpdateRocketAcceleration(float deltaTime, float YawChange, float PitchChange)
{
	local rotator NewRotation;

	NewRotation = Rotation;
	NewRotation.Yaw += 32.0 * deltaTime * YawChange;
	NewRotation.Pitch += 32.0 * deltaTime * PitchChange;
	NewRotation.Pitch = LimitPitch(NewRotation.Pitch);

	SetRotation(NewRotation);

	UpdateSpecialCustomAim(DeltaTime, YawChange, PitchChange);

	if( ROPlayer(Controller) != none )
	{
         ROPlayer(Controller).WeaponBufferRotation.Yaw = CustomAim.Yaw;
		 ROPlayer(Controller).WeaponBufferRotation.Pitch = CustomAim.Pitch;
	}
}

simulated function DrawHUD(Canvas Canvas)
{
    local PlayerController PC;
    local vector CameraLocation;
    local rotator CameraRotation;
    local Actor ViewActor;
    local vector GunOffset;

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

    		CameraRotation = Normalize(CameraRotation + PC.ShakeRot);
    		GunOffset += PC.ShakeOffset * FirstPersonGunShakeScale;

            // Make the first person gun appear lower when your sticking your head up
            GunOffset.z += (((Gun.GetBoneCoords('1stperson_wep').Origin.Z - CameraLocation.Z) * 3));
            GunOffset += HUDOverlayOffset;

            // Not sure if we need this, but the HudOverlay might lose network relevancy if its location doesn't get updated - Ramm
    		HUDOverlay.SetLocation(CameraLocation + (HUDOverlayOffset >> CameraRotation));

    		Canvas.DrawBoundActor(HUDOverlay, false, true,HUDOverlayFOV,CameraRotation,PC.ShakeRot*FirstPersonGunShakeScale,GunOffset*-1);
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
    VehiclePositionString="in a BA64 Gun Position"
    VehicleNameString="BA64 Gun"
	EntryPosition=(X=0,Y=0,Z=0)
	EntryRadius=130.0
	ExitPositions(0)=(X=0,Y=-200,Z=100)
	ExitPositions(1)=(X=0,Y=200,Z=100)
	GunClass=Class'ROVehicles.BA64Gun'
	CameraBone=camera_com
	FPCamPos=(X=0,Y=0,Z=0)
	FPCamViewOffset=(X=0.000000,Z=0.000000)
	bFPNoZFromCameraPitch=False
	TPCamLookat=(X=-25,Y=0,Z=0)
	TPCamWorldOffset=(X=0,Y=0,Z=120)
	TPCamDistance=300
	DrivePos=(X=0.000000,Y=0.00,Z=0.000000)
	DriveRot=(Pitch=0,Roll=0,Yaw=0);
	bDrawDriverInTP=True
	bDrawMeshInFP=True
	DriverDamageMult=1.0
	bHasAltFire=False
	//bPCRelativeFPRotation=true

	WeaponFov=85
	PitchUpLimit=4000
	PitchDownLimit=61000

	DriveAnim=VBA64_com_idle_close
	HUDOverlayClass=class'ROVehicles.ROVehDTOverlay'
	HUDOverlayOffset=(X=-15,Y=0,Z=0)
	HUDOverlayFOV=45
	FirstPersonGunShakeScale=3.0

    bAllowViewChange=false // Don't allow behindview

	bMustBeTankCrew=false
	bMultiPosition=true
	bCustomAiming = true

	DriverPositions(0)=(ViewLocation=(X=0,Y=0,Z=0),ViewFOV=85,PositionMesh=Mesh'allies_ba64_anm.BA64_turret_int',DriverTransitionAnim=VBA64_com_close,TransitionUpAnim=com_open,ViewPitchUpLimit=3500,ViewPitchDownLimit=63500,ViewPositiveYawLimit=10000,ViewNegativeYawLimit=-10000,bDrawOverlays=false,bExposed=false)
	DriverPositions(1)=(ViewLocation=(X=0,Y=0,Z=0),ViewFOV=85,PositionMesh=Mesh'allies_ba64_anm.BA64_turret_int',DriverTransitionAnim=VBA64_com_open,TransitionDownAnim=com_close,ViewPitchUpLimit=3500,ViewPitchDownLimit=63500,ViewPositiveYawLimit=10000,ViewNegativeYawLimit=-10000,bDrawOverlays=false,bExposed=true)

	PositionInArray=0
}


