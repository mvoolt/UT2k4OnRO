// ====================================================================
//  Class:  XInterface.STY_ListBox
//  Parent: XInterface.STY_SquareButton
//
//  Background style for the actual combo area of the listbox
//  i.e. when the menu is not expanded (I think ?)
// ====================================================================
class STY2ComboListBox extends STY2ListBox;

defaultproperties
{
    KeyName="ComboListBox"
    Images(0)=Texture'InterfaceArt_tex.Menu.changeme_texture' //Material'2K4Menus.NewControl.ComboListDropdown'
    Images(1)=Texture'InterfaceArt_tex.Menu.changeme_texture' //Material'2K4Menus.NewControl.ComboListDropdown'
    Images(2)=Texture'InterfaceArt_tex.Menu.changeme_texture' //Material'2K4Menus.NewControl.ComboListDropdown'
    Images(3)=Texture'InterfaceArt_tex.Menu.changeme_texture' //Material'2K4Menus.NewControl.ComboListDropdown'
    Images(4)=Texture'InterfaceArt_tex.Menu.changeme_texture' //Material'2K4Menus.NewControl.ComboListDropdown'

    BorderOffsets(0)=5
    BorderOffsets(1)=3
    BorderOffsets(2)=5
    BorderOffsets(3)=3
}
