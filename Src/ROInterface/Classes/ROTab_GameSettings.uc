//=============================================================================
// ROTab_GameSettings
//=============================================================================
// The game config tab
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Mathieu Mallet
//=============================================================================

class ROTab_GameSettings extends Settings_Tabs;

var automated GUISectionBackground i_BG1, i_BG2, i_BG3;

var automated moEditBox     ed_PlayerName;
var automated moComboBox    co_GoreLevel;

var automated moCheckBox    ch_DynNetspeed;
var automated moComboBox    co_Netspeed;

var automated moCheckBox    ch_TankThrottle, ch_VehicleThrottle, ch_ManualReloading;

var int     iGore;
var int     iNetspeed, iNetSpeedD;
var bool    bDynNet, bTankThrottle, bVehicleThrottle, bManualReloading;
var string  sPlayerName, sPlayerNameD;

var localized string    NetSpeedText[4];

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
    local int i;

	Super.InitComponent(MyController, MyOwner);

	if ( class'GameInfo'.Default.bAlternateMode )
    //	RemoveComponent(co_GoreLevel);
    {
        co_GoreLevel.AddItem(class'GameInfo'.default.GoreLevelText[0]);
    	co_GoreLevel.AddItem(class'GameInfo'.default.GoreLevelText[1]);
    }
    else
    {
    	co_GoreLevel.AddItem(class'GameInfo'.default.GoreLevelText[0]);
    	co_GoreLevel.AddItem(class'GameInfo'.default.GoreLevelText[2]);
    }

    for(i = 0; i < ArrayCount(NetSpeedText); i++)
        co_Netspeed.AddItem(NetSpeedText[i]);


    i_BG1.ManageComponent(ed_PlayerName);
    i_BG1.ManageComponent(co_GoreLevel);

    i_BG2.ManageComponent(co_Netspeed);
    i_BG2.ManageComponent(ch_DynNetspeed);

    i_BG3.ManageComponent(ch_TankThrottle);
    i_BG3.ManageComponent(ch_VehicleThrottle);
    i_BG3.ManageComponent(ch_ManualReloading);

    ed_PlayerName.MyEditBox.bConvertSpaces = true;
	ed_PlayerName.MyEditBox.MaxWidth=16;

}

function InternalOnLoadINI(GUIComponent Sender, string s)
{
    local PlayerController PC;
    local int i;

    PC = PlayerOwner();

    switch (Sender)
    {
        case co_GoreLevel:
            if ( PC.Level.Game != None )
                iGore = PC.Level.Game.GoreLevel;
            else
                iGore = class'GameInfo'.default.GoreLevel;

            if (iGore == 2)
                iGore = 1;

            co_GoreLevel.SetIndex(iGore);
            break;


        case co_Netspeed:
        	if ( PC.Player != None )
        		i = PC.Player.ConfiguredInternetSpeed;
        	else
                i = class'Player'.default.ConfiguredInternetSpeed;

            if (i <= 2600)
                iNetSpeed = 0;

            else if (i <= 5000)
                iNetSpeed = 1;

            else if (i <= 10000)
                iNetSpeed = 2;

            else iNetSpeed = 3;

			iNetSpeedD = iNetSpeed;
            co_NetSpeed.SetIndex(iNetSpeed);
            break;

        case ch_DynNetspeed:
            bDynNet = PC.bDynamicNetSpeed;
            ch_DynNetspeed.Checked(bDynNet);
            break;

        case ed_PlayerName:
            sPlayerName = PC.GetUrlOption("Name");
			sPlayerNameD = sPlayerName;
			ed_PlayerName.SetText(sPlayerName);

        case ch_TankThrottle:
            if (ROPlayer(PC) != none)
                bTankThrottle = ROPlayer(PC).bInterpolatedTankThrottle;
            else
                bTankThrottle = class'ROPlayer'.default.bInterpolatedTankThrottle;
            ch_TankThrottle.Checked(bTankThrottle);
            break;

        case ch_VehicleThrottle:
            if (ROPlayer(PC) != none)
                bVehicleThrottle = ROPlayer(PC).bInterpolatedVehicleThrottle;
            else
                bVehicleThrottle = class'ROPlayer'.default.bInterpolatedVehicleThrottle;
            ch_VehicleThrottle.Checked(bVehicleThrottle);
            break;

        case ch_ManualReloading:
            if (ROPlayer(PC) != none)
                bManualReloading = ROPlayer(PC).bManualTankShellReloading;
            else
                bManualReloading = class'ROPlayer'.default.bManualTankShellReloading;
            ch_ManualReloading.Checked(bManualReloading);
            break;
    }
}

