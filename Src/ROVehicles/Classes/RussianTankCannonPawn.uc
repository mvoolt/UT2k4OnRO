//===================================================================
// RussianTankCannonPawn
//
// Copyright (C) 2004 John "Ramm-Jaeger"  Gibson
//
// Base class for Russian tank cannon pawns with scopes that have a
// horizontal bar that moves up and down with the range
//===================================================================

class RussianTankCannonPawn extends ROTankCannonPawn
       abstract;

var() float ScopeCenterScaleX;
var() float ScopeCenterScaleY;

simulated function DrawHUD(Canvas Canvas)
{
	local PlayerController PC;
	local vector CameraLocation;
	local rotator CameraRotation;
	local Actor ViewActor;
	local float	SavedOpacity;
	local float scale;
	local float posx;
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

        scale = Canvas.SizeY / 1200.0;

        if ( DriverPositions[DriverPositionIndex].bDrawOverlays && !IsInState('ViewTransition'))
        {
			if( DriverPositionIndex == 0 )
			{
                // Calculate reticle drawing position (and position to draw black bars at)
                posx = float(Canvas.SizeX - Canvas.SizeY) / 2.0;

        		// Draw black bars on the sides
        		Canvas.SetPos(0, 0);
        		Canvas.DrawTile(Texture'Engine.BlackTexture', posx, Canvas.SizeY, 0, 0, 8, 8);
        		Canvas.SetPos(Canvas.SizeX - posx, 0);
        		Canvas.DrawTile(Texture'Engine.BlackTexture', posx, Canvas.SizeY, 0, 0, 8, 8);

			    // Draw reticle
        		Canvas.SetPos(posx, 0);
	    		Canvas.DrawTile( CannonScopeOverlay , Canvas.SizeY, Canvas.SizeY, 0.0, 0.0, CannonScopeOverlay.USize, CannonScopeOverlay.VSize );

				if( Gun != none && Gun.ProjectileClass != none )
					Canvas.SetPos(posx + ScopePositionX * Canvas.ClipY, Gun.ProjectileClass.static.GetYAdjustForRange(Gun.GetRange()) * Canvas.ClipY);
				else
					Canvas.SetPos(posx + ScopePositionX * Canvas.ClipY, ScopePositionY * Canvas.ClipY);

				Canvas.DrawTileScaled(CannonScopeCenter, scale * ScopeCenterScaleX, scale * ScopeCenterScaleY);

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
 				//Canvas.DrawTile( BinocsOverlay , Canvas.SizeY, Canvas.SizeY, 0.0, 0.0, BinocsOverlay.USize, BinocsOverlay.VSize );
			}
	    }

    	// reset HudOpacity to original value
		Canvas.ColorModulate.W = SavedOpacity;

        // Draw tank, turret, ammo count, passenger list
	    if (ROHud(PC.myHUD) != none && ROVehicle(GetVehicleBase()) != none)
            ROHud(PC.myHUD).DrawVehicleIcon(Canvas, ROVehicle(GetVehicleBase()), self);
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

defaultproperties
{
	ScopeCenterScaleX=1.35
	ScopeCenterScaleY=1.35
	ScopePositionX=0.215
	ScopePositionY=0.5
}
