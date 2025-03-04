//=====================================================
// ROSettingsPage
// Last change: 07.1.2003
//
// Contains the settings page(s) for RO
// Copyright 2003 by Red Orchestra
//=====================================================

class ROSettingsPage extends GUIPage;

var localized string	VideoTabLabel,
						VideoTabHint,
						DetailsTabLabel,
						DetailsTabHint,
						AudioTabLabel,
						AudioTabHint,
						PlayerTabLabel,
						PlayerTabHint,
						NetworkTabLabel,
						NetworkTabHint,
						ControlsTabLabel,
						ControlsTabHint,
						IForceTabLabel,
						IForceTabHint,
						WeaponsTabLabel,
						WeaponsTabHint,
						GameTabLabel,
						GameTabHint,
                        HudTabLabel,
                        HudTabHint,
						SpeechBinderTabLabel,
						SpeechBinderTabHint;

//var Tab_WeaponPref 		pWeaponPref;
var Tab_PlayerSettings  pPlayer;
var Tab_NetworkSettings	pNetwork;

var float				SavedPitch;

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
	local GUITabControl TabC;
	local rotator PlayerRot;
	local int i;


	Super.Initcomponent(MyController, MyOwner);

	// Set camera's pitch to zero when menu initialised (otherwise spinny weap goes kooky)
	PlayerRot = PlayerOwner().Rotation;
	SavedPitch = PlayerRot.Pitch;
	PlayerRot.Pitch = 0;
	PlayerOwner().SetRotation(PlayerRot);

	TabC = GUITabControl(Controls[1]);
	GUITitleBar(Controls[0]).DockedTabs = TabC;

	TabC.AddTab(VideoTabLabel,"ROInterface.ROUT2K4Tab_DetailSettings",,VideoTabHint,true);
	TabC.AddTab(AudioTabLabel,"ROInterface.ROUT2K4Tab_AudioSettings",,AudioTabHint);
	pPlayer = Tab_PlayerSettings(TabC.AddTab(PlayerTabLabel,"ROInterface.ROUT2K4Tab_PlayerSettings",,PlayerTabHint));
	TabC.AddTab(IForceTabLabel,"ROInterface.ROUT2K4Tab_IForceSettings",,IForceTabHint);
    TabC.AddTab(HudTabLabel,"ROInterface.ROUT2K4Tab_HudSettings",,HudTabHint);
	TabC.AddTab(GameTabLabel,"ROInterface.ROUT2K4Tab_GameSettings",,GameTabHint);

    TabC.bFillSpace = True;

	// Change the Style of the Tabs; DRR 05-11-2004
	for ( i = 0; i < TabC.TabStack.Length; i++ )
	{
		if ( TabC.TabStack[i] != None )
		{
	        //TabC.TabStack[i].Style=None;   // needed to reset style
			TabC.TabStack[i].FontScale=FNS_Medium;
			TabC.TabStack[i].bAutoSize=True;
			TabC.TabStack[i].bAutoShrink=False;
			//TabC.TabStack[i].StyleName="ROTabButton";
			//TabC.TabStack[i].Initcomponent(MyController, TabC);
        }
	}

}

function TabChange(GUIComponent Sender)
{
	if (GUITabButton(Sender)==none)
		return;

	GUITitleBar(Controls[0]).Caption = GUITitleBar(default.Controls[0]).Caption@"|"@GUITabButton(Sender).Caption;
}

event ChangeHint(string NewHint)
{
	GUITitleBar(Controls[2]).Caption = NewHint;
}


function InternalOnReOpen()
{
	local GUITabControl TabC;
	TabC = GUITabControl(Controls[1]);

	if ( (TabC.ActiveTab!=None) && (TabC.ActiveTab.MyPanel!=None) )
		TabC.ActiveTab.MyPanel.Refresh();
}

function bool ButtonClicked(GUIComponent Sender)
{
	if(InternalOnCanClose(false))
    {
    	GUITabControl(Controls[1]).ActiveTab.OnDeActivate();
		Controller.CloseMenu(true);
    }

	return true;
}

function bool InternalOnCanClose(optional bool bCanceled)
{

// May want to re-add this check at some point Puma 5-14-2004
//	if(!pNetwork.ValidStatConfig())
//	{
//		GUITabControl(Controls[1]).ActivateTabByName(NetworkTabLabel,true);
//		return false;
//	}
//	else
		return true;
}

