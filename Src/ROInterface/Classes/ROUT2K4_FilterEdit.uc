//-----------------------------------------------------------
//
//-----------------------------------------------------------

class ROUT2K4_FilterEdit extends LargeWindow;

var automated GUISectionBackground sb_Options;
var automated moEditBox eb_Name;
var automated moCheckBox ck_Full, ck_Bots, ck_Empty, ck_Passworded, ck_VACOnly, ck_Hidden;
var automated GUIButton b_Ok, b_Cancel;

var int 			FilterIndex;
var	BrowserFilters 	FM;

var UT2K4_FilterListPage FLP;

var bool bInitialized;

function InitComponent(GUIController MyC, GUIComponent MyO)
{
	Super.InitComponent(MyC, MyO);

	FLP = UT2K4_FilterListPage(ParentPage);

	sb_Options.ManageComponent(ck_Full);
	sb_Options.ManageComponent(ck_Empty);
	sb_Options.ManageComponent(ck_Passworded);
	sb_Options.ManageComponent(ck_Bots);
	sb_Options.ManageComponent(ck_VACOnly);
	sb_Options.ManageComponent(ck_Hidden);
}

event HandleParameters(string Param1, string Param2)
{
	local int i;
	local array<CustomFilter.AFilterRule> Rules;
	local MasterServerClient.QueryData 	FilterItem;

	FilterIndex = int(Param1);
	eb_Name.SetComponentValue(Param2);

	if (Param2~="Default")
		eb_Name.DisableMe();
	else
		eb_Name.EnableMe();

	//Get the custom filter
 	Rules = FLP.FM.GetFilterRules(FilterIndex);

	for (i=0;i<Rules.Length;i++)
	{
		FilterItem = Rules[i].FilterItem;
		if ( FilterItem.Key~="currentplayers" && FilterItem.Value=="0" && FilterItem.QueryType==QT_GreaterThan )
			ck_Empty.Checked(true);

		if ( FilterItem.Key~="password" && FilterItem.Value=="false" && FilterItem.QueryType==QT_Equals )
			ck_Passworded.Checked(true);

		if ( FilterItem.Key~="freespace" && FilterItem.Value =="0" && FilterItem.QueryType==QT_GreaterThan )
			ck_Full.Checked(true);

		if ( FilterItem.Key~="nobots" && FilterItem.Value=="true" && FilterItem.QueryType==QT_Equals)
			ck_Bots.Checked(true);

		if ( FilterItem.Key~="vacsecure" && FilterItem.Value=="true" && FilterItem.QueryType==QT_Equals)
			ck_VACOnly.Checked(true);
	}
}

function bool CancelClick(GUIComponent Sender)
{
	Controller.CloseMenu(true);
	return true;
}

function CustomFilter.AFilterRule BuildRule(string Key, string Value, MasterServerClient.EQueryType qType)
{
	local CustomFilter.AFilterRule NewRule;

	NewRule.FilterItem.Key   		= key;
	NewRule.FilterItem.Value 		= value;
	NewRule.FilterItem.QueryType	= qtype;
	NewRule.FilterType				= DT_Unique;
	NewRule.ItemName				= Key;

	return NewRule;
}


function bool OkClick(GUIComponent Server)
{
	local array<CustomFilter.AFilterRule> Rules;
	local int cnt;

	cnt = 0;

	// Build Query lists

	if ( ck_Empty.IsChecked() )
		Rules[Cnt++] = BuildRule("currentplayers","0",QT_GreaterThan);

	if ( ck_Full.IsChecked() )
		Rules[Cnt++] = BuildRule("freespace","0",QT_GreaterThan);

	if ( ck_Passworded.IsChecked() )
		Rules[Cnt++] = BuildRule("password","false",QT_Equals);

	if ( ck_Bots.IsChecked() )
		Rules[Cnt++] = BuildRule("nobots","true", QT_Equals);

	if ( ck_VACOnly.IsChecked() )
		Rules[Cnt++] = BuildRule("vacsecure","true", QT_Equals);

	FLP.FM.PostEdit(FilterIndex,eb_Name.GetComponentValue(),Rules);
	Controller.CloseMenu(true);
	FLP.InitFilterList();

	FLP.li_Filters.SetIndex(FLP.li_Filters.Find(eb_Name.GetComponentValue()));

	return true;
}

