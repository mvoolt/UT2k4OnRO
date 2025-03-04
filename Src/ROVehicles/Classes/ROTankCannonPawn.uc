//===================================================================
// ROTankCannonPawn
//
// Copyright (C) 2004 John "Ramm-Jaeger"  Gibson
//
// Base class for RO tank cannon pawns
//===================================================================

class  ROTankCannonPawn extends ROVehicleWeaponPawn
       abstract;


//===================================================================
// **Warning** This class, like many of the new vehicle classes
// is pretty hacked together right now. Clean up right after alpha!!!
// Ramm
//===================================================================

var     texture	                CannonScopeOverlay;
var     texture	                CannonScopeCenter;
var()	float			  		ScopePositionX;
var()	float			  		ScopePositionY;

var     texture	                BinocsOverlay;
var()   float                   BinocsEnlargementFactor;

var    	VehicleWeapon           HullMG;

var		bool					bLockCameraDuringTransition; // Lock the camera's rotation to the camera bone during transitions

var() 	float 					RangePositionX;
var() 	float 					RangePositionY;
var() 	localized string 		RangeText;

var()	int						BinocPositionIndex;	// The position index for when the commander is looking through thier binocs

replication
{
	reliable if( Role<ROLE_Authority )
        ServerToggleRoundType;
}


/*
exec function setpos(float x, float y)
{
	ScopePositionX=x;
	ScopePositionY=y;
}

exec function setX(float x)
{
	if( !class'ROEngine.ROLevelInfo'.static.RODebugMode() )
		return;

	ScopePositionX=x;
}

exec function setY(float y)
{
	if( !class'ROEngine.ROLevelInfo'.static.RODebugMode() )
		return;

	ScopePositionY=y;
} */

exec function SetRange(byte NewRange)
{
	if( !class'ROEngine.ROLevelInfo'.static.RODebugMode() )
		return;

	log("Switching range from "$Gun.CurrentRangeIndex$" to "$NewRange);

	Gun.CurrentRangeIndex = NewRange;
}

simulated exec function SwitchFireMode()
{
	if( Gun != none && ROTankCannon(Gun) != none && ROTankCannon(Gun).bMultipleRoundTypes)
	{
		if( Controller != none && ROPlayer(Controller) != none )
			ROPlayer(Controller).ClientPlaySound(sound'ROMenuSounds.msfxMouseClick',false,,SLOT_Interface);

		ServerToggleRoundType();
	}
}

function ServerToggleRoundType()
{
	if( Gun != none && ROTankCannon(Gun) != none )
	{
		ROTankCannon(Gun).ToggleRoundType();
	}
}

function AttachToVehicle(ROVehicle VehiclePawn, name WeaponBone)
{
    if (Level.NetMode != NM_Client)
    {
        VehicleBase = VehiclePawn;
        VehicleBase.AttachToBone(Gun, WeaponBone);
    }

	if( VehiclePawn != none && VehiclePawn.bDefensive )
	{
		bDefensive = true;
	}
}

function float ModifyThreat(float current, Pawn Threat)
{
	local vector to, t;
	local float r;

	if (Vehicle(Threat) != None)
	{
		current += 0.2;
		if (ROTreadCraft(Threat) != None)
		{
			current += 0.2;
			// big bonus points for perpendicular tank targets
			to = Normal(Threat.Location - Location);
			to.z = 0;
			t = Normal(vector(Threat.Rotation));
			t.z = 0;
			r = to dot t;
			if ( (r >= 0.90630 && r < -0.73135) || (r >= -0.73135 && r < 0.90630) )
				current += 0.3;
		}
		else if (ROWheeledVehicle(Threat) != None && ROWheeledVehicle(Threat).bIsAPC)
			current += 0.1;
	}
	else
		current += 0.25;
	return current;
}

simulated exec function ROManualReload()
{
    if ( ROPlayer(Controller) != none && ROPlayer(Controller).bManualTankShellReloading == true &&
         Gun != none && ROTankCannon(Gun) != none && ROTankCannon(Gun).CannonReloadState == CR_Waiting)
    {
        ROTankCannon(Gun).ServerManualReload();
    }
}

