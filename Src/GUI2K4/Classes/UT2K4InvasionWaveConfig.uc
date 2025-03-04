//==============================================================================
//	Created on: 09/17/2003
//	Custom page to handle configuration of the Waves property in SkaarjPack.Invasion
//
//  This is an example of how to write a GUIPage to handle a PlayInfo struct.
//
//	Written by Ron Prestenback
//	� 2003, Epic Games, Inc.  All Rights Reserved
// TODO: Override l_Title ondraw  in order to have custom background color
//==============================================================================
class UT2K4InvasionWaveConfig extends GUICustomPropertyPage;

var string PropName;
var string PropValue;

var array<string> Waves;

var automated GUIImage              i_Background;
var automated moNumericEdit         nu_Wave;
var automated GUIMultiOptionListBox lb_Waves;
var GUIMultiOptionList              li_waves;

var localized string WaveText, DiffHint, DurationHint, MaxInvaderHint,AIHint;

// Local copy of wave info
struct WaveInfo
{
	var int     WaveMask;
	var byte	WaveMaxMonsters;
	var byte	WaveDuration;
	var float	WaveDifficulty;
};

struct WaveMonster
{
	var localized string MName;
	var int Mask;
};

var int ActiveWave;	// Wave currently being edited
var WaveInfo WaveCopy[16];
var WaveMonster WaveMonsters[16];

var moSlider sl_Diff;
var moNumericEdit nu_Duration;
var moNumericEdit nu_MaxMonster;

function string GetResult()
{
	return PropValue;
}

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
	local int i;
	local class<GameInfo> InvClass;

	Super.InitComponent(MyController, MyOwner);

	InvClass = class<GameInfo>(DynamicLoadObject("SkaarjPack.Invasion", class'Class'));

	li_Waves = lb_Waves.List;
	li_Waves.OnChange = InternalOnChange;
	li_Waves.bDrawSelectionBorder = False;
    li_Waves.ItemPadding=0.15;
    li_Waves.ColumnWidth=0.95;
    li_Waves.bHotTrackSound = False;

	sl_Diff       = moSlider(li_Waves.AddItem(           "XInterface.moSlider", None, InvClass.static.GetDisplayText("WaveDifficulty"),  true ));
	nu_Duration   = moNumericEdit(li_Waves.AddItem( "XInterface.moNumericEdit", None, InvClass.static.GetDisplayText("WaveDuration"),    true ));
	nu_MaxMonster = moNumericEdit(li_Waves.AddItem( "XInterface.moNumericEdit", None, InvClass.static.GetDisplayText("WaveMaxMonsters"), true ));

	sl_Diff.Hint = DiffHint;
	nu_Duration.Hint=DurationHint;
	nu_MaxMonster.Hint=MaxInvaderHint;


	for ( i = 0; i < li_Waves.NumColumns; i++ )
		li_Waves.AddItem( "XInterface.GUIListSpacer" );

	sb_Main.ManageComponent(lb_Waves);
	sb_Main.LeftPadding=0;
	sb_Main.RightPadding=0;
	sb_Main.TopPadding=0.05;
	sb_Main.BottomPadding=0.05;
	sb_Main.SetPosition(0.030234,0.075000,0.851640,0.565624);

	InitWaveControls();
}

function InitWaveControls()
{
	InitDifficulty();
	InitDuration();
	InitMaxMonsters();
}

function InitDifficulty()
{
	sl_Diff.Setup( 0.0, 3.0 );
	sl_Diff.CaptionWidth = 0.1;
	sl_Diff.ComponentWidth = -1;
	sl_Diff.bAutoSizeCaption = true;
	sl_Diff.ComponentJustification = TXTA_Left;
}

function InitDuration()
{
	nu_Duration.Setup( 1, 255, 1 );
	nu_Duration.CaptionWidth = 0.1;
	nu_Duration.ComponentWidth = 0.3;
	nu_Duration.bAutoSizeCaption = true;
	nu_Duration.ComponentJustification = TXTA_Center;
}

function InitMaxMonsters()
{
	nu_MaxMonster.Setup( 1, 24, 1 );
	nu_MaxMonster.CaptionWidth = 0.1;
	nu_MaxMonster.ComponentWidth = 0.3;
	nu_MaxMonster.bAutoSizeCaption = true;
	nu_MaxMonster.ComponentJustification = TXTA_Center;
}

function SetOwner( GUIComponent NewOwner )
{
	Super.SetOwner(NewOwner);

	PropName = Item.DisplayName;
	PropValue = Mid(Item.Value,2,Len(Item.Value) - 4);
	t_WindowTitle.Caption = PropName;

	DisassembleWaveString();
	InitializeList();
}

function AssembleWaveString()
{
	local int i;

	PropValue = "((";
	for ( i = 0; i < ArrayCount(WaveCopy); i++ )
	{
		if ( i > 0 )
			PropValue $= "),(";

		PropValue $= "WaveMask="         $ WaveCopy[i].WaveMask;
		PropValue $= ",WaveMaxMonsters=" $ WaveCopy[i].WaveMaxMonsters;
		PropValue $= ",WaveDuration="    $ WaveCopy[i].WaveDuration;
		PropValue $= ",WaveDifficulty="  $ WaveCopy[i].WaveDifficulty;
	}
	PropValue $= "))";
}

function DisassembleWaveString()
{
	local int i;

	// Remove extra () and ""
	Split(PropValue, "),(", Waves);

	for ( i = 0; i < Waves.Length && i < ArrayCount(WaveCopy); i++ )
	{
		WaveCopy[i].WaveMask =          int(ParseOption(Waves[i], ",", "WaveMask"));
		WaveCopy[i].WaveMaxMonsters =  byte(ParseOption(Waves[i], ",", "WaveMaxMonsters"));
		WaveCopy[i].WaveDuration =     byte(ParseOption(Waves[i], ",", "WaveDuration"));
		WaveCopy[i].WaveDifficulty =  float(ParseOption(Waves[i], ",", "WaveDifficulty"));
	}
}

