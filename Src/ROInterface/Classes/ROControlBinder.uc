//-----------------------------------------------------------
//=============================================================================
// ROTab_ControlSettings
//=============================================================================
// Used for keybinding the RO functions
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2003 by John Gibson
//
//
//=========================================================
// Modify Listings
//
// 1.) new button binding added by Antarian 3/2/03 for "Bayonet Attach / MG Deploy"
// 2.) new button binding added by Antarin 8/30/03 for "Switch Fire Mode"
// 3.) Moved to ROControlBinder and updated for UT2004 Puma 5-15-2004
// 4.) new button binding added by Antarian 5/17/04 for "MG Ammo Resupply"
// 5.) new button binding added by Antarian 5/17/04 for "Save Artillery Coords"
//=============================================================================
//-----------------------------------------------------------
class ROControlBinder extends ControlBinder;

var()	Texture				mytexture;

function InitComponent( GUIController InController, GUIComponent InOwner )
{
    Super.InitComponent(InController, InOwner);

    class'ROInterfaceUtil'.static.SetROStyle(InController, Controls);

    sb_Main.HeaderTop=mytexture;
    sb_Main.HeaderBar=mytexture;
    sb_Main.HeaderBase=mytexture;

    /*myStyleName = "ROTitleBar";
    t_WindowTitle.StyleName = myStyleName;
    t_WindowTitle.Style = InController.GetStyle(myStyleName,t_WindowTitle.FontScale);

    myStyleName = "ROListSelection";
    SectionStyleName = myStyleName;
    SectionStyle = InController.GetStyle(myStyleName,li_Binds.FontScale);*/
}

function bool SystemMenuPreDraw(canvas Canvas)
{
    b_ExitButton.SetPosition( t_WindowTitle.ActualLeft() + (t_WindowTitle.ActualWidth()-35), t_WindowTitle.ActualTop()+10, 24, 24, true);
	return true;
}

