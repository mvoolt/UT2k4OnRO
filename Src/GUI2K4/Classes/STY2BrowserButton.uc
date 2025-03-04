//====================================================================
//  Parent: GUIStyles
//   Class: GUI2K4.STY2BrowserButton
//    Date: 04-11-2003
//
//  This is the base style class for all Server Browser menu buttons.
//  This class should be subclassed for each icon button (Back, Refresh, etc.)
//  once we have the icons created.  For now, it duplicates STY_ServerBrowserGridHeader
//
//  Written by Ron Prestenback
//  (c) 2003, Epic Games, Inc.  All Rights Reserved
// ====================================================================
class STY2BrowserButton extends GUI2Styles;

defaultproperties
{
    KeyName="BrowserButton"
    Images(0)=Texture'InterfaceArt_tex.Menu.changeme_texture' //Material'2K4Menus.NewControls.SlantButtonBlurry'
    Images(1)=Texture'InterfaceArt_tex.Menu.changeme_texture' //Material'2K4Menus.NewControls.SlantButtonWatched'
    Images(2)=Texture'InterfaceArt_tex.Menu.changeme_texture' //Material'2K4Menus.NewControls.SlantButtonFocused'
    Images(3)=Texture'InterfaceArt_tex.Menu.changeme_texture' //Material'2K4Menus.NewControls.SlantButtonPressed'
    Images(4)=Texture'InterfaceArt_tex.Menu.changeme_texture' //Material'2K4Menus.NewControls.SlantButtonDisabled'
    ImgStyle(0)=ISTY_Scaled
    ImgStyle(1)=ISTY_Scaled
    ImgStyle(2)=ISTY_Scaled
    ImgStyle(3)=ISTY_Scaled
    ImgStyle(4)=ISTY_Scaled

}
