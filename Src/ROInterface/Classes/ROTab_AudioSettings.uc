//=============================================================================
// ROTab_AudioSettings
//=============================================================================
// The audio config tab
// This contains alot of code duplicated from UT2K4Tab_AudioSettings and
// VoiceChatConfig
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Mathieu Mallet
//=============================================================================

class ROTab_AudioSettings extends Settings_Tabs;

var localized string	AudioModes[4],
						VoiceModes[3];


var automated GUISectionBackground	i_BG1, i_BG2, i_BG3;
var automated moSlider		sl_MusicVol, sl_EffectsVol, sl_VOIP;
var automated moComboBox	co_Mode, co_Voices, co_Announce;
var automated moCheckbox 	ch_ReverseStereo, ch_MessageBeep, ch_DisableGameMusic, ch_LowDetail, ch_Default, ch_VoiceChat;

//var automated moCheckBox    ch_AJPublic, ch_AJLocal, ch_AJTeam, ch_AutoSpeak, ch_Dampen;
var automated moCheckBox    ch_AJPublic, ch_AutoSpeak, ch_Dampen;
var automated moEditBox     ed_Active;
var automated moEditBox     ed_ChatPassword;
var automated moComboBox    co_Quality, co_LANQuality;

var float	fMusic, fEffects, fVOIP;
var int		iVoice, iMode, iVoiceMode;
var bool	bRev, bBeep, bDisableGameMusic, bLow, bCompat, b3DSound, bEAX, bDefault, bVoiceChat, bDampen;

//var bool bAJPublic, bAJLocal, bAJTeam, bAutoSpeak;
var bool bAJPublic, bAutoSpeak;
var string  sPwd, sCodec, sLANCodec, sActive;
var float fVoice;

var class<VoiceChatReplicationInfo> VoiceChatClass;
var string VoiceChatClassName;

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
	local int i;
    local bool bIsWin32;
   	local string CName, CDesc;
	local class<VoiceChatReplicationInfo> Cls;
	local array<string>    InstalledCodecs;

	bIsWin32 = ( ( PlatformIsWindows() ) && ( !PlatformIs64Bit() ) );

	Super.InitComponent(MyController, MyOwner);

	if ( bIsWin32 )
	{
		for(i = 0;i < ArrayCount(AudioModes);i++)
			co_Mode.AddItem(AudioModes[i]);
	}
	else
	{
		co_Mode.AddItem("OpenAL");
	}

	for(i = 0;i < ArrayCount(VoiceModes);i++)
		co_Voices.AddItem(VoiceModes[i]);

	// Need to load TeamVoiceReplicationInfo to get team channel names
	Cls = class<VoiceChatReplicationInfo>( DynamicLoadObject( VoiceChatClassName, class'Class') );
	if ( Cls != None )
		VoiceChatClass = Cls;

	VoiceChatClass.static.GetInstalledCodecs( InstalledCodecs );
	for ( i = 0; i < InstalledCodecs.Length; i++ )
	{
		VoiceChatClass.static.GetCodecInfo( InstalledCodecs[i], CName, CDesc );
		co_Quality.AddItem( CName,, InstalledCodecs[i] );
		co_LANQuality.AddItem( CName,, InstalledCodecs[i] );
	}

    ed_ChatPassword.MaskText(True);


	i_BG1.ManageComponent(sl_MusicVol);
	i_BG1.ManageComponent(ch_DisableGameMusic);
	i_BG1.ManageComponent(sl_EffectsVol);
	i_BG1.ManageComponent(sl_VOIP);
	i_BG1.ManageComponent(co_Mode);
	i_BG1.ManageComponent(ch_LowDetail);
	i_BG1.ManageComponent(ch_Default);
	i_BG1.ManageComponent(ch_reverseStereo);
	i_BG1.ManageComponent(co_Voices);
	i_BG1.ManageComponent(ch_MessageBeep);

	i_BG3.ManageComponent(ch_VoiceChat);
	i_BG3.ManageComponent(ch_Dampen);
	i_BG3.ManageComponent(ch_AJPublic);
	//i_BG3.ManageComponent(ch_AJLocal);
	//i_BG3.ManageComponent(ch_AJTeam);
	i_BG3.ManageComponent(ch_AutoSpeak);
	i_BG3.ManageComponent(ed_Active);
	i_BG3.ManageComponent(ed_ChatPassword);
	i_BG3.ManageComponent(co_Quality);
	i_BG3.ManageComponent(co_LANQuality);


	// !!! FIXME: Might use a preinstalled system OpenAL in the future on
	// !!! FIXME:  Mac or Unix, but for now, we don't...  --ryan.
	if ( !PlatformIsWindows() )
		ch_Default.DisableMe();
}

