//=============================================================================
// RODemosMenu
//=============================================================================
// The Demos management menu. Most of the code for this comes from the
// UT2K4Demos class.
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Mathieu Mallet
//=============================================================================

//class RODemosMenu extends LockedFloatingWindow;
class RODemosMenu extends LargeWindow;

var automated GUIListBox lb_DemoList,lb_DemoInfo;
var automated GUIScrollTextBox lb_ReqPacks;
var automated GUILabel lbl_Game, l_NoPreview;
var automated GUIImage i_MapShot;
var automated GUISectionBackground sb_1, sb_2, sb_3, sb_4;

var automated GUIButton b_Dump, b_Watch, b_Back;

var localized string ltScoreLimit, ltTimeLimit, UnknownText, CorruptDemText,ltSelectMsg;
var localized string ltClientSide, ltServerSide, ltRecordedBy,ltGoodMsg, ltBadMsg;
var array<CacheManager.MapRecord> Maps;
var array<CacheManager.GameRecord> Games;

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
	local array<string> Demos;
    local int i;

	Super.InitComponent(MyController,MyOwner);

	class'CacheManager'.static.GetMapList(Maps);
	class'CacheManager'.static.GetGameTypeList(Games);

    MyController.GetDEMList(Demos);
    for (i=0;i<Demos.Length;i++)
    	lb_DemoList.List.Add(TrimName(Demos[i]));

	bInit = False;
    if (lb_DemoList.ItemCount()>0)
	    DemoListClick(none);

	//MyPage.MyFooter.b_Watch.OnClick=WatchClick;
	//MyPage.MyFooter.b_Dump.OnClick=DumpClick;

	sb_1.ManageComponent(lb_DemoList);
	sb_2.Managecomponent(i_MapShot);
	sb_3.ManageComponent(lb_ReqPacks);
}

function string TrimName(string s)
{
	local int p;
	p = InStr(Caps(s),".DEMO4");
	if (p>=0)
		return Left(s,p);

	return s;
}

function bool DumpClick(GUIComponent Sender)
{
	Controller.OpenMenu("GUI2K4.UT2K4Demo2AVI",lb_DemoList.List.Get());
    return true;
}

function bool WatchClick(GUIComponent Sender)
{
	Console(Controller.Master.Console).DelayedConsoleCommand("demoplay"@lb_DemoList.List.Get());

	// Demoplay will frell up if we don't close menus.. Why is it commented out of the
	// engine source anyways?
    Controller.CloseAll(false, true);

    return true;
}

function bool OnCloseButtonClick(GUIComponent Sender)
{
    Controller.RemoveMenu(self);
    return true;
}


function DemoListClick(GUIComponent Sender)
{
	local string MapName, GameType, RecordedBy, TimeStamp,ReqPackages;
    local int	 i, ScoreLimit, TimeLimit, ClientSide;
    local Material Screenie;

	if ( bInit )
		return;

	lb_DemoInfo.List.Clear();
	if ( LB_DemoList.List.ItemCount<=0 )
	{
		lbl_Game.Caption = "";
		sb_2.Caption = "";
		lb_ReqPacks.SetContent("");
		i_MapShot.SetVisibility( false);
		l_NoPreview.SetVisibility( true );
		return;
	}

	if ( Controller.GetDEMHeader(lb_DemoList.List.Get( True )$".DEMO4",MapName,GameType,ScoreLimit,TimeLimit,ClientSide,RecordedBy,TimeStamp,ReqPackages) )
    {
    	lbl_Game.Caption=Caps(MapName);
    	i = GetGameIndex(GameType);

    	if ( i != -1 )
    		sb_2.Caption = Games[i].GameName;
		else sb_2.Caption = UnknownText;

		lb_DemoInfo.List.Add(ltScoreLimit@ScoreLimit@"  "@ltTimeLimit@TimeLimit);

        if (ClientSide!=0)
	        lb_DemoInfo.List.Add(ltClientSide);
    	else
	    	lb_DemoInfo.List.Add(ltServerSide);

       	lb_DemoInfo.List.Add(ltRecordedBy@RecordedBy);

        if (ReqPackages!="")
        	lb_ReqPacks.SetContent(ltBadMsg$"||"$ReqPackages);
        else
        	lb_ReqPacks.SetContent(ltGoodMsg);

		i = GetMapIndex(MapName);
		if ( i != -1 )
			Screenie = Material(DynamicLoadObject(Maps[i].ScreenshotRef, class'Material'));

    }
    else
    {
    	sb_2.Caption="";
        lbl_Game.Caption=UnknownText;
    	lb_DemoInfo.List.Clear();
    	lb_ReqPacks.SetContent(CorruptDemText);
    }

    i_MapShot.Image = Screenie;
	i_MapShot.SetVisibility( Screenie != None );
	l_NoPreview.SetVisibility( Screenie == None );

    lb_ReqPacks.Restart();
    lb_ReqPacks.Stop();

    return;
}