function SaveSettings()
{
    local PlayerController PC;
    local bool bSave;

	Super.SaveSettings();
    PC = PlayerOwner();

    if (PC.Level != None && PC.Level.Game != None)
    {
    	if ( PC.Level.Game.GoreLevel != min(2, (iGore * 2)) )
    	{
	        PC.Level.Game.GoreLevel = min(2, (iGore * 2));
	        PC.Level.Game.SaveConfig();
	    }
    }
    else
    {
		if ( class'Engine.GameInfo'.default.GoreLevel != min(2, (iGore * 2)) )
		{
	        class'Engine.GameInfo'.default.GoreLevel = min(2, (iGore * 2));
	        class'Engine.GameInfo'.static.StaticSaveConfig();
	    }
    }

	if ( iNetSpeed != iNetSpeedD || (class'Player'.default.ConfiguredInternetSpeed == 9636) )
	{
		if ( PC.Player != None )
		{
			switch (iNetSpeed)
			{
				case 0: PC.Player.ConfiguredInternetSpeed = 2600; break;
				case 1: PC.Player.ConfiguredInternetSpeed = 5000; break;
				case 2: PC.Player.ConfiguredInternetSpeed = 10000; break;
				case 3: PC.Player.ConfiguredInternetSpeed = 15000; break;
			}

			PC.Player.SaveConfig();
		}

		else
		{
			switch (iNetSpeed)
			{
				case 0: class'Player'.default.ConfiguredInternetSpeed = 2600; break;
				case 1: class'Player'.default.ConfiguredInternetSpeed = 5000; break;
				case 2: class'Player'.default.ConfiguredInternetSpeed = 10000; break;
				case 3: class'Player'.default.ConfiguredInternetSpeed = 15000; break;
			}

			class'Player'.static.StaticSaveConfig();
		}
	}

	if ( PC.bDynamicNetSpeed != bDynNet )
	{
		PC.bDynamicNetSpeed = bDynNet;
		bSave = True;
	}

	if (ROPlayer(PC) != none)
	{
	   if (ROPlayer(PC).bInterpolatedTankThrottle != bTankThrottle)
	   {
	       ROPlayer(PC).bInterpolatedTankThrottle = bTankThrottle;
	       bSave = true;
	   }

	   if (ROPlayer(PC).bInterpolatedVehicleThrottle != bVehicleThrottle)
	   {
	       ROPlayer(PC).bInterpolatedVehicleThrottle = bVehicleThrottle;
	       bSave = true;
	   }

	   if (ROPlayer(PC).bManualTankShellReloading != bManualReloading)
	   {
	       ROPlayer(PC).SetManualTankShellReloading(bManualReloading);
	       bSave = true;
	   }
	}
	else
	{
	    if (class'ROPlayer'.default.bInterpolatedTankThrottle != bTankThrottle)
	        class'ROPlayer'.default.bInterpolatedTankThrottle = bTankThrottle;
	    if (class'ROPlayer'.default.bInterpolatedVehicleThrottle != bVehicleThrottle)
	        class'ROPlayer'.default.bInterpolatedVehicleThrottle = bVehicleThrottle;
	    if (class'ROPlayer'.default.bManualTankShellReloading != bManualReloading)
	        class'ROPlayer'.default.bManualTankShellReloading = bManualReloading;
	    class'ROPlayer'.static.StaticSaveConfig();
	}

	if (sPlayerNameD != sPlayerName)
	{
		PC.ReplaceText(sPlayerName, "\"", "");
		sPlayerNameD = sPlayerName;
		PC.ConsoleCommand("SetName"@sPlayerName);
	}

    if (bSave)
        PC.SaveConfig();
}

function InternalOnChange(GUIComponent Sender)
{
    Super.InternalOnChange(Sender);

    switch (sender)
    {
        case ed_PlayerName:
			sPlayerName = ed_PlayerName.GetText();
			break;

        case co_GoreLevel:
            iGore = co_GoreLevel.GetIndex();
            break;

        case co_Netspeed:
            iNetSpeed = co_NetSpeed.GetIndex();
            break;

        case ch_DynNetspeed:
            bDynNet = ch_DynNetspeed.IsChecked();
            break;

        case ch_TankThrottle:
            bTankThrottle = ch_TankThrottle.IsChecked();
            break;

        case ch_VehicleThrottle:
            bVehicleThrottle = ch_VehicleThrottle.IsChecked();
            break;

        case ch_ManualReloading:
            bManualReloading = ch_ManualReloading.IsChecked();
            break;
    }
}

function ResetClicked()
{
	local PlayerController PC;
	local int i;

	Super.ResetClicked();

	PC = PlayerOwner();

	class'Player'.static.ResetConfig("ConfiguredInternetSpeed");
   	class'Engine.GameInfo'.static.ResetConfig("GoreLevel");
	class'PlayerController'.static.ResetConfig("bDynamicNetSpeed");
    class'ROPlayer'.static.ResetConfig("bInterpolatedTankThrottle");
    class'ROPlayer'.static.ResetConfig("bInterpolatedVehicleThrottle");

	for (i = 0; i < Components.Length; i++)
		Components[i].LoadINI();
}

