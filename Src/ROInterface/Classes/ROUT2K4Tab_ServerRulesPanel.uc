//-----------------------------------------------------------
//  edited emh 11/24/05
//-----------------------------------------------------------
class ROUT2K4Tab_ServerRulesPanel extends UT2K4Tab_ServerRulesPanel;

var GUIController localController;

var automated GUISectionBackground sb_background;

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
    localController = MyController;

    super(IAMultiColumnRulesPanel).InitComponent(MyController, MyOwner);

    RemoveComponent(b_Symbols);

    sb_background.ManageComponent(lb_Rules);
    sb_background.ManageComponent(nu_Port);
    sb_background.ManageComponent(ch_Webadmin);
    sb_background.ManageComponent(ch_LANServer);
    sb_background.ManageComponent(ch_Advanced);
}

function Refresh()
{
    Super.Refresh();

    sb_background.ManageComponent(lb_Rules);
}
DefaultProperties
{
     /*Begin Object Class=GUIImage Name=Bk1
         Image=Texture'ROInterfaceArt.button_normal'
         ImageStyle=ISTY_Stretched
         WinTop=0.014733
         WinLeft=0.000505
         WinWidth=0.996997
         WinHeight=0.907930
     End Object*/
     i_bk=none //GUIImage'ROInterface.ROUT2K4Tab_ServerRulesPanel.Bk1'

     Begin Object Class=ROGUIProportionalContainer Name=myBackgroundGroup
         bNoCaption=true
         WinTop=0
         WinLeft=0
         WinWidth=1
         WinHeight=1
     End Object
     sb_background=myBackgroundGroup

    Begin Object Class=GUIMultiOptionListBox Name=RuleListBox
        OnChange=InternalOnChange
        OnCreateComponent=ListBoxCreateComponent
        bBoundToParent=True
        bScaleToParent=True
        WinWidth=1.000000
        WinHeight=0.85
        WinLeft=0.000000
        WinTop=0.000000
        TabOrder=0
        bVisibleWhenEmpty=True
    End Object
    lb_Rules=RuleListBox

    Begin Object Class=moCheckBox Name=AdvancedButton
        OnChange=InternalOnChange
        Caption="View Advanced Options"
        Hint="Toggles whether advanced properties are displayed"
		WinWidth=0.400000
		WinHeight=0.040000
		WinLeft=0.05
		WinTop=0.9
        TabOrder=1
        RenderWeight=1.0
        bSquare=True
        bBoundToParent=True
        bScaleToParent=True
        bAutoSizeCaption=True
    End Object
    ch_Advanced=AdvancedButton

	Begin Object Class=moCheckbox Name=LANServer
		Caption="LAN Server"
		Hint="Optimizes various engine and network settings for LAN-based play.  Enabling this option when running an internet server will cause EXTREME lag during the match!"
		WinWidth=0.4
		WinHeight=0.04
		WinLeft=0.05
		WinTop=0.95
		INIOption="@Internal"
		OnLoadINI=InternalOnLoadINI
		OnChange=Change
		TabOrder=3
		bAutoSizeCaption=True
	End Object
	ch_LANServer=LANServer

	Begin Object Class=moCheckbox Name=EnableWebadmin
		Caption="Enable WebAdmin"
		Hint="Enables remote web-based administration of the server"
		WinWidth=0.4
		WinHeight=0.04
		WinLeft=0.55
		WinTop=0.9
		INIOption="@Internal"
		OnLoadINI=InternalOnLoadINI
		OnChange=Change
		TabOrder=4
		bAutoSizeCaption=True
	End Object
	ch_Webadmin=EnableWebAdmin

	Begin Object Class=moNumericEdit Name=WebadminPort
		Caption="WebAdmin Port"
		Hint="Select which port should be used to connect to the remote web-based administration"
		WinWidth=0.4
		WinHeight=0.04
		WinLeft=0.55
		WinTop=0.95
		MinValue=1
		MaxValue=65536
		INIOption="@Internal"
		OnLoadINI=InternalOnLoadINI
		OnChange=Change
		CaptionWidth=0.7
		ComponentWidth=0.3
		TabOrder=5
		bAutoSizeCaption=True
	End Object
	nu_Port=WebadminPort
}
