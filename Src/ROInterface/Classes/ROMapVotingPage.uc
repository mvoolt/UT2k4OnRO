//=============================================================================
// ROMapVotingPage
//=============================================================================
// Modified Map Voting page
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Mathieu Mallet
//=============================================================================

class ROMapVotingPage extends MapVotingPage;

function bool AlignBK(Canvas C)
{
	i_MapCountListBackground.WinWidth  = lb_VoteCountListbox.MyList.ActualWidth();
	i_MapCountListBackground.WinHeight = lb_VoteCountListbox.MyList.ActualHeight();
	i_MapCountListBackground.WinLeft   = lb_VoteCountListbox.MyList.ActualLeft();
	i_MapCountListBackground.WinTop    = lb_VoteCountListbox.MyList.ActualTop();

	return false;
}

DefaultProperties
{
    i_MapListBackground=none

    Begin Object Class=MapVoteCountMultiColumnListBox Name=VoteCountListBox
		WinWidth=0.96
		WinHeight=0.267520
		WinLeft=0.02
    	WinTop=0.077369
        bVisibleWhenEmpty=true
        bScaleToParent=True
        bBoundToParent=True
        FontScale=FNS_Small
        HeaderColumnPerc(0)=0.40
        HeaderColumnPerc(1)=0.20
        DefaultListClass="ROInterface.ROMapVoteCountMultiColumnList"
    End Object
    lb_VoteCountListBox = VoteCountListBox

    Begin Object Class=GUIImage Name=MapCountListBackground
		Image=Texture'InterfaceArt_tex.Menu.buttonGreyDark01'
		ImageStyle=ISTY_Stretched
        OnDraw=AlignBK
	End Object
	i_MapCountListBackground=MapCountListBackground

    // hax
    Begin Object class=moComboBox Name=GameTypeCombo
		Caption="Filter Game Type:"
        CaptionWidth=0.35
		bScaleToParent=True
		bVisible=false
    End Object
    co_GameType = GameTypeCombo
}
