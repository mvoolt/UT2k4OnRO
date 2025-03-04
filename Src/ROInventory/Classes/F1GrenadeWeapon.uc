//=============================================================================
// F1GrenadeWeapon
//=============================================================================
// Weapon class for the Russian F1 Grenade
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class F1GrenadeWeapon extends ROGrenadeWeapon;

#exec OBJ LOAD FILE=..\Animations\Allies_F1nade_1st.ukx

defaultproperties
{
	//** Info **//
    ItemName="F1 Grenade"

	//** Display **//
    Mesh=mesh'Allies_F1nade_1st.F1-Grenade-Mesh'
    DrawScale=1.0
    DisplayFOV=70
    BobDamping=1.6
	HighDetailOverlay=Material'Weapons1st_tex.Grenades.f1grenade_s'
	bUseHighDetailOverlayIndex=true
	HighDetailOverlayIndex=2
    PlayerViewOffset=(X=5,Y=5,Z=0)

    //** Weapon Firing **//
    FireModeClass(0)=F1GrenadeFire
    FireModeClass(1)=F1GrenadeTossFire//F1GrenadeFire
    FuzeLength=4.0

    //** Sounds **//
    LeverReleaseSound=sound'Inf_Weapons_Foley.F1.f1_handle'
    LeverReleaseVolume=1.0
    LeverReleaseRadius=200

	//** Weapon Functionality **//
	bCanRestDeploy=false
	bHasReleaseLever=true

	//** Inventory/Ammo **//
    PickupClass=class'F1GrenadePickup'
    AttachmentClass=class'F1GrenadeAttachment'

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
