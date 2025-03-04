//-----------------------------------------------------------
// Modified by emh, 11/24/2005
//-----------------------------------------------------------
class ROUT2K4GamePageSP extends UT2K4GamePageSP;

const GAME_DIFFICULTY_INDEX = 3;

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
    local int i;
    local ROUT2K4Tab_MainSP tab;
    local ROIAMultiColumnRulesPanel tab2;

    Super(UT2K4MainPage).Initcomponent(MyController, MyOwner);

    class'ROInterfaceUtil'.static.SetROStyle(MyController, Controls);

    RuleInfo = new(None) class'Engine.PlayInfo';

    i = 1; // there is no number 0 Tab
    p_Main        = UT2K4Tab_MainBase(c_Tabs.AddTab(PanelCaption[i],PanelClass[i],,PanelHint[i++]) );
	mcRules       = IAMultiColumnRulesPanel(c_Tabs.AddTab(PanelCaption[i], PanelClass[i],, PanelHint[i++]));
    p_Mutators    = UT2K4Tab_MutatorBase(c_Tabs.AddTab(PanelCaption[i],PanelClass[i],,PanelHint[i++]));

    // Set delegate
    tab = ROUT2K4Tab_MainSP(p_Main);
    if (tab != none)
        tab.OnChangeDifficulty = InternalOnChangeDifficulty;
    tab2 = ROIAMultiColumnRulesPanel(mcRules);
    if (tab2 != none)
        tab2.OnDifficultyChanged = InternalOnDifficultyChanged;

	b_Back = ROUT2K4GameFooterSP(t_Footer).b_Back;
	b_Primary = ROUT2K4GameFooterSP(t_Footer).b_Primary;

	/*
    for ( i = 0; i < c_Tabs.TabStack.Length; i++ )
	{
		if ( c_Tabs.TabStack[i] != None )
		{
			c_Tabs.TabStack[i].FontScale=FNS_Medium;
			c_Tabs.TabStack[i].bAutoSize=True;
			c_Tabs.TabStack[i].bAutoShrink=False;
        }
	}
    */
}


function PrepareToPlay(out string GameURL, optional string OverrideMap)
{
	local int i;
	local byte Value;

	Super.PrepareToPlay(GameURL, OverrideMap);

	i = RuleInfo.FindIndex("BotMode");
	//i=0;

	if ( i != -1 )
	{
		Value = byte(RuleInfo.Settings[i].Value) & 3;
	    // Use Map Defaults
		if ( Value == 1 )
			GameURL $= "?bAutoNumBots=True";

		// Use Bot Roster
		else if ( Value == 2 )
			GameURL $= p_BotConfig.Play();

		// Specify Number
		else
		{
			i = RuleInfo.FindIndex("MinPlayers");
			if ( i >= 0 )
				GameURL $= "?bAutoNumBots=False?NumBots="$RuleInfo.Settings[i].Value;
		}
	}
	log("Prepare to play GameURL= "$GameURL);
}

function InternalOnChangeDifficulty(int index)
{
    local ROIAMultiColumnRulesPanel tab;
    local int i;
    local moComboBox    combo;

    tab = ROIAMultiColumnRulesPanel(mcRules);
    if (tab != none)
    {
        //tab.Refresh();
        i = tab.FindComponentWithTag(GAME_DIFFICULTY_INDEX); // hax: game difficulty control is control #3
        if (i == -1)
            return;
        //log("element caption = " $ tab.li_Rules.Elements[i].Caption);
        combo = moComboBox(tab.li_Rules.Elements[i]);
        if (combo == none)
            return;
        combo.SetIndex(index);
        //log("tab refreshed.");
    }
}

function InternalOnDifficultyChanged(int index, int tag)
{
    local ROUT2K4Tab_MainSP gametab;

    if (tag != GAME_DIFFICULTY_INDEX)
        return;

    gametab = ROUT2K4Tab_MainSP(p_Main);
    if (gametab != none)
    {
        gametab.SilentSetDifficulty(index);
        log("difficulty changed.");
    }
}


DefaultProperties
{
     PageCaption="Single Player"

     /*Begin Object Class=GUIHeader Name=GamePageHeader
         RenderWeight=0.300000
         WinHeight=0.1000000
     End Object
     t_Header=GUIHeader'ROInterface.ROUT2K4GamePageSP.GamePageHeader'*/

     Begin Object Class=GUIImage Name=BkChar
         Image=Texture'MenuBackground.MainBackGround'
         ImageStyle=ISTY_Scaled
         X1=0
         Y1=0
         X2=1024
         Y2=1024
         WinHeight=1.000000
         RenderWeight=0.020000
     End Object
     i_bkChar=GUIImage'ROInterface.ROUT2K4GamePageSP.BkChar'

     /*Begin Object Class=GUITabControl Name=PageTabs
         OnChange=UT2k4MainPage.InternalOnChange
        TabOrder=3
		WinWidth=0.95
		WinLeft=0.025
		WinTop=0.067
		WinHeight=0.1
		TabHeight=0.06
		bAcceptsInput=true
		bDockPanels=true
     End Object
     c_Tabs=GUITabControl'ROInterface.ROUT2K4GamePageSP.PageTabs'*/

    Begin Object Class=ROUT2K4GameFooterSP Name=SPFooter
         PrimaryCaption="START PRACTICE MODE"
         PrimaryHint="Start A Match With These Settings"
         Justification=TXTA_Center
         TextIndent=5
         FontScale=FNS_Small
         WinTop=0.957943
         WinHeight=0.042057
         RenderWeight=0.300000
         TabOrder=8
         OnPreDraw=SPFooter.InternalOnPreDraw
         bBoundToParent=true
         Spacer=0.01
     End Object
     t_Footer=ROUT2K4GameFooterSP'ROInterface.ROUT2K4GamePageSP.SPFooter'

   PanelClass(0)=none
   PanelClass(1)="ROInterface.ROUT2K4Tab_MainSP"
   PanelClass(2)="ROInterface.ROIAMultiColumnRulesPanel"
   PanelClass(3)="ROInterface.ROUT2K4Tab_MutatorSP"
   PanelClass(4)=none


   PanelCaption(0)=none
   PanelCaption(1)="Select Map"
   PanelCaption(2)="Game Rules"
   PanelCaption(3)="Mutators"
   PanelCaption(4)="Bot Config"

   PanelHint(0)=none
   PanelHint(1)="Preview the maps for the currently selected gametype..."
   PanelHint(2)="Configure the game rules..."
   PanelHint(3)="Select and configure any mutators to use..."
   PanelHint(4)="Configure any bots that will be in the session..."
   OnOpen=UT2K4GamePageBase.InternalOnOpen
}
