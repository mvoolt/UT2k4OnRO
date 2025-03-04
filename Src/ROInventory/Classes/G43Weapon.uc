//=============================================================================
// G43Weapon
//=============================================================================
// Weapon class for the German G43 semi auto rifle
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================
class G43Weapon extends ROSemiAutoWeapon;

#exec OBJ LOAD FILE=..\Animations\Axis_G43_1st.ukx

defaultproperties
{
	//** Info **//
    ItemName="G43 Semi Auto Rifle"

	//** Display **//
    Mesh=mesh'Axis_G43_1st.G-43-Mesh'
    DrawScale=1.0
    DisplayFOV=70
    IronSightDisplayFOV=20
    BobDamping=1.6
    BayonetBoneName=Bayonet
	HighDetailOverlay=Material'Weapons1st_tex.Rifles.G43_S'
	bUseHighDetailOverlayIndex=true
	HighDetailOverlayIndex=2

    //** Weapon Firing **//
    FireModeClass(0)=G43Fire
    FireModeClass(1)=G34MeleeFire
    InitialNumPrimaryMags=7
	MaxNumPrimaryMags=7
	CurrentMagIndex=0
	bPlusOneLoading=true
	bHasBayonet=false

	//** Weapon Functionality **//
	bCanRestDeploy=true

	//** Inventory/Ammo **//
    PickupClass=class'G43Pickup'
    AttachmentClass=class'G43Attachment'

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
	// Bayo attach/detach
  	BayoAttachAnim=Bayonet_on
  	BayoDetachAnim=Bayonet_off
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
	AIRating=+0.4
    CurrentRating=0.4
    bSniping=true // So bots will use this weapon to take long range shots

 	//** Misc **//
 	SelectForce="SwitchToAssaultRifle"
}
