//-----------------------------------------------------------
//
//-----------------------------------------------------------
class AltSectionBackground extends GUISectionBackground;

DefaultProperties
{
    HeaderTop=none
    HeaderBar=none
// if _RO_
    // lazy emh
    //HeaderBase=Texture'RO2Menu_old.RODisplay'
    HeaderBase=Texture'InterfaceArt_tex.Menu.RODisplay_withcaption'
// else
//    HeaderBase=material'2K4Menus.NewControls.Display99'
// end if _RO_
// if _RO_
// else
//    ImageOffset(0)=16
//    ImageOffset(1)=32
//    ImageOffset(2)=16
//    ImageOffset(3)=32
// end if _RO_
    bAltCaption=true

	AltCaptionOffset(0)=40
	AltCaptionOffset(1)=8
	AltCaptionOffset(2)=40
	AltCaptionOffset(3)=25

	AltCaptionAlign=TXTA_Center
	FontScale=FNS_Medium


}
