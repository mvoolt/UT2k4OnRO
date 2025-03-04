//==============================================================================
// AHZ_VehicleMessage
//
// Red Orchestra Source - William Miller
// Copyright (C) 2007 Tripwire Interactive, LLC
//
// Message class for tanks with passengers.
//==============================================================================

class AHZ_VehicleMessage extends ROVehicleMessage;

//==============================================================================
// Variables
//==============================================================================
var(Messages) localized string CannotRide;
var(Messages) localized string VehicleFull;

//==============================================================================
// Functions
//==============================================================================
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
		case 2:
		     return default.CannotEnter;
        case 3:
             return default.CannotRide;
        default:
             return default.VehicleFull;
    }

}

//==============================================================================
// defaultproperties
//==============================================================================
defaultproperties
{
	CannotRide="Cannot Ride This Vehicle"
	VehicleFull="All Rider Positions are Filled"
}
