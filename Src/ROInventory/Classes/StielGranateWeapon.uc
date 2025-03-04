//=============================================================================
// StielGranateWeapon
//=============================================================================
// Weapon class for the German StG39 Grenade
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class StielGranateWeapon extends ROGrenadeWeapon;

#exec OBJ LOAD FILE=..\Animations\Axis_Granate_1st.ukx

defaultproperties
{
	//** Info **//
    ItemName="StG39 Grenade"

	//** Display **//
    Mesh=mesh'Axis_Granate_1st.German-Grenade-Mesh'
    DrawScale=1.0
    DisplayFOV=70
    BobDamping=1.6
	HighDetailOverlay=Material'Weapons1st_tex.Grenades.stiel_s'
	bUseHighDetailOverlayIndex=true
	HighDetailOverlayIndex=2
    PlayerViewOffset=(X=5,Y=5,Z=0)

    //** Weapon Firing **//
    FireModeClass(0)=StielGranateFire
    FireModeClass(1)=StielGranateTossFire
    FuzeLength=5.0

	//** Weapon Functionality **//
	bCanRestDeploy=false
	bHasReleaseLever=false

	//** Inventory/Ammo **//
    PickupClass=class'StielGranatePickup'
    AttachmentClass=class'StielGranateAttachment'

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
	PreFireHoldAnim=pre_fire_idle

	//** Bot/AI **//
	AIRating=+0.4
    CurrentRating=0.4
    bSniping=false // So bots will use this weapon to take long range shots

 	//** Misc **//
 	SelectForce="SwitchToAssaultRifle"
}