function Fire(optional float F)
{
	if( DriverPositionIndex == BinocPositionIndex && ROPlayer(Controller) != none &&
		ROPlayerReplicationInfo(Controller.PlayerReplicationInfo).RoleInfo.bCanBeTankCommander)
	{
		ROPlayer(Controller).ServerSaveArtilleryPosition();
		return;
	}
	else if( DriverPositionIndex == BinocPositionIndex)
	{
		return;
	}
	else if ( Controller != none && ROPlayer(Controller) != none && ROPlayer(Controller).bManualTankShellReloading == true &&
              Gun != none && ROTankCannon(Gun) != none && ROTankCannon(Gun).CannonReloadState == CR_Waiting )
    {
        ROTankCannon(Gun).ServerManualReload();
        return;
    }
	else if (Gun != none && ROTankCannon(Gun) != none && (ROTankCannon(Gun).CannonReloadState != CR_ReadyToFire || !ROTankCannon(Gun).bClientCanFireCannon))
	{
       return;
	}

	super.Fire(F);

	// Check for hint
	if (Gun != None && PlayerController(Controller) != None)
	    if (ROPlayer(Controller) != none)
            ROPlayer(Controller).CheckForHint(4);
}

function AltFire(optional float F)
{
	if( DriverPositionIndex == BinocPositionIndex && ROPlayer(Controller) != none &&
		ROPlayerReplicationInfo(Controller.PlayerReplicationInfo).RoleInfo.bCanBeTankCommander)
	{
		ROPlayer(Controller).ServerSaveRallyPoint();
		return;
	}
	else if( DriverPositionIndex == BinocPositionIndex)
		return;

	Super.AltFire(F);
}

static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Default.CannonScopeOverlay);
	L.AddPrecacheMaterial(Default.CannonScopeCenter);
 	L.AddPrecacheMaterial(Default.BinocsOverlay);
}

function KDriverEnter(Pawn P)
{
    super.KDriverEnter(P);

    //If we're entering a tank cannon
    if ( Gun != none && ROTankCannon(Gun) != none )
    {
        //If the cannon is waiting to reload and this player does not have manual reloading on, force a reload
        if ( ROTankCannon(Gun).CannonReloadState == CR_Waiting &&
            (ROPlayer(Controller) == none || ROPlayer(Controller).bManualTankShellReloading == false) )
        {
            ROTankCannon(Gun).ServerManualReload();
        }
        //Otherwise, replicate the cannon's current reload state
        else
            ROTankCannon(Gun).ClientSetReloadState(ROTankCannon(Gun).CannonReloadState);
    }
}

