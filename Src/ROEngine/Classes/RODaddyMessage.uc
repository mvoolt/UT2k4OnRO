//=============================================================================
// RODaddyMessage
// started by Antarian on 12/9/03
//
// Copyright (C) 2003 Jeffrey Nakai
//
// Easter Egg fun
//=============================================================================

class RODaddyMessage extends LocalMessage;

var localized string	DaddyMessage;


static function string GetString(
	optional int Switch,
	optional PlayerReplicationInfo RelatedPRI_1,
	optional PlayerReplicationInfo RelatedPRI_2,
	optional Object OptionalObject
	)
{
	switch(Switch)
	{
		default:
			return default.DaddyMessage;
	}
}

defaultproperties
{
	bFadeMessage=false
	bIsUnique=True
	bIsConsoleMessage = false

	DaddyMessage="Antarian Is Your Daddy!"

	DrawColor=(R=255,G=0,B=0,A=255)
	FontSize=2
	Lifetime=4

    PosX=0.5
    PosY=0.5
}
