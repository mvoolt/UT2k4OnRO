//=============================================================================
// ROSteamLoginPage
//=============================================================================
// Menu that pops up when attempting to connect to a server with an expired
// Steam login. This page allows the user to log back in without exiting
// to Steam.
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive - John Gibson
//=============================================================================
class ROSteamLoginPage extends UT2K4GetDataMenu;

var string	RetryURL;
var localized string IncorrectPassword;
var localized string SteamUserName;
var automated GUILabel  l_Text3, l_Text4;

var float WaitTime;
var int WaitCounter;

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
	Super.InitComponent(Mycontroller, MyOwner);
	PlayerOwner().ClearProgressMessages();

	ed_Data.MyEditBox.bMaskText=true;
	ed_Data.MyEditBox.bConvertSpaces = true;

	l_Text4.Caption = Controller.SteamGetUserName();
}

function HandleParameters(string URL, string FailCode)
{
	RetryURL = URL;
}

function bool InternalOnClick(GUIComponent Sender)
{
	if ( Sender == b_OK  ) // Retry
		RetryPassword();

	else if ( Sender == b_Cancel ) // Fail
		Controller.ReplaceMenu(Controller.GetServerBrowserPage());

	return true;
}

function RetryPassword()
{
	local string 			EntryString;
	local ExtendedConsole	MyConsole;

	EntryString = ed_Data.GetText();
	MyConsole = ExtendedConsole(PlayerOwner().Player.Console);

	if( Controller.SteamRefreshLogin(EntryString) )
	{
		SetTimer( 0.25, true);

		ed_Data.DisableMe();
		b_OK.DisableMe();
		//b_Cancel.DisableMe();
		l_Text3.DisableMe();
		l_Text4.DisableMe();
		return;

		//Controller.ReplaceMenu(Controller.GetServerBrowserPage());
		//return;
		// Put this back in when Valve fixes the AuthValidation Stall problem
		//PlayerOwner().ClientTravel( RetryURL,TRAVEL_Absolute,false);
	}
	else
	{
		l_Text.Caption = IncorrectPassword;
		return;
	}

	Controller.CloseAll(false,True);
}

event Timer()
{
	super.Timer();

	if( WaitTime <= 5.0 )
	{
		WaitTime += 0.25;

		if( WaitCounter == 1 )
		{
			l_Text.Caption = "Refreshing Login  .    ";
			WaitCounter++;
		}
		else if ( WaitCounter == 2 )
		{
			l_Text.Caption = "Refreshing Login   .   ";
			WaitCounter++;
		}
		else if ( WaitCounter == 3 )
		{
			l_Text.Caption = "Refreshing Login    .  ";
			WaitCounter++;
		}
 		else if ( WaitCounter == 4 )
		{
			l_Text.Caption = "Refreshing Login     . ";
			WaitCounter++;
		}
		else if ( WaitCounter == 5 )
		{
			l_Text.Caption = "Refreshing Login      .";
			WaitCounter=0;
		}
		else
		{
			l_Text.Caption = "Refreshing Login .     ";
			WaitCounter++;
		}

		SetTimer( 0.25, true);
	}
	else
	{
		Controller.ReplaceMenu(Controller.GetServerBrowserPage());
	}

}

defaultproperties
{
	IncorrectPassword="Incorrect password specified.  Please try again."

	Begin Object class=moEditBox Name=GetPassPW
		Caption="Steam Password"
		CaptionWidth=0.4
		TabOrder=0
		WinWidth=0.562500
		WinHeight=0.030000
		WinLeft=0.209375
		WinTop=0.485366
	End Object
	ed_Data=GetPassPW

	Begin Object Class=GUIButton Name=GetPassRetry
		Caption="SUBMIT"
        StyleName="SelectButton"
		OnClick=InternalOnClick
		bBoundToParent=true
		WinWidth=0.1475
		WinHeight=0.045
		WinLeft=0.320899
		WinTop=0.730455
		TabOrder=1
	End Object
	b_OK=GetPassRetry

	Begin Object Class=GUIButton Name=GetPassFail
		Caption="CANCEL"
        StyleName="SelectButton"
		OnClick=InternalOnClick
		bBoundToParent=true
		WinWidth=0.1475
		WinHeight=0.045000
		WinLeft=0.586523
		WinTop=0.547122
		TabOrder=2
	End Object
	b_Cancel=GetPassFail

	Begin Object Class=GUILabel Name=GetPassLabel
		Caption="Steam Login Expired or Invalid, Enter Password To Login"
		TextAlign=TXTA_Center
		StyleName="TextLabel"
		FontScale=FNS_Large
		WinHeight=0.054688
		WinLeft=0.024805
		WinTop=0.195980
		WinWidth=0.940430
		bBoundToParent=true
	End Object
	l_Text=GetPassLabel

	Begin Object Class=GUILabel Name=UserNameTagLabel
		Caption="Steam UserName:"
		//CaptionWidth=0.4
		//TabOrder=0
		StyleName="TextLabel"
		WinHeight=0.030000
		WinLeft=0.209375
		WinTop=0.440366
		WinWidth=0.562500
	End Object
	l_Text3=UserNameTagLabel

	Begin Object Class=GUILabel Name=SteamUserNameLabel
		StyleName="TextLabel"
		WinHeight=0.030000
		WinLeft=0.435938
		WinTop=0.438283
		WinWidth=0.562500
	End Object
	l_Text4=SteamUserNameLabel

	OpenSound=sound'ROMenuSounds.msfxEdit'
	bAllowedAsLast=true
}
