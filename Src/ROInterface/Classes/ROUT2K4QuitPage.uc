//-----------------------------------------------------------
//
//-----------------------------------------------------------
class ROUT2K4QuitPage extends UT2K4QuitPage;

DefaultProperties
{
     Begin Object Class=GUIButton Name=cYesButton
         StyleName="SelectButton"
         Caption="YES"
         WinTop=0.515625
         WinLeft=0.164063
         WinWidth=0.200000
         TabOrder=0
         OnClick=UT2K4QuitPage.InternalOnClick
         OnKeyEvent=cYesButton.InternalOnKeyEvent
     End Object
     YesButton=GUIButton'ROInterface.ROUT2K4QuitPage.cYesButton'

     Begin Object Class=GUIButton Name=cNoButton
         StyleName="SelectButton"
         Caption="NO"
         WinTop=0.515625
         WinLeft=0.610937
         WinWidth=0.200000
         TabOrder=1
         OnClick=UT2K4QuitPage.InternalOnClick
         OnKeyEvent=cNoButton.InternalOnKeyEvent
     End Object
     NoButton=GUIButton'ROInterface.ROUT2K4QuitPage.cNoButton'

     /*Begin Object Class=FloatingImage Name=MessageWindowFrameBackground
//         Image=Texture'2K4Menus.NewControls.Display2'
         Image=Texture'ROInterfaceArt.button_normal'
         DropShadowX=0
         DropShadowY=0
         WinTop=0.000000
         WinLeft=0.000000
         WinWidth=1.000000
         WinHeight=1.000000
     End Object
     i_FrameBG=FloatingImage'ROInterface.ROUT2K4QuitPage.MessageWindowFrameBackground'*/

}
