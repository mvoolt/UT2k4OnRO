//=============================================================================
// ROVehicleMessage
//=============================================================================
// Vehicle message
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2004 John "Ramm-Jaeger" Gibson
//=============================================================================

class ROVehicleMessage extends LocalMessage;

//=============================================================================
// Variables
//=============================================================================

var(Messages) localized string NotQualified;
var(Messages) localized string VehicleIsEnemy;
var(Messages) localized string CannotEnter;

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
			return default.NotQualified;
		case 1:
			return default.VehicleIsEnemy;
		default:
			return default.CannotEnter;
	}

}

//=============================================================================
// defaultproperties
//=============================================================================

defaultproperties
{
	NotQualified="Not Qualified To Operate This Vehicle"
	VehicleIsEnemy="Cannot Use An Enemy Vehicle"
	CannotEnter="Cannot Enter This Vehicle"
	bBeep=false
	bFadeMessage=true
	bIsUnique=false
	DrawColor=(R=214,G=28,B=36,A=255)
	FontSize=2
	LifeTime=3
	PosX=0.5
	PosY=0.75
}
