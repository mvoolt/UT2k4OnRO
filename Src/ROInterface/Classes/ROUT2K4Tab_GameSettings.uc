//-----------------------------------------------------------
//
//-----------------------------------------------------------
class ROUT2K4Tab_GameSettings extends UT2K4Tab_GameSettings;


function InitComponent(GUIController MyController, GUIComponent MyOwner)
{

    Super.InitComponent(MyController, MyOwner);

    class'ROInterfaceUtil'.static.SetROStyle(MyController, Controls);


}


DefaultProperties
{
     Begin Object Class=GUISectionBackground Name=GameBK1
         Caption="Gameplay"
         WinTop=0.033853
         WinLeft=0.014649
         WinWidth=0.449609
         WinHeight=0.748936
         RenderWeight=0.100100
         OnPreDraw=GameBK1.InternalPreDraw
     End Object
     i_BG1=GUISectionBackground'ROInterface.ROUT2K4Tab_GameSettings.GameBK1'
     //i_BG1=None

     Begin Object Class=GUISectionBackground Name=GameBK2
         Caption="Network"
		 WinWidth=0.496484
		 WinHeight=0.199610
		 WinLeft=0.470078
		 WinTop=0.033853
         OnPreDraw=GameBK2.InternalPreDraw
     End Object
     i_BG2=GUISectionBackground'ROInterface.ROUT2K4Tab_GameSettings.GameBK2'

     Begin Object Class=GUISectionBackground Name=GameBK3
         Caption="Stats"
		 WinWidth=0.496484
		 WinHeight=0.308985
		 WinLeft=0.470078
		 WinTop=0.242399

         RenderWeight=0.100200
         OnPreDraw=GameBK3.InternalPreDraw
     End Object
     i_BG3=GUISectionBackground'ROInterface.ROUT2K4Tab_GameSettings.GameBK3'

     Begin Object Class=GUISectionBackground Name=GameBK4
         Caption="Misc"
         WinTop=0.559889
         WinLeft=0.486328
         WinWidth=0.496484
         WinHeight=0.219141
         RenderWeight=0.100200
         OnPreDraw=GameBK4.InternalPreDraw
     End Object
//     i_BG4=GUISectionBackground'ROInterface.ROUT2K4Tab_GameSettings.GameBK4'
     i_BG4=None

     Begin Object Class=GUISectionBackground Name=GameBK5
         Caption="Unique ID / Messages"
         WinTop=0.791393
         WinLeft=0.017419
         WinWidth=0.965712
//         WinHeight=0.200706
         WinHeight=0.100706
         RenderWeight=0.100200
         OnPreDraw=GameBK5.InternalPreDraw
     End Object
     i_BG5=GUISectionBackground'ROInterface.ROUT2K4Tab_GameSettings.GameBK5'

     Begin Object Class=GUILabel Name=EpicID
         Caption="Your Unique id is:"
         TextAlign=TXTA_Center
         StyleName="TextLabel"
//         WinTop=0.858220
         WinTop=0.818220
         WinLeft=0.054907
         WinWidth=0.888991
         WinHeight=0.067703
         RenderWeight=0.200000
     End Object
     l_ID=GUILabel'ROInterface.ROUT2K4Tab_GameSettings.EpicID'

     Begin Object Class=GUIButton Name=ViewOnlineStats
         Caption="View Stats"
         Hint="Click to launch the UT stats website."
		 WinWidth=0.166055
		 WinHeight=0.050000
		 WinLeft=0.757885
		 WinTop=0.454124

         TabOrder=13
         OnClick=UT2K4Tab_GameSettings.OnViewStats
         OnKeyEvent=ViewOnlineStats.InternalOnKeyEvent
     End Object
     b_Stats=GUIButton'ROInterface.ROUT2K4Tab_GameSettings.ViewOnlineStats'

     Begin Object Class=moCheckBox Name=OnlineTrackStats
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Track Stats"
         OnCreateComponent=OnlineTrackStats.InternalOnCreateComponent
         IniOption="@Internal"
         IniDefault="True"
         Hint="Enable this option to join the online ranking system."
		 WinWidth=0.170273
		 //WinHeight=0.034351
		 WinLeft=0.631349
		 WinTop=0.308374

         TabOrder=10
         OnChange=UT2K4Tab_GameSettings.InternalOnChange
         OnLoadINI=UT2K4Tab_GameSettings.InternalOnLoadINI
     End Object
     ch_TrackStats=moCheckBox'ROInterface.ROUT2K4Tab_GameSettings.OnlineTrackStats'

     Begin Object Class=moCheckBox Name=NetworkDynamicNetspeed
         ComponentJustification=TXTA_Left
         CaptionWidth=0.940000
         Caption="Dynamic Netspeed"
         OnCreateComponent=NetworkDynamicNetspeed.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Netspeed is automatically adjusted based on the speed of your network connection"
		 WinWidth=0.419297
		 //WinHeight=0.034351
		 WinLeft=0.506497
		 WinTop=0.154567
         TabOrder=9
         OnChange=UT2K4Tab_GameSettings.InternalOnChange
         OnLoadINI=UT2K4Tab_GameSettings.InternalOnLoadINI
     End Object
     ch_DynNetspeed=moCheckBox'ROInterface.ROUT2K4Tab_GameSettings.NetworkDynamicNetspeed'

     Begin Object Class=moComboBox Name=OnlineNetSpeed
         bReadOnly=True
         ComponentJustification=TXTA_Left
         CaptionWidth=0.550000
         Caption="Connection"
         OnCreateComponent=OnlineNetSpeed.InternalOnCreateComponent
         IniOption="@Internal"
         IniDefault="Cable Modem/DSL"
         Hint="How fast is your connection?"
		 WinWidth=0.419297
		 //WinHeight=0.034351
		 WinLeft=0.506497
		 WinTop=0.105768
         TabOrder=8
         OnChange=UT2K4Tab_GameSettings.InternalOnChange
         OnLoadINI=UT2K4Tab_GameSettings.InternalOnLoadINI
     End Object
     co_Netspeed=moComboBox'ROInterface.ROUT2K4Tab_GameSettings.OnlineNetSpeed'

     Begin Object Class=moEditBox Name=OnlineStatsName
         CaptionWidth=0.400000
         Caption="UserName"
         OnCreateComponent=OnlineStatsName.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Please select a name to use for UT Stats!"
		 WinWidth=0.419316
		 //WinHeight=0.034351
		 WinLeft=0.504912
		 WinTop=0.358082

         TabOrder=11
         OnChange=UT2K4Tab_GameSettings.InternalOnChange
         OnLoadINI=UT2K4Tab_GameSettings.InternalOnLoadINI
     End Object
     ed_Name=moEditBox'ROInterface.ROUT2K4Tab_GameSettings.OnlineStatsName'

     Begin Object Class=moEditBox Name=OnlineStatsPW
         CaptionWidth=0.400000
         Caption="Password"
         OnCreateComponent=OnlineStatsPW.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Please select a password that will secure your UT Stats!"
		 WinWidth=0.419316
		 //WinHeight=0.034351
		 WinLeft=0.504912
		 WinTop=0.405868

         TabOrder=12
         OnChange=UT2K4Tab_GameSettings.InternalOnChange
         OnLoadINI=UT2K4Tab_GameSettings.InternalOnLoadINI
     End Object
     ed_Password=moEditBox'ROInterface.ROUT2K4Tab_GameSettings.OnlineStatsPW'

     ch_WeaponBob=None
     ch_AutoSwitch=None
     ch_Speech=None
     ch_Dodging=None
     ch_AutoAim=None
     ch_ClassicTrans=None
     ch_LandShake=None
     ch_Precache=None



}
