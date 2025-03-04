//=============================================================================
// Kar98Weapon
//=============================================================================
// Weapon class for the German Karbiner 98k bolt action rifle
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================
class Kar98Weapon extends ROBoltActionWeapon;

#exec OBJ LOAD FILE=..\Animations\Axis_Kar98_1st.ukx

defaultproperties
{
	//** Info **//
    ItemName="Kar98k Rifle"

	//** Display **//
    Mesh=mesh'Axis_Kar98_1st.kar98k_mesh'
    DrawScale=1.0
    DisplayFOV=70
    IronSightDisplayFOV=25
    BobDamping=1.6
    BayonetBoneName=Bayonet
	HighDetailOverlay=Material'Weapons1st_tex.Rifles.k98_s'
	bUseHighDetailOverlayIndex=true
	HighDetailOverlayIndex=2

    //** Weapon Firing **//
    FireModeClass(0)=Kar98Fire
    FireModeClass(1)=Kar98MeleeFire
    InitialNumPrimaryMags=10
	MaxNumPrimaryMags=10
	CurrentMagIndex=0
	bPlusOneLoading=false
	bHasBayonet=true

	//** Weapon Functionality **//
	bCanRestDeploy=true

	//** Inventory/Ammo **//
    PickupClass=class'Kar98Pickup'
    AttachmentClass=class'Kar98Attachment'

	//** Animation **//
	// Rates
	SelectAnimRate=1.0
    PutDownAnimRate=1.0
	// Draw/Put Away
	SelectAnim=Draw
	PutDownAnim=Put_Away
	// Reloading
	MagEmptyReloadAnim=Reload
	MagPartialReloadAnim=none
	// Bayo attach/detach
  	BayoAttachAnim=Bayonet_on
  	BayoDetachAnim=Bayonet_off
  	// Ironsites
  	IronBringUp=iron_in
  	IronBringUpRest=iron_inrest
  	IronIdleAnim=Iron_idle
	IronPutDown=iron_out
	// Crawling
	CrawlForwardAnim=crawlF
	CrawlBackwardAnim=crawlB
	CrawlStartAnim=crawl_in
	CrawlEndAnim=crawl_out
	// Bolt anims
	PostFireIronIdleAnim=iron_idlerest
	PostFireIdleAnim=Idle
    BoltHipAnim=bolt
    BoltIronAnim=iron_boltrest

     //** Zooming **//
    ZoomInTime=0.4
    ZoomOutTime=0.4

	//** Bot/AI **//
	AIRating=+0.4
    CurrentRating=0.4
    bSniping=true // So bots will use this weapon to take long range shots

 	//** Misc **//
 	SelectForce="SwitchToAssaultRifle"
}
