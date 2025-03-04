// ====================================================================
//  Written by Joe Wilcox
//  (c) 2002, Epic Games, Inc.  All Rights Reserved
//
//	Style content for all GUI tabs
// ====================================================================

class STY_TabButton extends GUIStyles;

defaultproperties
{
	KeyName="TabButton"
	Images(0)=Texture'InterfaceArt_tex.Menu.changeme_texture' //Material'InterfaceContent.Menu.BoxTab'
	Images(1)=Texture'InterfaceArt_tex.Menu.changeme_texture' //Material'InterfaceContent.Menu.BoxTabWatched'
	Images(2)=Texture'InterfaceArt_tex.Menu.changeme_texture' //Material'InterfaceContent.Menu.BoxTabPulse'
	Images(3)=Texture'InterfaceArt_tex.Menu.changeme_texture' //Material'InterfaceContent.Menu.BoxTabPulse2'

	FontNames(0)="UT2SmallHeaderFont"
	FontNames(1)="UT2SmallHeaderFont"
	FontNames(2)="UT2SmallHeaderFont"
	FontNames(3)="UT2SmallHeaderFont"
	FontNames(4)="UT2SmallHeaderFont"

	FontColors(0)=(R=255,G=255,B=255,A=255)
	FontColors(1)=(R=255,G=255,B=255,A=255)
	FontColors(2)=(R=230,G=200,B=0,A=255)
	FontColors(3)=(R=230,G=200,B=0,A=255)
}
