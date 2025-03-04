//===================================================================
// ROMountedTankMGPawn
//
// Copyright (C) 2004 John "Ramm-Jaeger"  Gibson
//
// Base class for mounted tank machine guns pawns. Overrides
// onslaught functionality that we don't want/need
//===================================================================

class ROMountedTankMGPawn extends ROVehicleWeaponPawn
	  abstract;

#exec OBJ LOAD FILE=..\textures\Vehicle_Optic.utx

var     texture               MGOverlay;
var     ROTankCannon          CannonTurret;

var()   rotator				  RealAimRot;
var()   float                 FirstPersonGunShakeScale;  // Scales up view shake on 1st person weapons only.Since we're rendering the first person guns differently now on some vehicles, the view shake needs to be scaled up on them

static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Default.MGOverlay);
}

simulated function ClientKDriverEnter(PlayerController PC)
{
    local rotator NewRotation;

	Super.ClientKDriverEnter(PC);

	PC.SetFOV( WeaponFOV );
	NewRotation = Gun.Rotation;
    NewRotation.Pitch = LimitPitch(NewRotation.Pitch);
	SetRotation(NewRotation);
}

function float ModifyThreat(float current, Pawn Threat)
{
	if (Vehicle(Threat) != None)
		current -= 2.0;
	else
		current += 0.4;
	return current;
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
	local coords CamBoneCoords;
	local quat CarQuat, LookQuat, ResultQuat;

	GetAxes(CameraRotation, x, y, z);
	ViewActor = self;

	if (bPCRelativeFPRotation)
	{
		CarQuat = QuatFromRotator(GetVehicleBase().Rotation);
		CameraRotation = Normalize(PC.Rotation);
		LookQuat = QuatFromRotator(CameraRotation);
		ResultQuat = QuatProduct(LookQuat, CarQuat);
		CameraRotation = QuatToRotator(ResultQuat);
	}
	else
		CameraRotation = PC.Rotation;

	CamViewOffsetWorld = FPCamViewOffset >> CameraRotation;

	if(CameraBone != '' && Gun != None)
	{
		CamBoneCoords = Gun.GetBoneCoords(CameraBone);
		CameraLocation = CamBoneCoords.Origin + (FPCamPos >> Rotation) + CamViewOffsetWorld;

		if(bFPNoZFromCameraPitch)
		{
			VehicleZ = vect(0,0,1) >> Rotation;
			CamViewOffsetZAmount = CamViewOffsetWorld Dot VehicleZ;
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
	//CameraLocation = Gun.Location;//CameraLocation + PC.ShakeOffset.X * x + PC.ShakeOffset.Y * y + PC.ShakeOffset.Z * z;
	CameraLocation = CameraLocation + PC.ShakeOffset.X * x + PC.ShakeOffset.Y * y + PC.ShakeOffset.Z * z;
}

function KDriverEnter(Pawn P)
{
	local rotator NewRotation;

	Super.KDriverEnter(P);

	NewRotation = Gun.Rotation;
	NewRotation.Pitch = LimitPitch(NewRotation.Pitch);
	SetRotation(NewRotation);
}

simulated function DrawHUD(Canvas Canvas)
{
	local PlayerController PC;
	local vector CameraLocation;
	local rotator CameraRotation;
	local Actor ViewActor;
	local float	SavedOpacity;
	local float posx;
	local vector x, y, z;

	PC = PlayerController(Controller);

	if( PC == none )
	{
		Super.RenderOverlays(Canvas);
		//log("PanzerTurret PlayerController was none, returning");
		return;
	}
	else  if (!PC.bBehindView)
	{
		// store old opacity and set to 1.0 for map overlay rendering
		SavedOpacity = Canvas.ColorModulate.W;
		Canvas.ColorModulate.W = 1.0;

		Canvas.DrawColor.A = 255;
		Canvas.Style = ERenderStyle.STY_Alpha;

		// Calculate reticle drawing position (and position to draw black bars at)
		posx = float(Canvas.SizeX - Canvas.SizeY) / 2.0;

		// Draw black bars on the sides
		Canvas.SetPos(0, 0);
		Canvas.DrawTile(Texture'Engine.BlackTexture', posx, Canvas.SizeY, 0, 0, 8, 8);
		Canvas.SetPos(Canvas.SizeX - posx, 0);
		Canvas.DrawTile(Texture'Engine.BlackTexture', posx, Canvas.SizeY, 0, 0, 8, 8);

		Canvas.SetPos(posx, 0);
	  	Canvas.DrawTile( MGOverlay, Canvas.SizeY, Canvas.SizeY, 0.0, 0.0, texture'Vehicle_Optic.MG_sight'.USize, texture'Vehicle_Optic.MG_sight'.VSize );

		// reset HudOpacity to original value
		Canvas.ColorModulate.W = SavedOpacity;

	}
	/*
		// Draw the tank and turret icons
		//scale = Canvas.SizeX / 1600.0;
		scale = Canvas.SizeY / 1200.0;

		MapX = TankIconX * Canvas.ClipX;
		MapY = TankIconY * Canvas.ClipY;

		SavedColor = Canvas.DrawColor;
		WhiteColor =  class'Canvas'.Static.MakeColor(255,255,255);

		if( GetVehicleBase().Health/GetVehicleBase().HealthMax > 0.75 )
		{
			TankColor = class'Canvas'.Static.MakeColor(255,255,255);
		}
		else if (GetVehicleBase().Health/GetVehicleBase().HealthMax > 0.35)
		{
			TankColor = class'Canvas'.Static.MakeColor(255,222,0);
		}
		else
		{
			TankColor = class'Canvas'.Static.MakeColor(154,0,0);
		}

		Canvas.DrawColor = TankColor;

		Canvas.Style = ERenderStyle.STY_Alpha;
		Canvas.SetPos(MapX, MapY);

		if( CannonTurret == none )
		{
			for (i = 0; i < ROVehicle(GetVehicleBase()).WeaponPawns.length; i++)
			{
				if( ROVehicle(GetVehicleBase()).WeaponPawns[i].Gun.IsA('ROTankCannon'))
				{
				    CannonTurret = ROTankCannon(ROVehicle(GetVehicleBase()).WeaponPawns[i].Gun);
				    break;
				}
	   		}
		}
		else if (TurretRot != none)
		{
		 MyTurretRot = rotator(vector(CannonTurret.CurrentAim) >> CannonTurret.Rotation);
		 TurretRot.Rotation.Yaw = GetVehicleBase().Rotation.Yaw - MyTurretRot.Yaw;

		   //TurretRot.UOffset = TurretRot.Material.MaterialUSize()/2;
		   //TurretRot.VOffset = TurretRot.Material.MaterialVSize()/2;
		}

		Canvas.DrawTileScaled(TankIcon, scale * TankHudScale , scale * TankHudScale );

	// Draw dot for driver
	MapX = DriverDotX * Canvas.ClipX;
	MapY = DriverDotY * Canvas.ClipY;

	Canvas.SetPos(MapX, MapY);
	Canvas.DrawColor = WhiteColor;

	if( GetVehicleBase().Driver != none )
	{
		Canvas.DrawTileScaled(RedDot, scale * TankHudScale , scale * TankHudScale );
	}
	else
	{
		Canvas.DrawTileScaled(GrayDot, scale * TankHudScale , scale * TankHudScale );
	}

	// Draw dot for mg gunner
	MapX = HullMGDotX * Canvas.ClipX;
	MapY = HullMGDotY * Canvas.ClipY;

	Canvas.SetPos(MapX, MapY);
	Canvas.DrawTileScaled(RedDot, scale * TankHudScale , scale * TankHudScale );

	// Draw Turret
	MapX = TankIconX * Canvas.ClipX;
	MapY = TankIconY * Canvas.ClipY;

	Canvas.SetPos(MapX, MapY);
	Canvas.DrawColor = TankColor;

	if (TurretRot != none)
		Canvas.DrawTileScaled(TurretRot, scale * TankHudScale , scale * TankHudScale );

	// Draw dot for cannon gunner
	MapX = CannonDotX * Canvas.ClipX;
	MapY = CannonDotY * Canvas.ClipY;

	Canvas.SetPos(MapX, MapY);
	Canvas.DrawColor = WhiteColor;
	if ( CannonTurret.bActive ) //ONSVehicle(GetVehicleBase()).WeaponPawns[0].Gun.bActive )
	{
		Canvas.DrawTileScaled(RedDot, scale * TankHudScale , scale * TankHudScale );
	}
	else
	{
		Canvas.DrawTileScaled(GrayDot, scale * TankHudScale , scale * TankHudScale );
	}

		Canvas.DrawColor = SavedColor;
		DrawPassengers(Canvas);
	}
	*/
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
			CameraLocation = CameraLocation + PC.ShakeOffset.X * x + PC.ShakeOffset.Y * y + PC.ShakeOffset.Z * z;

			HUDOverlay.SetLocation(CameraLocation + (HUDOverlayOffset >> CameraRotation));
			HUDOverlay.SetRotation(CameraRotation);
			Canvas.DrawActor(HUDOverlay, false, true, HUDOverlayFOV);
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
	HudName="MG"

	bPCRelativeFPRotation=false

	bAllowViewChange=false // Don't allow behindview
	MGOverlay=texture'Vehicle_Optic.tiger_sight_background' // Replaceme

	DriveAnim=VPanzer4_driver_idle_close // Generic, just in case we don't specify one
	bMustBeTankCrew=true

	bIsMountedTankMG=true
	PositionInArray=1

	FirstPersonGunShakeScale=1.0
}
