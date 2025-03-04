//=============================================================================
// ROTab_Hud
//=============================================================================
// The hud config tab
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Mathieu Mallet
//=============================================================================

class ROTab_Hud extends UT2K4Tab_HudSettings;

var automated moCheckBox	ch_ShowCompass, ch_ShowMapUpdatedText, ch_ShowMapFirstSpawn, ch_UseNativeRoleNames;
var automated moComboBox    co_Hints;

var bool bShowCompass, bShowMapUpdatedText, bShowMapOnFirstSpawn, bShowMapOnFirstSpawnD, bUseNativeRoleNames, bUseNativeRoleNamesD;
var int HintLevel, HintLevelD; // 0 = all hints, 1 = new hints, 2 = no hints

var localized array<string>        Hints;

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
    local int i;

	super(Settings_Tabs).InitComponent(MyController, MyOwner);

    RemoveComponent(co_CustomHUD);
	RemoveComponent(ch_Score);
	RemoveComponent(ch_EnemyNames);
	RemoveComponent(sl_Red);
	RemoveComponent(sl_Blue);
	RemoveComponent(sl_Green);
	RemoveComponent(i_Preview);
	RemoveComponent(i_PreviewBG);
	RemoveComponent(i_Scale);
	RemoveComponent(ch_CustomColor);
	RemoveComponent(ch_WeaponBar);
	RemoveComponent(ch_DeathMsgs);
	RemoveComponent(b_CustomHUD);
	//RemoveComponent(ch_Portraits);
	//RemoveComponent(ch_VCPortraits);

	i_BG2.ManageComponent(ch_Visible);
    i_BG2.ManageComponent(sl_Opacity);
    i_BG2.ManageComponent(sl_Scale);

    i_BG1.ManageComponent(co_Hints);
    i_BG1.ManageComponent(ch_Weapons);
    i_BG1.ManageComponent(ch_Personal);
    //i_BG1.ManageComponent(ch_Portraits);
    //i_BG1.ManageComponent(ch_VCPortraits);
    i_BG2.ManageComponent(nu_MsgCount);
    i_BG2.ManageComponent(nu_MsgScale);
    i_BG2.ManageComponent(nu_MsgOffset);

    i_BG1.ManageComponent(ch_ShowCompass);
    i_BG1.ManageComponent(ch_ShowMapUpdatedText);
    i_BG1.ManageComponent(ch_ShowMapFirstSpawn);
    i_BG1.ManageComponent(ch_UseNativeRoleNames);

    sl_Opacity.MySlider.bDrawPercentSign = True;
    sl_Scale.MySlider.bDrawPercentSign = True;

	for (i = 0; i < Hints.Length; i++)
	    co_Hints.AddItem(Hints[i]);
	co_Hints.ReadOnly(true);
}

function InternalOnLoadINI(GUIComponent Sender, string s)
{
	local ROHud H;

	H = ROHud(PlayerOwner().myHUD);
	switch (Sender)
	{
        case ch_UseNativeRoleNames:
    	    if (ROPlayer(PlayerOwner()) != none)
    	    {
				bUseNativeRoleNames = ROPlayer(PlayerOwner()).bUseNativeRoleNames;
    	    }
    	    else
    	    {
				bUseNativeRoleNames = class'ROPlayer'.default.bUseNativeRoleNames;
    	    }
            bUseNativeRoleNamesD=bUseNativeRoleNames;
            ch_UseNativeRoleNames.SetComponentValue(bUseNativeRoleNames,true);
            break;

        case ch_ShowMapFirstSpawn:
    	    if (ROPlayer(PlayerOwner()) != none)
    	    {
				bShowMapOnFirstSpawn = ROPlayer(PlayerOwner()).bShowMapOnFirstSpawn;
    	    }
    	    else
    	    {
				bShowMapOnFirstSpawn = class'ROPlayer'.default.bShowMapOnFirstSpawn;
    	    }
            bShowMapOnFirstSpawnD=bShowMapOnFirstSpawn;
            ch_ShowMapFirstSpawn.SetComponentValue(bShowMapOnFirstSpawn,true);
            break;

        case ch_ShowCompass:
            if (H != none)
                bShowCompass = H.bShowCompass;
            ch_ShowCompass.SetComponentValue(bShowCompass,true);
            break;

    	case ch_ShowMapUpdatedText:
    		if (H != none)
                bShowMapUpdatedText = H.bShowMapUpdatedText;
    		ch_ShowMapUpdatedText.SetComponentValue(bShowMapUpdatedText,true);
    		break;

        case sl_Opacity:
            fOpacity = (PlayerOwner().myHUD.HudOpacity / 255) * 100;
	        sl_Opacity.SetValue(fOpacity);
            break;

    	case sl_Scale:
    		fScale = PlayerOwner().myHUD.HudScale * 100;
    		sl_Scale.SetValue(fScale);
    		break;

    	case co_Hints:
    	    if (ROPlayer(PlayerOwner()) != none)
    	    {
    	        if (ROPlayer(PlayerOwner()).bShowHints)
    	            HintLevel = 1;
    	        else
    	            HintLevel = 2;
    	    }
    	    else
    	    {
    	        if (class'ROPlayer'.default.bShowHints)
    	            HintLevel = 1;
    	        else
    	            HintLevel = 2;
    	    }
    	    HintLevelD = HintLevel;
    	    co_Hints.SilentSetIndex(HintLevel);
    	    break;

    	default:
    	    super.InternalOnLoadINI(sender, s);
	}
}

