//=============================================================================
// P08LugerWeapon
//=============================================================================
// Weapon class for the German P08 Luger pistol
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================
class P08LugerWeapon extends ROPistolWeapon;

#exec OBJ LOAD FILE=..\Animations\Axis_Luger_1st.ukx

defaultproperties
{
	//** Info **//
    ItemName="P08 Luger Pistol"

	//** Display **//
    Mesh=mesh'Axis_Luger_1st.P08Luger'
    DrawScale=1.0
    DisplayFOV=70
    IronSightDisplayFOV=55
    BobDamping=1.6
    BayonetBoneName=Bayonet
	HighDetailOverlay=Material'Weapons1st_tex.Pistols.luger_s'
	bUseHighDetailOverlayIndex=true
	HighDetailOverlayIndex=2

    //** Weapon Firing **//
    FireModeClass(0)=P08LugerFire
    FireModeClass(1)=P08LugerMeleeFire
    InitialNumPrimaryMags=5
	MaxNumPrimaryMags=5
	CurrentMagIndex=0
	bPlusOneLoading=true
	bHasBayonet=false

	//** Weapon Functionality **//
	bCanRestDeploy=true

	//** Inventory/Ammo **//
    PickupClass=class'P08LugerPickup'
    AttachmentClass=class'P08LugerAttachment'

	//** Animation **//
	// Rates
	SelectAnimRate=1.0
    PutDownAnimRate=1.0
    // Idle
    IdleEmptyAnim=idle_empty
	// Draw/Put Away
	SelectAnim=Draw
	PutDownAnim=Put_Away
	SelectEmptyAnim=Draw_Empty
	PutDownEmptyAnim=Put_Away_empty
	// Reloading
	MagEmptyReloadAnim=reload_empty
	MagPartialReloadAnim=reload_half
	// Bayo attach/detach
  	BayoAttachAnim=Bayonet_on
  	BayoDetachAnim=Bayonet_off
  	// Ironsites
  	IronBringUp=iron_in
  	IronIdleAnim=Iron_idle
  	IronIdleEmptyAnim=iron_idle_empty
	IronPutDown=iron_out
	IronBringUpEmpty=iron_in_empty
	IronPutDownEmpty=iron_out_empty
	// Crawling
	CrawlForwardAnim=crawlF
	CrawlBackwardAnim=crawlB
	CrawlStartAnim=crawl_in
	CrawlEndAnim=crawl_out
	CrawlForwardEmptyAnim=crawlF_empty
	CrawlBackwardEmptyAnim=crawlB_empty
	CrawlStartEmptyAnim=crawl_in_empty
	CrawlEndEmptyAnim=crawl_out_empty
	// Sprinting
	SprintStartEmptyAnim=Sprint_Empty_Start
	SprintLoopEmptyAnim=Sprint_Empty_Middle
	SprintEndEmptyAnim=Sprint_Empty_End

     //** Zooming **//
    ZoomInTime=0.4
    ZoomOutTime=0.3

	//** Bot/AI **//
	AIRating=+0.35
    CurrentRating=0.35
    bSniping=false // So bots will use this weapon to take long range shots

 	//** Misc **//
 	SelectForce="SwitchToAssaultRifle"
}
