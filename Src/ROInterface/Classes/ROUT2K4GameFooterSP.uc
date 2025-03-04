//==============================================================================
//  Created on: 12/14/2003
//  This footer goes on Instant Action & Host Multiplayer pages
//
//  Written by Ron Prestenback
//  © 2003, Epic Games, Inc. All Rights Reserved
//==============================================================================

class ROUT2K4GameFooterSP extends ButtonFooter;

var automated GUIButton b_Primary, b_Back;
var() localized string PrimaryCaption, PrimaryHint;

var UT2K4GamePageBase Owner;

function InitComponent(GUIController InController, GUIComponent InOwner)
{
	Super.InitComponent(InController, InOwner);

	Owner = UT2K4GamePageBase(MenuOwner);
	b_Primary.OnClick = Owner.InternalOnClick;
	//b_Secondary.OnClick = Owner.InternalOnClick;
	b_Back.OnClick = Owner.InternalOnClick;
}

function SetupButtons( optional string bPerButtonSizes )
{
	b_Primary.Caption = PrimaryCaption;
	b_Primary.SetHint( PrimaryHint );

	//b_Secondary.Caption = SecondaryCaption;
	//b_Secondary.SetHint( SecondaryHint );

	Super.SetupButtons(bPerButtonSizes);
}

DefaultProperties
{
    Begin Object Class=GUIButton Name=GamePrimaryButton
        StyleName="FooterButton"
        WinWidth=0.12
        //WinHeight=0.033203
        //WinTop=0.966146
        WinHeight=0.036482
		WinTop=0.085678
        WinLeft=0.88
        TabOrder=0
        bBoundToParent=True
        MenuState=MSAT_Disabled
    End Object
    b_Primary=GamePrimaryButton

    Begin Object Class=GUIButton Name=GameBackButton
        Caption="BACK"
        Hint="Return to Previous Menu"
        StyleName="FooterButton"
        WinWidth=0.12
        //WinHeight=0.033203
        //WinTop=0.966146
        WinHeight=0.036482
		WinTop=0.085678
        WinLeft=0
        TabOrder=2
        bBoundToParent=True
    End Object
    b_Back=GameBackButton

}
