// ====================================================================
//  Class:  UT2K4UI.GUIGFXButton
//
//  Written by Joe Wilcox
//  (c) 2002, Epic Games, Inc.  All Rights Reserved
// ====================================================================

class GUICheckBoxButton extends GUIGFXButton
	Native;

cpptext
{
		void Draw(UCanvas* Canvas);
}

var()	Material	CheckedOverlay[10];
var()   bool		bAllOverlay;

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
	local int i;

	Super.InitComponent(MyController, MyOwner);

	for ( i = 0; i < ArrayCount(CheckedOverlay); i++ )
	{
		if ( CheckedOverlay[i] == None )
			CheckedOverlay[i] = Graphic;
	}
}

defaultproperties
{
// if _RO_
    CheckedOverlay(0)=Texture'InterfaceArt_tex.Menu.checkBoxX_b'
	CheckedOverlay(1)=Texture'InterfaceArt_tex.Menu.checkBoxX_b'
	CheckedOverlay(2)=Texture'InterfaceArt_tex.Menu.checkBoxX_b'
	CheckedOverlay(3)=Texture'InterfaceArt_tex.Menu.checkBoxX_b'
	CheckedOverlay(4)=Texture'InterfaceArt_tex.Menu.checkBoxX_b'
// else
//	CheckedOverlay(0)=Material'2K4Menus.Controls.checkboxx_b'
//	CheckedOverlay(1)=Material'2K4Menus.Controls.checkboxx_w'
//	CheckedOverlay(2)=Material'2K4Menus.Controls.checkboxx_f'
//	CheckedOverlay(3)=Material'2K4Menus.Controls.checkboxx_p'
//	CheckedOverlay(4)=Material'2K4Menus.Controls.checkboxx_d'
// end if _RO_
	bCheckBox=true
	Position=ICP_Scaled
	bRepeatClick=false
    bTabStop=true
    StyleName="CheckBox"
    ImageIndex=0
}
