//-----------------------------------------------------------
//
//-----------------------------------------------------------
class ROUT2K4_FilterListPage extends UT2K4_FilterListPage;

function InitComponent(GUIController MyC, GUIComponent MyO)
{
    //local string           myStyleName;

	Super.InitComponent(MyC, MyO);

    class'ROInterfaceUtil'.static.SetROStyle(MyC, Controls);

    /*myStyleName = "ROTitleBar";

    //StyleName = myStyleName;
    //Style = MyC.GetStyle(myStyleName,t_WindowTitle.FontScale);

    i_FrameBG.StyleName = myStyleName;
    i_FrameBG.Style = MyC.GetStyle(myStyleName,t_WindowTitle.FontScale);

    t_WindowTitle.StyleName = myStyleName;
    t_WindowTitle.Style = MyC.GetStyle(myStyleName,t_WindowTitle.FontScale);

    sb_Background.StyleName = myStyleName;
    sb_Background.Style = MyC.GetStyle(myStyleName,t_WindowTitle.FontScale);*/
}

function bool CreateClick(GUIComponent Sender)
{
	local string FN;
	local int i,cnt;
	local moCheckbox cb;

	cnt = 0;
	for (i=0;i<li_Filters.ItemCount;i++)
	{
		cb = moCheckbox( li_Filters.GetItem(i) );
		if (inStr(cb.Caption,"New Filter")>=0)
			cnt++;
	}

	if (cnt==0)
		FN ="New Filter";
	else
		FN = "New Filter"@cnt;

	FM.AddCustomFilter(FN);
	InitFilterList();
    i= FM.FindFilterIndex(FN);
    Controller.OpenMenu("ROInterface.ROUT2K4_FilterEdit",""$i,FN);

    return true;
}

function bool EditClick(GUIComponent Sender)
{
	local string FN;
	local int i;
	local moCheckbox cb;

	cb = moCheckbox( li_Filters.Get() );
	FN = cb.Caption;
    i= FM.FindFilterIndex(FN);
    Controller.OpenMenu("ROInterface.ROUT2K4_FilterEdit",""$i,FN);

    return true;
}

defaultproperties
{
	Begin Object Class=ALTSectionBackground Name=sbBackground
		WinWidth=0.343359
		WinHeight=0.766448
		WinLeft=0.262656
		WinTop=0.103281
		Caption="Filters..."
		LeftPadding=0.0025
		RightPadding=0.0025
		TopPadding=0.0025
		bFillClient=true
		BottomPadding=0.0025
		bNoCaption=true
	End Object
	sb_Background=sbBackground

	Begin Object class=GUIMultiOptionListBox name=lbFilters
		WinWidth=0.343359
		WinHeight=0.766448
		WinLeft=0.262656
		WinTop=0.103281
	End Object
	lb_Filters=lbFilters

	Begin Object Class=GUIButton name=bCreate
		WinWidth=0.168750
		WinHeight=0.050000
		WinLeft=0.610001
		WinTop=0.105000
		OnClick=CreateClick
		Caption="Create"
	End Object
	b_Create=bCreate

	Begin Object Class=GUIButton name=bRemove
		WinWidth=0.168750
		WinHeight=0.050000
		WinLeft=0.610001
		WinTop=0.158333
		Caption="Remove"
		OnClick=RemoveClick
	End Object
	b_Remove=bRemove

	Begin Object Class=GUIButton name=bEdit
		WinWidth=0.168750
		WinHeight=0.050000
		WinLeft=0.610001
		WinTop=0.266666
		OnClick=EditClick
		Caption="Edit"
	End Object
	b_Edit=bEdit

   	Begin Object Class=GUIButton name=bOK
   		WinWidth=0.168750
		WinHeight=0.050000
		WinLeft=0.610001
		WinTop=0.770000
		Caption="OK"
		OnClick=OKClick
	End Object
	b_OK=bOK;

   	Begin Object Class=GUIButton name=bCancel
   		WinWidth=0.168750
		WinHeight=0.050000
		WinLeft=0.610001
		WinTop=0.820000
		Caption="Cancel"
		OnClick=CancelClick
	End Object
	b_Cancel=bCancel;


	WinWidth=0.568750
	WinHeight=0.875001
	WinLeft=0.237500
	WinTop=0.046667
	WindowName="Select Filters"

	CantRemove="You can not remove the default filter"

}