function ResetClicked()
{
	local class<AudioSubSystem> A;
	local PlayerController PC;
	local int i;

	Super.ResetClicked();

	PC = PlayerOwner();

	A = class<AudioSubSystem>(DynamicLoadObject(GetNativeClassName("Engine.Engine.AudioDevice"), Class'Class'));
	A.static.ResetConfig();

	class'Hud'.static.ResetConfig("bMessageBeep");
	class'LevelInfo'.static.ResetConfig("bLowSoundDetail");

	class'PlayerController'.static.ResetConfig("bNoVoiceTaunts");
	class'PlayerController'.static.ResetConfig("bNoVoiceMessages");

	A.static.ResetConfig("VoiceVolume");

	class'Engine.PlayerController'.static.ResetConfig("VoiceChatCodec");
	class'Engine.PlayerController'.static.ResetConfig("VoiceChatLANCodec");
    class'Engine.PlayerController'.static.ResetConfig("AutoJoinMask");
    class'Engine.PlayerController'.static.ResetConfig("ChatPassword");
    class'Engine.PlayerController'.static.ResetConfig("DefaultActiveChannel");
    class'Engine.PlayerController'.static.ResetConfig("bEnableInitialChatRoom");
    class'ROPlayer'.static.ResetConfig("bEnableMusicInGame");

	for (i = 0; i < Components.Length; i++)
		Components[i].LoadINI();
}

function InternalOnLoadINI(GUIComponent Sender, string s)
{
	local PlayerController PC;
	local bool bIsWin32;

	PC = PlayerOwner();

	switch (Sender)
	{
    	case sl_MusicVol:
    		fMusic = float(PC.ConsoleCommand("get ini:Engine.Engine.AudioDevice MusicVolume"));
    		sl_MusicVol.SetComponentValue(fMusic,true);
    		break;

    	case ch_DisableGameMusic:
            if (ROPlayer(PC) != none)
                bDisableGameMusic = ROPlayer(PC).bDisableMusicInGame;
            else
                bDisableGameMusic = class'ROPlayer'.default.bDisableMusicInGame;
    		ch_DisableGameMusic.SetComponentValue(bDisableGameMusic,true);
            break;

    	case sl_EffectsVol:
    		fEffects = float(PC.ConsoleCommand("get ini:Engine.Engine.AudioDevice SoundVolume"));
    		sl_EffectsVol.SetComponentValue(fEffects,true);
    		break;

    	case co_Mode:
    		iMode = 1;
    		bIsWin32 = ( ( PlatformIsWindows() ) && ( !PlatformIs64Bit() ) );
    		if ( !bIsWin32 )
    		{
    			bCompat = False;
    			b3DSound = True;
    			iMode = 0;
    		}
    		else
    		{
    			if ( bool(PC.ConsoleCommand("get ini:Engine.Engine.AudioDevice CompatibilityMode")) )
    			{
    				bCompat = True;
    				iMode = 0;
    			}

    			if ( bool(PC.ConsoleCommand("get ini:Engine.Engine.AudioDevice Use3DSound")) )
    			{
    				b3DSound = True;
    				iMode = 2;
    			}

    			if ( bool(PC.ConsoleCommand("get ini:Engine.Engine.AudioDevice UseEAX" )) )
    			{
    				bEAX = True;
    				iMode = 3;
    			}
    		}
    		co_Mode.SilentSetIndex(iMode);
    		break;

    	case ch_ReverseStereo:
    		bRev = bool(PC.ConsoleCommand("get ini:Engine.Engine.AudioDevice ReverseStereo"));
    		ch_ReverseStereo.SetComponentValue(bRev,true);
    		break;

    	case ch_Default:
    		bDefault = bool(PC.ConsoleCommand("get ini:Engine.Engine.AudioDevice UseDefaultDriver"));
    		ch_Default.SetComponentValue(bDefault,true);
    		break;

    	case co_Voices:
    		if ( PC.bNoAutoTaunts ) iVoiceMode = 1;
    		if ( PC.bNoVoiceTaunts ) iVoiceMode = 1;
    		if ( PC.bNoVoiceMessages ) iVoiceMode = 2;
    		co_Voices.SilentSetIndex(iVoiceMode);
    		break;

    	case ch_MessageBeep:
    		bBeep = class'HUD'.default.bMessageBeep;
    		ch_MessageBeep.SetComponentValue(bBeep,true);
    		break;

    	case ch_LowDetail:
    		bLow = PC.Level.bLowSoundDetail;

    		// Make sure both are the same - LevelInfo.bLowSoundDetail take priority
    		if ( bLow != bool(PC.ConsoleCommand("get ini:Engine.Engine.AudioDevice LowQualitySound" )) )
    		{
    			PC.ConsoleCommand("set ini:Engine.Engine.AudioDevice LowQualitySound"@bLow);
    			PC.ConsoleCommand("SOUND_REBOOT");

    			// Restart music.
    			if( PC.Level.Song != "" && PC.Level.Song != "None" )
    				PC.ClientSetMusic( PC.Level.Song, MTRAN_Instant );

    			else PC.ClientSetMusic( class'ROMainMenu'.default.MenuSong, MTRAN_Instant );
    		}

    		ch_LowDetail.SetComponentValue(bLow,true);
    		break;

    	case ch_VoiceChat:
    		bVoiceChat = bool(PC.ConsoleCommand("get ini:Engine.Engine.AudioDevice UseVoIP"));
    		ch_VoiceChat.SetComponentValue(bVoiceChat,true);
    		UpdateVOIPControlsState();
    		break;


        case ed_ChatPassword:
            sPwd = PC.ChatPassword;
            ed_ChatPassword.SetComponentValue(sPwd, True);
            break;

        case sl_VOIP:
        	fVoice = float(PC.ConsoleCommand("get ini:Engine.Engine.AudioDevice VoiceVolume"));
        	sl_VOIP.SetComponentValue(fVoice, True);
        	break;

    	case co_Quality:
    		sCodec = PC.VoiceChatCodec;
    		co_Quality.SetExtra(sCodec,true);
    		break;

    	case co_LANQuality:
    		sLANCodec = PC.VoiceChatLANCodec;
    		co_LANQuality.SetExtra(sLANCodec,true);
    		break;

    	case ch_Dampen:
    	    bDampen = bool(PC.ConsoleCommand("get ini:Engine.Engine.AudioDevice DampenWithVoIP"));
    	    ch_Dampen.SetComponentValue(bDampen,true);
    	    break;

    	case ch_AJPublic:
    		bAJPublic = bool(PC.AutoJoinMask & 1);
    		ch_AJPublic.SetComponentValue(bAJPublic,True);
    		break;

    	/*case ch_AJLocal:
    		bAJLocal = bool(PC.AutoJoinMask & 2);
    		ch_AJLocal.SetComponentValue(bAJLocal,True);
    		break;

    	case ch_AJTeam:
    		bAJTeam = bool(PC.AutoJoinMask & 4);
    		ch_AJTeam.SetComponentValue(bAJTeam,True);
    		break;*/

    	case ch_AutoSpeak:
    		bAutoSpeak = PC.bEnableInitialChatRoom;
    		if ( bAutoSpeak )
    			EnableComponent(ed_Active);
    		else DisableComponent(ed_Active);

    		ch_AutoSpeak.SetComponentValue(bAutoSpeak, True);
    		break;

    	case ed_Active:
    		sActive = PC.DefaultActiveChannel;
    		ed_Active.SetComponentValue(sActive, True);
    		break;


    	default:
    		log(Name@"Unknown component calling LoadINI:"$ GUIMenuOption(Sender).Caption);
    		GUIMenuOption(Sender).SetComponentValue(s,true);
	}
}

