//=====================================================
// ROMainMenu
// Last change: 05.1.2003
//
// Contains the main menu for RO
// Copyright 2003 by Red Orchestra
// $Id: ROMainMenu.uc,v 1.16 2004/11/09 22:46:59 puma Exp $:
//=====================================================

class ROMainMenu extends UT2K4GUIPage;

//var automated   FloatingImage i_background, i_background2;
var automated   FloatingImage i_background;

var automated   GUISectionBackground sb_MainMenu;
var automated 	GUIButton	b_MultiPlayer, b_Practice, b_Settings, b_Help, b_Host, b_Quit;

var automated   GUISectionBackground sb_HelpMenu;
var automated   GUIButton   b_Credits, b_Manual, b_Demos, b_Website, b_Back;


var bool	    AllowClose;
var localized string      ManualURL;
var string      WebsiteURL;

var localized string SteamMustBeRunningText;
var localized string SinglePlayerDisabledText;

//var string MenuLevelName;

var() config string MenuSong;

var globalconfig bool AcceptedEULA;

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
	local int xl,yl,y;


	//MyController.RegisterStyle(class'ROSTY_RoundScaledButton');

	// G15 Support
	Super.InitComponent(MyController, MyOwner);

	Controller.LCDCls();
	Controller.LCDDrawTile(Controller.LCDLogo,0,0,50,43,0,0,50,43);

	y = 0;
	Controller.LCDStrLen("Red Orchestra",Controller.LCDMedFont,xl,yl);
	Controller.LCDDrawText("Red Orchestra",(100-(XL/2)),y,Controller.LCDMedFont);
	y += 14;
	Controller.LCDStrLen("Ostfront",Controller.LCDSmallFont,xl,yl);
	Controller.LCDDrawText("Ostfront",(100-(XL/2)),y,Controller.LCDSmallFont);

	y += 14;
	Controller.LCDStrLen("41-45",Controller.LCDLargeFont,xl,yl);
	Controller.LCDDrawText("41-45",(100-(XL/2)),y,Controller.LCDLargeFont);

	Controller.LCDRepaint();
	// end G15 support

	sb_MainMenu.ManageComponent(b_MultiPlayer);
	sb_MainMenu.ManageComponent(b_Practice);
	sb_MainMenu.ManageComponent(b_Settings);
	sb_MainMenu.ManageComponent(b_Help);
	sb_MainMenu.ManageComponent(b_Host);
	sb_MainMenu.ManageComponent(b_Quit);

	sb_HelpMenu.ManageComponent(b_Credits);
	sb_HelpMenu.ManageComponent(b_Manual);
	sb_HelpMenu.ManageComponent(b_Demos);
	sb_HelpMenu.ManageComponent(b_Website);
	sb_HelpMenu.ManageComponent(b_Back);

	/*if (PlayerOwner().Level.IsDemoBuild())
	{
		Controls[3].SetFocus(none);
		Controls[2].MenuStateChange(MSAT_Disabled);
	}*/
}

function InternalOnOpen()
{
    log("MainMenu: starting music "$MenuSong);
    PlayerOwner().ClientSetInitialMusic(MenuSong,MTRAN_Segue);


	// if this is the first time launching the game, show the EULA.
	if (!AcceptedEULA)
	{
	   Controller.OpenMenu("ROInterface.ROEULA");
	}
}


function OnClose(optional Bool bCanceled) {
}

// menu ids:
// 0 - main menu
// 1 - help menu
function ShowSubMenu(int menu_id)
{
    switch (menu_id)
    {
        case 0:
            sb_MainMenu.SetVisibility(true);
            sb_HelpMenu.SetVisibility(false);
            break;

        case 1:
            sb_MainMenu.SetVisibility(false);
            sb_HelpMenu.SetVisibility(true);
            break;
    }
}

function bool MyKeyEvent(out byte Key,out byte State,float delta)
{
	if(Key == 0x1B && State == 1)	// Escape pressed
	{
		AllowClose = true;
		return true;
	}
	else
		return false;
}

function bool CanClose(optional Bool bCanceled)
{
	if (AllowClose)
		Controller.OpenMenu(Controller.GetQuitPage());

	return false;
}