function InitializeList()
{
	local int i;
	local moCheckBox ch;

	for ( i = 0; i < ArrayCount(WaveCopy); i++ )
	{
		ch = moCheckbox(li_Waves.AddItem( "XInterface.moCheckbox",, WaveMonsters[i].MName ));
		if ( ch != None )
		{
			ch.Tag = WaveMonsters[i].Mask;
			ch.bAutoSizeCaption = True;
		}
	}

	UpdateWaveValues();
}

function string GetDataString()
{
	return PropValue;
}

event Closed( GUIComponent Sender, bool bCancelled )
{
	if ( !bCancelled )
		AssembleWaveString();
	else PropValue = "((" $ PropValue $ "))";

	Super.Closed(Sender, bCancelled);
}

function InternalOnChange(GUIComponent Sender)
{
	local GUIMenuOption mo;

	if ( Sender == nu_Wave )
	{
		ActiveWave = nu_Wave.GetValue();
		UpdateWaveValues();
	}

	else if ( Sender == li_Waves )
	{
		mo = li_Waves.Get();

		if ( mo == sl_Diff )
			WaveCopy[ActiveWave].WaveDifficulty = sl_Diff.GetValue();

		else if ( mo == nu_Duration )
			WaveCopy[ActiveWave].WaveDuration = nu_Duration.GetValue();

		else if ( mo == nu_MaxMonster )
			WaveCopy[ActiveWave].WaveMaxMonsters = nu_MaxMonster.GetValue();

		if ( moCheckBox(mo) != None )
		{
			if ( moCheckbox(mo).IsChecked() )
				WaveCopy[ActiveWave].WaveMask = WaveCopy[ActiveWave].WaveMask | mo.Tag;
			else WaveCopy[ActiveWave].WaveMask = WaveCopy[ActiveWave].WaveMask & ~mo.Tag;
		}
	}
}

// Called when the active wave has been changed - updates all components with the correct values
function UpdateWaveValues()
{
	local moCheckbox ch;
	local int i;

	sl_Diff.SetComponentValue( WaveCopy[ActiveWave].WaveDifficulty, true );
	nu_Duration.SetComponentValue( WaveCopy[ActiveWave].WaveDuration, True );
	nu_MaxMonster.SetComponentValue( WaveCopy[ActiveWave].WaveMaxMonsters, True );

	for ( i = 3; i < li_Waves.Elements.Length; i++ )
	{
		ch = moCheckBox(li_Waves.Elements[i]);
		if ( ch == None )
			continue;

		ch.SetComponentValue( WaveCopy[ActiveWave].WaveMask & ch.Tag, True );
	}
}

DefaultProperties
{
	Begin Object Class=moNumericEdit Name=WaveNumber
		Caption="Wave No."
		Hint="Select the wave you'd like to configure"
		WinWidth=0.220000
		WinHeight=0.042857
		WinLeft=0.407353
		WinTop=0.092990
		MinValue=0
		MaxValue=15
		CaptionWidth=0.1
		ComponentWidth=0.3
		bAutoSizeCaption=true
		ComponentJustification=TXTA_Center
		OnChange=InternalOnChange
		RenderWeight=0.7
		bBoundToParent=True
		bScaleToParent=True
	End Object
	nu_Wave=WaveNumber

	Begin Object Class=GUIMultiOptionListBox Name=WavesList
		NumColumns=3
        OnChange=InternalOnChange
		WinWidth=0.983750
		WinHeight=0.698149
		WinLeft=0.007500
		WinTop=0.150608
        TabOrder=1
        bVisibleWhenEmpty=True
        bBoundToParent=True
        bScaleToParent=True
//        StyleName="ServerBrowserGrid"
	End Object
	lb_Waves=WavesList

	WaveMonsters(0)=(MName="Pupae",Mask=1)
	WaveMonsters(1)=(MName="Razor Fly",Mask=2)
	WaveMonsters(2)=(MName="Manta",Mask=4)
	WaveMonsters(3)=(MName="Krall",Mask=8)
	WaveMonsters(4)=(MName="Elite Krall",Mask=16)
	WaveMonsters(5)=(MName="Gasbag",Mask=32)
	WaveMonsters(6)=(MName="Brute",Mask=64)
	WaveMonsters(7)=(MName="Skaarj",Mask=128)
	WaveMonsters(8)=(MName="Behemoth",Mask=256)
	WaveMonsters(9)=(MName="Ice Skaarj",Mask=512)
	WaveMonsters(10)=(MName="Fire Skaarj",Mask=1024)
	WaveMonsters(11)=(MName="Warlord",Mask=2048)
	WaveMonsters(12)=(MName="Pupae",Mask=4096)
	WaveMonsters(13)=(MName="Pupae",Mask=8192)
	WaveMonsters(14)=(MName="Razor Fly",Mask=16384)
	WaveMonsters(15)=(MName="Razor Fly",Mask=32768)

	bDrawFocusedLast=False

	WinWidth=0.9
	WinHeight=0.7
	WinLeft=0.05
	WinTop=0.15


	DefaultWidth=0.9
	DefaultHeight=0.7
	DefaultLeft=0.05
	DefaultTop=0.15

	DiffHint="How hard should this wave be."
	DurationHint="How long should this wave last."
	MaxInvaderHint="What is the maximum number of monsters to spawn for this wave."
	AIHint="Allow/Disallow this monster"
}
