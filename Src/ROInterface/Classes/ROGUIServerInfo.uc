//-----------------------------------------------------------
//
//-----------------------------------------------------------
class ROGUIServerInfo extends LargeWindow;

var automated GUITabControl c_Tabs;
var automated GUIFooter     t_Footer;

var array<string>               PanelClass;
var localized array<string>     PanelCaption;
var localized array<string>     PanelHint;

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
	local int i;

	if ( PlayerOwner() != None && PlayerOwner().GameReplicationInfo != None )
	    SetTitle();

    Super.InitComponent(MyController, MyOwner);

    c_Tabs.MyFooter = t_Footer;
	for ( i = 0; i < PanelClass.Length && i < PanelCaption.Length && i < PanelHint.Length; i++ )
	    c_Tabs.AddTab(PanelCaption[i],PanelClass[i],,PanelHint[i]);

	t_Footer.SetVisibility(false);
}

function SetTitle()
{
    local string temp;
    temp = PlayerOwner().GameReplicationInfo.ServerName;
    if (temp != "")
	   WindowName = temp;
}

DefaultProperties
{
    Begin Object Class=GUITabControl Name=ServerInfoTabs
        WinWidth=0.96
        WinLeft=0.02
        WinTop=0.07
        WinHeight=0.06
        TabHeight=0.04
        bAcceptsInput=true
        bDockPanels=true
        bBoundToParent=true
        bScaleToParent=true
        bFillSpace=True
    End Object
    c_Tabs=ServerInfoTabs

    Begin Object class=GUIFooter name=ServerInfoFooter
        WinWidth=1
        WinHeight=0.05
        WinLeft=0
        WinTop=0.95
        StyleName=""
//        StyleName="Footer"
//        Justification=TXTA_Center
        bBoundToParent=true
        bScaleToParent=true
    End Object
    t_Footer=ServerInfoFooter

    bRenderWorld=true
    bAllowedAsLast=true

    WinLeft=0.2
    WinWidth=0.6
    WinTop=0.1
    WinHeight=0.8

	PanelClass(0)="GUI2K4.UT2K4Tab_ServerMOTD"
	PanelClass(1)="GUI2K4.UT2K4Tab_ServerInfo"
	PanelClass(2)="GUI2K4.UT2K4Tab_ServerMapList"

	PanelCaption(0)="MOTD"
	PanelCaption(1)="Rules"
	PanelCaption(2)="Maps"

    PanelHint(0)="Message of the Day"
    PanelHint(1)="Game Rules"
    PanelHint(2)="Map Rotation"

    WindowName="Server Info"
}
