class GUIQuestionPage extends GUIPage;

var GUILabel lMessage;
var Material MessageIcon;	// Like Warning/Question/Exclamation
var localized array<string> ButtonNames; // Buttons Names: Ok, Cancel, Retry, Continue, Yes, No, Abort, Ignore.  Clamped [0,7].
var array<GUIButton> Buttons;
var GUIButton DefaultButton, CancelButton;

delegate OnButtonClick(byte bButton);
delegate bool NewOnButtonClick(byte bButton) { return true; }

function InitComponent(GUIController pMyController, GUIComponent MyOwner)
{
	Super.Initcomponent(pMyController, MyOwner);
	lMessage=GUILabel(Controls[1]);
	ParentPage.InactiveFadeColor=class'Canvas'.static.MakeColor(128,128,128,255);
}

function bool InternalOnPreDraw(Canvas C)
{
local float XL, YL;
local int i;
local array<string> MsgArray;

	// Organize the layout for the Label and the Buttons Top
	if (lMessage.TextFont != "")
		C.Font = Controller.GetMenuFont(lMessage.TextFont).GetFont(C.SizeX);

	C.TextSize("W", XL, YL);
	C.WrapStringToArray(lMessage.Caption, MsgArray, lMessage.ActualWidth(), "|");

	YL *= MsgArray.Length;

	if (lMessage.Style != None)
		YL += lMessage.Style.BorderOffsets[1] + lMessage.Style.BorderOffsets[3];

	// transform YL to a %
	lMessage.WinHeight =  (YL +1 )/ C.SizeY;
	WinHeight = (YL + Buttons[0].ActualHeight() + 60) / C.SizeY ;
	WinTop = (C.SizeY - ActualHeight())/2;
	lMessage.WinTop = WinTop + 20;
	for (i = 0; i<Buttons.Length; i++)
	{
		Buttons[i].WinTop = WinTop + 40 + YL;
	}
	OnPreDraw=None;
	return false;
}

function SetupQuestion(string Question, coerce byte bButtons, optional byte ActiveButton, optional bool bClearFirst )
{
	if ( lMessage != None )
		lMessage.Caption = Question;

	if ( bClearFirst )
		RemoveButtons();

	// Create Buttons Based on Buttons parameter
	AddButton(bButtons & QBTN_Yes);
	AddButton(bButtons & QBTN_No);
	AddButton(bButtons & QBTN_Ok);
	AddButton(bButtons & QBTN_Abort);
	AddButton(bButtons & QBTN_Retry);
	AddButton(bButtons & QBTN_Continue);
	CancelButton = AddButton(bButtons & QBTN_Cancel);
	AddButton(bButtons & QBTN_Ignore);
/*
	if ( bool(bButtons & QBTN_Abort) )
		AddButton(6);
	if ( bool(bButtons & QBTN_Retry) )
		AddButton(2);

	if ( bool(bButtons & QBTN_Cancel) )
		CancelButton = AddButton(1);

	if ( bool(bButtons & QBTN_Continue) )
		AddButton(3);
	if ( bool(bButtons & QBTN_Ignore) )
		AddButton(7);
	if ( bool(bButtons & QBTN_Ok) )
		AddButton(0);
	if ( bool(bButtons & QBTN_Yes) )
		AddButton(4);
	if ( bool(bButtons & QBTN_No) )
		AddButton(5);
*/
	LayoutButtons(ActiveButton);
}

function GUIButton AddButton(coerce byte idesc)
{
	local GUIButton btn;
	local byte mask;
	local int cnt;

	if ( idesc == 0 )
		return None;

	mask = 1;
	while ( !bool(mask & idesc) )
	{
		cnt++;
		mask = mask << 1;
	}

	if ( cnt >= ButtonNames.Length )
	{
		log("GUIQuestionPage.AddButton() button mask was larger than button name array!");
		return None;
	}

	btn = GUIButton(AddComponent("XInterface.GUIButton"));
	if ( btn == None )
		return None;

	btn.Tag = idesc;
	btn.TabOrder = Components.Length;
	btn.Caption = ButtonNames[cnt];
	btn.OnClick = ButtonClick;

	Buttons[Buttons.Length] = btn;
	return btn;
}

function LayoutButtons(byte ActiveButton)
{
local int i;
local float left, colw, btnw;

	// Simply center the button(s)
	colw = 1/(Buttons.Length + 1);
	btnw = colw * 0.66;
	left = colw - btnw/2;

	for (i = 0; i<Buttons.Length; i++)
	{
		Buttons[i].WinLeft = left;
		Buttons[i].WinWidth = btnw;
		Buttons[i].WinHeight = 0.042773;
		Buttons[i].WinTop = 0.6;
		left += colw;

		if ( bool(Buttons[i].Tag & ActiveButton) )
			Buttons[i].SetFocus(None);
	}
}

function bool ButtonClick(GUIComponent Sender)
{
local int T;
local GUIController C;

	C = Controller;
	T = GUIButton(Sender).Tag;

	ParentPage.InactiveFadeColor=ParentPage.Default.InactiveFadeColor;
	OnButtonClick(T);

	if ( NewOnButtonClick(T) )
		C.CloseMenu( bool(T & (QBTN_Cancel|QBTN_Abort)) );

	return true;
}

function string Replace(string Src, string Tag, string Value)
{
	if ( Left(Tag,1) != "%" )
		Tag = "%" $ Tag;
	if ( Right(Tag,1) != "%" )
		Tag $= "%";

	return Repl(Src,Tag,Value);
}

function RemoveButtons()
{
	local int i;

	for ( i = 0; i < Buttons.Length; i++ )
		RemoveComponent(Buttons[i], True);

	if ( Buttons.Length > 0 )
		Buttons.Remove(0,Buttons.Length);

	RemapComponents();
}

defaultproperties
{
	OnPreDraw=InternalOnPreDraw

	Begin Object Class=GUIImage Name=imgBack
		Image=Texture'InterfaceArt_tex.Menu.changeme_texture' //Material'InterfaceContent.Menu.SquareBoxA'
		ImageStyle=ISTY_Stretched
		WinTop=0.0
		WinLeft0.0
		WinHeight=1.0
		WinWidth=1.0
		bScaleToParent=true
		bBoundToParent=true
	End Object

	Begin Object Class=GUILabel Name=lblQuestion
		WinTop=0.2
		WinLeft=0.1
		WinHeight=0.4
		WinWidth=0.8
		bMultiLine=true
	End Object
	Controls(0)=imgBack
	Controls(1)=lblQuestion

	bCaptureInput=True
	bRequire640x480=False
	bRenderWorld=True

	WinTop=0.25
	WinHeight=0.5
	BackgroundColor=(R=64,G=64,B=64,A=255)
	BackgroundRStyle=MSTY_Alpha

	ButtonNames(0)="Ok"
	ButtonNames(1)="Cancel"
	ButtonNames(2)="Retry"
	ButtonNames(3)="Continue"
	ButtonNames(4)="Yes"
	ButtonNames(5)="No"
	ButtonNames(6)="Abort"
	ButtonNames(7)="Ignore"
	// if add more buttonnames, make sure to expand size of array declaration
}
