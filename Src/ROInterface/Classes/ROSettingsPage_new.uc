//=============================================================================
// ROSettingsPage_new
//=============================================================================
// The container page for all the settings tabs.
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Mathieu Mallet
//=============================================================================

class ROSettingsPage_new extends UT2K4SettingsPage;

function bool InternalOnCanClose(optional bool bCanceled)
{
    return true;
}

DefaultProperties
{
    PanelCaption(0)="Game"
    PanelCaption(1)="Display"
    PanelCaption(2)="Audio"
    PanelCaption(3)="Controls"
    PanelCaption(4)="Input"
    PanelCaption(5)="Hud"
    PanelCaption(6)=none

    PanelClass(0)="ROInterface.ROTab_GameSettings" //"GUI2K4.UT2K4Tab_PlayerSettings"
    PanelClass(1)="ROInterface.ROTab_DetailSettings"
    PanelClass(2)="ROInterface.ROTab_AudioSettings" //"GUI2K4.UT2K4Tab_AudioSettings"
    PanelClass(3)="ROInterface.ROTab_Controls" //"GUI2K4.UT2K4Tab_IForceSettings"
    PanelClass(4)="ROInterface.ROTab_Input" //"GUI2K4.UT2K4Tab_IForceSettings"
    PanelClass(5)="ROInterface.ROTab_Hud" //"GUI2K4.UT2K4Tab_WeaponPref"
    PanelClass(6)=none

    PanelHint(0)="Configure your Red Orchestra game..."
    PanelHint(1)="Select your resolution or change your display and detail settings..."
    PanelHint(2)="Adjust your audio experience..."
    PanelHint(3)="Configure your keyboard controls..."
    PanelHint(4)="Configure misc. input options..."
    PanelHint(5)="Customize your HUD..."
    PanelHint(6)=none

    Background=Material'MenuBackground.MainBackGround'
	WinWidth=1.0
	WinHeight=1.0
	WinTop=0.0
	WinLeft=0.0

	Begin Object Class=UT2K4Settings_Footer Name=SettingFooter
        RenderWeight=0.3
        TabOrder=4
        Spacer=0.01
    End Object
    t_Footer=SettingFooter
}
