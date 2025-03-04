//==============================================================================
//	Created on: 08/15/2003
//	Base class for all UT2004 GUIPages
//
//	Written by Ron Prestenback
//	© 2003, Epic Games, Inc.  All Rights Reserved
//==============================================================================
class UT2K4GUIPage extends GUIPage
	abstract;

var Sound PopInSound, SlideInSound, FadeInSound, BeepSound;

defaultproperties
{
	WinLeft=0.0
	WinTop=0.375
	WinWidth=1.0
	WinHeight=0.50

	bCaptureInput=True

// By default, UT2K4GUIPage does not render anything behind the top-most menu
// To change this, set bRenderWorld = True
	bRequire640x480=True
	bRenderWorld=False

    // Replaceme
	PopInSound=sound'ROMenuSounds.MainMenu.OptionIn'
	SlideInSound=sound'ROMenuSounds.MainMenu.GraphSlide'
    FadeInSound=sound'ROMenuSounds.MainMenu.CharFade'
    BeepSound=sound'ROMenuSounds.msfxMouseClick'
}
