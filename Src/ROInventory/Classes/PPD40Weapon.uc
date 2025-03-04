//=============================================================================
// PPD40Weapon
//=============================================================================
// Weapon class for the Russian PPD40 sub machinegun
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================
class PPD40Weapon extends ROFastAutoWeapon;

#exec OBJ LOAD FILE=..\Animations\Allies_Ppd40_1st.ukx

defaultproperties
{
	//** Info **//
    ItemName="PPD40 SMG"

	//** Display **//
    Mesh=mesh'Allies_Ppd40_1st.PPD-40-Mesh'
    DrawScale=1.0
    DisplayFOV=70
    IronSightDisplayFOV=35
    BobDamping=1.6

    //** Weapon Firing **//
    FireModeClass(0)=PPD40Fire
    FireModeClass(1)=PPD40MeleeFire
    InitialNumPrimaryMags=4
	MaxNumPrimaryMags=4
	CurrentMagIndex=0
	bPlusOneLoading=true
	bHasBayonet=false

	//** Weapon Functionality **//
	bCanRestDeploy=true

	//** Inventory/Ammo **//
    PickupClass=class'PPD40Pickup'
    AttachmentClass=class'PPD40Attachment'

	//** Animation **//
	// Rates
	SelectAnimRate=1.0
    PutDownAnimRate=1.0
	// Draw/Put Away
	SelectAnim=Draw
	PutDownAnim=Put_Away
	// Reloading
	MagEmptyReloadAnim=reload_empty
	MagPartialReloadAnim=reload_half
  	// Ironsites
  	IronBringUp=iron_in
  	IronIdleAnim=Iron_idle
	IronPutDown=iron_out
	// Crawling
	CrawlForwardAnim=crawlF
	CrawlBackwardAnim=crawlB
	CrawlStartAnim=crawl_in
	CrawlEndAnim=crawl_out

     //** Zooming **//
    ZoomInTime=0.4
    ZoomOutTime=0.2

	//** Bot/AI **//
	AIRating=+0.7
    CurrentRating=0.7
    bSniping=false

 	//** Misc **//
 	SelectForce="SwitchToAssaultRifle"
}
