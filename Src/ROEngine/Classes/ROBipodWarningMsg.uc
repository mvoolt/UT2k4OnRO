//-----------------------------------------------------------
//
//-----------------------------------------------------------
class ROBipodWarningMsg extends ROCriticalMessage;

var(Messages) localized string DeployToFire;
var(Messages) localized string DeployToReload;

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
        return default.DeployToFire;
    case 1:
        return default.DeployToReload;
    default:
	    return default.DeployToReload;
	}
}

DefaultProperties
{
     DeployToFire = "You must be deployed to fire your weapon!";
     DeployToReload = "You must be deployed to reload your weapon!";

     iconID=11
     altIconID=11
     errorIconID=11
}
