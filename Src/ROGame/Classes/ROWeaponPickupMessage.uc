//=====================================================
//ROWeaponPickupMessage
// started by Antarian 8/10/03
//
// Copyright (C) 2003 Jeffrey Nakai
//
// Class to show Red Orchestra Weapon Pickup Messages
// These will be displayed when an actor is touching
// a weapon that is lying on the ground
//=====================================================

class ROWeaponPickupMessage extends LocalMessage;

/*var localized string	GetInMessage;
var localized string	GetOutMessage;
var localized string	TooManyCarsMessage;

static function string GetString(
	optional int Switch,
	optional PlayerReplicationInfo RelatedPRI_1,
	optional PlayerReplicationInfo RelatedPRI_2,
	optional Object OptionalObject
	)
{
	switch(Switch)
	{
	case 0:
		return Default.GetInMessage;
		break;

	case 1:
		return Default.GetOutMessage;
		break;

	case 2:
		return Default.TooManyCarsMessage;
		break;
	}
}      */

defaultproperties
{
	bFadeMessage=false
	bIsSpecial=true
	bIsUnique=true
	bIsConsoleMessage = false
	Lifetime=3
	bBeep=false
    DrawColor=(R=128,G=128,B=255,A=255)

	//GetInMessage="Press [Use] To Enter Vehicle."
	//GetOutMessage="Press [Jump] To Exit Vehicle."
	//TooManyCarsMessage="Too Many Cars Already!"

	StackMode=SM_Down
    PosY=0.10
}
