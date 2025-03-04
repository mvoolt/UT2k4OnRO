//-----------------------------------------------------------
// ROGUIContainerNoSkin
// Class used to 'contain' other components.
// Same as ROGUIContainer but with no background skin &
// caption.
// emh -- 11/12/2005
//-----------------------------------------------------------

class ROGUIContainerNoSkin extends ROGUIContainer;

DefaultProperties
{
    bNoCaption=true

    HeaderTop=Texture'InterfaceArt_tex.Menu.empty'
    HeaderBar=Texture'InterfaceArt_tex.Menu.empty'
    HeaderBase=Texture'InterfaceArt_tex.Menu.empty'
    ImageStyle=ISTY_Stretched

    ImageOffset(0)=0
    ImageOffset(1)=0
    ImageOffset(2)=0
    ImageOffset(3)=0
}
