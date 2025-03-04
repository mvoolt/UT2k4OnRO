//=============================================================================
// Sdkfz251GunPawn
//=============================================================================
// Half Track gun pawn
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================
class Sdkfz251GunPawn extends ROMountedTankMGPawn;

/* PointOfView()
We don't ever want to allow behindview. It doesn't work with our system - Ramm
*/
simulated function bool PointOfView()
{
    return false;
}

simulated function ClientKDriverEnter(PlayerController PC)
{
	Gotostate('EnteringVehicle');

	Super.ClientKDriverEnter(PC);

    HUDOverlayOffset=default.HUDOverlayOffset;
}

simulated function ClientKDriverLeave(PlayerController PC)
{
 	Gotostate('LeavingVehicle');

	Super.ClientKDriverLeave(PC);
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

// Hack - Turn off the muzzle flash in first person when your head is sticking up since it doesn't look right
simulated state ViewTransition
{
	simulated function BeginState()
	{
		if( Role == ROLE_AutonomousProxy || Level.Netmode == NM_Standalone  || Level.NetMode == NM_ListenServer )
		{
    		if( DriverPositionIndex > 0 )
    		{
    		  Gun.AmbientEffectEmitter.bHidden = true;
    		}
		}

        super.BeginState();
	}

	simulated function EndState()
	{
		if( Role == ROLE_AutonomousProxy || Level.Netmode == NM_Standalone  || Level.NetMode == NM_ListenServer )
		{
    		if( DriverPositionIndex == 0 )
    		{
    		  Gun.AmbientEffectEmitter.bHidden = false;
    		}
		}

        super.EndState();
	}
}


defaultproperties
{
    VehiclePositionString="in a SDKFZ-251 Gun Position"
    VehicleNameString="SDKFZ-251 Gun"
	EntryPosition=(X=0,Y=0,Z=0)
	EntryRadius=130.0
	ExitPositions(0)=(X=0,Y=-200,Z=100)
	ExitPositions(1)=(X=0,Y=200,Z=100)
	GunClass=Class'ROVehicles.Sdkfz251Gun'
	CameraBone=Camera_Com
	FPCamPos=(X=0,Y=0,Z=0)
	FPCamViewOffset=(X=0,Y=0,Z=0)
	bFPNoZFromCameraPitch=False
	TPCamLookat=(X=-25,Y=0,Z=0)
	TPCamWorldOffset=(X=0,Y=0,Z=120)
	TPCamDistance=300
	DrivePos=(X=0,Y=0,Z=0)
	DriveRot=(Pitch=0,Roll=0,Yaw=16384);
	bDrawDriverInTP=True
	bDrawMeshInFP=True
	DriverDamageMult=1.0
	bHasAltFire=False
	//bPCRelativeFPRotation=true

	WeaponFov=85
	PitchUpLimit=4000
	PitchDownLimit=61000

	// TODO put the right anim here
	DriveAnim=vhalftrack_com_idle
	HUDOverlayClass=class'ROVehicles.ROVehMG34Overlay'
	HUDOverlayOffset=(X=0,Y=0,Z=0)
	HUDOverlayFOV=45
	FirstPersonGunShakeScale=2.0

    bAllowViewChange=true // Don't allow behindview

	bMustBeTankCrew=false
	bMultiPosition=true
	bCustomAiming = true

	DriverPositions(0)=(ViewLocation=(X=0,Y=0,Z=0),ViewFOV=85,PositionMesh=Mesh'axis_halftrack_anm.Halftrack_gun_int',DriverTransitionAnim=vhalftrack_com_close,TransitionUpAnim=com_open,ViewPitchUpLimit=2000,ViewPitchDownLimit=63000,ViewPositiveYawLimit=10000,ViewNegativeYawLimit=-10000,bDrawOverlays=false,bExposed=true)
	DriverPositions(1)=(ViewLocation=(X=0,Y=0,Z=0),ViewFOV=85,PositionMesh=Mesh'axis_halftrack_anm.Halftrack_gun_int',DriverTransitionAnim=vhalftrack_com_open,TransitionDownAnim=com_close,ViewPitchUpLimit=2000,ViewPitchDownLimit=63000,ViewPositiveYawLimit=10000,ViewNegativeYawLimit=-10000,bDrawOverlays=false,bExposed=true)

	PositionInArray=0
}


