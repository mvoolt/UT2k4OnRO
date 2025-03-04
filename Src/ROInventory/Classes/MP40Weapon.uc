//=============================================================================
// MP40Weapon
//=============================================================================
// Weapon class for the German MP40 sub machinegun
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================
class MP40Weapon extends ROAutoWeapon;

#exec OBJ LOAD FILE=..\Animations\Axis_Mp40_1st.ukx

defaultproperties
{
	//** Info **//
    ItemName="MP40 SMG"

	//** Display **//
    Mesh=mesh'Axis_Mp40_1st.mp40-mesh'
    DrawScale=1.0
    DisplayFOV=70
    IronSightDisplayFOV=35
    BobDamping=1.6
    SleeveNum = 1
    Handnum = 0
	HighDetailOverlay=Material'Weapons1st_tex.MP40_s'
	bUseHighDetailOverlayIndex=true
	HighDetailOverlayIndex=2


    //** Weapon Firing **//
    FireModeClass(0)=MP40Fire
    FireModeClass(1)=MP40MeleeFire
    InitialNumPrimaryMags=6
	MaxNumPrimaryMags=6
	CurrentMagIndex=0
	bPlusOneLoading=true
	bHasBayonet=false

	//** Weapon Functionality **//
	bCanRestDeploy=true

	//** Inventory/Ammo **//
    PickupClass=class'MP40Pickup'
    AttachmentClass=class'MP40Attachment'

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
    ZoomOutTime=0.15

	//** Bot/AI **//
	AIRating=+0.7
    CurrentRating=0.7
    bSniping=false

 	//** Misc **//
 	SelectForce="SwitchToAssaultRifle"
}
