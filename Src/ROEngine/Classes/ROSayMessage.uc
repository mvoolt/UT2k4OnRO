//=============================================================================
// ROSayMessage
//=============================================================================
// New messages
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2003-2004 Erik Christensen
//=============================================================================

class ROSayMessage extends ROStringMessage;

//=============================================================================
// Variables
//=============================================================================

var()	color		GermanColor;
var()	color		RussianColor;

//=============================================================================
// Functions
//=============================================================================

//-----------------------------------------------------------------------------
// RenderComplexMessage
//-----------------------------------------------------------------------------

static function RenderComplexMessage(
	Canvas Canvas,
	out float XL,
	out float YL,
	optional string MessageString,
	optional int Switch,
	optional PlayerReplicationInfo RelatedPRI_1,
	optional PlayerReplicationInfo RelatedPRI_2,
	optional Object OptionalObject
	)
{
	if (RelatedPRI_1 == None)
		return;

	if (RelatedPRI_1.Team.TeamIndex == 1)
		Canvas.DrawColor = default.RussianColor;
	else
		Canvas.DrawColor = default.GermanColor;

	Canvas.DrawText(RelatedPRI_1.PlayerName$": ", false);
	Canvas.SetPos(Canvas.CurX, Canvas.CurY - YL);
	Canvas.DrawColor = default.DrawColor;
	Canvas.DrawText(MessageString, false);
}

//-----------------------------------------------------------------------------
// AssembleString
//-----------------------------------------------------------------------------

static function string AssembleString(
	HUD myHUD,
	optional int Switch,
	optional PlayerReplicationInfo RelatedPRI_1,
	optional String MessageString
	)
{
	if ( RelatedPRI_1 == None )
		return "";
	if ( RelatedPRI_1.PlayerName == "" )
		return "";
	return RelatedPRI_1.PlayerName$": "$MessageString;
}

//-----------------------------------------------------------------------------
// GetConsoleColor
//-----------------------------------------------------------------------------

static function Color GetConsoleColor( PlayerReplicationInfo RelatedPRI_1 )
{
	if ( (RelatedPRI_1 == None) || (RelatedPRI_1.Team == None) )
		return default.DrawColor;

	if (RelatedPRI_1.Team.TeamIndex == 1)
		return default.RussianColor;
	else if (RelatedPRI_1.Team.TeamIndex == 0)
		return default.GermanColor;
	else
		return default.DrawColor;
}

//=============================================================================
// defaultproperties
//=============================================================================

defaultproperties
{
	bBeep=true
	bComplexString=true
	DrawColor=(R=255,G=255,B=255,A=255)
	GermanColor=(R=162,G=227,B=130,A=255)// (R=126,G=239,B=14,A=255)(R=179,G=243,B=255,A=255)(R=64,G=128,B=128,A=255)
	RussianColor=(R=251,G=41,B=4,A=255)// (R=192,G=64,B=64,A=255)
}