DefaultProperties
{
    Begin Object class=GUISectionBackground Name=GameBK1
		WinWidth=0.5
		WinHeight=0.25
		WinLeft=0.25
		WinTop=0.05
        RenderWeight=0.1001
        Caption="Gameplay"
    End Object
    i_BG1=GameBK1

    Begin Object class=GUISectionBackground Name=GameBK2
		WinWidth=0.5
		WinHeight=0.25
		WinLeft=0.25
		WinTop=0.35
        RenderWeight=0.1002
		Caption="Network"
    End Object
    i_BG2=GameBK2

    Begin Object class=GUISectionBackground Name=GameBK3
		WinWidth=0.5
		WinHeight=0.25
		WinLeft=0.25
		WinTop=0.65
        RenderWeight=0.1002
		Caption="Simulation Realism"
    End Object
    i_BG3=GameBK3


    Begin Object class=moEditBox Name=OnlineStatsName
		WinWidth=0.419316
		WinLeft=0.524912
		WinTop=0.373349
        INIOption="@Internal"
        OnLoadINI=InternalOnLoadINI
        OnChange=InternalOnChange
        Caption="Player Name"
        Hint="Please select a name to use ingame"
        CaptionWidth=0.5
        TabOrder=1
    End Object
    ed_PlayerName=OnlineStatsName

    Begin Object class=moComboBox Name=GameGoreLevel
        WinWidth=0.400000
        WinLeft=0.050000
        WinTop=0.415521
        Caption="Gore Level"
        INIOption="@Internal"
        OnLoadINI=InternalOnLoadINI
        OnChange=InternalOnChange
        Hint="Configure the amount of blood and gore you see while playing the game"
        ComponentJustification=TXTA_Right
        LabelJustification=TXTA_Left
        ComponentWidth=-1
        CaptionWidth=0.5
        RenderWeight=1.04
        TabOrder=2
        bReadOnly=True
    End Object
    co_GoreLevel=GameGoreLevel

    Begin Object class=moComboBox Name=OnlineNetSpeed
		WinWidth=0.419297
		WinLeft=0.528997
		WinTop=0.122944
        Caption="Connection"
        INIOption="@Internal"
        INIDefault="Cable Modem/DSL"
        OnLoadINI=InternalOnLoadINI
        OnChange=InternalOnChange
        Hint="How fast is your connection?"
        CaptionWidth=0.5
        ComponentJustification=TXTA_Left
        bReadOnly=true
        bHeightFromComponent=false
        TabOrder=3
    End Object
    co_Netspeed=OnlineNetSpeed

    Begin Object class=moCheckBox Name=NetworkDynamicNetspeed
		WinWidth=0.419297
		WinLeft=0.528997
		WinTop=0.166017
        Caption="Dynamic Netspeed"
        Hint="Netspeed is automatically adjusted based on the speed of your network connection"
        CaptionWidth=0.95
        bSquare=true
        ComponentJustification=TXTA_Left
        IniOption="@Internal"
        OnLoadINI=InternalOnLoadINI
        OnChange=InternalOnChange
        TabOrder=4
    End Object
    ch_DynNetspeed=NetworkDynamicNetspeed

    Begin Object class=moCheckBox Name=ThrottleTanks
		WinWidth=0.419297
		WinLeft=0.528997
		WinTop=0.166017
        Caption="Incremental Tank Throttle"
        Hint="Enabling this allows you to incrementally increase or decrease the throttle in tanks"
        CaptionWidth=0.95
        bSquare=true
        ComponentJustification=TXTA_Left
        IniOption="@Internal"
        OnLoadINI=InternalOnLoadINI
        OnChange=InternalOnChange
        TabOrder=4
    End Object
    ch_TankThrottle=ThrottleTanks

    Begin Object class=moCheckBox Name=ThrottleVehicle
		WinWidth=0.419297
		WinLeft=0.528997
		WinTop=0.166017
        Caption="Incremental Vehicle Throttle"
        Hint="Enabling this allows you to incrementally increase or decrease the throttle for non-tank vehicles"
        CaptionWidth=0.95
        bSquare=true
        ComponentJustification=TXTA_Left
        IniOption="@Internal"
        OnLoadINI=InternalOnLoadINI
        OnChange=InternalOnChange
        TabOrder=4
    End Object
    ch_VehicleThrottle=ThrottleVehicle

    Begin Object class=moCheckBox Name=ManualReloading
		WinWidth=0.419297
		WinLeft=0.528997
		WinTop=0.166017
        Caption="Manual Tank Shell Reloading"
        Hint="Stops tank shells from automatically reloading to allow for the selection of ammo types prior to reloading."
        CaptionWidth=0.95
        bSquare=true
        ComponentJustification=TXTA_Left
        IniOption="@Internal"
        OnLoadINI=InternalOnLoadINI
        OnChange=InternalOnChange
        TabOrder=5
    End Object
    ch_ManualReloading=ManualReloading

    WinTop=0.15
	WinLeft=0
	WinWidth=1
	WinHeight=0.72
	bAcceptsInput=false

    NetSpeedText(0)="Modem"
    NetSpeedText(1)="ISDN"
    NetSpeedText(2)="Cable/ADSL"
    NetSpeedText(3)="LAN/T1"



    PanelCaption="Game"
}