simulated function ClientKDriverEnter(PlayerController PC)
{
	Super.ClientKDriverEnter(PC);

	//CustomAim = rotator(vector(Gun.CurrentAim) >> Gun.Rotation);
    //CannonAim = //rot(0,0,0);

	PC.SetFOV( WeaponFOV );
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
	local rotator WeaponAimRot;
	local quat AQuat, BQuat, CQuat;

    GetAxes(CameraRotation, x, y, z);
	ViewActor = self;

    WeaponAimRot = rotator(vector(Gun.CurrentAim) >> Gun.Rotation);
    WeaponAimRot.Roll =  GetVehicleBase().Rotation.Roll;

	if( ROPlayer(Controller) != none )
	{
		 ROPlayer(Controller).WeaponBufferRotation.Yaw = WeaponAimRot.Yaw;
		 ROPlayer(Controller).WeaponBufferRotation.Pitch = WeaponAimRot.Pitch;
	}

	// This makes the camera stick to the cannon, but you have no control
	if (DriverPositionIndex == 0)
	{
		CameraRotation =  WeaponAimRot;
		// Make the cannon view have no roll
		CameraRotation.Roll = 0;
	}
	else if ( bPCRelativeFPRotation )
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

	if( IsInState('ViewTransition') && bLockCameraDuringTransition )
	{
		CameraRotation = Gun.GetBoneRotation( 'Camera_com' );
	}

   	CamViewOffsetWorld = FPCamViewOffset >> CameraRotation;
	if(CameraBone != '' && Gun != None)
	{
		CamBoneCoords = Gun.GetBoneCoords(CameraBone);

		if( DriverPositions[DriverPositionIndex].bDrawOverlays && DriverPositionIndex == 0 && !IsInState('ViewTransition'))
		{
			CameraLocation = CamBoneCoords.Origin + (FPCamPos >> WeaponAimRot) + CamViewOffsetWorld;
		}
		else
		{
			CameraLocation = Gun.GetBoneCoords('Camera_com').Origin;
		}

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

//function UpdateRocketAcceleration(float deltaTime, float YawChange, float PitchChange)
//{
//	local rotator WeaponAimRot;
//
//	super.UpdateRocketAcceleration(deltaTime, YawChange, PitchChange);
//
//	log("UpdateRocketAcceleration YawChange=  "$YawChange$" PitchChange = "$PitchChange);
//
//	if( YawChange != 0 || PitchChange != 0 )
//	{
//		WeaponAimRot = rotator(vector(Gun.CurrentAim) >> Gun.Rotation);
//
//		if( YawChange != 0 )
//		{
//			WeaponAimRot.Yaw += 32.0 * deltaTime * YawChange;
//			CustomAim.Yaw = WeaponAimRot.Yaw;
//		}
//
//		if( PitchChange != 0 )
//		{
//			WeaponAimRot.Pitch += 32.0 * deltaTime * PitchChange;
//			CustomAim.Pitch = WeaponAimRot.Pitch;
//		}
//
//		//WeaponAimRot.Yaw += 32.0 * deltaTime * YawChange;
//		//WeaponAimRot.Pitch += 32.0 * deltaTime * PitchChange;
//
//		if( ROPlayer(Controller) != none )
//		{
//			 ROPlayer(Controller).WeaponBufferRotation.Yaw = CustomAim.Yaw;
//			 ROPlayer(Controller).WeaponBufferRotation.Pitch = CustomAim.Pitch;
//		}
//
//		log("UpdateRocketAcceleration CustomAim = "$CustomAim$" Rotation = "$Rotation);
//
//		//CustomAim = WeaponAimRot;
//	}
//
//
////	local rotator NewRotation;
////
////	NewRotation = Rotation;
////	NewRotation.Yaw += 32.0 * deltaTime * YawChange;
////	NewRotation.Pitch += 32.0 * deltaTime * PitchChange;
////	NewRotation.Pitch = LimitPitch(NewRotation.Pitch);
////
////	CustomAim = NewRotation;
////	ScopeLook = CustomAim;
////
////	SetRotation(NewRotation);
//}

function HandleTurretRotation(float DeltaTime, float YawChange, float PitchChange)
{
	if( Gun == none || !Gun.bUseTankTurretRotation )
		return;

	UpdateTurretRotation(DeltaTime, YawChange, PitchChange);

	if( ROPlayer(Controller) != none )
	{
		 ROPlayer(Controller).WeaponBufferRotation.Yaw = CustomAim.Yaw;
		 ROPlayer(Controller).WeaponBufferRotation.Pitch = CustomAim.Pitch;
	}
}

simulated state LeavingVehicle
{
	simulated function HandleExit()
	{
		local rotator TurretYaw, TurretPitch;
		// Make the new mesh you swap to have the same rotation as the old one
		//if( /*Role == ROLE_AutonomousProxy ||*/ Level.Netmode == NM_Standalone )
		//{
 			if( Gun != none)
 			{
 				if( Level.Netmode == NM_Standalone )
 			    {
					TurretYaw.Yaw = GetVehicleBase().Rotation.Yaw - CustomAim.Yaw;
					TurretPitch.Pitch = GetVehicleBase().Rotation.Pitch - CustomAim.Pitch;

					Gun.LinkMesh(Gun.Default.Mesh);

					Gun.SetBoneRotation(Gun.YawBone, TurretYaw);
					Gun.SetBoneRotation(Gun.PitchBone, TurretPitch);
				}
				else
				{
					Gun.LinkMesh(Gun.Default.Mesh);
				}
			}
		//}

		//LinkMesh(Default.Mesh);

		if( Gun.HasAnim(Gun.BeginningIdleAnim))
		{
		    Gun.PlayAnim(Gun.BeginningIdleAnim);
	    }
	}
}


simulated function DrawHUD(Canvas Canvas)
{
	local PlayerController PC;
	local vector CameraLocation;
	local rotator CameraRotation;
	local Actor ViewActor;
	local float	SavedOpacity;
	local float	XL, YL, MapX, MapY;
	local color SavedColor, WhiteColor;

	PC = PlayerController(Controller);
	if( PC == none )
	{
		Super.RenderOverlays(Canvas);
		//log("PanzerTurret PlayerController was none, returning");
		return;
	}
	else if (!PC.bBehindView)
	{
		// store old opacity and set to 1.0 for map overlay rendering
		SavedOpacity = Canvas.ColorModulate.W;
		Canvas.ColorModulate.W = 1.0;

		Canvas.DrawColor.A = 255;
		Canvas.Style = ERenderStyle.STY_Alpha;

        if ( DriverPositions[DriverPositionIndex].bDrawOverlays)
        {
    		Canvas.SetPos(0,0);          // sets the DrawTile origin position to (0,0), which I believe is in the upper left corner

			if( DriverPositionIndex == 0 )
			{
	    		Canvas.DrawTile( CannonScopeOverlay , Canvas.SizeX, Canvas.SizeY, 0.0, 0.0, CannonScopeOverlay.USize, CannonScopeOverlay.VSize );

				if( Gun != none && Gun.ProjectileClass != none )
					Canvas.SetPos(ScopePositionX * Canvas.ClipX,Gun.ProjectileClass.static.GetYAdjustForRange(Gun.GetRange()) * Canvas.ClipY);
				else
					Canvas.SetPos(ScopePositionX * Canvas.ClipX,ScopePositionY * Canvas.ClipY);
	    		Canvas.DrawTile( CannonScopeCenter, Canvas.SizeX, Canvas.SizeY, 0.0, 0.0, CannonScopeOverlay.USize, CannonScopeOverlay.VSize );

				// Draw the range setting
				if( Gun != none )
				{
					Canvas.Style = ERenderStyle.STY_Normal;

					SavedColor = Canvas.DrawColor;
		    		WhiteColor =  class'Canvas'.Static.MakeColor(255,255,255,175);
		    		Canvas.DrawColor = WhiteColor;

                    MapX = RangePositionX * Canvas.ClipX;
                    MapY = RangePositionY * Canvas.ClipY;

					Canvas.SetPos(MapX,MapY);
					Canvas.Font = class'ROHUD'.Static.GetSmallMenuFont(Canvas);

					Canvas.StrLen(Gun.GetRange()$" "$RangeText, XL, YL);
					Canvas.DrawTextJustified(Gun.GetRange()$" "$RangeText, 2, MapX, MapY, MapX + XL, MapY+YL);

					Canvas.DrawColor = SavedColor;
				}
			}
			else
			{
			    DrawBinocsOverlay(Canvas);
 				//Canvas.DrawTile( BinocsOverlay , Canvas.SizeX, Canvas.SizeY, 0.0, 0.0, BinocsOverlay.USize, BinocsOverlay.VSize );
			}
	    }

    	// reset HudOpacity to original value
		Canvas.ColorModulate.W = SavedOpacity;

        // Draw tank, turret, ammo count, passenger list
	    if (ROHud(PC.myHUD) != none && ROVehicle(GetVehicleBase()) != none)
            ROHud(PC.myHUD).DrawVehicleIcon(Canvas, ROVehicle(GetVehicleBase()), self);

        /*// Draw the tank and turret icons
    	//scale = Canvas.SizeX / 1600.0;
    	scale = Canvas.SizeY / 1200.0;

    	MapX = TankIconX * Canvas.ClipX + VehicleIconAbsOffsetX * scale * TankHudScale;
	    MapY = TankIconY * Canvas.ClipY + VehicleIconAbsOffsetY * scale * TankHudScale;

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

    	Canvas.DrawTileScaled(TankIcon, scale * TankHudScale , scale * TankHudScale );
    	Canvas.SetPos(MapX, MapY);

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
	    if( HullMG == none )
	    {
	    	for (i = 0; i < ROVehicle(GetVehicleBase()).WeaponPawns.length; i++)
	    	{
	    		if( ROVehicle(GetVehicleBase()).WeaponPawns[i].Gun.IsA('ROMountedTankMG'))
	    		{
	    		    HullMG = ROVehicle(GetVehicleBase()).WeaponPawns[i].Gun;
	    		    break;
	    		}
	   		}
	    }


	    if (HullMG != none)
	    {
		    MapX = HullMGDotX * Canvas.ClipX;
			MapY = HullMGDotY * Canvas.ClipY;

		    Canvas.SetPos(MapX, MapY);

		    if ( HullMG.bActive // )
		    {
		        Canvas.DrawTileScaled(RedDot, scale * TankHudScale , scale * TankHudScale );
		    }
		    else
		    {
		        Canvas.DrawTileScaled(GrayDot, scale * TankHudScale , scale * TankHudScale );
		    }
		}

		// Draw the direction the turret wants to face
        if (Gun != none)
        {
		   	TurretLookRot.Rotation.Yaw = GetVehicleBase().Rotation.Yaw - CustomAim.Yaw;

           	//TurretLookRot.UOffset = TurretLookRot.Material.MaterialUSize()/2;
           	//TurretLookRot.VOffset = TurretLookRot.Material.MaterialVSize()/2;
        }

		// Draw direction the Turret wants to face
		MapX = TankIconX * Canvas.ClipX + VehicleIconAbsOffsetX * scale * TankHudScale;
	    MapY = TankIconY * Canvas.ClipY + VehicleIconAbsOffsetY * scale * TankHudScale;

		Canvas.SetPos(MapX, MapY);
		Canvas.DrawColor = TankColor;
        Canvas.DrawColor.A = 150;
	    Canvas.DrawTileScaled(TurretLookRot, scale * TankHudScale , scale * TankHudScale );


		// Set the direction the turret is facing
        if (Gun != none)
        {
		 	MyTurretRot = rotator(vector(ROTankCannon(Gun).CurrentAim) >> ROTankCannon(Gun).Rotation);
		 	TurretRot.Rotation.Yaw = GetVehicleBase().Rotation.Yaw - MyTurretRot.Yaw;

           	//TurretRot.UOffset = TurretRot.Material.MaterialUSize()/2;
           	//TurretRot.VOffset = TurretRot.Material.MaterialVSize()/2;
        }

		// Draw Turret
    	MapX = TankIconX * Canvas.ClipX + VehicleIconAbsOffsetX * scale * TankHudScale;
	    MapY = TankIconY * Canvas.ClipY + VehicleIconAbsOffsetY * scale * TankHudScale;

		Canvas.SetPos(MapX, MapY);
		Canvas.DrawColor = TankColor;

	    Canvas.DrawTileScaled(TurretRot, scale * TankHudScale , scale * TankHudScale );

	    // Draw dot for cannon gunner
	    MapX = CannonDotX * Canvas.ClipX;
		MapY = CannonDotY * Canvas.ClipY;

	    Canvas.SetPos(MapX, MapY);
	    Canvas.DrawColor = WhiteColor;
	    Canvas.DrawTileScaled(RedDot, scale * TankHudScale , scale * TankHudScale );

	    Canvas.DrawColor = SavedColor;

        if (Gun != none && ROTankCannon(Gun) != none && ROTankCannon(Gun).bMultipleRoundTypes )
        {
			// Draw the Round Type - temp, replace with real art etc - Ramm
		    SavedColor = Canvas.DrawColor;
		    WhiteColor =  class'Canvas'.Static.MakeColor(255,255,255,175);
		    Canvas.DrawColor = WhiteColor;

			Canvas.Style = ERenderStyle.STY_Normal;

			MapX = 0.01 * Canvas.ClipX;  //PassengerListX
			MapY = 0.75 * Canvas.ClipY; // PassengerListY
			Canvas.SetPos(MapX , MapY );
			Canvas.Font = class'HUD'.Static.GetConsoleFont(Canvas);

			Canvas.StrLen(ROTankCannon(Gun).GetRoundDescription(), XL, YL);
			Canvas.DrawTextJustified(ROTankCannon(Gun).GetRoundDescription(), 2, MapX, MapY, MapX + XL, MapY+YL);

			Canvas.DrawColor = SavedColor;
		}

	    DrawPassengers(Canvas);*/

	}

     // Zap the lame crosshair - Ramm

	if (IsLocallyControlled() && Gun != None && Gun.bCorrectAim && Gun.bShowAimCrosshair)
	{
		Canvas.DrawColor = CrosshairColor;
		Canvas.DrawColor.A = 255;
		Canvas.Style = ERenderStyle.STY_Alpha;
		Canvas.SetPos(Canvas.SizeX*0.5-CrosshairX, Canvas.SizeY*0.5-CrosshairY);
		Canvas.DrawTile(CrosshairTexture, CrosshairX*2.0, CrosshairY*2.0, 0.0, 0.0, CrosshairTexture.USize, CrosshairTexture.VSize);
	}


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
}

simulated function DrawBinocsOverlay(Canvas Canvas)
{
    local float posx, overlap;

	// Calculate reticle drawing position (and position to draw black bars at)
    posx = float(Canvas.SizeX - Canvas.SizeY) / 2.0 - Canvas.SizeY * BinocsEnlargementFactor;

    // Draw the reticle
	Canvas.SetPos(posx, -BinocsEnlargementFactor * Canvas.SizeY);
  	Canvas.DrawTile(BinocsOverlay, Canvas.SizeY * (1 + 2 * BinocsEnlargementFactor), Canvas.SizeY * (1 + 2 * BinocsEnlargementFactor), 0.0, 0.0, BinocsOverlay.USize, BinocsOverlay.VSize );

	// Draw black bars on the sides
	overlap = 58.0 / float(BinocsOverlay.VSize) * Canvas.SizeY * (1 + BinocsEnlargementFactor);
	canvas.SetPos(0, 0);
	Canvas.DrawTile(Texture'Engine.BlackTexture', posx + overlap, Canvas.SizeY, 0, 0, 8, 8);
	Canvas.SetPos(Canvas.SizeX - posx - overlap, 0);
	Canvas.DrawTile(Texture'Engine.BlackTexture', posx + overlap, Canvas.SizeY, 0, 0, 8, 8);
}

defaultproperties
{
	HudName="Cmdr"

	// true for debugging purposes
	bAllowViewChange=false // Don't allow behindview
	BinocsOverlay=Texture'Weapon_overlays.Scopes.BINOC_overlay'
	BinocsEnlargementFactor=0.2
	ScopePositionX=0
	ScopePositionY=0
	RangePositionX=0.8
	RangePositionY=0.8
 	RangeText="Meters"

	bMultiPosition=true
	bCustomAiming = true

    DriveAnim=VPanzer4_com_idle_close // Generic, just in case we don't specify one

    bMustBeTankCrew=true
    bSpecialRotateSounds=true
    bHasAltFire=True
    //AutoTurretControllerClass=class'ROTurretController'
    //bAutoTurret = true

 	bHasFireImpulse=True
	FireImpulse=(X=-90000,Y=0.0,Z=0.0)

	PositionInArray=0
	BinocPositionIndex=3
}

