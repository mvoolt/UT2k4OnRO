//=============================================================================
// ROTouchMessagePlus.
// started by Antarian on 8/20/03
//
// Copyright (C) 2003 Jeffrey Nakai
//
// Class for displaying Red Orchestra Pickup Touch Messages
//=============================================================================

class ROTouchMessagePlus extends LocalMessage;

static simulated function ClientReceive(
	PlayerController P,
	optional int Switch,
	optional PlayerReplicationInfo RelatedPRI_1,
	optional PlayerReplicationInfo RelatedPRI_2,
	optional Object OptionalObject
	)
{
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
	bFadeMessage=false
	bIsUnique=True
	bIsConsoleMessage = false

	DrawColor=(R=255,G=255,B=255,A=255)
	FontSize=0
	Lifetime=0.25//2.5

    PosY=0.80
}