DefaultProperties
{

     Begin Object Class=FloatingImage Name=FloatingFrameBackground
         Image=Texture'InterfaceArt_tex.Menu.button_normal'
         DropShadow=None
         ImageStyle=ISTY_Stretched
         ImageRenderStyle=MSTY_Normal
         WinTop=0.020000
         WinLeft=0.000000
         WinWidth=1.000000
         WinHeight=0.980000
         RenderWeight=0.000003
     End Object
     i_FrameBG=FloatingImage'ROInterface.ROControlBinder.FloatingFrameBackground'

     Begin Object Class=GUIImage Name=BindBk
//         Image=Texture'RO2Menu_old.buttonGreyLight01'
         Image=Texture'InterfaceArt_tex.Menu.button_normal'
         ImageStyle=ISTY_Stretched
         WinTop=0.057552
         WinLeft=0.031397
         WinWidth=0.937207
         WinHeight=0.808281
         bBoundToParent=True
         bScaleToParent=True
     End Object
     i_bk=GUIImage'ROInterface.ROControlBinder.BindBk'

     // RedOrchestra Bindings
	Bindings(0)=(bIsSectionLabel=true,KeyLabel="Red Orchestra",Alias="")
	Bindings(1)=(bIsSectionLabel=false,KeyLabel="Sprint",Alias="Button bSprint")
	Bindings(2)=(bIsSectionLabel=false,KeyLabel="Reload",Alias="ROManualReload")
	Bindings(3)=(bIsSectionLabel=false,KeyLabel="Iron Sights",Alias="ROIronSights")
	Bindings(4)=(bIsSectionLabel=false,KeyLabel="Change Role",Alias="PlayerMenu 2")
	Bindings(5)=(bIsSectionLabel=false,KeyLabel="Show / Hide Hud",Alias="ShowPlayInfo")
	Bindings(6)=(bIsSectionLabel=false,KeyLabel="Prone",Alias="Prone")
	Bindings(7)=(bIsSectionLabel=false,KeyLabel="Bayonet Attach / MG Deploy",Alias="Deploy")// Antarian 3/2/03
	Bindings(8)=(bIsSectionLabel=false,KeyLabel="Change MG Barrel",Alias="ROMGOperation")
	Bindings(9)=(bIsSectionLabel=false,KeyLabel="Show Objectives",Alias="ShowObjectives")
	Bindings(10)=(bIsSectionLabel=false,KeyLabel="Change Scope Detail",Alias="SetScopeDetail")
	Bindings(11)=(bIsSectionLabel=false,KeyLabel="Change Side",Alias="PlayerMenu")
	Bindings(12)=(bIsSectionLabel=false,KeyLabel="Use",Alias="Use")
	Bindings(13)=(bIsSectionLabel=false,KeyLabel="Switch Fire Mode",Alias="SwitchFireMode")// Antarian 8/30/03
	Bindings(14)=(bIsSectionLabel=false,KeyLabel="Change Weapons",Alias="PlayerMenu 3")
	Bindings(15)=(bIsSectionLabel=false,KeyLabel="MG Ammo Resupply",Alias="ThrowMGAmmo")	// Antarian 5/17/04
	Bindings(16)=(bIsSectionLabel=false,KeyLabel="Save Artillery Coordinates",Alias="SaveArtilleryPosition")	// Rammj 6/22/04

     Bindings(17)=(bIsSectionLabel=True,KeyLabel="Movement")
     Bindings(18)=(bIsSectionLabel=false,KeyLabel="Forward",Alias="MoveForward")
     Bindings(19)=(bIsSectionLabel=false,KeyLabel="Backward",Alias="MoveBackward")
     Bindings(20)=(bIsSectionLabel=false,KeyLabel="Strafe Left",Alias="StrafeLeft")
     Bindings(21)=(bIsSectionLabel=false,KeyLabel="Strafe Right",Alias="StrafeRight")
     Bindings(22)=(bIsSectionLabel=false,KeyLabel="Jump",Alias="Jump")
     Bindings(23)=(bIsSectionLabel=false,KeyLabel="Walk",Alias="Walking")
     Bindings(24)=(bIsSectionLabel=false,KeyLabel="ToggleCrouch",Alias="ToggleDuck")
     Bindings(25)=(bIsSectionLabel=false,KeyLabel="Crouch",Alias="Duck")
     Bindings(26)=(bIsSectionLabel=false,KeyLabel="Strafe Toggle",Alias="Strafe")
     Bindings(27)=(bIsSectionLabel=false,KeyLabel="Lean Left",Alias="LeanLeft")
     Bindings(28)=(bIsSectionLabel=false,KeyLabel="Lean Right",Alias="LeanRight")

     Bindings(29)=(bIsSectionLabel=True,KeyLabel="Looking")
     Bindings(30)=(bIsSectionLabel=false,KeyLabel="Turn Left",Alias="TurnLeft")
     Bindings(31)=(bIsSectionLabel=false,KeyLabel="Turn Right",Alias="TurnRight")
     Bindings(32)=(bIsSectionLabel=false,KeyLabel="Look Up",Alias="LookUp")
     Bindings(33)=(bIsSectionLabel=false,KeyLabel="Look Down",Alias="LookDown")
     Bindings(34)=(bIsSectionLabel=false,KeyLabel="Center View",Alias="CenterView")
     Bindings(35)=(bIsSectionLabel=false,KeyLabel="Toggle BehindView",Alias="ToggleBehindView")
     Bindings(36)=(bIsSectionLabel=false,KeyLabel="Toggle Camera Mode",Alias="ToggleFreeCam")

     Bindings(37)=(bIsSectionLabel=True,KeyLabel="Weapons")
     Bindings(38)=(bIsSectionLabel=false,KeyLabel="Fire",Alias="Fire")
     Bindings(39)=(bIsSectionLabel=false,KeyLabel="Alt-Fire",Alias="AltFire")
     Bindings(40)=(bIsSectionLabel=false,KeyLabel="Throw Weapon",Alias="ThrowWeapon")
     Bindings(41)=(bIsSectionLabel=false,KeyLabel="Best Weapon",Alias="SwitchToBestWeapon")
     Bindings(42)=(bIsSectionLabel=false,KeyLabel="Next Weapon",Alias="NextWeapon")
     Bindings(43)=(bIsSectionLabel=false,KeyLabel="Prev Weapon",Alias="PrevWeapon")
     Bindings(44)=(bIsSectionLabel=false,KeyLabel="Last Weapon",Alias="SwitchToLastWeapon")

     Bindings(45)=(bIsSectionLabel=True,KeyLabel="Communication")
     Bindings(46)=(bIsSectionLabel=false,KeyLabel="Say",Alias="Talk")
     Bindings(47)=(bIsSectionLabel=false,KeyLabel="Team Say",Alias="TeamTalk")
     Bindings(48)=(bIsSectionLabel=false,KeyLabel="In Game Chat",Alias="InGameChat")
     Bindings(49)=(bIsSectionLabel=false,KeyLabel="Speech Menu",Alias="SpeechMenuToggle")
     Bindings(50)=(bIsSectionLabel=false,KeyLabel="Activate Microphone",Alias="VoiceTalk")
     Bindings(51)=(bIsSectionLabel=false,KeyLabel="Speak in Public Channel",Alias="Speak Public")
     Bindings(52)=(bIsSectionLabel=false,KeyLabel="Speak in local Channel",Alias="Speak Local")
     Bindings(53)=(bIsSectionLabel=false,KeyLabel="Speak in Team Channel",Alias="Speak Team")
     Bindings(54)=(bIsSectionLabel=false,KeyLabel="Toggle Public Chatroom",Alias="TogglePublicChat")
     Bindings(55)=(bIsSectionLabel=false,KeyLabel="Toggle local Chatroom",Alias="ToggleLocalChat")
     Bindings(56)=(bIsSectionLabel=false,KeyLabel="Toggle Team Chatroom",Alias="ToggleTeamChat")

     Bindings(57)=(bIsSectionLabel=True,KeyLabel="Hud")
     Bindings(58)=(bIsSectionLabel=false,KeyLabel="Grow Hud",Alias="GrowHud")
     Bindings(59)=(bIsSectionLabel=false,KeyLabel="Shrink Hud",Alias="ShrinkHud")
     Bindings(60)=(bIsSectionLabel=false,KeyLabel="ScoreBoard",Alias="ShowScores")
     Bindings(61)=(bIsSectionLabel=false,KeyLabel="ScoreBoard (QuickView)",Alias="ScoreToggle")

     Bindings(62)=(bIsSectionLabel=True,KeyLabel="Game")
     Bindings(63)=(bIsSectionLabel=false,KeyLabel="Use",Alias="use")
     Bindings(64)=(bIsSectionLabel=false,KeyLabel="Pause",Alias="Pause")
     Bindings(65)=(bIsSectionLabel=false,KeyLabel="Screenshot",Alias="shot")
     Bindings(66)=(bIsSectionLabel=false,KeyLabel="Next Inventory Item",Alias="InventoryNext")
     Bindings(67)=(bIsSectionLabel=false,KeyLabel="Previous Inventory Item",Alias="InventoryPrevious")
     Bindings(68)=(bIsSectionLabel=false,KeyLabel="Activate Current Inventory Item",Alias="InventoryActivate")
     Bindings(69)=(bIsSectionLabel=false,KeyLabel="Show Personal Stats",Alias="ShowStats")
     Bindings(70)=(bIsSectionLabel=false,KeyLabel="View Next Player's Stats",Alias="NextStats")
     Bindings(71)=(bIsSectionLabel=false,KeyLabel="Server Info",Alias="ServerInfo")

     Bindings(72)=(bIsSectionLabel=True,KeyLabel="Miscellaneous")
     Bindings(73)=(bIsSectionLabel=false,KeyLabel="Menu",Alias="ShowMenu")
     Bindings(74)=(bIsSectionLabel=false,KeyLabel="Music Player",Alias="MusicMenu")
     Bindings(75)=(bIsSectionLabel=false,KeyLabel="Voting Menu",Alias="ShowVoteMenu")
     Bindings(76)=(bIsSectionLabel=false,KeyLabel="Toggle Console",Alias="ConsoleToggle")
     Bindings(77)=(bIsSectionLabel=false,KeyLabel="View Connection Status",Alias="Stat Net")
     Bindings(78)=(bIsSectionLabel=false,KeyLabel="Cancel Pending Connection",Alias="Cancel")

     Bindings(79)=(bIsSectionLabel=True,KeyLabel="Vehicle Communication")
     Bindings(80)=(bIsSectionLabel=false,KeyLabel="Vehicle Say",Alias="VehicleTalk")
     //Bindings(81)=(bIsSectionLabel=false,KeyLabel="",Alias="")
     //Bindings(80)=(bIsSectionLabel=false,KeyLabel="",Alias="")

	BindingLabel(0)="Red Orchestra"
	BindingLabel(1)="Sprint"
	BindingLabel(2)="Reload"
	BindingLabel(3)="Iron Sights"
	BindingLabel(4)="Change Role"
	BindingLabel(5)="Show / Hide Hud"
	BindingLabel(6)="Prone"
	BindingLabel(7)="Bayonet Attach / MG Deploy"  // Antarian 3/2/03
	BindingLabel(8)="Change MG Barrel"
	BindingLabel(9)="Show Objectives"
	BindingLabel(10)="Change Scope Detail"
	BindingLabel(11)="Change Side"
	BindingLabel(12)="Use"
	BindingLabel(13)="Switch Fire Mode"
	BindingLabel(14)="ChangeWeapons"
	BindingLabel(15)="MG Ammo Resupply" 			// Antarian 5/17/04
	BindingLabel(16)="Save Artillery Coordinates" 			// Antarian 5/17/04

     BindingLabel(17)="Movement"
     BindingLabel(18)="Forward"
     BindingLabel(19)="Backward"
     BindingLabel(20)="Strafe Left"
     BindingLabel(21)="Strafe Right"
     BindingLabel(22)="Jump"
     BindingLabel(23)="Walk"
     BindingLabel(24)="ToggleCrouch"
     BindingLabel(25)="Crouch"
     BindingLabel(26)="Strafe Toggle"
     BindingLabel(27)="Lean Left"
     BindingLabel(28)="Lean Right"

     BindingLabel(29)="Looking"
     BindingLabel(30)="Turn Left"
     BindingLabel(31)="Turn Right"
     BindingLabel(32)="Look Up"
     BindingLabel(33)="Look Down"
     BindingLabel(34)="Center View"
     BindingLabel(35)="Toggle "BehindView""
     BindingLabel(36)="Toggle Camera Mode"

     BindingLabel(37)="Weapons"
     BindingLabel(38)="Fire"
     BindingLabel(39)="Alt-Fire"
     BindingLabel(40)="Throw Weapon"
     BindingLabel(41)="Best Weapon"
     BindingLabel(42)="Next Weapon"
     BindingLabel(43)="Prev Weapon"
     BindingLabel(44)="Last Weapon"

     BindingLabel(45)="Communication"
     BindingLabel(46)="Say"
     BindingLabel(47)="Team Say"
     BindingLabel(48)="In Game Chat"
     BindingLabel(49)="Speech Menu"
     BindingLabel(50)="Activate Microphone"
     BindingLabel(51)="Speak in Public Channel"
     BindingLabel(52)="Speak in local Channel"
     BindingLabel(53)="Speak in Team Channel"
     BindingLabel(54)="Toggle Public Channel"
     BindingLabel(55)="Toggle local Channel"
     BindingLabel(56)="Toggle Team Channel"
     BindingLabel(57)="Hud"
     BindingLabel(58)="Grow Hud"
     BindingLabel(59)="Shrink Hud"
     BindingLabel(60)="ScoreBoard Toggle"
     BindingLabel(61)="ScoreBoard"
     BindingLabel(62)="Game"

     BindingLabel(63)="Use"
     BindingLabel(64)="Pause"
     BindingLabel(65)="Screenshot"
     BindingLabel(66)="Next Inventory Item"
     BindingLabel(67)="Previous Inventory Item"
     BindingLabel(68)="Activate Current Inventory Item"
     BindingLabel(69)="Show Personal Stats"
     BindingLabel(70)="View Next Player's Stats"
     BindingLabel(71)="Server Info"

     BindingLabel(72)="Miscellaneous"
     BindingLabel(73)="Menu"
     BindingLabel(74)="Music Player"
     BindingLabel(75)="Voting Menu"
     BindingLabel(76)="Toggle Console"
     BindingLabel(77)="View Connection Status"
     BindingLabel(78)="Cancel Pending Connection"

     BindingLabel(79)="Vehicle Communication"
     BindingLabel(80)="Vehicle Say"

     // cheap and sleazy work around to prevent superclass bindings from showing up
     //BindingLabel(79)=""
    // BindingLabel(79)=""
}
