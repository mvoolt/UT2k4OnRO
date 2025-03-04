//
// OptionalObject is an Pickup class
//
class ROPickupMessagePlus extends PickupMessagePlus;

static simulated function ClientReceive(
	PlayerController P,
	optional int Switch,
	optional PlayerReplicationInfo RelatedPRI_1,
	optional PlayerReplicationInfo RelatedPRI_2,
	optional Object OptionalObject
	)
{
	log("PlayerController P is "$P);
	log("Switch is "$Switch);
	log("PlayerReplicationInfo RelatedPRI_1 is "$RelatedPRI_1 );
	log("PlayerReplicationInfo RelatedPRI_2 is "$RelatedPRI_2 );
	log("Object OptionalObject is "$OptionalObject);
	Super.ClientReceive(P, Switch, RelatedPRI_1, RelatedPRI_2, OptionalObject);
	if ( class<Pickup>(OptionalObject) == None )
		return;

    // jdf ---
    if( P.bEnablePickupForceFeedback )
        P.ClientPlayForceFeedback( class<Pickup>(OptionalObject).default.PickupForce );
    // --- jdf
}

defaultproperties
{
	bIsConsoleMessage=false
	bFadeMessage=True
	bIsUnique=True

	DrawColor=(R=255,G=255,B=255,A=255)
	FontSize=0

    PosY=0.85
}