function SetVisibility( bool bIsVisible )
{
	Super.SetVisibility(bIsVisible);

	i_MapShot.SetVisibility( i_MapShot.Image != none );
	l_NoPreview.SetVisibility( i_MapShot.Image == None );
}

function int GetMapIndex( string MapName )
{
	local int i;

	for ( i = 0; i < Maps.Length; i++ )
		if ( Maps[i].MapName ~= MapName )
			return i;

	return -1;
}

function int GetGameIndex( string GameClass )
{
	local int i;

	for ( i = 0; i < Games.Length; i++ )
		if ( Games[i].ClassName ~= GameClass || GameClass ~= ("class " $ Games[i].ClassName ) )
			return i;

	return -1;
}

function InfoClick(GUIComponent Sender)
{
	lb_DemoInfo.List.Index=0;
}

defaultproperties
{
	Begin Object class=GUIImage Name=iMapShot
		WinWidth=1
		WinHeight=1
		WinLeft=0
		WinTop=0
        ImageColor=(R=255,G=255,B=255,A=255)
        ImageStyle=ISTY_Scaled
        ImageRenderStyle=MSTY_Normal
        RenderWeight=1
        DropShadowX=8
        DropShadowY=8
        bScaleToParent=True
        bBoundToParent=True
	End Object
	i_MapShot=iMapShot

    Begin Object Class=GUILabel Name=NoPreview
		WinWidth=0.287844
		WinHeight=0.208806
		WinLeft=0.523305
		WinTop=0.290546
        TextFont="UT2HeaderFont"
        TextAlign=TXTA_Center
        VertAlign=TXTA_Center
        bMultiline=True
        bTransparent=False
        TextColor=(R=125,G=0,B=0,A=255)
        Caption="No Preview Available"
        RenderWeight=1
        bScaleToParent=True
        bBoundToParent=True
    End Object
    l_NoPreview=NoPreview

	Begin Object class=GUISectionBackground name=iInfoBk
		WinWidth=0.624778
		WinHeight=0.537501
		WinLeft=0.352934
		WinTop=0.059057
		//HeaderBase=material'2K4Menus.NewControls.Display2'
		Caption="Information"
        RenderWeight=0.2
        bScaleToParent=True
        bBoundToParent=True
	End Object
	sb_4=iInfoBk

	// char stats
	Begin Object class=GUIListBox Name=lbDemoList
		WinWidth=0.265626
		WinHeight=0.735548
		WinLeft=0.030468
		WinTop=0.109375
        OnChange=DemoListClick;

        TabOrder=0
        bVisibleWhenEmpty=true
        bScaleToParent=True
        bBoundToParent=True
	End Object
    lb_DemoList=lbDemoList

	Begin Object class=GUIListBox Name=lbDemoInfo
		WinWidth=0.276054
		WinHeight=0.078998
		WinLeft=0.529180
		WinTop=0.155622
        bAcceptsInput=false
        bVisibleWhenEmpty=true
        OnChange=InfoClick
        bScaleToParent=True
        bBoundToParent=True
	End Object
    lb_DemoInfo=lbDemoInfo


	Begin Object class=GUIScrollTextBox Name=lbReqPacks
		WinWidth=0.650391
		WinHeight=0.193555
		WinLeft=0.310547
		WinTop=0.650090
        TabOrder=2
        bVisibleWhenEmpty=true
        bNoTeletype=true
        bScaleToParent=True
        bBoundToParent=True
	End Object
    lb_ReqPacks=lbReqPacks

	Begin Object class=GUILabel Name=lblGame
		Caption=""
		TextColor=(R=125,G=0,B=0,A=255)
		TextALign=TXTA_Center
		TextFont="UT2LargeFont"
		WinWidth=0.634467
		WinHeight=0.061558
		WinLeft=0.355370
		WinTop=0.103929
        RenderWeight=0.6
        bScaleToParent=True
        bBoundToParent=True
	End Object
    lbl_Game=lblGame

	Begin Object class=GUISectionBackground Name=sb1
		WinWidth=0.318642
		WinHeight=0.838661
		WinLeft=0.022249
		WinTop=0.057205
        Caption="Demos"
        BottomPadding=0.2
        RenderWeight=0.5
        bFillClient=true
        bScaleToParent=True
        bBoundToParent=True
	End Object
	sb_1=sb1

	Begin Object class=GUISectionBackground Name=sb2
		WinWidth=0.368224
		WinHeight=0.322830
		WinLeft=0.481726
		WinTop=0.228215
        Caption=""
        RenderWeight=0.5
        bFillClient=true
        bScaleToParent=True
        bBoundToParent=True
        bNoCaption=true
	End Object
	sb_2=sb2

   	Begin Object class=GUISectionBackground Name=sb3
		WinWidth=0.624778
		WinHeight=0.296317
		WinLeft=0.352934
		WinTop=0.598785
        Caption="Required Packages"
        RenderWeight=0.5
        BottomPadding=0.05
        LeftPadding=0.02
        RightPadding=0.02
        bFillClient=true
        bScaleToParent=True
        bBoundToParent=True
	End Object
	sb_3=sb3

    /*Begin Object Class=GUIButton Name=BB5
        Caption="Create AVI"
        Hint="Convert the selected demo to a DIVX AVI"
		WinWidth=0.120000
		WinHeight=0.036482
		WinLeft=0.556250
		WinTop=0.908333
        //RenderWeight=2.0001
        TabOrder=3
        bBoundToParent=True
        //StyleName="FooterButton"
        OnClick=DumpClick
    End Object
	b_Dump=BB5*/

    Begin Object Class=GUIButton Name=BB4
        Caption="Watch Demo"
        Hint="Watch the selected demo"
		WinWidth=0.120000
		WinHeight=0.036482
		WinLeft=0.701251
		WinTop=0.908333
        //RenderWeight=2.0001
        TabOrder=4
        bBoundToParent=True
        //StyleName="FooterButton"
        OnClick=WatchClick
    End Object
	b_Watch=BB4

    Begin Object Class=GUIButton Name=BB2
        Caption="Close"
        Hint="Close this dialog"
		WinWidth=0.120000
		WinHeight=0.036482
		WinLeft=0.847501
		WinTop=0.908333
        //RenderWeight=2.0001
        TabOrder=4
        bBoundToParent=True
        //StyleName="FooterButton"
        OnClick=OnCloseButtonClick
    End Object
	b_Back=BB2

    WinLeft=0.05
	WinTop=0.05
	WinHeight=0.9
	WinWidth=0.9

	CorruptDemText="Corrupted or missing .DEMO4 file !"
	UnknownText="Unknown"
    ltScoreLimit="Score Limit:"
    ltTimeLimit="Time Limit:"
	ltClientSide="Client Side Demo"
	ltServerSide="Server Side/Single Player Demo"
	ltGoodMsg="All of the packages required for this demo are installed"
	ltBadMsg="In order to be played, this demo requires the packages listed below.  If you are connected to the Internet, they will be autodownloaded when the demo is played||::Required Packages::"
	ltRecordedBy="Recorded By:"
	ltSelectMsg="Please select a demo from the list to the left."
	WindowName="Demo Management"
}