function SaveSettings()
{
	local PlayerController PC;
	local ROHud H;
	local bool bSave;

	Super.SaveSettings();

	PC = PlayerOwner();
	H = ROHud(PC.myHUD);

	if ( bUseNativeRoleNamesD != bUseNativeRoleNames )
	{
        if (ROPlayer(PC) != none)
        {
            ROPlayer(PC).bUseNativeRoleNames = bUseNativeRoleNames;
            ROPlayer(PC).SaveConfig();
        }
        else
        {
            class'ROPlayer'.default.bUseNativeRoleNames = bUseNativeRoleNames;
            class'ROPlayer'.static.StaticSaveConfig();
        }
	}

	if ( bShowMapOnFirstSpawnD != bShowMapOnFirstSpawn )
	{
        if (ROPlayer(PC) != none)
        {
            ROPlayer(PC).bShowMapOnFirstSpawn = bShowMapOnFirstSpawn;
            ROPlayer(PC).SaveConfig();
        }
        else
        {
            class'ROPlayer'.default.bShowMapOnFirstSpawn = bShowMapOnFirstSpawn;
            class'ROPlayer'.static.StaticSaveConfig();
        }
	}

	if (H == none)
	   return;

	if ( H.bShowCompass != bShowCompass )
	{
		H.bShowCompass = bShowCompass;
		bSave = True;
	}

	if ( H.bShowMapUpdatedText != bShowMapUpdatedText )
	{
		H.bShowMapUpdatedText = bShowMapUpdatedText;
		bSave = True;
	}

	if ( HintLevelD != HintLevel )
	{
	    if (HintLevel == 0)
	    {
	        if (ROPlayer(PC) != none)
	        {
	            ROPlayer(PC).bShowHints = true;
                ROPlayer(PC).UpdateHintManagement(true);
                if (ROPlayer(PC).HintManager != none)
	                ROPlayer(PC).HintManager.NonStaticReset();
                ROPlayer(PC).SaveConfig();
	        }
	        else
	        {
	            class'ROHintManager'.static.StaticReset();
	            class'ROPlayer'.default.bShowHints = true;
	            class'ROPlayer'.static.StaticSaveConfig();
	        }
	    }
	    else
	    {
	        if (ROPlayer(PC) != none)
	        {
	            ROPlayer(PC).bShowHints = (HintLevel == 1);
	            ROPlayer(PC).UpdateHintManagement(HintLevel == 1);
	            ROPlayer(PC).SaveConfig();
	        }
	        else
	        {
	            class'ROPlayer'.default.bShowHints = (HintLevel == 1);
	            class'ROPlayer'.static.StaticSaveConfig();
	        }
	    }
	}

	if ( bSave )
    	H.SaveConfig();
}

function InternalOnChange(GUIComponent Sender)
{
	Super.InternalOnChange(Sender);

	switch (Sender)
	{
    	case ch_UseNativeRoleNames:
    		bUseNativeRoleNames = ch_UseNativeRoleNames.IsChecked();
    		break;

    	case ch_ShowMapFirstSpawn:
    		bShowMapOnFirstSpawn = ch_ShowMapFirstSpawn.IsChecked();
    		break;

    	case ch_ShowCompass:
    		bShowCompass = ch_ShowCompass.IsChecked();
    		break;

    	case ch_ShowMapUpdatedText:
    		bShowMapUpdatedText = ch_ShowMapUpdatedText.IsChecked();
    		break;

    	case co_Hints:
    	    HintLevel = co_Hints.GetIndex();
    	    break;
    }
}

