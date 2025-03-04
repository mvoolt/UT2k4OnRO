//=============================================================================
// ROWeaponLost
// started by Puma on 6/17/2004
//
// Copyright (C) 2004 Red Orchestra
//
//=============================================================================

class ROWeaponLostMessage extends ROCriticalMessage;

var localized string	WeaponLostMessage;


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
			return default.WeaponLostMessage;
	}
}

defaultproperties
{
	//bFadeMessage=false
	//bIsUnique=True
	//bIsConsoleMessage = false

	WeaponLostMessage="Weapon Shot Out Of Your Hand!"

	//DrawColor=(R=255,G=0,B=0,A=255)
	//FontSize=2
	//Lifetime=2

    //PosX=0.5
    //PosY=0.85

    iconID=7
}
