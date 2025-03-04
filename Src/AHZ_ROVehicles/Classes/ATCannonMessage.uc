//==============================================================================
// ATCannonMessage
//
// Red Orchestra Source - William Miller
// Copyright (C) 2007 Tripwire Interactive, LLC
//
// Message class for large calibar weapons (guns, howizters, mortars, and turreted pill-boxes)
//==============================================================================
class ATCannonMessage extends ROVehicleMessage;

//==============================================================================
// Variables
//==============================================================================
var(Messages) localized string GunManned;
var(Messages) localized string CannotUse;
var(Messages) localized string NoExit;

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
             return default.GunManned;
        case 4:
			 return default.CannotUse;
        default:
			 return default.NoExit;
    }

}

//==============================================================================
// defaultproperties
//==============================================================================
defaultproperties
{
	GunManned="The Gun Is Fully Crewed"
	CannotUse="Cannot Use This Gun"
	NoExit="No Exit Location Can Not Be Found For This AT-Gun"
}