function bool NotifyLevelChange()
{
	LevelChanged(); // I added this from the 2K4 code, it might break something - Antarian 3/20/04

	Controller.CloseMenu(true);
	return true;
}

function InternalOnClose(optional Bool bCanceled)
{
	local rotator NewRot;

	// Destroy spinning player model actor
	if(pPlayer.SpinnyDude != None)
	{
		pPlayer.SpinnyDude.Destroy();
		pPlayer.SpinnyDude = None;
	}

	// Reset player
	NewRot = PlayerOwner().Rotation;
	NewRot.Pitch = SavedPitch;
	PlayerOwner().SetRotation(NewRot);

	// Save config.
	pNetwork.ApplyStatConfig();
	pPlayer.InternalApply(none);
	//pWeaponPref.WeapApply(none);

	Super.OnClose(bCanceled);
}

defaultproperties {
	Begin Object class=GUITitleBar name=SettingHeader
		Caption="Configuration"
		StyleName="ROHeader"
		WinWidth=1
		WinHeight=0.500000
		WinLeft=0
		WinTop=0.02
		Effect=Texture'InterfaceArt_tex.Menu.changeme_texture' //material'CO_Final'
	End Object
	Controls(0)=GUITitleBar'SettingHeader'

	Begin Object Class=GUITabControl Name=SettingTabs
		WinWidth=1.0
		WinLeft=0.02
		WinTop=0.067
		WinHeight=58
		TabHeight=0.06
		OnChange=TabChange;
		bAcceptsInput=true
		bDockPanels=true
	End Object
	Controls(1)=GUITabControl'SettingTabs'

	Begin Object class=GUITitleBar name=SettingFooter
		WinWidth=0.88
		WinHeight=0.055
		WinLeft=0.12
		WinTop=0.93
		bUseTextHeight=false
		StyleName="ROFooter"
		Justification=TXTA_Center
	End Object
	Controls(2)=GUITitleBar'SettingFooter'

	Begin Object Class=GUIButton Name=BackButton
		Caption="Back"
		StyleName="ROSquareMenuButton"
		Hint="Return to Previous Menu"
		WinWidth=0.12
		WinHeight=0.055
		WinLeft=0
		WinTop=0.93
		OnClick=ButtonClicked
	End Object
	Controls(3)=GUIButton'BackButton'

	Begin Object class=GUIImage Name=LogoSymbol
		WinWidth=0.26
		WinHeight=0.13
		WinLeft=0.830079
		WinTop=0.800782
		Image=Texture'InterfaceArt_tex.Menu.changeme_texture' //material'fbSymbolShader'
		ImageColor=(R=255,G=255,B=255,A=255);
		ImageStyle=ISTY_Scaled
		ImageRenderStyle=MSTY_Alpha
		bVisible=false
	End Object
	Controls(4)=GUIImage'LogoSymbol'


	OnReOpen=InternalOnReOpen
	OnClose=InternalOnClose
	OnCanClose=InternalOnCanClose

	Background=Material'MenuBackground.MainBackGround'
	WinWidth=1.0
	WinHeight=1.0
	WinTop=0.0
	WinLeft=0.0

	VideoTabLabel="Video"
	DetailsTabLabel="Details"
	AudioTabLabel="Audio"
	PlayerTabLabel="Player"
	NetworkTabLabel="Network"
	ControlsTabLabel="Controls"
	IForceTabLabel="Input"
	WeaponsTabLabel="Weapons"
	GameTabLabel="Game"
    HudTabLabel="Hud"
	SpeechBinderTabLabel="Speech"

	VideoTabHint="Select your resolution and change your brightness..."
	DetailsTabHint="Adjust the detail settings for better graphics or faster framerate..."
	AudioTabHint="Adjust your audio experience..."
	PlayerTabHint="Configure your Red Orchestra Avatar..."
	NetworkTabHint="Configure Red Orchestra for Online and Lan play..."
	ControlsTabHint="Configure your controls..."
	IForceTabHint="Configure misc. input options..."
	WeaponsTabHint="Adjust your weapon priorities and settings..."
	GameTabHint="Adjust various game releated settings..."
    HudTabHint="Customize your hud..."
	SpeechBinderTabHint="Bind messages to keys..."

}
