//=============================================================================
// ROGUIProportionalContainerNoSkin
//=============================================================================
// Same as ROGUIProportionalContainer, but without background skin and caption
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Mathieu Mallet
//=============================================================================

class ROGUIProportionalContainerNoSkin extends ROGUIProportionalContainer;

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
