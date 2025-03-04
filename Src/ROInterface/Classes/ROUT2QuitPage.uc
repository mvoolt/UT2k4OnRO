//-----------------------------------------------------------
//
//-----------------------------------------------------------
class ROUT2QuitPage extends UT2K3GUIPage;//UT2QuitPage;

function bool InternalOnClick(GUIComponent Sender)
{
	if (Sender==Controls[1])
	{
//		if(PlayerOwner().Level.IsDemoBuild())
//			Controller.ReplaceMenu("XInterface.UT2DemoQuitPage");
//		else
			PlayerOwner().ConsoleCommand("exit");
	}
	else
		Controller.CloseMenu(false);

	return true;
}


DefaultProperties
{
     Begin Object Class=GUIButton Name=QuitBackground
         StyleName="SquareBar"
         WinHeight=1.000000
         bBoundToParent=True
         bScaleToParent=True
         bAcceptsInput=False
         bNeverFocus=True
         OnKeyEvent=QuitBackground.InternalOnKeyEvent
     End Object
     Controls(0)=GUIButton'ROInterface.ROUT2QuitPage.QuitBackground'

     Begin Object Class=GUIButton Name=YesButton
         StyleName="RoundScaledButton"
         Caption="YES"
         WinHeight=0.08000
         WinTop=0.600000
         WinLeft=0.125000
         WinWidth=0.200000
         bBoundToParent=True
         OnClick=ROUT2QuitPage.InternalOnClick
         OnKeyEvent=YesButton.InternalOnKeyEvent
     End Object
     Controls(1)=GUIButton'ROInterface.ROUT2QuitPage.YesButton'

     Begin Object Class=GUIButton Name=NoButton
         StyleName="RoundScaledButton"
         Caption="NO"
         WinHeight=0.080000
         WinTop=0.600000
         WinLeft=0.650000
         WinWidth=0.200000
         bBoundToParent=True
         OnClick=ROUT2QuitPage.InternalOnClick
         OnKeyEvent=NoButton.InternalOnKeyEvent
     End Object
     Controls(2)=GUIButton'ROInterface.ROUT2QuitPage.NoButton'

	Begin Object class=GUILabel Name=QuitDesc
		Caption="Are you sure you wish to quit?"
		TextALign=TXTA_Center
		TextColor=(R=220,G=180,B=0,A=255)
		TextFont="UT2HeaderFont"
		WinWidth=1
		WinLeft=0
		WinTop=0.4
		WinHeight=32
	End Object
	Controls(3)=GUILabel'QuitDesc'

	WinLeft=0
	WinTop=0.375
	WinWidth=1
	WinHeight=0.25
	bRequire640x480=false

    bRenderWorld=True
    //BackgroundColor=(R=0,G=0,B=0,A=0)
}