function InternalOnChange(GUIComponent Sender)
{
	local PlayerController PC;
	local bool bIsWin32;

	bIsWin32 = ( ( PlatformIsWindows() ) && ( !PlatformIs64Bit() ) );

	Super.InternalOnChange(Sender);
	PC = PlayerOwner();

	switch(Sender)
	{
		case sl_MusicVol:
			fMusic = sl_MusicVol.GetValue();
			PC.ConsoleCommand("set ini:Engine.Engine.AudioDevice MusicVolume"@fMusic);
			PC.ConsoleCommand("SetMusicVolume"@fMusic);

			if( PC.Level.Song != "" && PC.Level.Song != "None" )
				PC.ClientSetMusic( PC.Level.Song, MTRAN_Instant );
			else PC.ClientSetMusic( class'ROMainMenu'.default.MenuSong, MTRAN_Instant );
			break;

		case ch_DisableGameMusic:
			bDisableGameMusic = ch_DisableGameMusic.IsChecked();
		    break;

		case sl_EffectsVol:
			fEffects = sl_EffectsVol.GetValue();
			PC.ConsoleCommand("set ini:Engine.Engine.AudioDevice SoundVolume"@fEffects);
			PC.ConsoleCommand("stopsounds");
			// ifndef _RO_
			//PC.PlaySound(sound'PickupSounds.AdrenelinPickup');
			break;

		case co_Mode:
			if ( !bIsWin32 )  // Simple OpenAL abstraction...  --ryan.
				break;

			iMode = co_Mode.GetIndex();
			if (iMode > 1)
				ShowPerformanceWarning();

			bCompat = iMode < 1;
			b3DSound = iMode > 1;
			bEAX = iMode > 2;
	        PC.ConsoleCommand("set ini:Engine.Engine.AudioDevice CompatibilityMode"@bCompat);
	        PC.ConsoleCommand("set ini:Engine.Engine.AudioDevice Use3DSound"@b3DSound);
	        PC.ConsoleCommand("set ini:Engine.Engine.AudioDevice UseEAX"@bEAX);
			PC.ConsoleCommand("SOUND_REBOOT");

			// Restart music.
			if( PC.Level.Song != "" && PC.Level.Song != "None" )
				PC.ClientSetMusic( PC.Level.Song, MTRAN_Instant );
			else PC.ClientSetMusic( class'ROMainMenu'.default.MenuSong, MTRAN_Instant );
			break;

		case ch_ReverseStereo:
			bRev = ch_ReverseStereo.IsChecked();
			break;

		case ch_MessageBeep:
			bBeep = ch_MessageBeep.IsChecked();
			break;

		case co_Voices:
			iVoiceMode = co_Voices.GetIndex();
			break;

		case ch_Default:
			bDefault = ch_Default.IsChecked();
			PC.ConsoleCommand("set ini:Engine.Engine.AudioDevice UseDefaultDriver"@bDefault);
			PC.ConsoleCommand("SOUND_REBOOT");
			break;

		case ch_LowDetail:
			bLow = ch_LowDetail.IsChecked();

			PC.Level.bLowSoundDetail = bLow;
			//PC.Level.StaticSaveConfig();
			PC.Level.SaveConfig();

			PC.ConsoleCommand("set ini:Engine.Engine.AudioDevice LowQualitySound"@bLow);
			PC.ConsoleCommand("SOUND_REBOOT");

			// Restart music.
			if( PC.Level.Song != "" && PC.Level.Song != "None" )
				PC.ClientSetMusic( PC.Level.Song, MTRAN_Instant );
			else PC.ClientSetMusic( class'ROMainMenu'.default.MenuSong, MTRAN_Instant );
			break;

		case ch_VoiceChat:
			bVoiceChat = ch_VoiceChat.IsChecked();
			UpdateVOIPControlsState();
			break;

        case ch_Dampen:
            bDampen = ch_Dampen.IsChecked();
            break;

        case ed_ChatPassword:
            sPwd = ed_ChatPassword.GetText();
            break;

        case sl_VOIP:
        	fVoice = sl_VOIP.GetValue();
        	break;

		case co_Quality:
			sCodec = co_Quality.GetExtra();
			break;

		case co_LANQuality:
			sLANCodec = co_LANQuality.GetExtra();
			break;

		case ch_AJPublic:
			bAJPublic = ch_AJPublic.IsChecked();
			break;

		/*case ch_AJLocal:
			bAJLocal = ch_AJLocal.IsChecked();
			break;

		case ch_AJTeam:
			bAJTeam = ch_AJTeam.IsChecked();
			break;*/

		case ch_AutoSpeak:
			bAutoSpeak = ch_AutoSpeak.IsChecked();
			if ( bAutoSpeak )
				EnableComponent(ed_Active);
			else DisableComponent(ed_Active);
			break;

		case ed_Active:
			sActive = ed_Active.GetText();
			break;

	}
}

