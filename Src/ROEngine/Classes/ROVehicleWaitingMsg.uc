//=============================================================================
// ROVehicleWaitingMsg
//=============================================================================
// Wiating for Crew message
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2004 John "Ramm-Jaeger" Gibson
//=============================================================================

class ROVehicleWaitingMsg extends LocalMessage;

//=============================================================================
// Variables
//=============================================================================

var(Messages) localized string WaitingForCrew;

//=============================================================================
// Functions
//=============================================================================

//-----------------------------------------------------------------------------
// GetString
//-----------------------------------------------------------------------------

static function string GetString(
	optional int Switch,
	optional PlayerReplicationInfo RelatedPRI_1,
	optional PlayerReplicationInfo RelatedPRI_2,
	optional Object OptionalObject
	)
{
	switch (Switch)
	{
		case 0:
			return default.WaitingForCrew;
		default:
			return default.WaitingForCrew;
	}

}

//=============================================================================
// defaultproperties
//=============================================================================

defaultproperties
{
	WaitingForCrew="Waiting for Additional Crewmembers"
	bBeep=false
	bFadeMessage=true
	bIsUnique=false
	DrawColor=(R=255,G=255,B=255,A=255)
	FontSize=2
	LifeTime=2
	PosX=0.5
	PosY=0.75
}