function bool ButtonClick(GUIComponent Sender)
{
    local GUIButton selected;
    if (GUIButton(Sender) != None)
		selected = GUIButton(Sender);

	switch (sender)
	{
        case b_Practice:
        	if ( class'LevelInfo'.static.IsDemoBuild() )
        	{
	    		Controller.OpenMenu(Controller.QuestionMenuClass);
				GUIQuestionPage(Controller.TopPage()).SetupQuestion(SinglePlayerDisabledText, QBTN_Ok, QBTN_Ok);
        	}
        	else
        	{
	            Profile("InstantAction");
	    		Controller.OpenMenu(Controller.GetInstantActionPage());
	    		Profile("InstantAction");
    		}
            break;

        case b_MultiPlayer:
        	if( !Controller.CheckSteam() )
        	{
            	Controller.OpenMenu(Controller.QuestionMenuClass);
		    	GUIQuestionPage(Controller.TopPage()).SetupQuestion(SteamMustBeRunningText, QBTN_Ok, QBTN_Ok);
        	}
        	else
        	{
	            Profile("ServerBrowser");
				Controller.OpenMenu(Controller.GetServerBrowserPage());
				Profile("ServerBrowser");
        	}
			break;

		case b_Host:
        	if( !Controller.CheckSteam() )
        	{
            	Controller.OpenMenu(Controller.QuestionMenuClass);
		    	GUIQuestionPage(Controller.TopPage()).SetupQuestion(SteamMustBeRunningText, QBTN_Ok, QBTN_Ok);
        	}
        	else
        	{
		        Profile("MPHost");
				Controller.OpenMenu(Controller.GetMultiplayerPage());
				Profile("MPHost");
        	}
 	        break;

	    case b_Settings:
            Profile("Settings");
     	    Controller.OpenMenu(Controller.GetSettingsPage());
    		Profile("Settings");
    		break;

    	case b_Credits:
    	    Controller.OpenMenu("ROInterface.ROCreditsPage");
    	    break;

        case b_Quit:
            Profile("Quit");
    		Controller.OpenMenu(Controller.GetQuitPage());
    		Profile("Quit");
    		break;

        case b_Manual:
            Profile("Manual");
            PlayerOwner().ConsoleCommand("start "@ManualURL);
    		Profile("Manual");
    		break;

    	case b_Website:
    	    Profile("Website");
            PlayerOwner().ConsoleCommand("start "@WebsiteURL);
    		Profile("Website");
    		break;

    	case b_Demos:
    	    Controller.OpenMenu("ROInterface.RODemosMenu");
    	    break;

    	case b_Help:
    	    ShowSubMenu(1);
    	    break;

    	case b_Back:
    	    ShowSubMenu(0);
    	    break;

	}

    /*
	if ( Sender == b_ModsAndDemo )
	{
			Profile("ModsandDemos");
			Controller.OpenMenu(Controller.GetModPage());
     		profile("ModsandDemos");
	}
	*/

	return true;
}

event Opened(GUIComponent Sender)
{

	if ( bDebugging )
		log(Name$".Opened()   Sender:"$Sender,'Debug');

    if ( Sender != None && PlayerOwner().Level.IsPendingConnection() )
    	PlayerOwner().ConsoleCommand("CANCEL");

    ShowSubMenu(0);

    //log("Current level.outer = " $ string(PlayerOwner().level.outer));

    /*if (PlayerOwner().Level.game == none ||
        !PlayerOwner().Level.game.isa('ROMainMenuGame'))
    {
        log("Loading main menu level...");
        LoadMenuLevel();
        Super.Opened(Sender);
        Controller.bCurMenuInitialized = true; // hax!
        Controller.CloseAll(false, true); // Close all menus so that the level isn`t disconnected
        return;
    }*/

    //log("Current level.outer = " $ string(PlayerOwner().level.outer));

    Super.Opened(Sender);
}

function LoadMenuLevel()
{
    //log("LoadMenuLevel called.");
    //PlayerOwner().ClientTravel(MenuLevelName $ "?game=ROInterface.ROMainMenuGame", TRAVEL_Absolute, False);
    //PlayerOwner().ConsoleCommand("switchlevel " $ MenuLevelName);
    //PlayerOwner().Level.ServerTravel(MenuLevelName $ "?game=ROInterface.ROMainMenuGame", false);
    //Console(Controller.Master.Console).DelayedConsoleCommand("start" @ MenuLevelName $ "?game=ROInterface.ROMainMenuGame");
}

event bool NotifyLevelChange()
{
	if ( bDebugging )
		log(Name@"NotifyLevelChange  PendingConnection:"$PlayerOwner().Level.IsPendingConnection());

	return PlayerOwner().Level.IsPendingConnection();
}



