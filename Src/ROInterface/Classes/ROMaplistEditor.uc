//-----------------------------------------------------------
// created by emh, 11/24/05
//-----------------------------------------------------------
class ROMaplistEditor extends MaplistEditor;

var automated GUISectionBackground  sb_container;

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
    Super.InitComponent(MyController, MyOwner);

    sb_MapList.ManageComponent(co_Maplist);
    sb_MapList.ManageComponent(sb_container);
    sb_container.ManageComponent(b_Delete);
    sb_container.ManageComponent(b_Rename);
    sb_container.ManageComponent(b_New);


}

// wtf is this bollocks? I want my controls statically aligned!
function bool ButtonPreDraw(Canvas C)
{
    return false;
}


defaultproperties
{
    Begin Object class=GUISectionBackground name=MapListSectionBackground
		WinWidth=0.943100
		//WinHeight=0.190595
		WinHeight=0.17
		WinLeft=0.023646
		WinTop=0.055162
		Caption="Saved Map Lists"
		NumColumns=2
		BottomPadding=0.05
		TopPadding=0.05
	End Object
	sb_MapList=MapListSectionBackground

	Begin Object class=ROGUIContainerNoSkinAlt name=subcontainer
	    NumColumns=3
	    WinWidth=1
		WinHeight=1
		WinLeft=0
		WinTop=0
		TabOrder=1
	End Object
	sb_container=subcontainer

	Begin Object Class=GUIComboBox Name=SelectMaplistCombo
		Hint="Load a existing custom maplist"
		OnChange=MaplistSelectChange
		WinWidth=0.55
		WinHeight=0.050000
		WinLeft=0
		WinTop=0
		TabOrder=0
		bReadOnly=True
		bScaleToParent=false
	End Object
    co_Maplist=SelectMaplistCombo

	Begin Object Class=GUIButton Name=NewMaplistButton
		Caption="New"
		Hint="Create a new custom maplist"
		OnClick=CustomMaplistClick
		WinWidth=0.1
		WinHeight=0.05
		WinLeft=0.6
		WinTop=0
		TabOrder=1
		bScaleToParent=false
	End Object
    b_New=NewMaplistButton

	Begin Object Class=GUIButton Name=RenameMaplistButton
		Caption="Rename"
		Hint="Rename the currently selected maplist"
		OnClick=CustomMaplistClick
		WinWidth=0.1
		WinHeight=0.05
		WinLeft=0.75
		WinTop=0
		TabOrder=2
		bScaleToParent=false
	End Object
    b_Rename=RenameMaplistButton

	Begin Object Class=GUIButton Name=DeleteMaplistButton
		Caption="Delete"
		Hint="Delete the currently selected maplist.  If this is the last maplist for this gametype, a new default maplist will be generated."
		OnClick=CustomMaplistClick
		WinWidth=0.1
		WinHeight=0.05
		WinLeft=0.9
		WinTop=0
		TabOrder=3
		OnPreDraw=ButtonPreDraw
		bScaleToParent=false
	End Object
    b_Delete=DeleteMaplistButton

    Begin Object Class=GUISectionBackground Name=AvailBackground
		WinWidth=0.380859
		WinHeight=0.716073
		WinLeft=0.025156
		WinTop=0.235260
		Caption="Available Maps"
		LeftPadding=0.0025
		RightPadding=0.0025
		TopPadding=0.0025
		BottomPadding=0.0025

		bBoundToParent=True
		bScaleToParent=True
		bFillClient=True
	End Object
	sb_Avail=AvailBackground

	Begin Object Class=GUISectionBackground Name=ActiveBackground
		WinWidth=0.380859
		WinHeight=0.716073
		WinLeft=0.586876
		WinTop=0.235260
		Caption="Selected Maps"
		LeftPadding=0.0025
		RightPadding=0.0025
		TopPadding=0.0025
		BottomPadding=0.0025

		bBoundToParent=True
		bScaleToParent=True
		bFillClient=True
	End Object
	sb_Active=ActiveBackground



	Begin Object Class=GUIButton Name=AddButton
		Caption="Add"
		Hint="Add the selected maps to your map list"
		WinWidth=0.145000
		WinHeight=0.050000
		WinLeft=0.425
		WinTop=0.3
		bScaleToParent=true
		OnClick=ModifyMapList
		OnClickSound=CS_Up
		TabOrder=6
		bRepeatClick=True
	End Object
	b_Add=AddButton

	Begin Object Class=GUIButton Name=AddAllButton
		Caption="Add All"
		Hint="Add all maps to your map list"
		WinWidth=0.145000
		WinHeight=0.050000
		WinLeft=0.425
		WinTop=0.36
		bScaleToParent=true
		OnClick=ModifyMapList
		OnClickSound=CS_Up
		TabOrder=5
	End Object
	b_AddAll=AddAllButton

	Begin Object Class=GUIButton Name=MoveUpButton
		Caption="Up"
		Hint="Move this map higher up in the list"
		WinWidth=0.145000
		WinHeight=0.050000
		WinLeft=0.425
		WinTop=0.5
		bScaleToParent=true
		OnClick=ModifyMapList
		OnClickSound=CS_Up
		TabOrder=9
		bRepeatClick=True
	End Object
	b_MoveUp=MoveUpButton

   	Begin Object Class=GUIButton Name=MoveDownButton
		Caption="Down"
		Hint="Move this map lower down in the list"
		WinWidth=0.145000
		WinHeight=0.050000
		WinLeft=0.425
		WinTop=0.56
		OnClick=ModifyMapList
		bScaleToParent=true
		OnClickSound=CS_Down
		TabOrder=8
		bRepeatClick=True
	End Object
	b_MoveDown=MoveDownButton


	Begin Object Class=GUIButton Name=RemoveButton
		Caption="Remove"
		Hint="Remove the selected maps from your map list"
		WinWidth=0.145000
		WinHeight=0.050000
		WinLeft=0.425
		WinTop=0.7
		OnClick=ModifyMapList
		OnClickSound=CS_Down
		TabOrder=10
		AutoSizePadding=(HorzPerc=0.5,VertPerc=0.0)
		bScaleToParent=true
		bRepeatClick=True
	End Object
	b_Remove=RemoveButton

	Begin Object Class=GUIButton Name=RemoveAllButton
		Caption="Remove All"
		Hint="Remove all maps from your map list"
		WinWidth=0.145000
		WinHeight=0.050000
		WinLeft=0.425
		WinTop=0.76
		OnClick=ModifyMapList
		OnClickSound=CS_Down
		TabOrder=11
		bScaleToParent=true
	End Object
	b_RemoveAll=RemoveAllButton
}
