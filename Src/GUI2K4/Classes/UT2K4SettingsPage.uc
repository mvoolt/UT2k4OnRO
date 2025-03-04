//==============================================================================
//  Description
//
//  Written by Ron Prestenback (based on XInterface.SettingsPage)
//  � 2003, Epic Games, Inc.  All Rights Reserved
//==============================================================================
class UT2K4SettingsPage extends UT2K4MainPage;

// if _RO_
// else
//#exec OBJ LOAD FILE=InterfaceContent.utx
// end if _RO_

var Automated GUIButton b_Back;
var Automated GUIButton b_Apply, b_Reset;

var() config bool                 bApplyImmediately;  // Whether to apply changes to setting immediately
var UT2K4Tab_GameSettings       tp_Game;

var() editconst noexport float               SavedPitch;
var() string PageCaption;
var() GUIButton SizingButton;
var() Settings_Tabs ActivePanel;
var localized string InvalidStats;

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
    local rotator PlayerRot;
    local int i;

    Super.InitComponent(MyController, MyOwner);
    PageCaption = t_Header.Caption;

    GetSizingButton();


    // Set camera's pitch to zero when menu initialised (otherwise spinny weap goes kooky)
    PlayerRot = PlayerOwner().Rotation;
    SavedPitch = PlayerRot.Pitch;
    PlayerRot.Pitch = 0;
    PlayerRot.Roll = 0;
    PlayerOwner().SetRotation(PlayerRot);

	for ( i = 0; i < PanelCaption.Length && i < PanelClass.Length && i < PanelHint.Length; i++ )
	{
		Profile("Settings_" $ PanelCaption[i]);
		c_Tabs.AddTab(PanelCaption[i], PanelClass[i],, PanelHint[i]);
		Profile("Settings_" $ PanelCaption[i]);
	}

    tp_Game = UT2K4Tab_GameSettings(c_Tabs.BorrowPanel(PanelCaption[3]));
}

function GetSizingButton()
{
    local int i;

    SizingButton = None;
    for (i = 0; i < Components.Length; i++)
    {
        if (GUIButton(Components[i]) == None)
            continue;

        if ( SizingButton == None || Len(GUIButton(Components[i]).Caption) > Len(SizingButton.Caption))
            SizingButton = GUIButton(Components[i]);
    }
}

function bool InternalOnPreDraw(Canvas Canvas)
{
    local int X, i;
    local float XL,YL;

    if (SizingButton == None)
        return false;

    SizingButton.Style.TextSize(Canvas, SizingButton.MenuState, SizingButton.Caption, XL, YL, SizingButton.FontScale);

    XL += 32;
    X = Canvas.ClipX - XL;
    for (i = Components.Length - 1; i >= 0; i--)
    {
        if (GUIButton(Components[i]) == None)
            continue;

        Components[i].WinWidth = XL;
        Components[i].WinLeft = X;
        X -= XL;
    }

    return false;
}

function bool InternalOnCanClose(optional bool bCanceled)
{
    if(Controller.ActivePage == Self && !tp_Game.ValidStatConfig())
    {
        c_Tabs.ActivateTabByPanel(tp_Game, True);

		Controller.OpenMenu("GUI2K4.UT2K4GenericMessageBox",InvalidStats,tp_Game.l_Warning.Caption);
        return false;
    }

    return true;
}

function InternalOnClose(optional Bool bCanceled)
{
    local rotator NewRot;

    // Reset player
    NewRot = PlayerOwner().Rotation;
    NewRot.Pitch = SavedPitch;
    PlayerOwner().SetRotation(NewRot);

    Super.OnClose(bCanceled);
}

function InternalOnChange(GUIComponent Sender)
{
	Super.InternalOnChange(Sender);

	if ( c_Tabs.ActiveTab == None )
		ActivePanel = None;
	else ActivePanel = Settings_Tabs(c_Tabs.ActiveTab.MyPanel);
}

function BackButtonClicked()
{
	if ( InternalOnCanClose(False) )
	{
    	c_Tabs.ActiveTab.OnDeActivate();
        Controller.CloseMenu(False);
    }
}


function DefaultsButtonClicked()
{
	ActivePanel.ResetClicked();
}

function bool ButtonClicked(GUIComponent Sender)
{
    ActivePanel.AcceptClicked();
    return true;
}

event bool NotifyLevelChange()
{
	bPersistent = false;
	LevelChanged();
	return true;
}

defaultproperties
{
    OnClose=InternalOnClose
    OnCanClose=InternalOnCanClose
    OnPreDraw=InternalOnPreDraw

    Begin Object class=GUIHeader name=SettingHeader
        Caption="Settings"
		WinHeight=25
		RenderWeight=0.3
    End Object

    Begin Object Class=UT2K4Settings_Footer Name=SettingFooter
        RenderWeight=0.3
        TabOrder=4
    End Object

    Begin Object Class=GUIButton Name=aApply
        Caption="APPLY"
        WinWidth=0.097460
        WinLeft=0.902148
        WinHeight=0.033203
        WinTop=0.966146
        TabOrder=1
        bVisible=True
        OnClick=ButtonClicked
        StyleName="SquareButton"
        MenuState=MSAT_Disabled
        RenderWeight=1.0
    End Object

    t_Header=SettingHeader
    t_Footer=SettingFooter

    WinWidth=1.0
    WinHeight=1.0
    WinTop=0.0
    WinLeft=0.0

    PanelCaption(0)="Display"
    PanelCaption(1)="Audio"
    PanelCaption(2)="Player"
    PanelCaption(3)="Game"
    PanelCaption(4)="Input"
    PanelCaption(5)="Weapons"
    PanelCaption(6)="HUD"

    PanelClass(0)="GUI2K4.UT2K4Tab_DetailSettings"
    PanelClass(1)="GUI2K4.UT2K4Tab_AudioSettings"
    PanelClass(2)="GUI2K4.UT2K4Tab_PlayerSettings"
    PanelClass(3)="GUI2K4.UT2K4Tab_GameSettings"
    PanelClass(4)="GUI2K4.UT2K4Tab_IForceSettings"
    PanelClass(5)="GUI2K4.UT2K4Tab_WeaponPref"
    PanelClass(6)="GUI2K4.UT2K4Tab_HudSettings"

    PanelHint(0)="Select your resolution or change your display and detail settings..."
    PanelHint(1)="Adjust your audio experience..."
    PanelHint(2)="Configure your UT2004 Avatar..."
    PanelHint(3)="Configure game and network related settings..."
    PanelHint(4)="Configure misc. input options..."
    PanelHint(5)="Adjust your weapon priorities and settings..."
    PanelHint(6)="Customize your HUD..."
 	InvalidStats="Invalid Stats Info"
    bApplyImmediately=True
}
