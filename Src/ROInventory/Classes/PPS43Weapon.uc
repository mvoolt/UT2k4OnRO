//=============================================================================
// PPS43Weapon
//=============================================================================
// Weapon class for the Russian PPS43 sub machinegun
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================
class PPS43Weapon extends ROFastAutoWeapon;

#exec OBJ LOAD FILE=..\Animations\Allies_Pps43_1st.ukx

defaultproperties
{
	//** Info **//
    ItemName="PPS43 SMG"

	//** Display **//
    Mesh=mesh'Allies_Pps43_1st.PPS-43-mesh'
    DrawScale=1.0
    DisplayFOV=70
    IronSightDisplayFOV=35
    BobDamping=1.6
	HighDetailOverlay=Material'Weapons1st_tex.SMG.PPS43_S'
	bUseHighDetailOverlayIndex=true
	HighDetailOverlayIndex=2

    //** Weapon Firing **//
    FireModeClass(0)=PPS43Fire
    FireModeClass(1)=PPS43MeleeFire
    InitialNumPrimaryMags=6
	MaxNumPrimaryMags=6
	CurrentMagIndex=0
	bPlusOneLoading=true
	bHasBayonet=false

	//** Weapon Functionality **//
	bCanRestDeploy=true

	//** Inventory/Ammo **//
    PickupClass=class'PPS43Pickup'
    AttachmentClass=class'PPS43Attachment'

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