function SaveSettings()
{
	local PlayerController PC;
	local bool bSave, bReboot;

	Super.SaveSettings();
	PC = PlayerOwner();

	if (PC.bNoAutoTaunts != iVoiceMode > 0)
	{
		PC.bNoAutoTaunts = iVoiceMode > 0;
		PC.default.bNoAutoTaunts = PC.bNoAutoTaunts;
		bSave = True;
	}

	if (PC.bNoVoiceTaunts != iVoiceMode > 0)
	{
		PC.bNoVoiceTaunts = iVoiceMode > 0;
		PC.default.bNoVoiceTaunts = PC.bNoVoiceTaunts;
		bSave = True;
	}

	if (PC.bNoVoiceMessages != iVoiceMode == 2)
	{
		PC.bNoVoiceMessages = iVoiceMode == 2;
		PC.default.bNoVoiceMessages = PC.bNoVoiceMessages;
		bSave = True;
	}

	if (fMusic != sl_MusicVol.GetValue())
		PC.ConsoleCommand("set ini:Engine.Engine.AudioDevice MusicVolume"@fMusic);

	if (ROPlayer(PC) != none)
	{
        if (ROPlayer(PC).bDisableMusicInGame != bDisableGameMusic)
        {
            ROPlayer(PC).bDisableMusicInGame = bDisableGameMusic;
	        bSave = true;

            //If they are on the menu, leave the music playing
            if ( PC.Level.ZoneTag != 'ROEntry')
            {
                if ( bDisableGameMusic )
                {
                    //Stop any playing music
                    PC.StopAllMusic();
                }
                else
                {
    			    // Restart level's music, if it exists
    			    if( PC.Level.Song != "" && PC.Level.Song != "None" )
    				    PC.ClientSetMusic( PC.Level.Song, MTRAN_Instant );
                }
            }
        }
	}
	else
	{
	    if (class'ROPlayer'.default.bDisableMusicInGame != bDisableGameMusic)
        {
            class'ROPlayer'.default.bDisableMusicInGame = bDisableGameMusic;
	        class'ROPlayer'.static.StaticSaveConfig();

            //If they are on the menu, leave the music playing
            if ( PC.Level.ZoneTag != 'ROEntry')
            {
                if ( bDisableGameMusic )
                {
                    //Stop any playing music
                    PC.StopAllMusic();
                }
                else
                {
    			    // Restart level's music, if it exists
    			    if( PC.Level.Song != "" && PC.Level.Song != "None" )
    				    PC.ClientSetMusic( PC.Level.Song, MTRAN_Instant );
                }
            }
        }
	}

	if (fEffects != sl_EffectsVol.GetValue())
		PC.ConsoleCommand("set ini:Engine.Engine.AudioDevice SoundVolume"@fEffects);

	if (bool(PC.ConsoleCommand("get ini:Engine.Engine.AudioDevice ReverseStereo")) != bRev)
		PC.ConsoleCommand("set ini:Engine.Engine.AudioDevice ReverseStereo"@bRev);

	if (bool(PC.ConsoleCommand("get ini:Engine.Engine.AudioDevice DampenWithVoIP")) != bDampen)
		PC.ConsoleCommand("set ini:Engine.Engine.AudioDevice DampenWithVoIP"@bDampen);

	if (bDefault != bool(PC.ConsoleCommand("get ini:Engine.Engine.AudioDevice UseDefaultDriver")))
	{
		PC.ConsoleCommand("set ini:Engine.Engine.AudioDevice UseDefaultDriver"@bDefault);
		bReboot = True;
	}

	if( PC.MyHud != None )
	{
		if ( PC.myHUD.bMessageBeep != bBeep )
		{
			PC.myHUD.bMessageBeep = bBeep;
			PC.myHUD.SaveConfig();
		}
	}

	else
	{
		if ( class'HUD'.default.bMessageBeep != bBeep )
		{
			class'HUD'.default.bMessageBeep = bBeep;
			class'HUD'.static.StaticSaveConfig();
		}
	}

	if ( bAJPublic != bool(PC.AutoJoinMask & 1) )
	{
		if ( bAJPublic )
			PC.AutoJoinMask = PC.AutoJoinMask | 1;
		else PC.AutoJoinMask = PC.AutoJoinMask & ~1;
		bSave = True;
	}

	/*if ( bAJLocal != bool(PC.AutoJoinMask & 2) )
	{
		if ( bAJLocal )
			PC.AutoJoinMask = PC.AutoJoinMask | 2;
		else PC.AutoJoinMask = PC.AutoJoinMask & ~2;
		bSave = True;
	}

	if ( bAJTeam != bool(PC.AutoJoinMask & 4) )
	{
		if ( bAJTeam )
			PC.AutoJoinMask = PC.AutoJoinMask | 4;
		else PC.AutoJoinMask = PC.AutoJoinMask & ~4;
		bSave = True;
	}*/

    if ( fVoice != float(PC.ConsoleCommand("get ini:Engine.Engine.AudioDevice VoiceVolume")) )
    	PC.ConsoleCommand("set ini:Engine.Engine.AudioDevice VoiceVolume"@fVoice);

    if ( sCodec != PC.VoiceChatCodec )
    {
    	PC.VoiceChatCodec = sCodec;
    	bSave = True;
    }

    if ( sLANCodec != PC.VoiceChatLANCodec )
    {
    	PC.VoiceChatLANCodec = sLANCodec;
    	bSave = True;
    }

    if ( PC.bEnableInitialChatRoom != bAutoSpeak )
    {
    	PC.bEnableInitialChatRoom = bAutoSpeak;
    	bSave = True;
    }

	if ( !(PC.DefaultActiveChannel ~= sActive) )
	{
		PC.DefaultActiveChannel = sActive;
		bSave = True;
	}

    if (PC.ChatPassword != sPwd)
    {
        PC.SetChatPassword(sPwd);
        bSave = False;
    }

    if (bVoiceChat != bool(PC.ConsoleCommand("get ini:Engine.Engine.AudioDevice UseVoIP")))
	{
		if (bVoiceChat)
			PC.EnableVoiceChat();
		else
            PC.DisableVoiceChat();

		bReboot = False;
	}

	if (bSave)
		PC.SaveConfig();

	if (bReboot)
		PC.ConsoleCommand("SOUND_REBOOT");
}

