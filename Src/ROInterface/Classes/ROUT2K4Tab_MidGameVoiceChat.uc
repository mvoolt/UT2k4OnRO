//-----------------------------------------------------------
//
//-----------------------------------------------------------
class ROUT2K4Tab_MidGameVoiceChat extends UT2K4Tab_MidGameVoiceChat;

var()	Texture				mytexture;

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
	Super.InitComponent(MyController, MyOwner);

    class'ROInterfaceUtil'.static.SetROStyle(MyController, Controls);

    /*myStyleName = "ROItemOutline";
    lb_Players.List.OutLineStyleName = myStyleName;
    lb_Players.List.OutLineStyle = MyController.GetStyle(myStyleName,lb_Players.List.FontScale);
    myStyleName = "ROListSelection";
    lb_Players.List.SelectedStyleName = myStyleName;
    lb_Players.List.SelectedStyle = MyController.GetStyle(myStyleName,lb_Players.List.FontScale);

    myStyleName = "ROItemOutline";
    lb_Specs.List.OutLineStyleName = myStyleName;
    lb_Specs.List.OutLineStyle = MyController.GetStyle(myStyleName,lb_Specs.List.FontScale);
    myStyleName = "ROListSelection";
    lb_Specs.List.SelectedStyleName = myStyleName;
    lb_Specs.List.SelectedStyle = MyController.GetStyle(myStyleName,lb_Specs.List.FontScale);
    */
}

function ShowPanel( bool bShow )
{
	Super.ShowPanel(bShow);

	if (bShow)
	{
        OnPredraw = PreDraw;
	}
}

function bool PreDraw(Canvas Canvas)
{
	if ( GRI() != None )
	{
		bTeamGame = GRI().bTeamGame;
		FillPlayerLists();

    	OnPreDraw = none;
	}

	return false;
}

function ListChange( GUIComponent Sender )
{
	local int ID;
	local GUIList List;

	List = GUIListBox(Sender).List;
	if ( List == None )
		return;

	ClearIndexes( List );

	// grab the associated PlayerID from the selected player
	id = int(List.GetExtra());
	if ( PlayerIDIsMine(id) || List.IsSection())
	{
		SelectedSelf();
		return;
	}
	SelectIndex = FindChatListIndex(id);
	LoadRestrictions(SelectIndex);
}

function PopulateLists(GameReplicationInfo GRI)
{
	li_Players.Clear();
    super.PopulateLists(GRI);
}

DefaultProperties
{
	Begin Object Class=GUISectionBackground Name=PlayersBackground
        Caption="Players"
        LeftPadding=0.00000
        RightPadding=0.00000
        TopPadding=0.00000
        BottomPadding=0.00000
		WinWidth=0.462019
		WinHeight=0.899506
		WinLeft=0.019250
		WinTop=0.030325
        bBoundToParent=True
        bScaleToParent=True
	End Object
	sb_Players=PlayersBackground

	Begin Object Class=GUISectionBackground Name=SpecBackground
		Caption="Spectators"
        LeftPadding=0.00000
        RightPadding=0.00000
        TopPadding=0.00000
        BottomPadding=0.00000
		WinWidth=0.462019
		WinHeight=0.468385
		WinLeft=0.512544
		WinTop=0.030325
        bBoundToParent=True
        bScaleToParent=True
	End Object
	sb_Specs=SpecBackground

	Begin Object Class=GUISectionBackground Name=OptionBackground
		Caption="Voice Options"
		WinWidth=0.462019
		WinHeight=0.421768
		WinLeft=0.512544
		WinTop=0.508063
		TopPadding=0.04
		BottomPadding=0.0
        bBoundToParent=True
        bScaleToParent=True
	End Object
	sb_Options=OptionBackground

	Begin Object Class=GUIListBox Name=PlayersList
		WinWidth=0.429133
		WinHeight=0.801164
		WinLeft=0.035693
		WinTop=0.106813
		OnChange=ListChange
		bInitializeList=False
		TabOrder=0
		StyleName="NoBackground"
	End Object
	lb_Players=PlayersList

     RedTeamDesc="AXIS TEAM"
     BlueTeamDesc="ALLIES TEAM"

     mytexture=Texture'InterfaceArt_tex.Menu.button_normal'
}
