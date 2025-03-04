// ====================================================================
//  Written by Joe Wilcox
//  (c) 2002, Epic Games, Inc.  All Rights Reserved
// ====================================================================

//class ROSTY_TabButton extends GUIStyles;
class ROSTY_TabButton extends GUI2Styles;

defaultproperties
{
	KeyName="TabButton"
	/*Images(0)=Material'ROInterfaceArt.Menu.Tab_Normal'
	Images(1)=Material'ROInterfaceArt.Menu.Tab_Normal'
	Images(2)=Material'ROInterfaceArt.Menu.Button_Depressed'
	Images(3)=Material'ROInterfaceArt.Menu.Button_Depressed'*/

	Images(0)=Texture'InterfaceArt_tex.Menu.tabssolid'
	Images(1)=Texture'InterfaceArt_tex.Menu.tabssolid_watched'
	Images(2)=Texture'InterfaceArt_tex.Menu.tabssolid'
	Images(3)=Texture'InterfaceArt_tex.Menu.tabssolid_watched'
	Images(4)=Texture'InterfaceArt_tex.Menu.tabssolid'

	/*FontNames(0)="ROSmallFont"
	FontNames(1)="ROSmallFont"
	FontNames(2)="ROSmallFont"
	FontNames(3)="ROSmallFont"
	FontNames(4)="ROSmallFont"*/

    FontColors(2)=(R=255,G=255,B=255,A=255)
	/*FontColors(0)=(R=255,G=255,B=255,A=255)
	FontColors(1)=(R=224,G=224,B=0,A=255)
	FontColors(2)=(R=255,G=255,B=255,A=255)
	FontColors(3)=(R=255,G=255,B=255,A=255)*/
}
