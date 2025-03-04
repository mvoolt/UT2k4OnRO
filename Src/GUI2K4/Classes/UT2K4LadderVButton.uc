//==============================================================================
// GUI button for a ladder entry
// Based on XIntaerface.LadderButton
//
// Written by Michiel Hendriks
// (c) 2003, Epic Games, Inc. All Rights Reserved
//==============================================================================

class UT2K4LadderVButton extends UT2K4LadderButton;

//#EXEC OBJ LOAD FILE=..\Textures\Old2k4\UCGeneric.utx

function SetState(int Rung)
{
	local string NewStyleName;

	if (MatchInfo == None)
	{
		Warn("MatchInfo == None");
		return;
	}

	// Set our state based on Rung
	// We Also set our Graphic
	if (Rung < MatchIndex)	// Match out of reach
	{
		//if (MatchInfo.ThumbnailInActive != none) Graphic = MatchInfo.ThumbnailInActive;
		//	else Graphic = Material(DynamicLoadObject("SinglePlayerThumbs."$MatchInfo.LevelName$"_G", class'Material', true));
		if (Graphic == none) Graphic = Material(DynamicLoadObject("SinglePlayerThumbs.Grey", class'Material', true));
		MenuState = MSAT_Disabled;
		NewStyleName="LadderButton";
		if (ProgresBar != none) ProgresBar.Image = PBNormal;
	}
	else
	{
		if (MyMapRecord.ScreenshotRef != "") Graphic = Material(DynamicLoadObject(MyMapRecord.ScreenshotRef, class'Material'));
		else Graphic = Material'Engine.BlackTexture';
		MenuState = MSAT_Blurry;

		if (Rung == MatchIndex)	NewStyleName="LadderButton";
			else NewStyleName="LadderButtonHi";
		if (ProgresBar != none) ProgresBar.Image = PBActive;
	}
	if (MaterialSequence(Graphic) != none) Graphic = MaterialSequence(Graphic).SequenceItems[0].Material;

	if (!(NewStyleName ~= StyleName))
	{
		StyleName = NewStyleName;
		if (Controller != none) Style = Controller.GetStyle(StyleName, FontScale);
		if (Style == None)
		{
			Log("UT2K4LadderButton.NewStyle IS None");
		}
	}
}

event SetVisibility(bool bIsVisible)
{
	super.SetVisibility(bIsVisible);
	if (ProgresBar != none) ProgresBar.SetVisibility(bIsVisible);
}


defaultproperties
{
// ifndef _RO_
	//Graphic=Material'SinglePlayerThumbs.Grey'
	PBNormal=Texture'InterfaceArt_tex.Menu.changeme_texture' //Material'InterfaceContent.SPMenu.BarVertical'
	PBActive=Texture'InterfaceArt_tex.Menu.changeme_texture' //Material'InterfaceContent.SPMenu.BarVerticalHi'
	Position=ICP_Scaled
	bClientBound=true
	bRepeatClick=false
	StyleName="LadderButton"
	WinHeight=0.113672
	WinWidth=0.090234
}