defaultproperties
{
	WinWidth=1
	WinHeight=1
	WinLeft=0
	WinTop=0

    Begin Object Class=FloatingImage Name=FloatingBackground
        Image=Texture'menuBackground.InterfaceBackgrounds.MainBackGround'
        DropShadow=None
        ImageStyle=ISTY_Scaled
        ImageRenderStyle=MSTY_Alpha
        WinTop=0.0
        WinLeft=0.000000
        WinWidth=1.000000
        WinHeight=1.0
        RenderWeight=0.000003
    End Object
    i_background=FloatingBackground

    /*Begin Object Class=FloatingImage Name=FloatingBackground
        Image=Texture'MainMenuArt.General.wheat_mask_blurred'
        DropShadow=None
        ImageStyle=ISTY_Scaled
        ImageRenderStyle=MSTY_Alpha
        WinTop=0.450000
        WinLeft=0.000000
        WinWidth=1.000000
        WinHeight=0.3
        RenderWeight=0.000003
    End Object
    i_background=FloatingBackground

    Begin Object Class=FloatingImage Name=FloatingBackground2
        Image=Texture'Engine.BlackTexture'
        DropShadow=None
        ImageStyle=ISTY_Scaled
        ImageRenderStyle=MSTY_Alpha
        WinTop=0.750000
        WinLeft=0.000000
        WinWidth=1.000000
        WinHeight=1.0
        RenderWeight=0.000003
    End Object
    i_background2=FloatingBackground2*/

    Begin Object class=ROGUIContainerNoSkinAlt Name=sbSection1
		WinWidth=0.485000
		WinHeight=0.281354
		WinLeft=0.021875
		WinTop=0.694000
        //RenderWeight=0.01
	End Object
	sb_MainMenu=sbSection1

    Begin Object class=ROGUIContainerNoSkinAlt Name=sbSection2
		WinWidth=0.485000
		WinHeight=0.240728
		WinLeft=0.021875
		WinTop=0.694000
        //RenderWeight=0.01
	End Object
	sb_HelpMenu=sbSection2

	Begin Object Class=GUIButton name=ServerButton
		Caption="Multiplayer"
		OnClick=ButtonClick
		CaptionAlign=TXTA_Left
        FontScale=FNS_Large
        CaptionEffectStyleName="TextButtonEffect"
        StyleName="TextButton"
        Hint="Play a multiplayer match"
        TabOrder=1
        bFocusOnWatch=True
        //bAutoSize=True
        bAutoShrink=False
        bUseCaptionHeight=true
	End Object
	b_MultiPlayer=GUIButton'ServerButton'

	Begin Object Class=GUIButton Name=InstantActionButton
        Caption="Practice"
        //bAutoSize=True
        bAutoShrink=False
        FontScale=FNS_Large
		CaptionAlign=TXTA_Left
        CaptionEffectStyleName="TextButtonEffect"
        StyleName="TextButton"
        Hint="Play a practice match"
        TabOrder=2
        bFocusOnWatch=True
        OnClick=ButtonClick
        OnKeyEvent=GUIButton.InternalOnKeyEvent
        bUseCaptionHeight=true
    End Object
    b_Practice=GUIButton'InstantActionButton';



    /*
	Begin Object Class=GUIButton name=ModsAndDemosButton
		Caption="Community"
		WinWidth=0.337250
		WinHeight=0.088333
		WinLeft=0.359376
		WinTop=0.575001
		bAutoSize=True
        bAutoShrink=False
		OnClick=ButtonClick
		CaptionAlign=TXTA_Left
        FontScale=FNS_Small
        CaptionEffectStyleName="TextButtonEffect"
        StyleName="TextButton"
        Hint="Configuration settings"
        TabOrder=2
        bFocusOnWatch=True
	End Object
//	b_ModsAndDemo=GUIButton'ROInterface.ROMainMenu.ModsAndDemosButton';
	b_ModsAndDemo=None
	*/



	Begin Object Class=GUIButton name=SettingsButton
		Caption="Configuration"
		//bAutoSize=True
        bAutoShrink=False
		OnClick=ButtonClick
		CaptionAlign=TXTA_Left
        FontScale=FNS_Large
        CaptionEffectStyleName="TextButtonEffect"
        StyleName="TextButton"
        Hint="Configuration settings"
        TabOrder=3
        bFocusOnWatch=True
        bUseCaptionHeight=true
	End Object
	b_Settings=GUIButton'SettingsButton'

    Begin Object Class=GUIButton Name=HelpButton
        Caption="Help & Game Management"
		//bAutoSize=True
        bAutoShrink=False
		OnClick=ButtonClick
		CaptionAlign=TXTA_Left
        FontScale=FNS_Large
        CaptionEffectStyleName="TextButtonEffect"
        StyleName="TextButton"
        Hint="Help and Game Management utilities"
        TabOrder=4
        bFocusOnWatch=True
        bUseCaptionHeight=true
    End Object
    b_Help=GUIButton'HelpButton'

    Begin Object Class=GUIButton Name=HostButton
        Caption="Host Game"
		//bAutoSize=True
        bAutoShrink=False
		OnClick=ButtonClick
		CaptionAlign=TXTA_Left
        FontScale=FNS_Large
        CaptionEffectStyleName="TextButtonEffect"
        StyleName="TextButton"
        Hint="Host Your Own Server"
        TabOrder=5
        bFocusOnWatch=True
        bUseCaptionHeight=true
    End Object
    b_Host=GUIButton'HostButton'

	Begin Object Class=GUIButton name=QuitButton
		Caption="Exit"
		//bAutoSize=True
        bAutoShrink=False
	    OnClick=ButtonClick
		CaptionAlign=TXTA_Left
        FontScale=FNS_Large
        CaptionEffectStyleName="TextButtonEffect"
        StyleName="TextButton"
        Hint="Exit the game"
        TabOrder=6
        bFocusOnWatch=True
        bUseCaptionHeight=true
	End Object
	b_Quit=GUIButton'QuitButton'

	Begin Object Class=GUIButton name=CreditsButton
		Caption="Credits"
		//bAutoSize=True
        bAutoShrink=False
		OnClick=ButtonClick
		CaptionAlign=TXTA_Left
        FontScale=FNS_Large
        CaptionEffectStyleName="TextButtonEffect"
        StyleName="TextButton"
        Hint="View the Credits"
        TabOrder=11
        bFocusOnWatch=True
        bUseCaptionHeight=true
	End Object
	b_Credits=GUIButton'CreditsButton'

	Begin Object Class=GUIButton name=ManualButton
		Caption="Manual"
		//bAutoSize=True
        bAutoShrink=False
		OnClick=ButtonClick
		CaptionAlign=TXTA_Left
        FontScale=FNS_Large
        CaptionEffectStyleName="TextButtonEffect"
        StyleName="TextButton"
        Hint="Read the Manual"
        TabOrder=12
        bFocusOnWatch=True
        bUseCaptionHeight=true
	End Object
	b_Manual=GUIButton'ManualButton'

	Begin Object Class=GUIButton name=WebsiteButton
		Caption="Visit Website"
		//bAutoSize=True
        bAutoShrink=False
		OnClick=ButtonClick
		CaptionAlign=TXTA_Left
        FontScale=FNS_Large
        CaptionEffectStyleName="TextButtonEffect"
        StyleName="TextButton"
        Hint="Visit the official Red Orchestra website"
        TabOrder=12
        bFocusOnWatch=True
        bUseCaptionHeight=true
	End Object
	b_Website=GUIButton'WebsiteButton'

	Begin Object Class=GUIButton name=DemosButton
		Caption="Demo Management"
		//bAutoSize=True
        bAutoShrink=False
		OnClick=ButtonClick
		CaptionAlign=TXTA_Left
        FontScale=FNS_Large
        CaptionEffectStyleName="TextButtonEffect"
        StyleName="TextButton"
        Hint="Manage recorded demos"
        TabOrder=12
        bFocusOnWatch=True
        bUseCaptionHeight=true
	End Object
	b_Demos=GUIButton'DemosButton'

    Begin Object Class=GUIButton name=BackButton
		Caption="Back"
		//bAutoSize=True
        bAutoShrink=False
		OnClick=ButtonClick
		CaptionAlign=TXTA_Left
        FontScale=FNS_Large
        CaptionEffectStyleName="TextButtonEffect"
        StyleName="TextButton"
        Hint="Return to Main Menu"
        TabOrder=12
        bFocusOnWatch=True
        bUseCaptionHeight=true
	End Object
	b_Back=GUIButton'BackButton'

    /*
    Begin Object Class=GUISectionBackground Name=ButtonGroup
         bFillClient=True
         Caption=""
         WinTop=0.8
         WinLeft=0.05
         WinWidth=0.9
         WinHeight=0.176
         OnPreDraw=PreviewGroup.InternalPreDraw
         bNoCaption=true
    End Object
    sb_Buttons=GUISectionBackground'ButtonGroup'
    */

    MenuSong="RO_Eastern_Front"
    OnOpen=InternalOnOpen

	BackgroundColor=(B=0,G=255,R=0,A=255)
    InactiveFadeColor=(B=0,G=0,R=255,A=255)
    //"./Manuals/manual.pdf"//
    ManualURL="http://www.redorchestragame.com/downloads/manuals/Game_Manual.pdf"
    WebsiteURL="http://www.redorchestragame.com/"

    SteamMustBeRunningText="Steam must be running and you must have an active internet connection to play multiplayer"
	SinglePlayerDisabledText="Practice mode is only available in the full version."
//     MenuSong="KR-UT2004-Menu"

    //bRenderWorld=true
    //MenuLevelName="MainMenu.rom"

    AcceptedEULA=false
}