function UpdateVOIPControlsState()
{
    if (bVoiceChat)
    {
        //ch_AJLocal.EnableMe();
        sl_VOIP.EnableMe();
        //ch_AJLocal.EnableMe();
        ch_AJPublic.EnableMe();
        //ch_AJTeam.EnableMe();
        ed_Active.EnableMe();
        ed_ChatPassword.EnableMe();
        co_Quality.EnableMe();
        co_LANQuality.EnableMe();
        ch_AutoSpeak.EnableMe();
    }
    else
    {
        //ch_AJLocal.DisableMe();
        sl_VOIP.DisableMe();
        //ch_AJLocal.DisableMe();
        ch_AJPublic.DisableMe();
        //ch_AJTeam.DisableMe();
        ed_Active.DisableMe();
        ed_ChatPassword.DisableMe();
        co_Quality.DisableMe();
        co_LANQuality.DisableMe();
        ch_AutoSpeak.DisableMe();
    }
}

defaultproperties
{
	Begin Object class=GUISectionBackground Name=AudioBK1
		WinWidth=0.485000
		WinHeight=0.7
		WinLeft=0.000948
		WinTop=0.1
		Caption="Sound System"
	End Object
	i_BG1=AudioBK1

	Begin Object class=GUISectionBackground Name=AudioBK3
		WinWidth=0.502751
		WinHeight=0.633059
		WinLeft=0.495826
		WinTop=0.1
		Caption="Voice Chat"
	End Object
	i_BG3=AudioBK3

	Begin Object class=moSlider Name=AudioEffectsVolumeSlider
		WinWidth=0.450000
		WinLeft=0.524024
		WinTop=0.070522
		MinValue=0.0
		MaxValue=1.0
		Caption="Effects Volume"
		Hint="Adjusts the volume of all in game sound effects."
		LabelJustification=TXTA_Left
		ComponentJustification=TXTA_Right
		CaptionWidth=0.5
		ComponentWidth=-1
		bAutoSizeCaption=True
		OnLoadINI=InternalOnLoadINI
		OnChange=InternalOnChange
		INIOption="@Internal"
		INIDefault="0.9"
		TabOrder=1
	End Object
	sl_EffectsVol=AudioEffectsVolumeSlider

	Begin Object class=moSlider Name=AudioMusicVolume
		WinWidth=0.450000
		WinLeft=0.018164
		WinTop=0.070522
		Caption="Music Volume"
		LabelJustification=TXTA_Left
		ComponentJustification=TXTA_Right
		CaptionWidth=0.5
		ComponentWidth=-1
		bAutoSizeCaption=True
		MinValue=0.0
		MaxValue=1.0
		OnLoadINI=InternalOnLoadINI
		OnChange=InternalOnChange
		INIOption="@Internal"
		INIDefault="0.5"
		Hint="Adjusts the volume of the background music."
		TabOrder=2
	End Object
	sl_MusicVol=AudioMusicVolume

	Begin Object Class=moSlider Name=VoiceVolume
		WinWidth=0.408907
		WinLeft=0.518507
		WinTop=0.142484
    	Caption="Voice Chat Volume"
    	Hint="Adjusts the volume of other players' voice chat communication."
    	IniOption="@Internal"
    	OnLoadINI=InternalOnLoadINI
    	OnChange=InternalOnChange
    	RenderWeight=1.04
	    TabOrder=3
	    MinValue=1.0
	    MaxValue=10.0
		CaptionWidth=0.5
		ComponentWidth=-1
		bAutoSizeCaption=True
    	ComponentJustification=TXTA_Right
    	LabelJustification=TXTA_Left
    End Object
    sl_VOIP=VoiceVolume

	Begin Object class=moComboBox Name=AudioMode
		WinWidth=0.450000
		WinLeft=0.018164
		WinTop=0.149739
		Caption="Audio Mode"
		INIOption="@Internal"
		INIDefault="Software 3D Audio"
		OnLoadINI=InternalOnLoadINI
		OnChange=InternalOnChange
		Hint="Changes the audio system mode."
		CaptionWidth=0.5
		LabelJustification=TXTA_Left
		ComponentJustification=TXTA_Right
		bReadOnly=true
		TabOrder=4
	End Object
	co_Mode=AudioMode

	Begin Object class=moCheckBox Name=AudioLowDetail
		WinWidth=0.45
		WinLeft=0.018164
		WinTop=0.235052
		Caption="Low Sound Detail"
		INIOption="@Internal"
		INIDefault="False"
		OnLoadINI=InternalOnLoadINI
		OnChange=InternalOnChange
		Hint="Lowers quality of sound."
		CaptionWidth=0.94
		bSquare=true
		ComponentJustification=TXTA_Left
		TabOrder=5
	End Object
	ch_LowDetail=AudioLowDetail

	Begin Object class=moCheckBox Name=AudioDefaultDriver
		WinWidth=0.45
		WinLeft=0.018164
		WinTop=0.320365
		Caption="System Driver"
		Hint="Use system installed OpenAL driver"
		INIOption="@Internal"
		INIDefault="False"
		OnLoadINI=InternalOnLoadINI
		OnChange=InternalOnChange
		CaptionWidth=0.94
		ComponentJustification=TXTA_Left
		TabOrder=6
	End Object
	ch_Default=AudioDefaultDriver

	Begin Object class=moCheckBox Name=AudioReverseStereo
		WinWidth=0.45
		WinLeft=0.018164
		WinTop=0.405678
		Caption="Reverse Stereo"
		Hint="Reverses the left and right audio channels."
		INIOption="@Internal"
		INIDefault="False"
		OnLoadINI=InternalOnLoadINI
		OnChange=InternalOnChange
		CaptionWidth=0.94
		ComponentJustification=TXTA_Left
		TabOrder=7
	End Object
	ch_ReverseStereo=AudioReverseStereo

	Begin Object class=moComboBox Name=AudioPlayVoices
		WinWidth=0.45
		WinLeft=0.524024
		WinTop=0.149739
		Caption="Play Voice Messages"
		Hint="Defines the types of voice messages to play."
		INIOption="@Internal"
		INIDefault="All"
		OnLoadINI=InternalOnLoadINI
		OnChange=InternalOnChange
		CaptionWidth=0.5
		LabelJustification=TXTA_Left
		ComponentJustification=TXTA_Right
		bReadOnly=true
		TabOrder=8
		bHeightFromComponent=False
	End Object
	co_Voices=AudioPlayVoices

	Begin Object class=moCheckBox Name=AudioMessageBeep
		WinWidth=0.45
		WinLeft=0.524024
		WinTop=0.405678
		Caption="Message Beep"
		Hint="Enables a beep when receiving a text message from other players."
		INIOption="@Internal"
		INIDefault="True"
		OnLoadINI=InternalOnLoadINI
		OnChange=InternalOnChange
		CaptionWidth=0.94
		bSquare=true
		ComponentJustification=TXTA_Left
		TabOrder=9
	End Object
	ch_MessageBeep=AudioMessageBeep

	Begin Object class=moCheckBox Name=DisableGameMusic
		WinWidth=0.45
		WinLeft=0.018164
		WinTop=0.235052
		Caption="Disable Music During Gameplay"
		INIOption="@Internal"
		INIDefault="False"
		OnLoadINI=InternalOnLoadINI
		OnChange=InternalOnChange
		Hint="Turns off background music during gameplay."
		CaptionWidth=0.94
		bSquare=true
		ComponentJustification=TXTA_Left
		TabOrder=10
	End Object
	ch_DisableGameMusic=DisableGameMusic

	Begin Object class=moCheckBox Name=EnableVoiceChat
		WinWidth=0.461134
		WinLeft=0.527734
		WinTop=0.834777
		INIOption="@Internal"
		OnLoadINI=InternalOnLoadINI
		OnChange=InternalOnChange
		Hint="Enables the voice chat system during online matches."
		Caption="Enable Voice Chat"
		CaptionWidth=-1
		bSquare=true
		TabOrder=20
		ComponentJustification=TXTA_Right
	End Object
	ch_VoiceChat=EnableVoiceChat


    Begin Object Class=moCheckBox Name=Dampen
		WinWidth=0.826652
		WinLeft=0.086280
		WinTop=0.145784
    	Caption="Dampen Game Volume When Using VOIP"
    	Hint="Dampens the volume of the game when receiving VOIP communications."
    	IniOption="@Internal"
    	OnLoadINI=InternalOnLoadIni
    	OnChange=InternalOnChange
    	bSquare=True
    	ComponentJustification=TXTA_Right
    	LabelJustification=TXTA_Left
    	ComponentWidth=-1
    	CaptionWidth=0.94
    	TabOrder=21
   End Object
    ch_Dampen=Dampen

    Begin Object Class=moCheckBox Name=AutoJoinPublic
		WinWidth=0.826652
		WinLeft=0.086280
		WinTop=0.145784
    	Caption="Autojoin Public Channel"
    	Hint="Automatically join the 'Public' channel upon connecting to a server."
    	IniOption="@Internal"
    	OnLoadINI=InternalOnLoadIni
    	OnChange=InternalOnChange
    	bSquare=True
    	ComponentJustification=TXTA_Right
    	LabelJustification=TXTA_Left
    	ComponentWidth=-1
    	CaptionWidth=0.94
    	TabOrder=23
   End Object
    ch_AJPublic=AutoJoinPublic

//    Begin Object Class=moCheckBox Name=AutoJoinLocal
//		WinWidth=0.826652
//		WinLeft=0.086280
//		WinTop=0.145784
//    	Caption="Autojoin Local Channel"
//    	Hint="Automatically join the 'Local' channel upon connecting to a server."
//    	IniOption="@Internal"
//    	OnLoadINI=InternalOnLoadIni
//    	OnChange=InternalOnChange
//    	bSquare=True
//    	ComponentJustification=TXTA_Right
//    	LabelJustification=TXTA_Left
//    	ComponentWidth=-1
//    	CaptionWidth=0.94
//    	TabOrder=23
//   End Object
//    ch_AJLocal=AutoJoinLocal
//
//    Begin Object Class=moCheckBox Name=AutoJoinTeam
//		WinWidth=0.440910
//		WinLeft=0.022803
//		WinTop=0.226937
//    	Caption="Autojoin Team Channel"
//    	Hint="Automatically join the 'Team' channel upon connecting to a server."
//    	IniOption="@Internal"
//    	OnLoadINI=InternalOnLoadIni
//    	OnChange=InternalOnChange
//    	bSquare=True
//    	ComponentJustification=TXTA_Right
//    	LabelJustification=TXTA_Left
//    	ComponentWidth=-1
//    	CaptionWidth=0.8
//    	TabOrder=24
//   End Object
//    ch_AJTeam=AutoJoinTeam

    Begin Object Class=moCheckBox Name=AutoSpeakCheckbox
		WinWidth=0.442638
		WinHeight=0.060000
		WinLeft=0.039812
		WinTop=0.603526
    	Caption="Auto-select Active Channel"
    	Hint="Automatically set an active channel when you join a server.  The default channel is determined by the gametype, but you can specify your own using the editbox below"
    	IniOption="@Internal"
    	OnLoadINI=InternalOnLoadIni
    	OnChange=InternalOnChange
    	bSquare=True
    	ComponentJustification=TXTA_Right
    	LabelJustification=TXTA_Left
    	ComponentWidth=-1
    	CaptionWidth=0.8
    	TabOrder=24
		bBoundToParent=True
		bScaleToParent=True
    End Object
    ch_AutoSpeak=AutoSpeakCheckbox

        Begin Object Class=moEditBox Name=DefaultActiveChannelEditBox
		WinWidth=0.420403
		WinLeft=0.032569
		WinTop=0.757277
        Hint="Enter the name of the channel to speak on by default when you join the server.  To use the default chatroom for whichever gametype you're playing, leave this field empty"
        Caption="Default Channel Name"
        IniOption="@Internal"
        OnLoadIni=InternalOnLoadIni
        OnChange=InternalOnChange
        ComponentJustification=TXTA_Right
        LabelJustification=TXTA_Left
    	CaptionWidth=0.6
    	ComponentWidth=-1
        TabOrder=25
	End Object
    ed_Active=DefaultActiveChannelEditBox

    Begin Object Class=moEditBox Name=ChatPasswordEdit
		WinWidth=0.420403
		WinLeft=0.032569
		WinTop=0.332828
        Hint="Set a password on your personal chat room to limit who is allowed to join"
        Caption="Chat Password"
        IniOption="@Internal"
        OnLoadIni=InternalOnLoadIni
        OnChange=InternalOnChange
        ComponentJustification=TXTA_Right
        LabelJustification=TXTA_Left
    	CaptionWidth=0.6
    	ComponentWidth=-1
    	bAutoSizeCaption=True
        TabOrder=26
    End Object
    ed_ChatPassword=ChatPasswordEdit

    Begin Object class=moComboBox Name=VoiceQuality
		WinWidth=0.408907
		WinLeft=0.523390
		WinTop=0.241391
    	Caption="Internet Quality"
    	Hint="Determines the codec used to transmit voice chat to and from internet servers."
    	IniOption="@Internal"
    	OnLoadINI=InternalOnLoadINI
    	OnChange=InternalOnChange
    	TabOrder=27
    	bReadOnly=True
    	CaptionWidth=0.6
    	ComponentWidth=-1
    	bAutoSizeCaption=True
        ComponentJustification=TXTA_Right
       LabelJustification=TXTA_Left
    End Object
    co_Quality=VoiceQuality

    Begin Object class=moComboBox Name=VoiceQualityLAN
		WinWidth=0.408907
		WinLeft=0.523390
		WinTop=0.333786
    	Caption="LAN Quality"
    	Hint="Determines the codec used to transmit voice chat to and from LAN servers."
    	IniOption="@Internal"
    	OnLoadINI=InternalOnLoadINI
    	OnChange=InternalOnChange
    	TabOrder=28
    	bReadOnly=True
    	CaptionWidth=0.6
    	ComponentWidth=-1
    	bAutoSizeCaption=True
        ComponentJustification=TXTA_Right
        LabelJustification=TXTA_Left
    End Object
    co_LANQuality=VoiceQualityLAN

	VoiceChatClassName="UnrealGame.TeamVoiceReplicationInfo"
	VoiceChatClass=class'Engine.VoiceChatReplicationInfo'


	WinTop=0.15
	WinLeft=0
	WinWidth=1
	WinHeight=0.74
	bAcceptsInput=false

	AudioModes[0]="Safe Mode"
	AudioModes[1]="3D Audio"
	AudioModes[2]="H/W 3D Audio"
	AudioModes[3]="H/W 3D + EAX"

	VoiceModes[0]="All"
	//VoiceModes[1]="No auto-taunts"
	VoiceModes[1]="No taunts"
	VoiceModes[2]="None"

	PanelCaption="Audio"
}

