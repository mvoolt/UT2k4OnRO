//=============================================================================
// SatchelCharge10lb10sWeapon
//=============================================================================
// Weapon class for the 10 pund 10 second fuse SatchelCharge
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class SatchelCharge10lb10sWeapon extends ROSatchelChargeWeapon;

#exec OBJ LOAD FILE=..\Animations\Common_Satchel_1st.ukx

defaultproperties
{
	//** Info **//
    ItemName="10 lb Satchel Charge"

	//** Display **//
    Mesh=mesh'Common_Satchel_1st.Sachel_Charge'
    DrawScale=1.0
    DisplayFOV=70
    BobDamping=1.6
    PlayerViewOffset=(X=10,Y=5,Z=0)

    //** Weapon Firing **//
    FireModeClass(0)=SatchelCharge10lb10sFire
    FireModeClass(1)=SatchelCharge10lb10sFire
    FuzeLength=10.0

	//** Weapon Functionality **//
	bCanRestDeploy=false
	bHasReleaseLever=false

	//** Inventory/Ammo **//
    PickupClass=class'SatchelCharge10lb10sPickup'
    AttachmentClass=class'SatchelCharge10lb10sAttachment'

	//** Animation **//
	// Rates
	SelectAnimRate=1.0
    PutDownAnimRate=1.0
	// Draw/Put Away
	SelectAnim=Draw
	PutDownAnim=Put_Away
	// Crawling
	CrawlForwardAnim=crawlF
	CrawlBackwardAnim=crawlB
	CrawlStartAnim=crawl_in
	CrawlEndAnim=crawl_out
	// Firing
	PreFireHoldAnim=Weapon_Down

	//** Bot/AI **//
	AIRating=+0.4
    CurrentRating=0.4
    bSniping=false // So bots will use this weapon to take long range shots

 	//** Misc **//
 	SelectForce="SwitchToAssaultRifle"
}