function bool ebPreDraw(canvas Canvas)
{
	// Reposition
	eb_Name.WinTop = sb_Options.ActualTop() + 36;
	return true;
}

defaultproperties
{
	Begin Object class=moEditBox name=ebName
		WinWidth=0.654297
		WinHeight=0.030000
		WinLeft=0.184531
		WinTop=0.124114
		bStandardized=true
		Caption="Filter Name:"
		ComponentWidth=0.7
		TabOrder=0
		OnPreDraw=ebPreDraw
	End Object
	eb_Name=ebName

	Begin Object Class=GUISectionBackground Name=sbOptions
		WinWidth=0.827735
		WinHeight=0.427735
		WinLeft=0.086094
		WinTop=0.257448
		Caption="Options..."
		LeftPadding=0.0025
		RightPadding=0.0025
        TopPadding=0.2
		bFillClient=true
		BottomPadding=0.0025
		NumColumns=2
	End Object
	sb_Options=sbOptions

	Begin Object class=moCheckBox name=ckFull
		WinWidth=0.5
		WinLeft=0.25
		WinTop=0.25
		bStandardized=true
		Caption="No Full Servers"
		ComponentWidth=0.1
		TabOrder=1
	End Object
	ck_Full=ckFull

	Begin Object class=moCheckBox name=ckBots
		WinWidth=0.5
		WinLeft=0.25
		WinTop=0.25
		bStandardized=true
		Caption="No Bots"
		ComponentWidth=0.1
		TabOrder=2
	End Object
	ck_Bots=ckBots

	Begin Object class=moCheckBox name=ckEmpty
		WinWidth=0.5
		WinLeft=0.25
		WinTop=0.25
		bStandardized=true
		Caption="No Empty Servers"
		ComponentWidth=0.1
		TabOrder=3
	End Object
	ck_Empty=ckEmpty

	Begin Object class=moCheckBox name=ckPassworded
		WinWidth=0.5
		WinLeft=0.25
		WinTop=0.25
		bStandardized=true
		Caption="No Passworded Servers"
		ComponentWidth=0.1
		TabOrder=4
	End Object
	ck_Passworded=ckPassworded

	Begin Object class=moCheckBox name=ckVACOnly
		WinWidth=0.5
		WinLeft=0.25
		WinTop=0.25
		bStandardized=true
		Caption="Valve Anti-Cheat Protected Only"
		ComponentWidth=0.1
		TabOrder=5
	End Object
	ck_VACOnly=ckVACOnly

	Begin Object class=moCheckBox name=ckHidden
		WinWidth=0.5
		WinLeft=0.25
		WinTop=0.25
		bStandardized=true
		Caption="Hidden"
		ComponentWidth=0.1
		TabOrder=6
		bVisible=false
	End Object
	ck_Hidden=ckHidden

   	Begin Object Class=GUIButton name=bOK
		WinWidth=0.168750
		WinHeight=0.050000
		WinLeft=0.561564
		WinTop=0.698612
		Caption="OK"
		OnClick=OKClick
	End Object
	b_OK=bOK;

   	Begin Object Class=GUIButton name=bCancel
		WinWidth=0.168750
		WinHeight=0.050000
		WinLeft=0.742814
		WinTop=0.698612
		Caption="Cancel"
		OnClick=CancelClick
	End Object
	b_Cancel=bCancel;

	WinWidth=0.90
	WinHeight=0.57
	WinLeft=0.05
	WinTop=0.20
	WindowName="Edit Filter Rules..."
}
