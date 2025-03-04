//-----------------------------------------------------------
//
//-----------------------------------------------------------
class ROUT2K4PlayerSetupPage extends ROUT2K4GUIPage;

const NUM_ROLES = 10;

var	automated	GUIImage				BackgroundImage;
var	automated	GUITitleBar				TitleBar;
var automated GUIHeader         t_Header;
var automated GUITabControl     playerTabs;
//var automated  GUISectionBackground i_playerBG;
var ROUT2K4TabPanel_UnitSelection unitTab;
var ROUT2K4TabPanel_RoleSelection roleTab;
//var ROUT2K4TabPanel_WeaponSelection weaponTab;
//once the player selects their role this will be set
// this is used to select the correct role to populate the weapons page.
var int selectedRoleInfoIndex;
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
    local int i;
    local ROPlayer player;
    local ROPlayerReplicationInfo playerRep;

    Super.Initcomponent(MyController, MyOwner);

    class'ROInterfaceUtil'.static.SetROStyle(MyController, Controls);

	TitleBar.DockedTabs = playerTabs;
//    t_Header.DockedTabs = playerTabs;
//    t_Header.SetCaption("Player Setup");

    selectedRoleInfoIndex = -1;
    //log("ROUT2K4PlayerSetupPage::InitComponent");
    unitTab =  ROUT2K4TabPanel_UnitSelection(
    playerTabs.addTab("Unit","ROInterface.ROUT2K4TabPanel_UnitSelection"));
    unitTab.OnSelect = onUnitSelected;

    roleTab=ROUT2K4TabPanel_RoleSelection(
    playerTabs.addTab("Role","ROInterface.ROUT2K4TabPanel_RoleSelection"));
    roleTab.OnSelect = onRoleSelected;

//    weaponTab=ROUT2K4TabPanel_WeaponSelection(
//    playerTabs.addTab("Weapon","ROInterface.ROUT2K4TabPanel_WeaponSelection"));
//    weaponTab.OnSelect = onWeaponSelected;
//    weaponTab.DisableMe();
//    DisableComponent(weaponTab);

    player = ROPlayer(PlayerOwner());
    playerRep = ROPlayerReplicationInfo(player.PlayerReplicationInfo);

    roleTab.DisableMe();
    if(playerRep != none &&
       playerRep.RoleInfo != none)
    {
       selectedRoleInfoIndex = findRoleIndexByAltName(playerRep.RoleInfo.AltName);
       if(selectedRoleInfoIndex != -1)
       {
           onRoleSelected(selectedRoleInfoIndex);
           roleTab.EnableMe();
           playerTabs.ActivateTabByPanel(roleTab,true);
       }
    }
    else
       roleTab.DisableMe();

	// Change the Style of the Tabs; DRR 05-11-2004
    /*myStyleName = "ROTabButton";
//    playerTabs.bFillSpace = True;
*/
    playerTabs.bFillSpace = False;
	for ( i = 0; i < playerTabs.TabStack.Length; i++ )
	{
		if ( playerTabs.TabStack[i] != None )
		{
			playerTabs.TabStack[i].FontScale=FNS_Medium;
			playerTabs.TabStack[i].bAutoSize=True;
			playerTabs.TabStack[i].bAutoSize=False;
			playerTabs.TabStack[i].bAutoShrink=False;
            //playerTabs.TabStack[i].StyleName = myStyleName;
            //playerTabs.TabStack[i].Style = MyController.GetStyle(myStyleName,playerTabs.TabStack[i].FontScale);
        }
	}
    SetTimer(0.1, true);
}
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
function bool validTeam()
{
   if(PlayerOwner().PlayerReplicationInfo == none ||
       PlayerOwner().PlayerReplicationInfo.Team == none ||
       PlayerOwner().PlayerReplicationInfo.Team.TeamIndex > 1)
   return false;

   return true;
}
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
function InternalOnChange(GUIComponent Sender)
{
	if (playerTabs.ActiveTab != None && playerTabs.ActiveTab.MyPanel != None)
		playerTabs.ActiveTab.MyPanel.Refresh();
   //log("ROUT2K4PlayerSetupPage::InternalOnChange, sender="$Sender);
}
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------

