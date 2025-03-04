//=============================================================================
// ROTeamSayDeadMessage
//=============================================================================
// New messages
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2003-2004 Erik Christensen
//=============================================================================

class ROTeamSayDeadMessage extends ROStringMessage;

//=============================================================================
// Variables
//=============================================================================

var	Color			GermanColor;
var	Color			RussianColor;

var	localized	string	MessagePrefix;

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
	local string LocationName;

	if (RelatedPRI_1 == None)
		return;

	if (RelatedPRI_1.Team.TeamIndex == 1)
		Canvas.SetDrawColor(192,64,64,255); //DrawColor = default.RussianColor;
	else
		Canvas.SetDrawColor(64,128,128,255); //DrawColor = default.GermanColor;

	Canvas.DrawText(default.MessagePrefix$RelatedPRI_1.PlayerName$" ", false);
	Canvas.SetPos(Canvas.CurX, Canvas.CurY - YL);
	LocationName = RelatedPRI_1.GetLocationName();

	if (LocationName != "")
		Canvas.DrawText("("$LocationName$"):", false);
	else
		Canvas.DrawText(": ", false);

	Canvas.SetPos( Canvas.CurX, Canvas.CurY - YL );
	Canvas.SetDrawColor(255,255,255,255); //DrawColor = default.DrawColor;
	Canvas.DrawText( MessageString, False );
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
	local string LocationName;

	if (RelatedPRI_1 == None)
		return "";
	LocationName = RelatedPRI_1.GetLocationName();
	if ( LocationName == "" )
		return default.MessagePrefix$RelatedPRI_1.PlayerName@":"@MessageString;
	else
		return default.MessagePrefix$RelatedPRI_1.PlayerName$" ("$LocationName$"): "$MessageString;
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
	GermanColor=(R=162,G=227,B=130,A=255)// (R=64,G=128,B=128,A=255)
	RussianColor=(R=251,G=41,B=4,A=255)// (R=192,G=64,B=64,A=255
	MessagePrefix="(DEAD) *PLATOON* "
}
