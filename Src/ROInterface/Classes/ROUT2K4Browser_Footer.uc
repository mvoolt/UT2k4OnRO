//-----------------------------------------------------------
//
//-----------------------------------------------------------
class ROUT2K4Browser_Footer extends UT2k4Browser_Footer;

DefaultProperties
{
    Begin Object class=GUITitleBar name=BrowserStatus
		WinWidth=0.761055
		WinHeight=0.45
		WinLeft=0.238945
		WinTop=0.030495
        StyleName="TextLabel"
        Caption=""
        bUseTextHeight=false
        Justification=TXTA_Right
        bBoundToParent=True
        bScaleToParent=True
        FontScale=FNS_Small
    End Object
    t_StatusBar=BrowserStatus

	/*Begin Object class=moCheckBox Name=OnlyStandardCheckBox
		bStandardized=False
		WinWidth=0.243945
		WinHeight=0.308203
		WinLeft=0.020000
		WinTop=0.093073
		Caption="Standard Servers Only"
		Hint="Only display standard servers (no mutators) in the server browser.  This option overrides filter settings."
		CaptionWidth=0.9
		TabOrder=5
        bBoundToParent=True
        bScaleToParent=True
        FontScale=FNS_Small
	End Object
	ch_Standard=OnlyStandardCheckBox*/

	Begin Object Class=GUIButton Name=BrowserFilter
		Caption="FILTERS"
		Hint="Filters allow more control over which servers will appear in the server browser lists."
		WinHeight=0.036482
		WinTop=0.5
		bAutoSize=True
		WinLeft=0.0
		bBoundToParent=True
		OnClick=InternalOnClick
		RenderWeight=2
        StyleName="FooterButton"
		TabOrder=0
	End Object
	b_Filter=BrowserFilter

    Begin Object Class=GUIButton Name=BrowserBack
        Caption="BACK"
        Hint="Return to the previous menu"
		WinHeight=0.036482
		WinTop=0.5
        RenderWeight=2
        TabOrder=4
        bBoundToParent=True
        StyleName="FooterButton"
		OnClick=InternalOnClick
    End Object
    b_Back=BrowserBack

    Begin Object Class=GUIButton Name=BrowserRefresh
        Caption="REFRESH"
        WinWidth=0.114648
        WinLeft=0.885352
		WinHeight=0.036482
		WinTop=0.5
        RenderWeight=2
        TabOrder=3
        bBoundToParent=True
        MenuState=MSAT_Disabled
        StyleName="FooterButton"
		OnClick=InternalOnClick
    End Object
    b_Refresh=BrowserRefresh

    Begin Object Class=GUIButton Name=BrowserJoin
        Caption="JOIN"
		WinWidth=124.000000
		WinLeft=611.000000
		WinHeight=0.036482
		WinTop=0.5
        TabOrder=2
        RenderWeight=2
        bBoundToParent=True
        MenuState=MSAT_Disabled
        StyleName="FooterButton"
		OnClick=InternalOnClick
    End Object
    b_Join=BrowserJoin

    Begin Object Class=GUIButton Name=BrowserSpec
        Caption="SPECTATE"
        WinWidth=0.114648
		WinHeight=0.036482
		WinTop=0.5
        WinLeft=0.771094
        RenderWeight=2
        TabOrder=1
        bBoundToParent=True
        MenuState=MSAT_Disabled
        StyleName="FooterButton"
		OnClick=InternalOnClick
    End Object
    b_Spectate=BrowserSpec
}