DefaultProperties
{
    Begin Object class=GUISectionBackground Name=GameBK
		WinWidth=0.448633
		WinHeight=0.499740
		WinLeft=0.521367
		WinTop=0.180360
        RenderWeight=0.001
		Caption="Options"
	End Object
	i_BG1=GameBK

	Begin Object class=GUISectionBackground Name=GameBK1
    	WinWidth=0.448633
		WinHeight=0.502806
		WinLeft=0.030000
		WinTop=0.179222
        Caption="Style"
        RenderWeight=0.001
	End Object
	i_BG2=GameBK1

	Begin Object class=moSlider Name=myGameHudOpacity
		WinWidth=0.450000
		WinLeft=0.018164
		WinTop=0.070522
		Caption="HUD Opacity"
		LabelJustification=TXTA_Left
		ComponentJustification=TXTA_Right
		CaptionWidth=0.5
		ComponentWidth=-1
		bAutoSizeCaption=True
		MinValue=51
		MaxValue=100
		OnLoadINI=InternalOnLoadINI
		OnChange=InternalOnChange
		INIOption="@Internal"
		INIDefault="0.5"
		Hint="Adjust the transparency of the HUD"
		TabOrder=21
	End Object
	sl_Opacity=myGameHudOpacity

	Begin Object class=moSlider Name=myHudScale
		WinWidth=0.450000
		WinLeft=0.018164
		WinTop=0.070522
		MinValue=50
		MaxValue=100
		Caption="HUD Scaling"
		LabelJustification=TXTA_Left
		ComponentJustification=TXTA_Right
		CaptionWidth=0.5
		ComponentWidth=-1
		bAutoSizeCaption=True
		OnLoadINI=InternalOnLoadINI
		OnChange=InternalOnChange
		INIOption="@Internal"
		INIDefault="0.5"
		Hint="Adjust the size of the items on the HUD"
		TabOrder=22
	End Object
	sl_Scale=myHudScale

	Begin Object class=moCheckBox Name=ShowCompass
		WinWidth=0.373749
		WinLeft=0.555313
		WinTop=0.481406
		Caption="Show Compass"
		INIOption="@Internal"
		OnLoadINI=InternalOnLoadINI
		OnChange=InternalOnChange
		Hint="Display direction compass on the HUD."
		CaptionWidth=0.9
		bSquare=true
		ComponentJustification=TXTA_Left
		bAutoSizeCaption=True
		TabOrder=23
	End Object
	ch_ShowCompass=ShowCompass

	Begin Object class=moCheckBox Name=ShowMapFirstSpawn
		WinWidth=0.373749
		WinLeft=0.555313
		WinTop=0.481406
		Caption="Show Map On Initial Spawn"
		INIOption="@Internal"
		OnLoadINI=InternalOnLoadINI
		OnChange=InternalOnChange
		Hint="Display the overhead map for the first spawn each level."
		CaptionWidth=0.9
		bSquare=true
		ComponentJustification=TXTA_Left
		bAutoSizeCaption=True
		TabOrder=24
	End Object
	ch_ShowMapFirstSpawn=ShowMapFirstSpawn

	Begin Object class=moCheckBox Name=UseNativeRoleNames
		WinWidth=0.373749
		WinHeight=0.034156
		WinLeft=0.555313
		WinTop=0.822959
		Caption="Use Native Role Names"
		INIOption="@Internal"
		OnLoadINI=InternalOnLoadINI
		OnChange=InternalOnChange
		Hint="Use non-translated role names in the menus and HUD."
		CaptionWidth=0.9
		bSquare=true
		ComponentJustification=TXTA_Left
		bAutoSizeCaption=True
		TabOrder=25
	End Object
	ch_UseNativeRoleNames=UseNativeRoleNames

	Begin Object class=moCheckBox Name=ShowMapUpdateText
		WinWidth=0.373749
		WinLeft=0.555313
		WinTop=0.481406
		Caption="Show 'Map Updated' Text"
		INIOption="@Internal"
		OnLoadINI=InternalOnLoadINI
		OnChange=InternalOnChange
		Hint="Show the 'Map Updated' text hint on the HUD."
		CaptionWidth=0.9
		bSquare=true
		ComponentJustification=TXTA_Left
		bAutoSizeCaption=True
		TabOrder=26
	End Object
	ch_ShowMapUpdatedText=ShowMapUpdateText

	Begin Object Class=moComboBox Name=HintsCombo
	    Caption="Hint Level"
	    ComponentJustification=TXTA_Left
	    Hint="Selects whether hints should be shown or not."
		WinWidth=0.401953
		WinLeft=0.547773
		WinTop=0.335021
		CaptionWidth=0.55
	    TabOrder=0
	    bBoundToParent=True
	    bScaleToParent=True
	    OnLoadINI=InternalOnLoadINI
	    OnChange=InternalOnChange
	    IniOption="@Internal"
	End Object
	co_Hints=HintsCombo

	Hints(0)="All Hints (Reset)"
	Hints(1)="New Hints Only"
	Hints(2)="No Hints"
}
