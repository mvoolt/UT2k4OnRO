//-----------------------------------------------------------
// ROGUIProportionalContainerNoSkinAlt
// Class used to 'contain' other components.
// This class differs from ROGuiContainer in that it uses
// the contained control's scaling attributes.
// Same as ROGUIProportionalContainerNoSkin but with
// no % padding on the sides.
// emh -- 11/12/2005
//-----------------------------------------------------------
class ROGUIProportionalContainerNoSkinAlt extends ROGUIProportionalContainerNoSkin;

DefaultProperties
{
    TopPadding=0.0
    LeftPadding=0.0
    RightPadding=0.0
    BottomPadding=0.0
}