/*
function Timer()
{
	if (ROPlayer(PlayerOwner()) != None &&
        !ROPlayer(PlayerOwner()).HasSelectedTeam())
        {
        		roleTab.DisableMe();
//                weaponTab.DisableMe();
        }
}
*/
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
function bool InternalOnCanClose(optional bool bCanceled)
{
	return true;
}
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
function onUnitSelected(int teamIndex)
{
   roleTab.EnableMe();
   roleTab.lastTeamIndex = teamIndex;
   playerTabs.ActivateTabByPanel(roleTab,true);
//   weaponTab.DisableMe();

}
//------------------------------------------------------------------------------
function onRoleSelected(int roleIndex)
{
  //enable weapon selection tab and focus weapon selection
  //log("OnRoleSelected("$roleIndex$")");
  selectedRoleInfoIndex = roleIndex;
  if(selectedRoleInfoIndex == -1)
      return;

//  weaponTab.EnableMe();

//  weaponTab.setRoleByIndex(roleIndex);


//  playerTabs.ActivateTabByPanel(weaponTab,true);

	// New players must be ready code
    //ROPlayer(PlayerOwner()).PlayerReplicationInfo.bReadyToPlay = true;

    //log("My player is ready = "$ROPlayer(PlayerOwner()).PlayerReplicationInfo.bReadyToPlay);

  	controller.CloseMenu();
}
//------------------------------------------------------------------------------
// weapon selection should complete the player setup
//------------------------------------------------------------------------------
/*
function onWeaponSelected()
{
    controller.CloseMenu();
}
*/
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
function int findRoleIndexByAltName(string altName)
{
   local int  count, whichTeamIndex;
   local  ROGameReplicationInfo GRI;

   GRI = ROGameReplicationInfo(PlayerOwner().GameReplicationInfo);

   if(GRI == none)
      return -1;

   if(!validTeam())
      return -1;

   whichTeamIndex = PlayerOwner().PlayerReplicationInfo.Team.TeamIndex;

   for(count = 0 ; count < NUM_ROLES ; count++)
   {
        switch(whichTeamIndex)
        {
           case AXIS_TEAM_INDEX :
           if(GRI.AxisRoles[count] != none &&
              GRI.AxisRoles[count].AltName == altName)
           {
              //log("findRoleIndexByAltName("$altName$") index = "$count);
              return count;
           }
           break;
           case ALLIES_TEAM_INDEX :
           if(GRI.AlliesRoles[count] != none &&
              GRI.AlliesRoles[count].AltName == altName)
           {
              return count;
           }
           break;
        }
   }
   //not found
   return -1;
}

//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
DefaultProperties
{
	Begin Object Class=GUIImage name=MyBackground
		bAcceptsInput=false
		bNeverFocus=true
		Image=Texture'InterfaceArt_tex.Menu.button_normal'
		ImageStyle=ISTY_Stretched
		WinWidth=1.0
		WinHeight=1.0
		WinTop=0.0
		WinLeft=0.0
		bBoundToParent=true
		bScaleToParent=true
		RenderWeight=0.0001
	End Object
	BackgroundImage=MyBackground

	Begin Object class=GUITitleBar name=psTitleBar
		Caption="Player Setup"
		StyleName="TitleBar"
		bUseTextHeight=false
		WinWidth=0.800000
		WinHeight=0.056055
//		WinLeft=0.100000
//		WinTop=0.100000
		WinLeft=0.050000
		WinTop=0.050000
		RenderWeight=0.3
	End Object
	TitleBar=psTitleBar

/*
   Begin Object Class=GUIHeader Name=GamePageHeader
         RenderWeight=0.300000
         WinHeight=0.075000
		 WinWidth=0.8
		 WinLeft=0.1
		 WinTop=0.02
         Caption="Player Setup"
         StyleName="ROHeader"
   End Object
   t_Header=ROInterface.ROUT2K4PlayerSetupPage.GamePageHeader
*/

//   WinTop=0.10000
//   WinLeft=0.10000
//   WinWidth=0.80000
//   WinHeight=0.80000
   WinTop=0.025000
   WinLeft=0.025000
   WinWidth=0.950000
   WinHeight=0.950000

   Begin Object Class=GUITabControl Name=PageTabs
         bDockPanels=True
         TabHeight=0.060000
//         WinTop=0.10000
         WinTop=0.050000
         WinLeft=0.05000
         WinWidth=0.92000
         WinHeight=0.10000
         RenderWeight=0.490000
         TabOrder=3
         bAcceptsInput=True
         //OnActivate=PageTabs.InternalOnActivate
         //OnChange=ROUT2K4PlayerSetupPage.InternalOnChange
     End Object
     playerTabs=ROInterface.ROUT2K4PlayerSetupPage.PageTabs


     //bRequire640x480=false
	 bAllowedAsLast=true
	 bVisible=True
	 bRenderWorld=True  // must be true or precaching statics and textures doesn't work right
	 OnCanClose=InternalOnCanClose
}
