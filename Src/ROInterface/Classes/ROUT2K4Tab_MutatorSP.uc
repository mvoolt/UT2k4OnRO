//-----------------------------------------------------------
//
//-----------------------------------------------------------
class ROUT2K4Tab_MutatorSP extends UT2K4Tab_MutatorSP;

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
	Super.InitComponent(MyController, MyOwner);

    class'ROInterfaceUtil'.static.SetROStyle(MyController, Controls);
}

DefaultProperties
{

     Begin Object Class=GUISectionBackground Name=AvailBackground
         Caption="Available Mutators"
         LeftPadding=0.002500
         RightPadding=0.002500
         TopPadding=0.002500
         BottomPadding=0.002500
         WinTop=0.036614
         WinLeft=0.025156
         WinWidth=0.380859
         WinHeight=0.547697
         OnPreDraw=AvailBackground.InternalPreDraw
     End Object
     sb_Avail=GUISectionBackground'ROInterface.ROUT2K4Tab_MutatorSP.AvailBackground'

     Begin Object Class=GUISectionBackground Name=ActiveBackground
         Caption="Active Mutators"
         LeftPadding=0.002500
         RightPadding=0.002500
         TopPadding=0.002500
         BottomPadding=0.002500
         WinTop=0.036614
         WinLeft=0.586876
         WinWidth=0.380859
         WinHeight=0.547697
         OnPreDraw=ActiveBackground.InternalPreDraw
     End Object
     sb_Active=GUISectionBackground'ROInterface.ROUT2K4Tab_MutatorSP.ActiveBackground'

     Begin Object Class=GUISectionBackground Name=DescriptionBackground
         Caption="Mutator Details"
         LeftPadding=0.002500
         RightPadding=0.002500
         TopPadding=0.002500
         BottomPadding=0.002500
         WinTop=0.610678
         WinLeft=0.025976
         WinWidth=0.942969
         WinHeight=0.291796
         OnPreDraw=DescriptionBackground.InternalPreDraw
     End Object
     sb_Description=GUISectionBackground'ROInterface.ROUT2K4Tab_MutatorSP.DescriptionBackground'

    Begin Object Class=GUIScrollTextBox Name=IAMutatorScroll
		WinWidth=0.938254
		WinHeight=0.244296
		WinLeft=0.028333
		WinTop=0.648595
		CharDelay=0.0025
		EOLDelay=0.5
		bNeverFocus=true
		StyleName="NoBackground"
		bTabStop=False
		bVisibleWhenEmpty=True
		bNoTeletype=True
	End Object
    lb_MutDesc=IAMutatorScroll
}
